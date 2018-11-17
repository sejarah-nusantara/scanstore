Ext.define('Scanstore.view.imports.UploadWindow', {
    extend: 'Ext.window.Window',
    xtype: 'importUploadWindow',
    closeAction: 'hide',
    title: "Upload scan collection",
    modal: true,
    border: false,
    resizable: false,
    width: 400,
    height: 200,
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
					xtype:'fieldset',
					columnWidth: 0.5,
					title: 'Location of the scan collection',
					layout: 'anchor',
					items: [
						{
						    xtype: 'filefield',
						    name: 'filedata',
						    fieldLabel: 'ZIP file',
						    labelWidth: 100,
						    allowBlank: false,
						    anchor: '100%',
						    buttonText: 'Select file...'
						}
					]
				}
			],
            buttons: [
                {
                    text: 'Upload',
                    id: 'import-upload-window-upload-btn'
                },
                {
                    text: 'Cancel',
                    id: 'import-upload-window-cancel-btn'
                }
            ]
        }]  
        this.callParent(arguments);
    }
});