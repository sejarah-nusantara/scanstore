Ext.define('Scanstore.view.users.Grid', {
    extend: 'Scanstore.view.abstract.Grid',
    xtype: 'userGrid',
    store: 'Users',
    border: false,
    selModel: {selType: 'rowmodel', mode: 'MULTI'},
    initComponent: function() {
        var me = this,
            cellEditingPlugin = Ext.create('Ext.grid.plugin.CellEditing');
        me.plugins = [cellEditingPlugin];
        me.dockedItems = [
			{ xtype: 'userGridBar' },
            {
  		  		xtype: 'pagingtoolbar',
  		  		inputItemWidth: 40,
  		  		dock: 'bottom',
  				store: me.getStore(),
  				displayInfo: true,
  				displayMsg: 'Users {0} - {1} of {2}',
  				emptyMsg: "No users to display"
  		  	}
  		];
        me.columns = {
            defaults: {
                draggable: true,
                resizable: true,
                hideable: true
            },
            items: [
                {
                    text: 'Institution',
                    dataIndex: 'institutionID',
                    flex: 1,
                    minWidth: 100,
                    importance: 3,
                    renderer: function(value, metaData, scan, rowIndex, colIndex, store, view) {
                    	try {
                    		return Ext.getStore('Institutions').getById(value).get('name');
                    	} catch(e){
                    		return value;
                    	}
                    }
                },
                {
                    text: 'Username',
                    dataIndex: 'username',
                    minWidth: 100,
                    hideable: false,
                    flex: 1
                },
                {
                    text: 'Firstname',
                    dataIndex: 'firstname',
                    minWidth: 150,
                    importance: 2,
                    flex: 2,
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
                },
                {
                    text: 'Lastname',
                    dataIndex: 'lastname',
                    minWidth: 150,
                    importance: 2,
                    flex: 2,
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
                },
                {
                    text: 'E-mail',
                    dataIndex: 'email',
                    minWidth: 200,
                    importance: 3,
                    flex: 3,
                    editor: {
                        xtype: 'textfield',
                        selectOnFocus: true
                    }
                },
                {
                    text: 'Administrator',
                    dataIndex: 'admin',
                    importance: 2,
                    width: 80,
                    editor: {
                        xtype: 'checkbox',
                        selectOnFocus: true
                    },
                    renderer: function(value, metaData, record, rowIndex, colIndex, store, view) {
	                   	if(value){
                    		return '<img src="resources/images/accept.png" class="state" title="User is administrator" />';
	                   	} else {
	                   		return '<img src="resources/images/unknown.png" class="state" />';
	                   	}
    	            }
                },
                {
                    xtype: 'actioncolumn',
                    menuDisabled: true,
                    sortable: false,
                    hideable: false,
                    width: 50,
                    items:[
		                {
		                	iconCls: 'user-edit actionitem',
		                    tooltip: 'Edit user',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('editclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                },
		                {
		                	iconCls: 'user-delete actionitem',
		                    tooltip: 'Delete user',
		                    handler: function(gridView, rowIndex, colIndex, column, e){
		                    	me.fireEvent('deleteclick', gridView, rowIndex, colIndex, column, e)
		                    }
		                }
					]
                }
            ]
        };
        me.callParent(arguments);
    },

});