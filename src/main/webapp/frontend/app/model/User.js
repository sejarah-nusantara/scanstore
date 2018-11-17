Ext.define('Scanstore.model.User', {
	extend: 'Ext.data.Model',
	fields: [
		{ name: 'id', type: 'int' },
		{ name: 'username', type: 'string' },
		{ name: 'institutionID', type: 'string' },
		{ name: 'admin', type: 'boolean' },
		{ name: 'firstname', type: 'string' },
		{ name: 'lastname', type: 'string' },
		{ name: 'email', type: 'string' },
		{ name: 'password', type: 'string', serialize: function(value){
			return value.length>0?CryptoJS.SHA256(value).toString(CryptoJS.enc.Hex):''
		} }
	],
	getName: function(){
		var fullname = this.get('firstname')+' '+this.get('lastname');
		if(fullname.trim().length>0){
			return fullname;
		} else {
			return 'Unknown';
		}
	},
	//associations: [
	//	{ type: 'hasOne', model: 'Institution', foreignKey: 'institutionID' }
	//]
    proxy: {
		type: 'ajax',
		api: {
			create: Scanstore.serverurl+'remote/RemoteUserService.cfc?method=updateUser',
			update: Scanstore.serverurl+'remote/RemoteUserService.cfc?method=updateUser',
			destroy: Scanstore.serverurl+'remote/RemoteUserService.cfc?method=deleteUser'
		}
	},
	writer: {
		writeAllFields: false
	}
});