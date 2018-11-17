Ext.define('Scanstore.view.imports.StatePanel', {
    extend: 'Ext.container.Container',
	xtype: 'importStatePanel',
	width: 330,
	defaultType: 'panel',
    updateState: function(state){
    	this.removeAll();
    	if(state){
    		var content = '<h1>Upload details</h1>';
   			content += '<p>File <b>'+state.file+'</b></p>';
   			content += '<p>Size '+Scanstore.bytesize(state.bytes.total)+' divided in '+state.count.total+' part(s)</p>';
       		content += '<h2>Time</h2>'
    		content += '<p>Started on '+Scanstore.dateformatter(state.time.start)+'</p>';
    		if(!state.time.running){
    			content += '<p>Finished on '+Scanstore.dateformatter(state.time.end)+'</p>';
    			content += '<p>Time taken '+Scanstore.secformatter((state.time.end-state.time.start)/1000)+'</p>';
    		} else {
    			content += '<p>Expected Time of Arrival on '+Scanstore.dateformatter(state.time.end)+'</p>';
    			content += '<p>Time elapsed '+Scanstore.secformatter((new Date()-state.time.start)/1000)+'</p>';
    		}
    		content += '<h2>Throughput</h2>'
   			if(!state.time.running){
    			content += '<p>Average upload speed was '+Scanstore.bytesize(state.bytes.average)+' p/s</p>';
   			} else {
    			content += '<p>Current upload speed is '+Scanstore.bytesize(state.bytes.average)+' p/s</p>';
   			}
    		if(state.count.send > state.count.succeeded){
    			content += '<p style="color:#888888;">Uploaded a total of '+Scanstore.bytesize(state.bytes.send)+' in '+state.count.send+' part(s)</p>';
    		}
    		content += '<p style="color:#006600;font-weight:bold;">Successful uploaded '+Scanstore.bytesize(state.bytes.succeeded)+' in '+state.count.succeeded+' part(s)</p>';    		
    		if(state.count.failed > 0){
	    		if(!state.time.running){
	    			content += '<p style="color:#662222;">Failed uploading '+Scanstore.bytesize(state.bytes.failed)+' in '+state.count.failed+' part(s) but recovered</p>';
	    		} else {
	    			content += '<p style="color:#882222;">Failed uploading '+Scanstore.bytesize(state.bytes.failed)+' in '+state.count.failed+' part(s)</p>';
	    		}
	    		if(!state.time.running && state.part.failed >= 0){
	    			content += '<p style="color:#660000;font-weight:bold;">Stopped uploading of part '+state.part.failed+', too many attempts!</p>';
	    		}
    		}
    		if(state.count.landed < state.count.total){
    			content += '<p>Currently there is '+Scanstore.bytesize(state.bytes.landed)+' in '+state.count.landed+' part(s) on the server</p>';
    		} else {
    			content += '<p style="color:#228822;font-weight:bold;">All parts are available on server</p>';
    		}
     		if(state.count.pending > 0){
    			content += '<p style="font-weight:bold;">Still '+Scanstore.bytesize(state.bytes.pending)+' in '+state.count.pending+' part(s) pending</p>';
    		}
     		this.add({ baseCls: 'state', html: content })
    	};
    }
});