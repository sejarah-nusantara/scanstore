Ext.define('Scanstore.view.images.ViewPanel', {
	extend: 'Ext.panel.Panel',
    xtype: 'imageViewPanel',
    header: false,
    border: false,
    hidden:true,
    layout: {
    	type: 'vbox',
    	align: 'center', 
    	pack: 'center'
    },
    listeners:{
    	resize: {
            fn: function(){
            	if(this.img) this.img.resize();
            }
		}
    },
    addImage: function(image){
    	var me = this;
		if(me.isVisible() && typeof me.loadMask == 'undefined'){
			me.loadMask = new Ext.LoadMask(me, {msg:"Loading image..."});
			me.loadMask.show();
		}
		me.removeAll();
		me.img = Ext.create('Ext.Img', {
		    src: image.get('fileUrl')+'?size=750x750',
		    margin: 10,
		    padding: 1,
		    hideMode: 'visibility',
		    border: 1,
			listeners:{
		        load: {
		            element : 'el',
		            fn : function(){
		            	me.img.resize();
		            	me.img.show();
		            	if(me.isVisible() && me.loadMask){
		            		me.loadMask.destroy();
			    			delete me.loadMask;
		            	}
		            }
		        },
				click: {
					element: 'el',
		            fn: function(){
		            	me.fireEvent('viewerpanelclick', image)
		            }
				}
		    },
		    style: {
		        borderColor: '#222222',
		        borderStyle: 'solid',
	        	backgroundColor: '#AAAAAA',
	        	cursor: 'pointer'
		    },
		    resize: function(){
		    	var aHeight = me.getHeight()-50;
	    		var aWidth = me.getWidth()-50;
	    		var mHeight = this.getHeight()/aHeight;
	    		var mWidth = this.getWidth()/aWidth;
	    		if(mHeight>mWidth){
	    			this.setHeight(aHeight);
	    			this.setWidth(null);
	    		} else {
	    			this.setHeight(null);
	    			this.setWidth(aWidth);
	    		}
            }
		});
		me.img.hide();
		me.add(me.img);
	},
	setImage: function(image){
		var me = this;
		if(me.getDockedItems().length>0)
			me.removeDocked(me.getDockedItems()[0]);
		var toolbar = Ext.create('Ext.toolbar.Toolbar',{
			xtype: 'toolbar',
			dock: 'top'
		});
		toolbar.add({
			iconCls: 'image-add',
			text: 'Add new image',
			tooltip: 'Add a new image to this scan',
			handler: function(){
              	me.fireEvent('addclick',image);
			}
        });
		toolbar.add({
			iconCls: 'image-edit',
			text: 'Replace image',
			tooltip: 'Replace this image',
			handler: function(){
              	me.fireEvent('editclick',image);
			}
        });
		toolbar.add({
			iconCls: 'image-viewer-window',
			tooltip: 'View image in external viewer',
			handler: function(){
              	me.fireEvent('viewerwindowclick',image)
            }
        });
		toolbar.add({
			iconCls: 'image-viewer-panel',
			tooltip: 'View image in viewer',
			handler: function(){
              	me.fireEvent('viewerpanelclick',image)
            }
        });
		if(!image.get('useForPublication')){
			toolbar.add({
				iconCls: 'image-publish',
				tooltip: 'Use image for publication',
				handler: function(){
	              	me.fireEvent('publishclick',image)
	            }
	        });
		}
		toolbar.add({
			iconCls: 'image-download',
			tooltip: 'Download the original of this image',
			handler: function(){
              	me.fireEvent('downloadclick',image);
            }
        });
		toolbar.add({ xtype: 'tbfill' });
		toolbar.add({
			iconCls: 'image-delete',
			text: 'Delete image',
			tooltip: 'Delete this image',
			handler: function(gridView, rowIndex, colIndex, column, e){
              	me.fireEvent('deleteclick',image);
            }
        });
		me.addDocked(toolbar);
		me.addImage(image);
		me.show();
	}
});