Ext.define('Scanstore.store.ImportScenarios', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.ImportScenario',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteScanImportService.cfc?method=getImportScenarios'
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