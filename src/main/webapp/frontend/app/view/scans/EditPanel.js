Ext.define('Scanstore.view.scans.EditPanel', {
	extend: 'Ext.panel.Panel',
    xtype: 'scanEditPanel',
    iconCls: 'scan-tab',
    header: false,
    border: false,
	bodyPadding: 1,
	toggleWidth:900,
    layout: {
        type: 'hbox',
        align: 'stretch'
    },
    closable: true,
    initComponent: function() {
    	var me = this;
        me.callParent(arguments);
    	me.imageStore = Ext.create('Scanstore.store.Images');
    	var imageGrid = Ext.create('Scanstore.view.images.Grid',{
			store: me.imageStore,
			flex: 1
		});
		imageGrid.viewPanel = Ext.create('Scanstore.view.images.ViewPanel',{
			flex: 3
		});
		var imagePanel = Ext.create('Ext.panel.Panel',{
   	    	flex: 3,
   	        layout: {
   	            type: 'vbox',
   	            align: 'stretch'
   	        },
   	    	collapsible: true,
   	    	collapseDirection: 'left',
   	    	margin: '0 1 0 0',
   	    	title: 'Scan images',
   	    	iconCls: 'image-panel',
   	    	items: [ imageGrid.viewPanel, imageGrid ]
		});
		me.add(imagePanel);
		var dataPanel = Ext.create('Ext.panel.Panel',{
	    	flex: 4,
	    	layout: 'anchor',
	    	collapsible: true,
	    	collapseDirection: 'right',
			autoScroll: true,
	    	title: 'Scan metadata',
	    	iconCls: 'scan-panel',
	    	items: [{
				xtype: 'form',
				layout: 'fit',
				border: false,
	  	    	dockedItems: [
					{
						xtype: 'toolbar',
						dock: 'top',
						items: [
							{
								iconCls: 'save',
								text: 'Save scan',
								tooltip: 'Save changes and close this scan',
								id: me.id+'-panel-save-btn'
							},
							{
								iconCls: 'cancel',
								text: 'Cancel',
								tooltip: 'Remove all pending changes and close this scan',
								id: me.id+'-panel-cancel-btn'
							},
							{ xtype: 'tbfill' },
							{
								iconCls: 'delete',
								text: 'Delete scan',
								tooltip: 'Delete and close this scan',
								id: me.id+'-panel-delete-btn'
							}
						]
					}
    			],
				items: [
				    {
						xtype: 'tabpanel',
						layout: 'anchor',
						border: false,
						items: [
						    {	xtype: 'scanEditTabIdentification' },
						    {	xtype: 'scanEditTabImage' },
						    {	xtype: 'scanEditTabTranscription' },
						    {	xtype: 'scanEditTabOther' }
						]
					}
				]
			}]
		});
		me.add(dataPanel);
		dataPanel.on('beforecollapse',function(){
			if(imagePanel.getCollapsed()){
				imagePanel.suspendEvents();
				imagePanel.expand();
				imagePanel.resumeEvents();
			}
		});
		dataPanel.on('beforeexpand',function(){
			if(!imagePanel.getCollapsed() && me.getWidth() < me.toggleWidth){
				imagePanel.suspendEvents();
				imagePanel.collapse();
				imagePanel.resumeEvents();
			}
			return true;
		});
		imagePanel.on('beforecollapse',function(){
			if(dataPanel.getCollapsed()){
				dataPanel.suspendEvents();
				dataPanel.expand();
				dataPanel.resumeEvents();
			}
		});
		imagePanel.on('beforeexpand',function(){
			if(!dataPanel.getCollapsed() && me.getWidth() < me.toggleWidth){
				dataPanel.suspendEvents();
				dataPanel.collapse();
				dataPanel.resumeEvents();
			}
			return true;
		});
        me.on('resize',function(){
        	if(me.getWidth() < me.toggleWidth){
        		imagePanel.collapse();
        	} else {
        		imagePanel.expand();
        	}
        })
		me.loadRecord = function(scan){
			var form = dataPanel.query('form')[0].getForm();
			form.loadRecord(scan);
			imageGrid.viewPanel.scan = scan;
			me.imageStore.getProxy().extraParams = { scanID:scan.get('number') };
	        me.imageStore.load();
	    }
    }
});