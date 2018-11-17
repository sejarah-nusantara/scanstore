Ext.define('Scanstore.view.files.Grid', {
    extend: 'Scanstore.view.abstract.Grid',
    xtype: 'fileGrid',
    store: 'FilesPublished',
    initComponent: function() {
        var me = this;
        me.features = [
        	{ ftype:'grouping' }
        ];
        me.dockedItems = [
            {
		  		xtype: 'pagingtoolbar',
		  		inputItemWidth: 40,
		  		dock: 'bottom',
				store: me.getStore(),
				displayInfo: true,
				displayMsg: 'Files {0} - {1} of {2}',
				emptyMsg: "No files to display"
		  	}
		];
        me.columns = {
            defaults: {
                draggable: true,
                resizable: true,
                hideable: true
            },
            items: [
                {
                    text: 'Archive',
                    dataIndex: 'archiveID',
                    flex: 1,
                    minWidth: 100,
                    importance: 2,
                    renderer: function(value, metaData, scan, rowIndex, colIndex, store, view) {
                    	try {
                    		return Ext.getStore('Archives').getById(value).get('name');
                    	} catch(e){
                    		return value;
                    	}
                    }
                },
                {
                    text: 'Number',
                    dataIndex: 'number',
                    flex: 1,
                    minWidth: 100,
                    hideable: false
                },
                {
                    text: 'Scan Count',
                    dataIndex: 'scanCount',
                    flex: 1,
                    minWidth: 100,
                    hideable: true
                },
                {
                    text: 'Published',
                    dataIndex: 'statusID',
                    importance: 1,
                    width: 60,
                    renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
	                   	if(value == 2){
	                   		return '<img src="resources/images/accept.png" class="state" title="Archive file is public" />';
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
                    hideable: false,
                    width: 50,
                    items:[
                    	{
	   	                    tooltip: 'Unpublish file',
	   	                    getClass: function (value, metadata, record) {
	   	                    	if (record.get('statusID') != 2) {
	   	                    		return 'x-action-col-img-noaction';
	   	                        } else {
	   	                        	return 'file-unpublish actionitem';
	   	                        }
	   	                    },
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('unpublishclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
	   	                    tooltip: 'Publish file',
		                	getClass: function (value, metadata, record) {
	   	                    	if (record.get('statusID') == 2) {
	   	                    		return 'x-action-col-img-noaction';
	   	                        } else {
	   	                        	return 'file-publish actionitem';
	   	                        }
	   	                    },
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('publishclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
		                	iconCls: 'scans-delete actionitem',
		                    tooltip: 'Delete all scans attached to this file and archive',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('deletescansclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                }
					]
                }
            ]
        };
        me.callParent(arguments);
    },

});