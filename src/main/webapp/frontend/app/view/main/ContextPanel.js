Ext.define('Scanstore.view.main.ContextPanel', {
	extend: 'Ext.tab.Panel',
	xtype: 'mainContextPanel',
	region: 'center',
	bodyCls: 'main-outline',
	activeTab: 1,
	tabBar:{
		cls:'main-toolbar'
	},
	border: false,
	items: [
		{
			xtype: 'panel',
			tabConfig:{
				margin:'0 0 0 5',
			},
			iconCls: 'import-management',
			title: 'Manage imports',
			layout: 'fit',
			border: false,
			items: [ { xtype:'panel', layout: 'fit',items:[ { xtype:'importGrid' } ] } ],
			id: 'main-import-tab',
			disabled:true
		},
		{
			xtype: 'scanContextPanel',
			iconCls: 'scan-management',
			title: 'Manage scans',
			id: 'main-scan-tab',
			disabled:true
		},
		{
			xtype: 'panel',
			iconCls: 'file-management',
			title: 'Manage archive files',
			layout: 'fit',
			border: false,
			items: [ { xtype:'panel', layout: 'fit',items:[ { xtype:'fileGrid' } ] } ],
			id: 'main-file-tab',
			disabled:true
		},
		{
			xtype: 'userContextPanel',
			iconCls: 'user-management',
			title: 'Manage user',
			id: 'main-user-tab',
			disabled:true
		}
	]
});