Ext.define('Scanstore.view.images.ContextMenu', {
    extend: 'Ext.menu.Menu',
    xtype: 'imageContextMenu',
    setImage: function(image) {
        this.image = image;
        this.removeAll();
        this.add({
    		iconCls: 'image-viewer-window',
            text: 'View image in external viewer',
            id: 'image-context-viewer-window-item'
	    });
        this.add({
    		iconCls: 'image-viewer-panel',
            text: 'View image in viewer',
            id: 'image-context-viewer-panel-item'
	    });
        if(!image.get('useForPublication')){
	        this.add({
	        	iconCls: 'image-publish',
	        	text: 'Publish image',
	        	id: 'image-context-publish-item'
		    });
        }
        this.add({
        	iconCls: 'image-edit',
        	text: 'Replace image',
            id: 'image-context-edit-item'
	    });
        this.add({
        	iconCls: 'image-delete',
        	text: 'Delete image',
            id: 'image-context-delete-item'
	    });
    },
    getImage: function() {
        return this.image;
    }
});