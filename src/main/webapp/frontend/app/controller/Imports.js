Ext.define('Scanstore.controller.Imports', {
	extend: 'Ext.app.Controller',
	models: ['Type','Language','Archive','Institution','File','ImportDirectory','ImportScenario'],
	stores: ['Types','Archives','Institutions','Files','ImportDirectories','ImportScenarios'],
	views: [
		'imports.Grid',
		'imports.GridBar',
		'imports.ContextMenu',
		'imports.UploadImportWindow',
		'imports.ImportWindow',
		'imports.UploadWindow',
		'imports.StatePanel',
		'imports.LogWindow'
	],
	refs: [
		{
			ref: 'importPanel',
			selector: 'importImportPanel',
			xtype: 'importImportPanel',
			forceCreate: true
		},{
			ref: 'statePanel',
			selector: 'importStatePanel',
			xtype: 'importStatePanel',
			autoCreate: true
		},{
			ref: 'gridBar',
			selector: 'importGridBar'
		},{
			ref: 'grid',
			selector: 'importGrid'
		},{
			ref: 'contextMenu',
			selector: 'importContextMenu',
			xtype: 'importContextMenu',
			autoCreate: true
		},{
			ref: 'uploadWindow',
			selector: 'importUploadWindow',
			xtype: 'importUploadWindow',
			autoCreate: true
		},{
			ref: 'uploadImportWindow',
			selector: 'importUploadImportWindow',
			xtype: 'importUploadImportWindow',
			autoCreate: true
		},{
			ref: 'importWindow',
			selector: 'importImportWindow',
			xtype: 'importImportWindow',
			autoCreate: true
		},{
			ref: 'logWindow',
			selector: 'importLogWindow',
			xtype: 'importLogWindow',
			autoCreate: true
		}
	],
	init: function() {
		var me = this;
        me.control({
    		'importGrid': {
                logclick: me.handleLogRowClick,
            	deleteclick: me.handleDeleteRowClick,
                importclick: me.handleImportRowClick,
                itemcontextmenu: me.showContextMenu,
        		destroy: me.suspendTimer
            },
        	'#main-import-tab': {
        		afterrender: me.loadData,
        		activate: me.resumeTimer,
        		deactivate: me.suspendTimer
        	},
            '#upload-cancel-btn': {
                click: me.handleCancelUpload
            },
        	'#upload-archive-btn': {
                click: me.showUploadWindow
            },
            '#upload-import-archive-btn': {
                click: me.showUploadImportWindow
            },
            '#import-context-log-item': {
                click: me.handleLogContextClick
            },
            '#import-context-delete-item': {
                click: me.handleDeleteContextClick
            },
            '#import-context-import-item': {
                click: me.handleImportContextClick
            },
            '#import-upload-window-cancel-btn': {
                click: me.hideUploadWindow
            },
            '#import-upload-window-upload-btn': {
                click: me.handleUploadWindowClick
            },
            '#import-upload-import-window-cancel-btn': {
                click: me.hideUploadImportWindow
            },
            '#import-upload-import-window-upload-btn': {
                click: me.handleUploadImportWindowClick
            },
            '#import-import-window-cancel-btn': {
                click: me.hideImportWindow
            },
            '#import-import-window-import-btn': {
                click: me.handleImportWindowClick
            }
		});
	},
	timerInitiated: false,
	silentTime: 15000,
	silentTimer: 0,
	silentLoader: function(item, e) {
		var me = this;
		var store = me.getStore("ImportDirectories");
		me.suspendTimer();
		if(!store.isLoading){
			store.suspendEvents();
			store.isLoading = true;
			store.load();
			store.resumeEvents();
		}
	},
	loadData: function(item, e) {
		var me = this;
		var store = me.getStore("ImportDirectories");
		store.on({
			beforeload: function(){
				me.suspendTimer();
			},
			load: function(){
				me.silentTimer = setTimeout(function(){me.silentLoader()},me.silentTime);
				me.timerInitiated = true;
			}
		})
		store.load();
	},
	resumeTimer: function(item, e) {
		var me = this;
		if(me.timerInitiated) me.silentLoader();
	},
	suspendTimer: function(item, e) {
		clearTimeout(this.silentTimer);
	},
	handleImportWindowClick: function(item, e) {
		var me = this,
			form = me.getImportWindow().down('form').getForm();
		if(form.isValid()) {
			form.submit({
                url: Scanstore.serverurl+'remote/RemoteScanImportService.cfc?method=sendScanImportToRepository',
	            success: function(form, action) {
	                me.getStore("ImportDirectories").reload();
  	  	        	me.hideImportWindow();
	            },
	            failure: function(form, action) {
	            	var msg = 'An error occured during upload: ';
	            	if(action.result) msg += action.result.message;
	            	else if(action.response.statusText.length>0) msg += action.response.statusText;
	            	else msg += 'Connection failure';
	            	Ext.MessageBox.show({
	                    title: 'Import initiation scan collection failed',
	                    msg: msg,
	                    icon: Ext.Msg.ERROR,
	                    buttons: Ext.Msg.OK
	                });
	            },
            });
	    } else {
	    	Ext.MessageBox.show({
                title: 'Form validation error ',
                msg: form.getValidationHTML(),
                icon: Ext.Msg.WARNING,
                buttons: Ext.Msg.OK
            });
	    }
    },
    uploadRunning: false,
	handleUploadWindowClick: function(item, e) {
		this.autoRetryCount = Scanstore.retryCount;
		this.handleUpload('UPLOAD');
    },
    handleUploadImportWindowClick: function(item, e) {
    	this.autoRetryCount = Scanstore.retryCount;
    	this.handleUpload('UPLOADIMPORT');
    },
	handleCancelUpload: function() {
		var me = this;
    	for(var i in Ext.Ajax.requests){
    		var request = Ext.Ajax.requests[i];
    		if((request.options.url == 'action/uploadZipAction.cfm' ||
    			request.options.url == 'action/importZipAction.cfm') &&
    			request.options.failure){
    			request.options.failure = null;
    			Ext.Ajax.abort(request);
    		}
    	}
		me.uploadRunning = false;
		me.getGridBar().getComponent('import-progresspanel').hide();
    	me.getController('Main').hideBackgroundProcess();
	},
	handleUpload: function(type) {
        var me = this, form, url;
        switch(type){
	        case 'UPLOAD':
	        	form = me.getUploadWindow().down('form').getForm();
	        	url = Scanstore.serverurl+'action/uploadZipAction.cfm';
	        break;
	        case 'UPLOADIMPORT':
	        	form = me.getUploadImportWindow().down('form').getForm();
	        	url = Scanstore.serverurl+'action/importZipAction.cfm';
	        break;
        }
        if(form.isValid()) {
            me.uploadRunning = true;
        	me.getController('Main').showBackgroundProcess('Uploading scan collection');
            switch(type){
		        case 'UPLOAD':
		        	me.getUploadWindow().close();
		        break;
		        case 'UPLOADIMPORT':
		        	me.getUploadImportWindow().close();
		        break;
	        }
            // Copy input field for resubmitting filedata on error
            var file = { field: form.findField('filedata') };
            file.value = file.field.inputEl.dom.value;
            file.elem = file.field.fileInputEl.dom;
			// Set progress bar
            var progressPanel = me.getGridBar().getComponent('import-progresspanel'),
            	progressBar = me.getGridBar().queryById('import-progressbar'),
            	progressText = me.getGridBar().queryById('import-progresstext'),
            	progressTime = new Date(),
            	stateTime = new Date(),
        		progressBarTip = Ext.create('Ext.tip.ToolTip', {
        			target: [ 'import-progressbar', 'import-progresstext', 'main-header-info'],
        			dismissDelay: 0,
        			maxWidth: 342,
        			width: 342,
        			mouseOffset: [-175,0],
        			listeners: { show:{ fn:function(){ this.add(me.getStatePanel()) } } }
        		});
            progressBar.wait();
            progressBar.updateProgress(0,'Preparing upload...');
	    	progressText.setText('Starting upload');
            progressPanel.show();
            form.submit({
                url: url,
                chunkSize: Scanstore.chunkSize,
                retryCount: Scanstore.retryCount,
	            success: function(form, action) {
                	me.getStore("ImportDirectories").reload();
                	switch(type){
		    	        case 'UPLOAD':
		    	        	var msg = '<p>Upload scan collection finished.</p>',
		    	        		detail = 'You will be able to import this collection from within the import manager.',
		    	        		title = 'Upload scan collection';
			            	me.getStore("Files").reload();
		    	        	me.hideUploadWindow();
		    	        break;
		    	        case 'UPLOADIMPORT':
		    	        	var msg = '<p>Upload scan collection finished and import has been initiated.</p>',
			            		detail = 'Please check the log file for any errors that might occur during importing.',
			            		title = 'Upload & import scan collection';
		    	        	me.getStore("Scans").reload();
			                me.getStore("Files").reload();
		    	        	me.hideUploadImportWindow();
		    	        break;
		            }
	            	// Set last known state
                	me.getStatePanel().updateState(action.state);
                	// Show result message
                	Ext.create('Ext.window.Window', {
                        title: title,
                        modal: true,
                        border: false,
                        plain: true,
                        defaultType: 'container',
                        width: 400,
                        layout: { type: 'vbox', align:'center' },
                        items:[
                            { cls:Ext.Msg.INFO, html:msg, minHeight:40, width:350, margin:'10 25 5 25', padding:'10 0 5 50', border:false },
                       		me.getStatePanel(),
                            { html:detail, width:350, margin:'15 25 10 25', border:false }
                        ],
                        buttonAlign:'center', buttons:[{
            				text: 'OK', handler: function(){
            					this.up('window').close();
            				}
            			}]
                    }).show();
                	me.uploadRunning = false;
                	progressBarTip.destroy();
                	progressPanel.hide();
	            	me.getController('Main').hideBackgroundProcess();
	            },
	            failure: function(form, action) {
	            	var msg = '<p>An error occured during upload:</p>';
	            	msg += '<p style="margin:15px 0 15px 0;color:#660000;">';
	            	if(action.result) msg += action.result.message;
	            	else if(action.response.statusText.length>0) msg += action.response.statusText;
	            	else msg += 'Connection failure';
	            	msg += '</p>';
	            	// Show error message
	            	var autoRetryTime = 30,
            			autoRetryTimer = 0;
	            	// Set last known state
                	me.getStatePanel().updateState(action.state);
	            	if(action.state.count.landed<action.state.count.total){
	            		detail = '<p>Would you like to try to continue uploading?</p><p id="autoRetryHolder">&nbsp;</p>';
	                	// Show error message
		            	var msgBox = Ext.create('Ext.window.Window', {
	                        title: 'Upload scan collection failed',
	                        modal: true,
	                        border: false,
	                        plain: true,
	                        defaultType: 'container',
	                        width: 400,
	                        layout: { type: 'vbox', align:'center' },
	                        items:[
	                            { cls:Ext.Msg.ERROR, html:msg, minHeight:40, width:350, margin:'10 25 5 25', padding:'0 0 0 50', border:false },
	                       		me.getStatePanel(),
	                            { html:detail, width:300, margin:'15 50 10 50', border:false }
	                        ],
	                        buttonAlign:'center', buttons:[{
	            				text: 'OK', handler: function(){
		                   			clearTimeout(autoRetryTimer);
	            					me.autoRetryCount = Scanstore.retryCount;
		                   			file.field.inputEl.dom.value = file.value;
		                        	file.field.fileInputEl.dom = file.elem; 
		                        	me.handleUpload(type);
	            					this.up('window').close();
	            				}
	                        },{
	            				text: 'Cancel', handler: function(){
	            					clearTimeout(autoRetryTimer);
	            					this.up('window').close();
	            				}
	            			}]
	                    }).show();
		            	// Set auto retry
		            	var autoRetryMethod = function(){
	            			if(autoRetryTime == 0){
	                   			Ext.get('autoRetryHolder').dom.innerHTML = '';
	            				clearTimeout(autoRetryTimer);
		                   		me.autoRetryCount--;
		                   		msgBox.close();
			            		file.field.inputEl.dom.value = file.value;
		                       	file.field.fileInputEl.dom = file.elem; 
		                       	me.handleUpload(type);
		                   	} else if(me.autoRetryCount > 0){
		                   		Ext.get('autoRetryHolder').dom.innerHTML = 'Automatically retrying in '+autoRetryTime+' seconds...';
		                   		autoRetryTime--;
		                   		autoRetryTimer = setTimeout(autoRetryMethod,1000);
		                   	}
	            		};
		            	autoRetryMethod();
	            	} else {
               			clearTimeout(autoRetryTimer);
	            		var msgBox = Ext.create('Ext.window.Window', {
	                        title: 'Upload scan collection failed',
	                        modal: true,
	                        border: false,
	                        plain: true,
	                        defaultType: 'container',
	                        width: 400,
	                        layout: { type: 'vbox', align:'center' },
	                        items:[
	                            { cls:Ext.Msg.ERROR, html:msg, minHeight:40, width:350, margin:'10 25 5 25', padding:'0 0 0 50', border:false },
	                       		me.getStatePanel(),
	                       		{ width:300, margin:'10 50 0 50', border:false }
	                        ],
	                        buttonAlign:'center', buttons:[{
	            				text: 'OK', handler: function(){
	            					this.up('window').close();
	            				}
	                        }]
	                    }).show();
	            	}
	            	me.uploadRunning = false;
                	progressBarTip.destroy();
	            	progressPanel.hide();
	            	me.getController('Main').hideBackgroundProcess();
	            },
	            progress: function(action, event) {
	            	// Update every 250ms
	            	if(new Date()-stateTime > 250){
	            		stateTime = new Date();
	            		me.getStatePanel().updateState(event.state);
			    	    if(event.state.time.end - new Date()>0){
			    	    	me.getController('Main').showBackgroundProcess('Uploading scan collection - <b>ETA '+Scanstore.relaformatter(event.state.time.end)+'</b>');
			    	    }
	            	}
	            	// Update every 100ms
	            	if(new Date()-progressTime > 100){
						progressTime = new Date();
		            	var loaded = Scanstore.bytesize(event.loadedBytes),
			    	    	total = Scanstore.bytesize(event.totalBytes),
			    	    	average = Scanstore.bytesize(event.state.bytes.average),
		                	perc = Math.round(100*event.progress);
		            	progressBar.updateProgress(perc/100,perc+'%');
			    	    progressText.setText('Uploading - '+loaded+' from '+total+' at '+average+' p/s');
			    	    if(loaded == total){
			    	    	progressBar.wait();
					       	progressBar.updateProgress(0,'Processing scan collection...');
			    	    	progressText.setText('Upload finished - '+total);
		            		me.getStatePanel().updateState(event.state);
			    	    	me.getController('Main').showBackgroundProcess('Processing scan collection');
			    	    	me.autoRetryCount = 0;
		                } else if(progressBar.isWaiting()) {
		                	progressBar.reset();
		                }
			    	}
	            }
            });
	    } else {
	    	Ext.MessageBox.show({
                title: 'Form validation error ',
                msg: form.getValidationHTML(),
                icon: Ext.Msg.WARNING,
                buttons: Ext.Msg.OK
            });
	    }
    },
    handleImportContextClick: function(item, e) {
    	this.showImportWindow(
    		this.getContextMenu().getImport()
        )
    },
    handleDeleteContextClick: function(item, e) {
        this.deleteImport(
           	this.getContextMenu().getImport()
        );
    },
    handleLogContextClick: function(item, e) {
        this.showLogWindow(
        	this.getContextMenu().getImport()
        )
    },
    handleLogRowClick: function(view, rowIndex, colIndex, column, e) {
        this.showLogWindow(
        	this.getStore('ImportDirectories').getAt(rowIndex)
        )
    },
    handleImportRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.showImportWindow(
       		this.getStore('ImportDirectories').getAt(rowIndex)
    	)
    },
    handleDeleteRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.deleteImport(
    		this.getStore('ImportDirectories').getAt(rowIndex)
    	);
    },
    showContextMenu: function(view, importDirectory, node, rowIndex, e) {
        var contextMenu = this.getContextMenu();
        contextMenu.setImport(importDirectory);
        contextMenu.showAt(e.getX(), e.getY());
        e.preventDefault();
    },
    // Import actions
    deleteImport: function(importDirectory,panel) {
    	var me = this,
			grid = me.getGrid();
    	Ext.MessageBox.show({
            title: 'Deleting import directory',
            msg: 'Are you sure you want to delete this scan collection import folder?',
            icon: Ext.Msg.QUESTION,
            buttons: Ext.Msg.YESNO,
            fn: function (btn){
                if(btn=='yes'){
                	grid.setLoading(true);
                	var store = importDirectory.store;
                	importDirectory.destroy({
                        success: function(importDirectory, operation) {
                        	grid.setLoading(false);
                        	if(store.currentPage>1 && (store.getTotalCount()-1)/25 <= store.currentPage-1){
                        		store.previousPage();
                        	} else {
                        		store.reload();
                        	}
                            if(panel) panel.close();
                        },
                        failure: function(importDirectory, operation) {
                        	grid.setLoading(false);
                            var error = operation.getError(),
                                msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
            	                Ext.MessageBox.show({
                                title: 'Deleting scan collection import folder failed',
                                msg: msg,
                                icon: Ext.Msg.ERROR,
                                buttons: Ext.Msg.OK
                            });
                        }
                    });
                }
            }
        });	
    },
    showImportWindow: function(importDirectory) {
		var me = this,
			importWindow = me.getImportWindow(),
			institutionID = me.getController('Main').session.get('institutionID');
		importWindow.down('form').getForm().setValues([
			{ id:'importDirectory', value:importDirectory.get('directoryName') },
			{ id:'importDirectoryDisplay', value:importDirectory.get('directoryName') },
			{ id:'institutionID', value:institutionID },
			{ id:'institutionDisplay', value:Ext.getStore('Institutions').getById(institutionID).get('name') }
		]);
		importWindow.show();
    },
    hideImportWindow: function(button, e) {
        this.getImportWindow().close();
    },
    showUploadWindow: function() {
    	var me = this;
        if(me.uploadRunning){
	    	Ext.MessageBox.show({
	            title: 'Upload scan collection',
	            msg: 'Upload scan collection is in progress.<br/>Please wait for or cancel the running upload.',
	            icon: Ext.Msg.INFO,
	            buttons: Ext.Msg.OK
	        });
        } else {
	        var uploadWindow = me.getUploadWindow(), 
				institutionID = me.getController('Main').session.get('institutionID');
	        uploadWindow.down('form').getForm().setValues([
				{ id:'institutionID', value:institutionID },
				{ id:'institutionDisplay', value:Ext.getStore('Institutions').getById(institutionID).get('name')	}
			]);
	    	uploadWindow.show();
	    }
    },
    hideUploadWindow: function(button, e) {
        this.getUploadWindow().close();
    },
    showUploadImportWindow: function() {
        var me = this;
        if(me.uploadRunning){
	    	Ext.MessageBox.show({
	            title: 'Upload scan collection',
	            msg: 'Upload scan collection is in progress.<br/>Please wait for or cancel the running upload.',
	            icon: Ext.Msg.INFO,
	            buttons: Ext.Msg.OK
	        });
        } else {
        	var institutionID = me.getController('Main').session.get('institutionID');
	    		uploadImportWindow = me.getUploadImportWindow(); 
	    	uploadImportWindow.down('form').getForm().setValues([
				{ id:'institutionID', value:institutionID },
				{ id:'institutionDisplay', value:Ext.getStore('Institutions').getById(institutionID).get('name')	}
			]);
	    	uploadImportWindow.show();
        }
    },
    hideUploadImportWindow: function(button, e) {
        this.getUploadImportWindow().close();
    },
    showLogWindow: function(importDirectory) {
    	var me = this;
		var logWindow = this.getLogWindow();
		logWindow.setTitle('Import scan collection log viewer - ' + importDirectory.get('directoryName'));
		logWindow.removeAll();
		if(importDirectory.get('logInfo').length>0){
			logWindow.setLog(importDirectory.get('logInfo'));
		} else {
			this.getModel('ImportDirectory').load(importDirectory.get('id'),{
			    success: function(fullImportDirectory) {
					importDirectory.set('logInfo',fullImportDirectory.get('logInfo'));
			    	logWindow.setLog(importDirectory.get('logInfo'));
			    }
			});
		}
		logWindow.show();
    }
});