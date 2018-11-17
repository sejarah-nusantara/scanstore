Ext.define('Scanstore.view.scans.edit.EditTabTranscription', {
	extend: 'Ext.panel.Panel',
    xtype: 'scanEditTabTranscription',
    title: 'Transcription and translation',
    layout: 'anchor',
	bodyPadding: 30,
	border: false,
	items: [
		{
		    xtype: 'textfield',
		    name: 'transcriptionAuthor',
		    fieldLabel: 'Transcription author',
		    labelWidth: 200,
		    anchor: '100%'
		},
        {
		    xtype: 'datefield',
		    name: 'transcriptionDate',
		    fieldLabel: 'Transcription date',
		    labelWidth: 200,
		    format: Scanstore.dateformat,
		    anchor: '100%'
		},
		{
		    xtype: 'textareafield',
		    name: 'transcription',
		    rows:8,
		    fieldLabel: 'Transcription',
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'textfield',
		    name: 'translationENAuthor',
		    fieldLabel: 'Translation author (EN)',
		    labelWidth: 200,
		    anchor: '100%'
		},
        {
		    xtype: 'datefield',
		    name: 'translationENDate',
		    fieldLabel: 'Translation date (EN)',
		    labelWidth: 200,
		    format: Scanstore.dateformat,
		    anchor: '100%'
		},
		{
		    xtype: 'textareafield',
		    name: 'translationEN',
		    rows:8,
		    fieldLabel: 'Translation (EN)',
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'textfield',
		    name: 'translationIDAuthor',
		    fieldLabel: 'Translation author (ID)',
		    labelWidth: 200,
		    anchor: '100%'
		},
        {
		    xtype: 'datefield',
		    name: 'translationIDDate',
		    fieldLabel: 'Translation date (ID)',
		    labelWidth: 200,
		    format: Scanstore.dateformat,
		    anchor: '100%'
		},
		{
		    xtype: 'textareafield',
		    name: 'translationID',
		    rows:8,
		    fieldLabel: 'Translation (ID)',
		    labelWidth: 200,
		    anchor: '100%'
		}
	]
});