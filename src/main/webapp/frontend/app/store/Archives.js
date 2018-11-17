Ext.define('Scanstore.store.Archives', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.Archive',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=getArchives'
		},
		reader: {
			type: 'json',
			root: 'collection',
			idProperty: 'id',
			successProperty: 'success',
			totalProperty: 'count',
			messageProperty: 'message'
		}
	}
});