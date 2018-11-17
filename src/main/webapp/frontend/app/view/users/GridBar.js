Ext.define('Scanstore.view.users.GridBar', {
    extend: 'Ext.toolbar.Toolbar',
    dock: 'top',
    xtype: 'userGridBar',
    height: 30,
    items: [
        {
        	iconCls: 'user-add',
            text: 'Add user',
            tooltip: 'Create a new user',
            id: 'user-overview-add-btn'
        },
        {
        	iconCls: 'users-save',
            text: 'Save users',
            tooltip: 'Save all pending changes to edited users',
            id: 'user-overview-save-btn'
        },
        {
        	iconCls: 'cancel',
            text: 'Cancel',
            tooltip: 'Remove all pending changes to edited users',
            id: 'user-overview-cancel-btn'
        },
	    { xtype: 'tbfill' },
	    {
        	iconCls: 'users-delete',
            text: 'Delete users',
            tooltip: 'Delete all selected users',
            id: 'user-overview-delete-btn'
        }
	]
});