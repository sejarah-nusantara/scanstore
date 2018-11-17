Ext.define('Scanstore.view.imports.Grid', {
    extend: 'Scanstore.view.abstract.Grid',
    xtype: 'importGrid',
    store: 'ImportDirectories',
    border: false,
    margin: 1,
    initComponent: function() {
        var me = this;
        me.dockedItems = [
			{ xtype: 'importGridBar' },
            {
		  		xtype: 'pagingtoolbar',
		  		inputItemWidth: 40,
		  		dock: 'bottom',
		  		store: me.getStore(),
				displayInfo: true,
				displayMsg: 'Import folders {0} - {1} of {2}',
				emptyMsg: "No import folders to display"
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
                    text: 'Name',
                    dataIndex: 'directoryName',
                    flex: 1,
                    minWidth: 200,
                    hideable: false
                },
                {
                    xtype: 'datecolumn',
                    text: 'Creation Date',
                    dataIndex: 'creationDate',
                    width: 130,
                    importance: 2,
                    format: Scanstore.dateformat+' '+Scanstore.timeformat
                },
                {
                    xtype: 'datecolumn',
                    text: 'Last Import Date',
                    dataIndex: 'lastImportdate',
                    width: 130,
                    importance: 2,
                    format: Scanstore.dateformat+' '+Scanstore.timeformat
                },
                {
                    text: 'Queue Count',
                    dataIndex: 'fileQueue',
                    importance: 3,
                    width: 90
                },
                {
                    text: 'File Count',
                    dataIndex: 'fileCount',
                    importance: 3,
                    width: 90
                },
                {
                    text: 'Failure Count',
                    dataIndex: 'failureCount',
                    importance: 3,
                    width: 90
                },
                {
                    text: 'Status',
                    dataIndex: 'isProcessing',
                    importance: 1,
                    width: 60,
                    renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
	                   	if(value){
                    		return '<img src="resources/images/loading-light.gif" class="state" title="Importing scan collection" />';
	                   	} else if (record.get('fileCount') == 0){
	                   		return '<img src="resources/images/exclamation.png" class="state" title="Scan collection has no files for import, please try uploading the archive again" />';
	                   	} else if (record.get('failureCount') > 0){
	                   		return '<img src="resources/images/exclamation.png" class="state" title="Import scan collection failed, check log!" />';
	                   	} else if (record.get('fileQueue') == 0){
	                   		return '<img src="resources/images/accept.png" class="state" title="Import scan collection succeeded" />';
	                   	} else {
	                   		return '<img src="resources/images/unknown.png" class="state" title="Import scan collection pending" />';
	                   	}
    	            }
                },
                {
                    xtype: 'actioncolumn',
                    menuDisabled: true,
                    align: 'right',
                    sortable: false,
                    hideable: false,
                    width: 80,
                    items:[
   		                {
		                	iconCls: 'import-log actionitem',
		                    tooltip: 'View  scan collection log',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('logclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
                        {
		                	tooltip: 'Import scan collection',
	   	                    getClass: function (value, metadata, record) {
	   	                    	if (record.get('isProcessing') || record.get('fileQueue') == 0) {
	   	                    		return 'x-action-col-img-noaction';
	   	                        } else {
	   	                        	return 'import-import actionitem';
	   	                        }
	   	                    },
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('importclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
		                	iconCls: 'import-delete actionitem',
		                    tooltip: 'Delete scan collection',
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