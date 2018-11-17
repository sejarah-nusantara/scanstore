Ext.define('Scanstore.view.imports.LogWindow', {
    extend: 'Ext.window.Window',
    xtype: 'importLogWindow',
    modal: true,
    layout: 'fit',
    bodyCls: 'log',
    iconCls: 'import-log-viewer',
    initComponent: function() {
    	var me = this;
		me.setHeight(Ext.getBody().getViewSize().height-30);
		me.setWidth(800);
		me.center();
		me.callParent(arguments);
		me.loadMask = new Ext.LoadMask(me, {msg:"Loading log..."});
    },
    setLoader: function() {
    	var me = this;
    	me.callParent(arguments);
    	if(me.items.length==0){
			me.loadMask.show();
    	}
    },
    setLog: function(log){
    	var me = this;
    	me.loadMask.hide();
		me.add({
			type: "panel",
			html: log
		});
	}
});