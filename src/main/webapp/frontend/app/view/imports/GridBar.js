Ext.define('Scanstore.view.imports.GridBar', {
    extend: 'Ext.toolbar.Toolbar',
    dock: 'top',
    xtype: 'importGridBar',
    height: 30,
    items:[
		{
			iconCls: 'archive-import-upload',
			id: 'upload-import-archive-btn',
			tooltip: 'Upload & import compressed (ZIP) scan collection',
			text: 'Upload & import scan collection'
		},
		{
			iconCls: 'archive-upload',
			id: 'upload-archive-btn',
			tooltip: 'Upload compressed (ZIP) scan collection',
			text: 'Upload scan collection'
		},
	    {
        	xtype: 'toolbar',
        	id: 'import-progresspanel',
        	border: false,
        	hidden: true,
        	items: [
       	        {
			        xtype: 'tbtext',
			        text: '<span style="font-style:italic;color:#AAAAAA;margin:0 5px 0 15px">Upload</span>'
			    },
				{
					xtype: 'progressbar',
					id: 'import-progressbar',
					width: 250,
					border:true,
					style:{
						backgroundColor:'#FFFFFF'
					}
				},
		        {
		        	iconCls: 'delete',
		            text: 'Cancel',
		            tooltip: 'Cancel the ongoing upload',
		            id: 'upload-cancel-btn'
		        },
       	        {
			        xtype: 'tbtext',
			        id: 'import-progresstext'
			    }
			]
		}
	]
});