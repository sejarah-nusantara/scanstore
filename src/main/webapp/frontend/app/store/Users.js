Ext.define('Scanstore.store.Users', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.User',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteUserService.cfc?method=getUsers'
		},
		reader: {
			type: 'json',
			root: 'collection',
			idProperty: 'id',
			successProperty: 'success',
			totalProperty: 'count',
			messageProperty: 'message'
		},
		writer: {
			writeAllFields: false
		}
	}
});