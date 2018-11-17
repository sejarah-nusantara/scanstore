Ext.define('Scanstore.view.imports.ImportWindow', {
    extend: 'Ext.window.Window',
    xtype: 'importImportWindow',
    closeAction: 'hide',
    title: "Import scan collection",
    modal: true,
    border: false,
    resizable: false,
    width: 400,
    height: 350,
    layout: 'fit',
    initComponent: function() {
        this.items = [{
        	xtype: 'form',
			layout: 'anchor',
			bodyPadding: 20,
			border: false,
			frame: true,
			items: [
				{
				    xtype: 'displayfield',
				    name: 'importDirectoryDisplay',
				    fieldLabel: 'Import folder',
				    labelWidth: 100,
				    anchor: '100%'
				},
				{
				    xtype: 'hiddenfield',
				    name: 'importDirectory',
				},
				{
					xtype:'fieldset',
					columnWidth: 0.5,
					title: 'Shared scan collection meta data',
					layout: 'anchor',
					items: [
						{
						    xtype: 'displayfield',
						    name: 'institutionDisplay',
						    fieldLabel: 'Institution',
						    labelWidth: 100,
						    anchor: '100%'
						},
						{
						    xtype: 'hiddenfield',
						    name: 'institutionID',
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
						    labelWidth: 100,
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
						    labelWidth: 100,
						    anchor: '100%'
						},
						{
						    xtype: 'combobox',
						    name: 'scenarioID',
						    fieldLabel: 'Scenario',
						    store: 'ImportScenarios',
						    displayField: 'name',
						    valueField: 'id',
						    allowBlank: false,
						    forceSelection:true,
						    labelWidth: 100,
						    anchor: '100%'
						},
						{
						    xtype: 'textfield',
						    name: 'title',
						    fieldLabel: 'Title',
						    allowBlank: false,
						    labelWidth: 100,
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
						    forceSelection:true,
						    labelWidth: 100,
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
						    labelWidth: 100,
						    anchor: '100%'
						}
					]
				}
			],
            buttons: [
                {
                    text: 'Import',
                    id: 'import-import-window-import-btn'
                },
                {
                    text: 'Cancel',
                    id: 'import-import-window-cancel-btn'
                }
            ]
        }]  
        this.callParent(arguments);
    }
});