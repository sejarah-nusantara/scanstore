Ext.define('Scanstore.store.Files', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.File',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=getFiles'
		},
		pageSize: Scanstore.pagesize,
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