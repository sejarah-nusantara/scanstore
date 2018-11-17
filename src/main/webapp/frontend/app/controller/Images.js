Ext.define('Scanstore.controller.Images', {
	extend: 'Ext.app.Controller',
	models: ['Image'],
	views: [
		'images.Grid',
		'images.ContextMenu',
		'images.UploadAddWindow',
		'images.UploadEditWindow',
		'images.ViewPanel'
	],
	refs: [
		{
			ref: 'grid',
			selector: 'imageGrid'
		},{
			ref: 'contextMenu',
			selector: 'imageContextMenu',
			xtype: 'imageContextMenu',
			autoCreate: true
		},{
			ref: 'uploadAddWindow',
			selector: 'imageUploadAddWindow',
			xtype: 'imageUploadAddWindow',
			autoCreate: true
		},{
			ref: 'uploadEditWindow',
			selector: 'imageUploadEditWindow',
			xtype: 'imageUploadEditWindow',
			autoCreate: true
		},{
			ref: 'viewPanel',
			selector: 'imageViewPanel',
			xtype: 'imageViewPanel'
		}
	],
	init: function() {
		var me = this;
        me.control({
			'imageGrid': {
				render: me.selectPublicated,
				select: me.selectImage,
			    deleteclick: me.handleDeleteRowClick,
			    viewerpanelclick: me.handleViewerPanelRowClick,
			    editclick: me.handleEditRowClick,
			    publishclick: me.handlePublishRowClick,
			    itemcontextmenu: me.showContextMenu
			},
			'imageViewPanel': {
				addclick: me.showAddWindow,
			    deleteclick: me.deleteImage,
			    downloadclick: me.downloadImage,
			    viewerwindowclick: me.showViewerWindow,
			    viewerpanelclick: me.showViewerPanel,
			    editclick: me.showEditWindow,
			    publishclick: me.publishImage
			},
			'#image-context-viewer-window-item': {
			    click: me.handleViewerWindowContextClick
			},
			'#image-context-viewer-panel-item': {
			    click: me.handleViewerPanelContextClick
			},
			'#image-context-publish-item': {
			    click: me.handlePublishContextClick
			},
			'#image-context-delete-item': {
			    click: me.handleDeleteContextClick
			},
			'#image-context-edit-item': {
			    click: me.handleEditContextClick
			},
			'#image-add-window-cancel-btn': {
			    click: me.hideAddWindow
			},
			'#image-add-window-upload-btn': {
			    click: me.handleUploadAddWindowClick
			},
			'#image-edit-window-cancel-btn': {
			    click: me.hideEditWindow
			},
			'#image-edit-window-upload-btn': {
			    click: me.handleUploadEditWindowClick
			}
		});
	},
    handleViewerPanelRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.showViewerPanel(view.store.getAt(rowIndex));
    },
    handlePublishRowClick: function(view, rowIndex, colIndex, column, e) {
        this.publishImage(
        	view.store.getAt(rowIndex)
        );
    },
    handleEditRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.showEditWindow(
           	view.store.getAt(rowIndex)
        );
    },
    handleDeleteRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.deleteImage(
    		view.store.getAt(rowIndex)
    	);
    },
    handleViewerWindowContextClick: function(item, e) {
        this.showViewerWindow(this.getContextMenu().getImage());
    },
    handleViewerPanelContextClick: function(item, e) {
        this.showViewerPanel(this.getContextMenu().getImage());
    },
    handleEditContextClick: function(item, e) {
    	this.showEditWindow(
           	this.getContextMenu().getImage()
    	);
    },
    handlePublishContextClick: function(item, e) {
        this.publishImage(
           	this.getContextMenu().getImage()
        );
    },
    handleDeleteContextClick: function(item, e) {
        this.deleteImage(
           	this.getContextMenu().getImage()
        );
    },
    handleUploadAddWindowClick: function(item, e) {
		this.handleUpload('ADD');
    },
    handleUploadEditWindowClick: function(item, e) {
		this.handleUpload('EDIT');
    },
	handleUpload: function(type) {
        var me = this, form, url;
        switch(type){
	        case 'ADD':
	        	form = me.getUploadAddWindow().down('form').getForm();
	        	url = Scanstore.serverurl+'remote/RemoteImageService.cfc?method=addImage';
	        break;
	        case 'EDIT':
	        	form = me.getUploadEditWindow().down('form').getForm();
	        	url = Scanstore.serverurl+'remote/RemoteImageService.cfc?method=replaceImage';
	        break;
        }
        if(form.isValid()) {
        	form.submit({
                url: url,
                waitMsg: 'Uploading scan image...',
	            success: function(form, action) {
	            	switch(type){
		    	        case 'ADD':
			                Ext.MessageBox.show({
			                    title: 'Scan image upload succeeded',
			                    icon: Ext.Msg.INFO,
			                    msg: 'The scan image has been added successfully.',
			                    buttons: Ext.Msg.OK,
			                });
			                me.getUploadAddWindow().store.reload();
			            	me.hideAddWindow();
		    	        break;
		    	        case 'EDIT':
			                Ext.MessageBox.show({
			                    title: 'Scan image upload succeeded',
			                    icon: Ext.Msg.INFO,
			                    msg: 'The scan image has been changed successfully.',
			                    buttons: Ext.Msg.OK,
			                });	
			                me.getUploadEditWindow().store.reload();
			                me.hideEditWindow();
		    	        break;
	                }
	            },
	            failure: function(form, action) {
	            	var msg = 'An error occured during upload: ';
	            	if(action.result) msg += action.result.message;
	            	else if(action.response.statusText.length>0) msg += action.response.statusText;
	            	else msg += 'Connection failure';
	 	            Ext.MessageBox.show({
	                    title: 'Scan image upload failed',
	                    msg: msg,
	                    icon: Ext.Msg.ERROR,
	                    buttons: Ext.Msg.OK
	                });
	            },
	            progress: function(action, event) {
		            var loaded = Math.round(event.loadedBytes/102.4)/10,
	                	total = Math.round(event.totalBytes/102.4)/10,
	                	msg = 'Uploading scan image<br />',
	                	info = Math.round(100*event.progress)+'%',
	                	progressBar = Ext.Msg.down('progressbar');
	                if(loaded>1024) loaded = (Math.round(loaded/102.4)/10)+'MiB'; else loaded += 'KiB';
	                if(total>1024) total = (Math.round(total/102.4)/10)+'MiB'; else total += 'KiB';
	                msg += '<p style="padding:10px 0 0 10px">Data send '+loaded+' from '+total+'</p>';
	                if(loaded == total){
	                	progressBar.wait();
	                	info = 'Processing image...'; 
	                } else if(progressBar.isWaiting()) {
	                	progressBar.reset();
	                }
	                Ext.Msg.updateProgress(event.progress, info, msg);
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
    // Image actions
    publishImage: function(image) {
        image.set('useForPublication',true);
    	this.saveImage(image);
    },
    deleteImage: function(image) {
    	var me = this,
    		grid = me.getGrid();
    	Ext.MessageBox.show({
            title: 'Deleting image',
            msg: 'Are you sure you want to delete this image?',
            icon: Ext.Msg.QUESTION,
            buttons: Ext.Msg.YESNO,
            fn: function (btn){
                if(btn=='yes'){
                	var store = image.store;
                	grid.setLoading(true);
                	image.destroy({
                        success: function(image, operation) {
                        	grid.setLoading(false);
                            store.reload();
                        },
                        failure: function(image, operation) {
                        	grid.setLoading(false);
                            var error = operation.getError(),
                                msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
            	                Ext.MessageBox.show({
                                title: 'Deleting image failed',
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
    saveImage: function(image) {
    	var me = this,
    		grid = me.getGrid(),
    		store = image.store;
    	grid.setLoading(true);
    	image.save({
            success: function(image, operation) {
            	grid.setLoading(false);
            	store.reload();
            },
            failure: function(image, operation) {
            	grid.setLoading(false);
                var error = operation.getError(),
                    msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	                Ext.MessageBox.show({
                    title: 'Image save failed',
                    msg: msg,
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        })
    },
    downloadImage: function(image) {
    	window.open(image.get('fileUrl'));
    },
	selectPublicated: function(table, e) {
		table.getSelectionModel().select(0);
		table.getStore().addListener('load',function(){
			table.getSelectionModel().select(0);
		});
    },
    selectImage: function(model, record, index, e) {
    	model.view.panel.viewPanel.setImage(record);
    },
    showViewerWindow: function(image) {
    	this.getController('Scans').showViewerWindow(this.getViewPanel().scan,image);
    },
    showViewerPanel: function(image) {
    	this.getController('Scans').showViewerPanel(this.getViewPanel().scan,image);
    },
    showContextMenu: function(view, image, node, rowIndex, e) {
        var contextMenu = this.getContextMenu();
        contextMenu.setImage(image);
        contextMenu.showAt(e.getX(), e.getY());
        e.preventDefault();
    },
    showEditWindow: function(image) {
        var me = this,
        	uploadWindow = me.getUploadEditWindow();
        uploadWindow.down('form').getForm().setValues([
			{ id:'id', value:image.get('id') },
			{ id:'imageDisplay', value:image.get('originalFileName') },
			{ id:'scanID', value:image.get('scanID') }
		]);
        uploadWindow.store = image.store;
    	uploadWindow.show();
    },
    showAddWindow: function(image) {
        var me = this,
    		uploadWindow = me.getUploadAddWindow();
	    uploadWindow.down('form').getForm().setValues([
			{ id:'scanID', value:image.get('scanID') }
		]);
	    uploadWindow.store = image.store;
    	uploadWindow.show();
    },
    hideAddWindow: function(button, e) {
        this.getUploadAddWindow().close();
    },
    hideEditWindow: function(button, e) {
        this.getUploadEditWindow().close();
    }
});