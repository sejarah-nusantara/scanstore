Ext.define('Scanstore.model.File', {
	extend: 'Ext.data.Model',
	fields: [
		{ name: 'id', type: 'string' },
		{ name: 'archiveID', type: 'string' },
		{ name: 'number', type: 'string' },
		{ name: 'scanCount', type: 'int'  },
		{ name: 'description', type: 'string' },
		{ name: 'statusID', type: 'int' }
	],
	proxy: {
		type: 'ajax',
		api: {
			update: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=updateArchiveFile',
			destroy: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=deleteArchiveFile',
		}
	},
	//associations: [
	//	{ type: 'hasOne', model: 'Archive', foreignKey: 'archiveID', associationKey: 'archive' }
	//],
});
