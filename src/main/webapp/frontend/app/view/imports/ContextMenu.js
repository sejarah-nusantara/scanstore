Ext.define('Scanstore.view.imports.ContextMenu', {
    extend: 'Ext.menu.Menu',
    xtype: 'importContextMenu',
    setImport: function(importDirectory) {
        this.importDirectory = importDirectory;
        this.removeAll();
        this.add({
	        text: 'View scan collection log',
	        iconCls: 'import-log',
	        id: 'import-context-log-item'
	    });
        if (!importDirectory.get('isProcessing') && importDirectory.get('fileQueue') > 0) {
		    this.add({
		        text: 'Import scan collection',
		        iconCls: 'import-import',
		        id: 'import-context-import-item'
		    });
        }
        this.add({
            text: 'Delete scan collection',
            iconCls: 'import-delete',
            id: 'import-context-delete-item'
	    });
    },
    getImport: function() {
        return this.importDirectory;
    }
});