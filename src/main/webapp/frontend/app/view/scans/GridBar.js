Ext.define('Scanstore.view.scans.GridBar', {
    extend: 'Ext.toolbar.Toolbar',
    dock: 'top',
    xtype: 'scanGridBar',
    height: 30,
    items: [
        {
        	iconCls: 'scans-save',
            text: 'Save scans',
            tooltip: 'Save all pending changes to edited scans',
            id: 'scan-overview-save-btn'
        },
        {
        	iconCls: 'cancel',
            text: 'Cancel',
            tooltip: 'Remove all pending changes to edited scans',
            id: 'scan-overview-cancel-btn'
        },
	    {
        	xtype: 'toolbar',
        	id: 'scan-filter',
        	border: false,
        	items: [
       	        {
			        xtype: 'tbtext',
			        text: '<span style="font-style:italic;color:#AAAAAA;;margin:0 5px 0 15px">Filter</span>'
			    },
		        {
				    xtype: 'numberfield',
			    	id: 'scan-filter-number',
				    name: 'number',
				    emptyText: 'Number...',
				    width: 125,
				    plugins: ['clearbutton']
				},
				{
				    xtype: 'combobox',
				    id: 'scan-filter-archive',
				    name: 'archiveID',
				    store: 'Archives',
				    displayField: 'name',
				    valueField: 'id',
				    emptyText: 'Archive...',
				    width: 125,
				    plugins: ['clearbutton']
				},
				{
				    xtype: 'combobox',
				    id: 'scan-filter-file',
				    name: 'archiveFileID',
				    store: 'Files',
				    displayField: 'number',
				    valueField: 'id',
				    emptyText: 'File...',
				    width: 125,
				    plugins: ['clearbutton']
				},
				{
				    xtype: 'combobox',
				    id: 'scan-filter-status',
				    name: 'statusID',
				    store: 'Status',
				    displayField: 'name',
				    valueField: 'id',
				    emptyText: 'Status...',
				    width: 100,
				    forceSelection:true,
				    plugins: ['clearbutton']
				},
		        {
		        	iconCls: 'search',
		            text: 'Apply',
		            tooltip: 'Filter with selected filters',
		            id: 'scan-overview-search-btn'
		        },
		        {
		        	iconCls: 'clear',
		            text: 'Clear',
		            tooltip: 'Reset all filter options',
		            id: 'scan-overview-clear-btn'
		        },
				{
				    xtype: 'checkbox',
				    id: 'scan-filter-auto',
				    name: 'autosearch',
				    labelWidth: 0,
				    fieldLabel: 'Autofilter'
				}
        	]
       	},
	    { xtype: 'tbfill' },
	    {
        	iconCls: 'scans-delete',
            text: 'Delete scans',
            tooltip: 'Delete all selected scans',
            id: 'scan-overview-delete-btn'
        }
	],
	listeners:{
		'resize':{
	        fn:function(){
	        	if(this.getWidth()>1050){
	        		this.getComponent('scan-filter').show();
	        	} else {
	        		this.getComponent('scan-filter').hide();
	        	}
	        }
		}
	}
});