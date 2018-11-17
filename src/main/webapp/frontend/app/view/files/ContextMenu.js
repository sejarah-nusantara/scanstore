Ext.define('Scanstore.view.files.ContextMenu', {
    extend: 'Ext.menu.Menu',
    xtype: 'fileContextMenu',
    setFile: function(file) {
        this.file = file;
        this.removeAll();
        if(file.get('statusID') == 2){
	        this.add({
	        	iconCls: 'file-unpublish',
	        	text: 'Unpublish file',
	        	id: 'file-context-unpublish-item'
		    });
        } else {
	        this.add({
	        	iconCls: 'file-publish',
	        	text: 'Publish file',
	        	id: 'file-context-publish-item'
		    });
        }
        this.add({
        	iconCls: 'scans-delete',
        	text: 'Delete all scans attached to this file and archive',
        	id: 'file-context-scans-delete-item'
	    });
    },
    getFile: function() {
        return this.file;
    }
});