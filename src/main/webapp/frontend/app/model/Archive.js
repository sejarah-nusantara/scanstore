Ext.define('Scanstore.model.Archive', {
	extend: 'Ext.data.Model',
	fields: [
		{ name: 'id', type: 'string' },
		{ name: 'institutionID', type: 'string' },
		{ name: 'name', type: 'string' },
		{ name: 'description', type: 'string' }
	]
	//associations: [
	//	{ type: 'hasOne', model: 'Institution', foreignKey: 'institutionID', associationKey: 'institution' }
	//],
});