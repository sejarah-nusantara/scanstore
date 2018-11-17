Ext.define('Scanstore.store.ImportDirectories', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.ImportDirectory',
	listeners:{
		beforeload: function(store){
			store.isLoading = true;
			if(store.lastRequest) Ext.Ajax.abort(store.lastRequest);
		},
		load: function(store){
			store.isLoading = false;
		}
	},
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteScanImportService.cfc?method=getPendingImports'
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