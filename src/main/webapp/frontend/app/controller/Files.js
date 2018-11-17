Ext.define('Scanstore.controller.Files', {
	extend: 'Ext.app.Controller',
	models: ['File'],
	stores: ['FilesPublished'],
	views: [
		'files.Grid',
		'files.ContextMenu'
	],
	refs: [
		{
			ref: 'grid',
			selector: 'fileGrid'
		},{
			ref: 'contextMenu',
			selector: 'fileContextMenu',
			xtype: 'fileContextMenu',
			autoCreate: true
		}
	],
	init: function() {
		var me = this;
        me.control({
			'fileGrid': {
			    publishclick: me.handlePublishRowClick,
			    unpublishclick: me.handleUnPublishRowClick,
			    deletescansclick: me.handleDeleteScansRowClick,
			    itemcontextmenu: me.showContextMenu
			},
        	'#main-file-tab': {
        		afterrender: me.loadData
        	},
			'#file-context-publish-item': {
			    click: me.handlePublishContextClick
			},
			'#file-context-unpublish-item': {
			    click: me.handleUnPublishContextClick
			},
			'#file-context-scans-delete-item': {
			    click: me.handleDeleteScansContextClick
			}
		});
	},
	loadData: function(item, e) {
		var me = this,
			filesPublished = me.getStore("FilesPublished");
		filesPublished.load();
	},
    handlePublishRowClick: function(file, rowIndex, colIndex, column, e) {
        this.publishFile(
        	file.store.getAt(rowIndex)
        );
    },
    handleUnPublishRowClick: function(file, rowIndex, colIndex, column, e) {
        this.unPublishFile(
        	file.store.getAt(rowIndex)
        );
    },
    handleDeleteScansRowClick: function(file, rowIndex, colIndex, column, e) {
        this.deleteScans(
        	file.store.getAt(rowIndex)
        );
    },
    handlePublishContextClick: function(item, e) {
        this.publishFile(
           	this.getContextMenu().getFile()
        );
    },
    handleUnPublishContextClick: function(item, e) {
        this.unPublishFile(
           	this.getContextMenu().getFile()
        );
    },
    handleDeleteScansContextClick: function(item, e) {
        this.deleteScans(
           	this.getContextMenu().getFile()
        );
    },
    showContextMenu: function(view, file, node, rowIndex, e) {
        var contextMenu = this.getContextMenu();
        contextMenu.setFile(file);
        contextMenu.showAt(e.getX(), e.getY());
        e.preventDefault();
    },
    publishFile: function(file){
    	var store = file.store,
			grid = this.getGrid();
    	grid.setLoading(true);
    	file.set('statusID',2);
    	file.save({
            success: function(image, operation) {
            	grid.setLoading(false);
            	store.reload();
            },
            failure: function(image, operation) {
            	grid.setLoading(false);
                var error = operation.getError(),
                    msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	                Ext.MessageBox.show({
                    title: 'File save failed',
                    msg: msg,
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        });
    },
    unPublishFile: function(file){
    	var store = file.store,
			grid = this.getGrid();
    	grid.setLoading(true);
    	file.set('statusID',1);
    	file.save({
            success: function(image, operation) {
            	grid.setLoading(false);
            	store.reload();
            },
            failure: function(image, operation) {
            	grid.setLoading(false);
                var error = operation.getError(),
                    msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	                Ext.MessageBox.show({
                    title: 'File save failed',
                    msg: msg,
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        });
    },
    deleteScans: function(file){
    	var store = file.store,
			grid = this.getGrid();
    	Ext.MessageBox.show({
            title: 'Deleting scans',
            msg: 'Are you sure you want to delete all scans from this file and archive?',
            icon: Ext.Msg.QUESTION,
            buttons: Ext.Msg.YESNO,
            fn: function (btn){
                if(btn=='yes'){
                	grid.setLoading(true);
	            	file.destroy({
	                    success: function(scan, operation) {
	                    	grid.setLoading(false)
	                    	if(store.currentPage>1 && (store.getTotalCount()-1)/25 <= store.currentPage-1){
	                    		store.previousPage();
	                    	} else {
	                    		store.reload();
	                    	}
	                    },
	                    failure: function(scan, operation) {
	                    	grid.setLoading(false);
	                    	var error = operation.getError(),
	                            msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	        	                Ext.MessageBox.show({
	                            title: 'Deleting scans failed',
	                            msg: msg,
	                            icon: Ext.Msg.ERROR,
	                            buttons: Ext.Msg.OK
	                        });
	                    }
	                });
                }
            }
        });	
    }
});