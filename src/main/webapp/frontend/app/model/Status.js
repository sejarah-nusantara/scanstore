Ext.define('Scanstore.model.Status', {
	extend: 'Ext.data.Model',
	fields: [
		{ name: 'id', type: 'int' },
		{ name: 'name', type: 'string' },
		{ name: 'description', type: 'string' }
	]
});