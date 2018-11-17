Ext.define('Scanstore.view.users.ContextPanel', {
	extend: 'Scanstore.view.abstract.ContextPanel',
	xtype: 'userContextPanel',
	toggleWidth:940,
    initComponent: function() {
    	var me = this;
        me.gridConfig = {
    		iconCls: 'user-management',
    		title: 'User overview',
			xtype: 'userGrid',
        	layout: 'fit',
        	flex: 2
		};
        me.panelConfig = {
	       	flex: 3
    	};
    	me.callParent(arguments);
    }
});