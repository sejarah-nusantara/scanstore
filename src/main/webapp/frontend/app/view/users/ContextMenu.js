Ext.define('Scanstore.view.users.ContextMenu', {
    extend: 'Ext.menu.Menu',
    xtype: 'userContextMenu',
    items: [
	    {
	        text: 'Add user',
	        iconCls: 'user-add',
	        id: 'user-context-add-item'
	    },
	    {
            text: 'Edit user',
            iconCls: 'user-edit',
            id: 'user-context-edit-item'
        },
        {
            text: 'Delete user',
            iconCls: 'user-delete',
            id: 'user-context-delete-item'
        }
    ],
    setUser: function(user) {
        this.user = user;
    },
    getUser: function() {
        return this.user;
    }
});