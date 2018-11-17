Ext.define('Scanstore.view.images.UploadAddWindow', {
    extend: 'Ext.window.Window',
    xtype: 'imageUploadAddWindow',
    closeAction: 'hide',
    title: "Add new image",
    modal: true,
    border: false,
    resizable: false,
    width: 400,
    height: 175,
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
                    id: 'image-add-window-upload-btn'
                },
                {
                    text: 'Cancel',
                    id: 'image-add-window-cancel-btn'
                }
            ]
        }]  
        this.callParent(arguments);
    }
});