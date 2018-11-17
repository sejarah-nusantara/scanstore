Ext.define('Scanstore.store.Institutions', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.Institution',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=getIntitutions'
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