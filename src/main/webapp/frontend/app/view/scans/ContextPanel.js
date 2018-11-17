Ext.define('Scanstore.view.scans.ContextPanel', {
    extend: 'Scanstore.view.abstract.ContextPanel',
	xtype: 'scanContextPanel',
    toggleWidth:1340,
    initComponent: function() {
    	var me = this;
        me.gridConfig = {
   			iconCls: 'scan-management',
   			title: 'Scan overview',
			xtype: 'scanGrid',
        	layout: 'fit',
        	flex: 2
		};
        me.panelConfig = {
	       	flex: 5
    	};
    	me.callParent(arguments);
    }
});