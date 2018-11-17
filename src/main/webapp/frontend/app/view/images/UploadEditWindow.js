Ext.define('Scanstore.view.images.UploadEditWindow', {
    extend: 'Ext.window.Window',
    xtype: 'imageUploadEditWindow',
    closeAction: 'hide',
    title: "Replace image",
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
				    xtype: 'hiddenfield',
				    name: 'scanID',
				},
				{
				    xtype: 'hiddenfield',
				    name: 'id',
				},
				{
				    xtype: 'displayfield',
				    name: 'imageDisplay',
				    fieldLabel: 'Current image',
				    labelWidth: 100,
				    anchor: '100%'
				},
		        {
					xtype:'fieldset',
					columnWidth: 0.5,
					title: 'Location of the image',
					layout: 'anchor',
					items: [
						{
						    xtype: 'filefield',
						    name: 'filedata',
						    fieldLabel: 'Image file',
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
                    id: 'image-edit-window-upload-btn'
                },
                {
                    text: 'Cancel',
                    id: 'image-edit-window-cancel-btn'
                }
            ]
        }]  
        this.callParent(arguments);
    }
});