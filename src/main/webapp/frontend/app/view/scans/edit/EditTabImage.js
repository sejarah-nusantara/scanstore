Ext.define('Scanstore.view.scans.edit.EditTabImage', {
	extend: 'Ext.panel.Panel',
    xtype: 'scanEditTabImage',
    title: 'Image content descriptive',
    layout: 'anchor',
	bodyPadding: 30,
	border: false,
	items: [
		{
		    xtype: 'textfield',
		    name: 'title',
		    fieldLabel: 'Title',
		    allowBlank: false,
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'combobox',
		    name: 'type',
		    fieldLabel: 'Type',
		    store: 'Types',
		    displayField: 'name',
		    valueField: 'name',
		    allowBlank: false,
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'combobox',
		    name: 'languageID',
		    fieldLabel: 'Language',
		    store: 'Languages',
		    displayField: 'name',
		    valueField: 'id',
		    allowBlank: false,
		    forceSelection:true,
		    labelWidth: 200,
		    anchor: '100%'
		},
        {
		    xtype: 'numberfield',
		    name: 'sequenceNumber',
		    fieldLabel: 'Sequence number',
		    allowBlank: false,
		    labelWidth: 200,
		    minValue: 1,
		    anchor: '100%'
		},
		{
		    xtype: 'textfield',
		    name: 'folioNumber',
		    fieldLabel: 'Folio number',
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'textfield',
		    name: 'originalFolioNumber',
		    fieldLabel: 'Original folio number',
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'datefield',
		    name: 'timeFrameFrom',
		    fieldLabel: 'Time frame from',
		    labelWidth: 200,
		    format: Scanstore.dateformat,
		    anchor: '100%'
		},
		{
		    xtype: 'datefield',
		    name: 'timeFrameTo',
		    fieldLabel: 'Time frame to',
		    labelWidth: 200,
		    format: Scanstore.dateformat,
		    anchor: '100%'
		},
		{
		    xtype: 'textareafield',
		    name: 'subjectEN',
		    rows:8,
		    fieldLabel: 'Subject',
		    labelWidth: 200,
		    anchor: '100%'
		}
	]
});
