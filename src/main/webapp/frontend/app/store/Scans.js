Ext.define('Scanstore.store.Scans', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.Scan',
	groupField: 'archiveID',
	proxy: {
		type: 'ajax',
		api: {
			update: Scanstore.serverurl+'remote/RemoteScanstoreController.cfc?method=updateScans',
			read: Scanstore.serverurl+'remote/RemoteScanstoreController.cfc?method=searchScans'
		},
		pageSize: Scanstore.pagesize,
		reader: {
			type: 'json',
			root: 'collection',
			idProperty: 'id',
			successProperty: 'success',
			totalProperty: 'count',
			messageProperty: 'message'
		},
		writer: {
			allowSingle: false,
			writeAllFields: false
		}
	}
});