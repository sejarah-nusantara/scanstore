Ext.define('Scanstore.view.scans.Grid', {
    extend: 'Scanstore.view.abstract.Grid',
    xtype: 'scanGrid',
    store: 'Scans',
    enableDragDrop: true,
    selModel: {selType: 'rowmodel', mode: 'MULTI'},
    viewConfig: {
    	listeners: {
    		beforedrop: function(node, data, target, position){
    			var accepted = false;
    			if(data.records.length==1){
	    			var origin = data.records[0];
	    			if(origin.get('archiveID') == target.get('archiveID') && origin.get('archiveFileID') == target.get('archiveFileID')){
	    				var nPos = target.get('sequenceNumber');
	    				var oPos = origin.get('sequenceNumber');
	    				if(position == 'before' && nPos > oPos) nPos--;
	    				else if(position == 'after' && nPos < oPos) nPos++;
	    				origin.set('sequenceNumber',nPos);
	    				accepted = true;
	    			}
    			}
				return accepted;
    		}
    	},
    	plugins: [
    		{
	    	    ptype: 'gridviewdragdrop',
    		    dragText: 'Reorder scans (Change sequence number)'
    		}
    	]
    },
    initComponent: function() {
        var me = this;
        me.plugins = [
			{ ptype: 'cellediting' }
       	];
        me.features = [
            { ftype:'grouping' }
        ];
        me.dockedItems = [
            { xtype: 'scanGridBar' },
            {
            	xtype: 'pagingtoolbar',
            	inputItemWidth: 40,
            	dock: 'bottom',
            	store: me.getStore(),
            	displayInfo: true,
            	displayMsg: 'Scans {0} - {1} of {2}',
            	emptyMsg: "No scans to display"
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
                    text: 'Institution',
                    dataIndex: 'institutionID',
                    flex: 1,
                    minWidth: 100,
                    importance: 5,
                    renderer: function(value, metaData, scan, rowIndex, colIndex, store, view) {
                    	try {
                    		return Ext.getStore('Institutions').getById(value).get('name');
                    	} catch(e){
                    		return value;
                    	}
                    }
                },
                {
                    text: 'Archive',
                    dataIndex: 'archiveID',
                    flex: 1,
                    editor: {
                    	xtype: 'combobox',
    				    store: 'Archives',
    				    forceSelection: true,
    				    displayField: 'name',
    				    valueField: 'id',
    				    selectOnFocus: true
                    },
                    minWidth: 60,
                    importance: 5,
                    renderer: function(value, metaData, scan, rowIndex, colIndex, store, view) {
                    	try {
                    		return Ext.getStore('Archives').getById(value).get('name');
                    	} catch(e){
                    		return value;
                    	}
                    }
                },
                {
                    text: 'File',
                    dataIndex: 'archiveFileID',
                    flex: 1,
                    editor: {
                    	xtype: 'combobox',
    				    store: 'Files',
    				    forceSelection: true,
    				    displayField: 'number',
    				    valueField: 'id',
    				    selectOnFocus: true
                    },
                    minWidth: 60,
                    importance: 1,
                    renderer: function(value, metaData, scan, rowIndex, colIndex, store, view) {
                    	try {
                    		return Ext.getStore('Files').getById(value).get('number');
                    	} catch(e){
                    		return value;
                    	}
                    }
                },
                {
                    text: 'Seq.',
                    width: 60,
                    dataIndex: 'sequenceNumber',
                    importance: 1,
                    editor: {
                        xtype: 'numberfield',
                        selectOnFocus: true,
                        minValue: 1
                    }
                },
                {
                    text: 'Status',
                    dataIndex: 'statusID',
                    flex: 1,
                    editor: {
                    	xtype: 'combobox',
    				    store: 'Status',
    				    forceSelection: true,
    				    displayField: 'name',
    				    valueField: 'id',
    				    selectOnFocus: true
                    },
                    minWidth: 60,
                    importance: 1,
                    renderer: function(value, metaData, scan, rowIndex, colIndex, store, view) {
                    	try {
                    		return Ext.getStore('Status').getById(value).get('name');
                    	} catch(e){
                    		return value;
                    	}
                    }
                },
                {
                    text: 'Nr.',
                    minWidth: 60,
                    flex: 1,
                    hideable: false,
                    dataIndex: 'number'
                },
                {
                    text: 'Thumb',
                    dataIndex: 'imageUrl',
                    width: 60,
                    sortable: false,
                    importance: 2,
                    renderer: function(value, metaData, scan, rowIndex, colIndex, store, view) {
                    	return '<img src="'+value+'?size=x25" class="thumbnail" />';
                    }
                },
                {
                    text: 'Title',
                    dataIndex: 'title',
                    flex: 3,
                    hideable: true,
                    minWidth: 200,
                    importance: 2,
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
                },
                {
                    text: 'Folio number',
                    dataIndex: 'folioNumber',
                    width: 110,
                    importance: 3,
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
                },
                {
                    text: 'Orig. folio number',
                    dataIndex: 'originalFolioNumber',
                    width: 120,
                    importance: 3,
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
                },
                {
                    xtype: 'datecolumn',
                    text: 'Time fr. from',
                    dataIndex: 'timeFrameFrom',
                    width: 90,
                    editor: {
                        xtype: 'datefield',
                        format: Scanstore.dateformat
                    },
                    importance: 3,
                    format: Scanstore.dateformat
                },
                {
                    xtype: 'datecolumn',
                    text: 'Time fr. to',
                    dataIndex: 'timeFrameTo',
                    width: 90,
                    editor: {
                        xtype: 'datefield',
                        format: Scanstore.dateformat
                    },
                    importance: 3,
                    format: Scanstore.dateformat
                },
                {
                    text: 'Subject',
                    dataIndex: 'subjectEN',
                    minWidth: 200,
                    importance: 5,
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
                },
                {
                    xtype: 'datecolumn',
                    text: 'Creation date',
                    dataIndex: 'date',
                    width: 90,
                    editor: 'datefield',
                    importance: 2,
                    format: Scanstore.dateformat
                },
                {
                    text: 'Creator',
                    minWidth: 90,
                    importance: 4,
                    dataIndex: 'creator'
                },
                {
                    text: 'Contributor',
                    minWidth: 90,
                    importance: 4,
                    dataIndex: 'contributor'
                },
                {
                    text: 'Publisher',
                    minWidth: 90,
                    importance: 4,
                    dataIndex: 'publisher'
                },
                {
                    xtype: 'actioncolumn',
                    menuDisabled: true,
                    sortable: false,
                    hideable: false,
                    width: 80,
                    items:[
                    	{
                    		iconCls: 'image-viewer-panel actionitem',
                            style: { margin: '10px;' },
                    		tooltip: 'View published image in viewer',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('viewerpanelclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
		                	iconCls: 'scan-edit actionitem',
		                    tooltip: 'Edit scan',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('editclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
		                	iconCls: 'scan-delete actionitem',
		                    tooltip: 'Delete scan',
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