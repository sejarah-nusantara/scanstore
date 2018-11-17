(function() {
	/**
	 * @class Ext.ux.data.Html5Connection
	 *
	 * Plugin for HTML5 file uploader supporting progress feedback and chunk based uploads
	 *
	 * @author <a href="mailto:mvanworkum@nmera.com">M. van Workum</a>
	 *
	 * @copyright (c) 2013 nMera - Interactive
	 * @license Ext.ux.data.Html5Connection is released under the
	 * <a target="_blank" href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>.
	 *
	 */
	Ext.define('Ext.plugin.data.Html5Connection', {
		override: 'Ext.data.Connection',
		fileCollection: [],
		isHtml5Supported: function() {return typeof FileReader != "undefined"},
		isFormUpload: function(options) {
			return !this.isHtml5Supported() && this.callParent(arguments);
		},
		setOptions: function(options, scope) {
			var opts = this.callParent(arguments);
			if (this.isHtml5Supported() && options.isUpload && options.form) {
				if(options.scope.chunkSize && options.scope.chunkSize > 0){
					for(var i=0;i<options.form.elements.length;i++){
						if(options.form.elements[i].files){
							var fileLinkNames = [];
							for(var j=0;j<options.form.elements[i].files.length;j++){
								var blobs = [], start = 0, end = options.scope.chunkSize;
								while (start < options.form.elements[i].files[j].size) {
									blobs.push(options.form.elements[i].files[j].slice(start, end));
									start = end;
									end = start + options.scope.chunkSize;
								}
								this.fileCollection.push({
									field: options.form.elements[i].name,
									name: options.form.elements[i].files[j].name,
									type: options.form.elements[i].files[j].type,
									size: options.form.elements[i].files[j].size,
									parts: blobs.length,
									data: blobs
								});
								fileLinkNames.push(options.form.elements[i].files[j].name);
							}
							if(fileLinkNames.length){
								var fileLink = document.createElement('input');
								fileLink.type = 'hidden';
								fileLink.name = options.form.elements[i].name+'_name';
								fileLink.value = fileLinkNames.toString();
								options.form.removeChild(options.form.elements[i]);
								options.form.appendChild(fileLink);
							}
						}
					}
				}
				opts.data = new FormData(options.form);
			}
			return opts;
		},
		abort: function(request) {
			var me = this;
			me.blobXhr.onreadystatechange = null;
			me.blobXhr.onprogress = null;
			me.blobXhr.abort();
			me.callParent(arguments);
		},
		openRequest: function(options, requestOptions, async, username, password) {
			if (options.isUpload && options.progress) {
				var me = this,
					state = {
						file: '',
						count: { total:0, landed:0, succeeded:0, pending:0, failed:0, send:0 },
						part:{ failed:-1 },
						bytes:{ total:0, landed:0, succeeded:0, pending:0, failed:0, send:0, average:0 },
						time: { start:new Date(), end:0, running:true }
					},
					throttle = { last:0, time:new Date(), count: 500 },
					send = { current:0, last:0 },
					retryCount,
					retryCounter = 0,
					xhr = me.callParent(arguments);
				if(options.scope.retryCount) retryCount = options.scope.retryCount;
				

				console.log(me.fileCollection);
				
				if(me.fileCollection.length>0){
					xhr.setRequestHeader('X-Form-Action','Post');
					// Currently supports only 1 file per form!
					var file = me.fileCollection.shift();
					me.blobXhr = me.newRequest(options);
					var	sendPart = function(){
						if (username){
							me.blobXhr.open(requestOptions.method, requestOptions.url, async, username, password);
						} else {
							me.blobXhr.open(requestOptions.method, requestOptions.url, async);
						}
						me.blobXhr.setRequestHeader('X-Form-Field',file.field);
						me.blobXhr.setRequestHeader('X-File-Name',file.name);
						me.blobXhr.setRequestHeader('X-Form-Action','File');
						if(file.type.length>0){
							me.blobXhr.setRequestHeader('Content-Type',file.type);
						} else {
							me.blobXhr.setRequestHeader('Content-Type','application/binary');
						}
						if(me.blobXhr.part){
							me.blobXhr.setRequestHeader('X-File-Part',me.blobXhr.part);
							me.blobXhr.send(file.data[me.blobXhr.part-1]);
						} else {
							me.blobXhr.setRequestHeader('X-File-Parts',file.parts);
							me.blobXhr.setRequestHeader('X-File-Part-Size',options.scope.chunkSize);
							me.blobXhr.setRequestHeader('X-File-Size',file.size);
							me.blobXhr.send();
						}
					}
					state.file = file.name;
					state.count.total = file.data.length;
					state.bytes.total = file.size;
					// Set file part onprogress handler
					me.blobXhr.upload.onprogress = function(event){
						// Save current file and part byte delta's
						send.current = (event.position||event.loaded);
						if(state.count.landed>0 || state.count.pending>0){
							state.bytes.send += (send.current-send.last);
						}
						send.last = send.current;
						// Save running file byte counters
						state.bytes.landed = event.loadedBytes = send.current + (state.count.landed*options.scope.chunkSize)
						state.bytes.pending = state.bytes.total-state.bytes.landed;
						event.totalBytes = file.size;
						event.progress = event.loadedBytes / event.totalBytes;
						// Throttle average calculations every 500ms
						var timeDiff = new Date()-throttle.time;
						if(timeDiff > throttle.count || event.progress >= 1){
							throttle.time = new Date();
							var average = ((throttle.count/timeDiff)*(state.bytes.send-throttle.last))/(throttle.count/1000);
							throttle.last = state.bytes.send;
							// Use previous byte average for 50% in the new one
							if(state.bytes.average>0){
								state.bytes.average = (average+state.bytes.average)/2;
							} else {
								state.bytes.average = average;
							}
							var deviation = state.bytes.pending/state.bytes.average;
							// Use previous time average for 50% in the new one
							if(state.time.end>0){
								deviation = (deviation+((state.time.end-throttle.time)/1000))/2;
							}
							state.time.end = new Date();
							state.time.end.setSeconds(throttle.time.getSeconds()+deviation);
						}
						event.state = options.scope.state = state;
						if(options.progress){
							setTimeout(options.progress(event),0);
						}
					}
					me.blobXhr.onreadystatechange = function(){
						if(me.blobXhr.readyState == 4 || me.blobXhr.readyState == 0){
							// Reset send byte delta state
							send.last = 0;
							if(me.blobXhr.status == 200){
								var parts = Ext.JSON.decode(me.blobXhr.responseText);
								state.count.landed = state.count.total-parts.length;
								state.count.pending = state.count.total-state.count.landed;
								if(state.count.landed>0){
									state.count.send++;
									state.count.succeeded++;
									state.bytes.succeeded += send.current;
								}
								if(parts.length > 0){
									retryCounter = retryCount;
									me.blobXhr.part = parts.shift(); 
									sendPart();
								} else {
									xhr.send(me.postData);
								}
							} else {
								if(state.count.pending>0){
									state.count.send++;
									state.count.failed++;
									state.bytes.failed += send.current;
								}
								if(retryCounter > 0){
									setTimeout(function(){sendPart()},500);
								} else {
									// Set average to average download speed
									state.time.running = false;
									state.time.end = new Date();
									state.bytes.average = state.bytes.send/((state.time.end-state.time.start)/1000);
									if(me.blobXhr.part) state.part.failed = me.blobXhr.part;
									me.fireEvent('requestexception', me, me.blobXhr, requestOptions);
									Ext.callback(options.failure, options.scope, [me.blobXhr, requestOptions]);
								}
								retryCounter--;
							}
						}
					}
					return new function(){
						var proxy = this;
						this.open = function(method, url, async, username, password){
							return xhr.open(method, url, async, username, password);
						};
						xhr.onreadystatechange = function(){
							proxy.readyState = xhr.readyState;
							proxy.status = xhr.status;
							proxy.statusText = xhr.statusText;
							proxy.responseText = xhr.responseText;
							proxy.responseXML = xhr.responseXML;
							if(proxy.onreadystatechange){
								setTimeout(proxy.onreadystatechange(),0);
							}
						};
						xhr.upload.onprogress = function(event){
							event.loadedBytes = file.size;
							event.totalBytes = file.size;
							event.progress = 1;
							// Set average to average download speed
							state.time.running = false;
							state.time.end = new Date();
							state.bytes.average = state.bytes.send/((state.time.end-state.time.start)/1000);
							event.state = options.scope.state = state;
							if(options.progress){
								setTimeout(options.progress(event),0);
							}
						}
						this.send = function(data){
							me.postData = data;
							sendPart();
						};
						this.abort = function(){
							xhr.onreadystatechange = null;
							xhr.upload.onprogress = null;
							xhr.abort();
						};
						this.setRequestHeader = function(header, content){
							return xhr.setRequestHeader(header, content);
						};
						this.getAllResponseHeaders = function(){
							return xhr.getAllResponseHeaders();
						};
						this.readyState = 1;
						this.status = 0;
						this.statusText = '';
						this.responseText = '';
			 			this.responseXML = '';
					}();
				}
				xhr.upload.onprogress = function(event){
					event.loadedBytes = (event.position || event.loaded);
					event.totalBytes = (event.totalSize || event.total);
					event.progress = event.loadedBytes / event.totalBytes;
					event.state = options.scope.state = state;
					if(options.progress){
						setTimeout(options.progress(event),0);
					}
				}
			    return xhr;
			} else {
				return this.callParent(arguments);
			}
		},
		setupHeaders: function(xhr, options, data, params) {
			if(this.isHtml5Supported() && options.isUpload) {
				var headers = this.callParent([
					// Create XHR placeholder for parent object to keep it from
					// adding a Content-Type header which will break the HTML5 upload.
					// It will be added automatically with the correct multipart boundary.
					{ setRequestHeader: function(){} },
					options,
					data,
					params
				]);
				try {
					for (var key in headers) {
						if (headers.hasOwnProperty(key) && key != 'Content-Type') {
							xhr.setRequestHeader(key,headers[key]);
						}
					}
				} catch(event) {
					this.fireEvent('requestexception', key, headers);
				}
				return headers;
			} else {
				return this.callParent(arguments);
			}
		}
	});
	Ext.define('Ext.plugin.form.action.Action', {
		override: 'Ext.form.action.Action',
		createCallback: function() {
			var me = this;
			var callback = this.callParent();
			callback.progress = function(event) {
				Ext.callback(me.progress, me.scope || me, [me, event]);
			}
			return callback;
		}
	});
})();