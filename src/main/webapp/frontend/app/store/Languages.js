Ext.define('Scanstore.store.Languages', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.Language',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=getLanguages'
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