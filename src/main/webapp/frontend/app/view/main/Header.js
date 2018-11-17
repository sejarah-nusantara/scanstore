Ext.define('Scanstore.view.main.Header', {
	extend: 'Ext.container.Container',
	region: 'north',
	xtype: 'mainHeader',
	baseCls: 'main-header',
	layout: {
		type: 'hbox',
		align: 'stretch'
	},
	items:[
		{
			xtype: 'tbtext',
			margin: 10,
			id: 'main-title',
			text: '<div style="width:16px;margin:1px 12px 0 0;" class="x-btn-icon application-window">&nbsp;</div>DASA - Scanstore<div class="version">v'+Scanstore.version+'</div>'
		},
		{ xtype: 'tbfill' },
		{
			xtype: 'tbtext',
			margin: 10,
			hidden: true,
			id: 'main-header-info'
		},
		{
			xtype: 'toolbar',
			id: 'user-session-box',
			margin: '0 4 0 0',
			border: false,
			hidden: true,
			plain: true,
			style: 'background:none;',
			items:[
				{
					xtype: 'tbtext',
					id: 'user-session-info'
				},
				{
					iconCls: 'user-logoff',
					id: 'user-logout-btn',
					tooltip: 'Logout current user',
					text: 'Logout'
				},
				{
					iconCls: 'help',
					id: 'help-btn',
					tooltip: 'Open scanstore manual'
				}
			]
		}
	]
});