Ext.define('Scanstore.view.scans.edit.EditTabIdentification', {
	extend: 'Ext.panel.Panel',
    xtype: 'scanEditTabIdentification',
    title: 'Identification and status',
    layout: 'anchor',
	bodyPadding: 30,
	border: false,
	items: [
		{
		    xtype: 'displayfield',
		    name: 'number',
		    fieldLabel: 'Scan number',
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'combobox',
		    name: 'institutionID',
		    fieldLabel: 'Institution',
		    store: 'Institutions',
		    displayField: 'name',
		    valueField: 'id',
		    allowBlank: false,
		    forceSelection:true,
		    disabled:true,
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'combobox',
		    name: 'archiveID',
		    fieldLabel: 'Archive',
		    store: 'Archives',
		    displayField: 'name',
		    valueField: 'id',
		    allowBlank: false,
		    forceSelection:true,
		    disabled:true,
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'combobox',
		    name: 'archiveFileID',
		    fieldLabel: 'File',
		    store: 'Files',
		    displayField: 'number',
		    valueField: 'id',
		    allowBlank: false,
		    forceSelection:true,
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'combobox',
		    name: 'statusID',
		    fieldLabel: 'Status',
		    store: 'Status',
		    displayField: 'name',
		    valueField: 'id',
		    allowBlank: false,
		    forceSelection:true,
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'textfield',
		    name: 'source',
		    fieldLabel: 'Source',
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'textfield',
		    name: 'URI',
		    fieldLabel: 'URI',
		    labelWidth: 200,
		    anchor: '100%'
		},
		{
		    xtype: 'textfield',
		    name: 'relation',
		    fieldLabel: 'Relation',
		    labelWidth: 200,
		    anchor: '100%'
		}
	]
});