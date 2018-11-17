Ext.define('Scanstore.model.Session', {
	extend: 'Scanstore.model.User',
	proxy: {
		type: 'ajax',
		api: {
			read: Scanstore.serverurl+'remote/RemoteUserSessionController.cfc?method=getLoggedInUser',
			create: Scanstore.serverurl+'remote/RemoteUserSessionController.cfc?method=loginUser',
			destroy: Scanstore.serverurl+'remote/RemoteUserSessionController.cfc?method=logoutUser'
		},
		reader: {
			type: 'json',
			root: 'item',
			successProperty: 'success',
			messageProperty: 'message'
		}
	}
});