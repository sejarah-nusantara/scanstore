Ext.define('Scanstore.model.Image', {
	extend: 'Ext.data.Model',
	fields: [
		{ name: 'id', type: 'string' },
		{ name: 'fileUrl', type: 'string' },
		{ name: 'originalFileName', type: 'string' },
		{ name: 'useForPublication', type: 'boolean' },
		{ name: 'scanID', type: 'string' }
	],
	proxy: {
		type: 'ajax',
		api: {
			update: Scanstore.serverurl+'remote/RemoteImageService.cfc?method=updateImage',
			destroy: Scanstore.serverurl+'remote/RemoteImageService.cfc?method=removeImage'
		}
	}
	//associations: [
	//	{ type: 'hasOne', model: 'Institution', foreignKey: 'institutionID', associationKey: 'institution' }
	//],
});