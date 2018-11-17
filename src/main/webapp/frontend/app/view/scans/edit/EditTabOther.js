Ext.define('Scanstore.view.scans.edit.EditTabOther', {
	extend: 'Ext.panel.Panel',
    xtype: 'scanEditTabOther',
    title: 'Other',
    layout: 'anchor',
	bodyPadding: 30,
	border: false,
	items: [
			{
			    xtype: 'textfield',
			    name: 'creator',
			    fieldLabel: 'Creator',
			    labelWidth: 200,
			    anchor: '100%'
			},
	        {
			    xtype: 'datefield',
			    name: 'date',
			    fieldLabel: 'Scan creation date',
			    labelWidth: 200,
			    format: Scanstore.dateformat,
			    anchor: '100%'
			},
			{
			    xtype: 'textareafield',
			    name: 'format',
			    rows:8,
			    fieldLabel: 'Format',
			    labelWidth: 200,
			    anchor: '100%'
			},
			{
			    xtype: 'textfield',
			    name: 'contributor',
			    fieldLabel: 'Contributor',
			    labelWidth: 200,
			    anchor: '100%'
			},
			{
			    xtype: 'textfield',
			    name: 'publisher',
			    fieldLabel: 'Publisher',
			    labelWidth: 200,
			    anchor: '100%'
			},
			{
			    xtype: 'textfield',
			    name: 'rights',
			    fieldLabel: 'Rights',
			    labelWidth: 200,
			    anchor: '100%'
			}
		]
});