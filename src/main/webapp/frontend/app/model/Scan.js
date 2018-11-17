Ext.define('Scanstore.model.Scan', {
	extend: 'Ext.data.Model',
	fields: [
		{ name: 'number', type: 'int' },
		{ name: 'archiveID', type: 'string' },
		{ name: 'archiveFileID', type: 'string' },
		{ name: 'statusID', type: 'int' },
		{ name: 'languageID', type: 'string' },
		{ name: 'institutionID', type: 'string' },
		{ name: 'sequenceNumber', type: 'int' },
		{ name: 'imageUrl', type: 'string' },
		{ name: 'folioNumber', type: 'string' },		
		{ name: 'originalFolioNumber', type: 'string' },
		{ name: 'creator', type: 'string' },
		{ name: 'contributor', type: 'string' },
		{ name: 'publisher', type: 'string' },
		{ name: 'rights', type: 'string' },
		{ name: 'URI', type: 'string' },
		{ name: 'date', type: 'date', dateFormat: 'Y-m-d' },
		{ name: 'format', type: 'string' },
		{ name: 'title', type: 'string' },
		{ name: 'type', type: 'string' },
		{ name: 'source', type: 'string' },
		{ name: 'relation', type: 'string' },
		{ name: 'timeFrameFrom', type: 'date', dateFormat: 'Y-m-d' },
		{ name: 'timeFrameTo', type: 'date', dateFormat: 'Y-m-d' },
		{ name: 'subjectEN', type: 'string' },
		{ name: 'transcriptionAuthor', type: 'string' },
		{ name: 'transcriptionDate', type: 'date', dateFormat: 'Y-m-d' },
		{ name: 'transcription', type: 'string' },
		{ name: 'translationEN', type: 'string' },
		{ name: 'translationENAuthor', type: 'string' },
		{ name: 'translationENDate', type: 'date', dateFormat: 'Y-m-d' },
		{ name: 'translationIDAuthor', type: 'string' },
		{ name: 'translationIDDate', type: 'date', dateFormat: 'Y-m-d' },
		{ name: 'translationID', type: 'string' }
	],
	idProperty:'number',
	//associations: [
	//	{ type: 'hasOne', model: 'Archive', foreignKey: 'archiveID', associationKey: 'archive' },
	//	{ type: 'hasOne', model: 'File', foreignKey: 'archiveFileID', associationKey: 'archiveFile' },
	//	{ type: 'hasOne', model: 'Status', foreignKey: 'statusID', associationKey: 'status' },
	//	{ type: 'hasOne', model: 'Status', foreignKey: 'languageID', associationKey: 'language' },
	//	{ type: 'hasOne', model: 'Institution', foreignKey: 'institutionID', associationKey: 'institution' }
	//],
	proxy: {
		type: 'ajax',
		api: {
			update: Scanstore.serverurl+'remote/RemoteScanstoreController.cfc?method=updateScan',
			destroy: Scanstore.serverurl+'remote/RemoteScanstoreController.cfc?method=deleteScan'
		}
	},
	writer: {
		writeAllFields: false
	}
});
