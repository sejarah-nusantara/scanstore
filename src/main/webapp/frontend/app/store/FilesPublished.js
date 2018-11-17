Ext.define('Scanstore.store.FilesPublished', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.File',
	groupField: 'archiveID',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteArchiveService.cfc?method=getFilesListForPublishing'
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