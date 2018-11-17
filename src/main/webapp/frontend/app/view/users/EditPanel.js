Ext.define('Scanstore.view.users.EditPanel', {
	extend: 'Ext.panel.Panel',
    xtype: 'userEditPanel',
    iconCls: 'user-tab',
    header: false,
    border: false,
	bodyPadding: 1,
    layout: 'fit',
    closable: true,
    initComponent: function() {
    	var me = this;
        me.callParent(arguments);
		var dataPanel = Ext.create('Ext.form.Panel',{
			layout: 'anchor',
			bodyPadding: 30,
  	    	dockedItems: [
				{
					xtype: 'toolbar',
					dock: 'top',
					items: [
						{
							iconCls: 'save',
							text: 'Save user',
							tooltip: 'Save changes to this user return to the overview',
							id: me.id+'-panel-save-btn'
						},
						{
							iconCls: 'cancel',
							text: 'Cancel',
							tooltip: 'Remove all changes to this user and return to the overview',
							id: me.id+'-panel-cancel-btn'
						},
						{ xtype: 'tbfill' },
						{
							iconCls: 'delete',
							text: 'Delete user',
							tooltip: 'Delete this user and return to the overview',
							id: me.id+'-panel-delete-btn'
						}
					]
				}
			],
			items: [
				{
				    xtype: 'combobox',
				    name: 'institutionID',
				    fieldLabel: 'Institution',
				    store: 'Institutions',
				    displayField: 'name',
				    valueField: 'id',
				    allowBlank: false,
				    forceSelection:true,
				    labelWidth: 200,
				    anchor: '100%'
				},
				{
				    xtype: 'textfield',
				    name: 'username',
				    fieldLabel: 'Username',
				    allowBlank: false,
				    labelWidth: 200,
				    anchor: '100%'
				},
				{
				    xtype: 'textfield',
				    name: 'firstname',
				    fieldLabel: 'Firstname',
				    allowBlank: false,
				    labelWidth: 200,
				    anchor: '100%'
				},
				{
				    xtype: 'textfield',
				    name: 'lastname',
				    fieldLabel: 'Lastname',
				    allowBlank: false,
				    labelWidth: 200,
				    anchor: '100%'
				},
				{
				    xtype: 'textfield',
				    name: 'email',
				    fieldLabel: 'E-Mail',
				    vtype: 'email',
				    labelWidth: 200,
				    anchor: '100%'
				},
				{
				    xtype: 'checkbox',
				    name: 'admin',
				    fieldLabel: 'Administrator',
				    labelWidth: 200,
				    anchor: '100%'
				},
				{
				    xtype: 'textfield',
				    name: 'password',
				    fieldLabel: 'Password',
				    inputType: 'password',
				    labelWidth: 200,
	                vtype: "strength",
	                strength: 10,
	                plugins: {
	                    ptype: "passwordstrength"
	                },
				    validator: function() {
						var form = dataPanel.getForm();
	                    if (form.findField('password').getValue() == form.findField('passwordControl').getValue()){
	                    	form.findField('passwordControl').markInvalid();
	                    	return true;
	                    } else {
	                    	form.findField('passwordControl').markInvalid('Password does not match this field');
	                        return "Repeat password does not match this field";
	                    }
		            },
				    anchor: '100%'
				},
				{
				    xtype: 'textfield',
				    name: 'passwordControl',
				    inputType: 'password',
				    fieldLabel: 'Repeat password',
				    labelWidth: 200,
				    listeners:{
				    	change:{
				    		fn:function() {
				    			dataPanel.getForm().findField('password').validate();
				    		}
				    	},
				    	blur:{
				    		fn:function() {
				    			dataPanel.getForm().findField('password').validate();
				    		}
				    	}
				    },
				    anchor: '100%'
				}
			]
		});
		me.add(dataPanel);
		me.loadRecord = function(user){
			var form = dataPanel.getForm();
			form.loadRecord(user);
			if(form.findField('username').getValue().length>0){
		    	form.findField('institutionID').setDisabled(true);
		    	form.findField('username').setDisabled(true);
		    } else {
		    	dataPanel.queryById(me.id+'-panel-delete-btn').setDisabled(true);
		    	form.findField('password').allowBlank = false;
		    }
	    }
    },
});