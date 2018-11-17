/**
 * @class view.scans.EditWindow
 * @extends Ext.window.Window
 */
Ext.define('Scanstore.view.main.LoginWindow', {
    extend: 'Ext.window.Window',
    xtype: 'loginWindow',
    closable: false,
    resizable: false,
    plain: true,
    modal: true,
    border: false,
    width: 350,
    height: 320, 
    title: 'DASA - Scanstore - Login',
    initComponent: function() {
        this.items = [
			{
			    xtype: 'image',
			    src: 'resources/images/logo.png'
			},{
	        	xtype: 'form',
				layout: 'anchor',
				bodyPadding: 20,
				border: false,
				frame: true,
				items: [
					{
					    xtype: 'textfield',
					    name: 'username',
					    fieldLabel: 'Username',
					    labelWidth: 100,
					    anchor: '100%',
					    allowBlank: false
					},{
					    xtype: 'textfield',
					    name: 'password',
					    fieldLabel: 'Password',
					    inputType: 'password',
					    labelWidth: 100,
					    anchor: '100%',
					    allowBlank: false
					},
				],
	            buttons: [
	                {
	     	    	    iconCls: 'user-login',
	    	    	    id: 'user-login-btn',
	                    text: 'Login',
	                }
	            ]
	        }
		]  
        this.callParent(arguments);
    }
});