Ext.define('Scanstore.store.Types', {
	extend: 'Ext.data.Store',
	model: 'Scanstore.model.Type',
	data : [
		{ name: 'Handwritten folio' },
		{ name: 'Page of a book publication' }
	],
	proxy: {
		type: 'memory'
	}
});