Ext.define('Scanstore.store.Status', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.Status',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=getStatuses'
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