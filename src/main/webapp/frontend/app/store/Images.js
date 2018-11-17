Ext.define('Scanstore.store.Images', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.Image',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteImageService.cfc?method=getImages'
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