Ext.define('Scanstore.model.ImportDirectory', {
	extend: 'Ext.data.Model',
	fields: [
		{ name: 'id', type: 'string' },
		{ name: 'directoryName', type: 'string' },
		{ name: 'fileCount', type: 'int' },
		{ name: 'creationDate', type: 'date', dateFormat: 'Y-m-d H:i:s' },
		{ name: 'lastImportdate', type: 'date', dateFormat: 'Y-m-d H:i:s' },
		{ name: 'fileQueue', type: 'int' },
		{ name: 'failureCount', type: 'int' },
		{ name: 'isProcessing', type: 'boolean' },
		{ name: 'logInfo', type: 'string' }
	],
	proxy: {
		type: 'ajax',
		api: {
			destroy: Scanstore.serverurl+'remote/RemoteScanImportService.cfc?method=deleteImportDirectory',
			read: Scanstore.serverurl+'remote/RemoteScanImportService.cfc?method=getImportDirectory'
		},
		reader: {
			type: 'json',
			root: 'item',
			successProperty: 'success',
			messageProperty: 'message'
		}
	}
});