Ext.define('Scanstore.view.images.Grid', {
    extend: 'Ext.grid.Panel',
    xtype: 'imageGrid',
    border: false,
    initComponent: function() {
        var me = this;
        me.dockedItems = [
            {
            	xtype: 'pagingtoolbar',
            	inputItemWidth: 40,
            	dock: 'bottom',
				store: me.getStore(),
            	displayInfo: true,
            	displayMsg: 'Images {0} - {1} of {2}',
            	emptyMsg: "No images to display"
            }
        ];
        me.columns = {
       		defaults: {
                draggable: true,
                resizable: true,
                hideable: false
            },
            items: [
                {
                    text: 'Thumb',
                    dataIndex: 'fileUrl',
                    width: 50,
                    sortable: false,
                    renderer: function(value, metaData, image, rowIndex, colIndex, store, view) {
                    	return '<img src="'+value+'?size=x25" class="thumbnail" />';
                    }
                },
                {
                    text: 'Name',
                    flex:1,
                    dataIndex: 'originalFileName',
                },
                {
                    text: 'Published',
                    dataIndex: 'useForPublication',
                    width: 60,
                    renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
	                   	if(value){
	                   		return '<img src="resources/images/accept.png" class="state" title="Image is used for publication" />';
	                   	} else {
	                   		return '<img src="resources/images/unknown.png" class="state" />';
	                   	}
    	            }
                },
                {
                    xtype: 'actioncolumn',
                    menuDisabled: true,
                    align: 'right',
                    sortable: false,
                    width: 100,
                    items:[
                    	{
                    		iconCls: 'image-viewer-panel actionitem',
                            style: { margin: '10px;' },
                    		tooltip: 'View image in viewer',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('viewerpanelclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
	   	                    tooltip: 'Use image for publication',
	   	                    getClass: function (value, metadata, record) {
	   	                    	if (record.get('useForPublication')) {
	   	                    		return 'x-action-col-img-noaction';
	   	                        } else {
	   	                        	return 'image-publish actionitem';
	   	                        }
	   	                    },
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('publishclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
		                	iconCls: 'image-edit actionitem',
		                    tooltip: 'Replace image',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('editclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
		                	iconCls: 'image-delete actionitem',
		                    tooltip: 'Delete image',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('deleteclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                }
					]
                }
            ]
        };
        me.callParent(arguments);
    }

});