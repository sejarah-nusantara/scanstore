Ext.define('Scanstore.controller.Main', {
	extend: 'Ext.app.Controller',
	models: ['Session'],
	views: [
		'main.Header',
		'main.ContextPanel',
		'main.LoginWindow'
	],
	refs: [
		{
			ref: 'loginWindow',
			selector: 'loginWindow',
			xtype: 'loginWindow',
			autoCreate: true
		},
		{
			ref: 'contextPanel',
			selector: 'mainContextPanel',
			xtype: 'mainContextPanel',
			autoCreate: true
		},
		{
			ref: 'header',
			selector: 'mainHeader',
			xtype: 'mainHeader',
			autoCreate: true
		}
	],
	init: function() {
		var me = this;
		me.control({
        	'#user-login-btn': {
        		click: me.handleLogin
        	},
        	'loginWindow textfield': {
                specialkey: function(field, e) {
                	if(e.getKey() == e.ENTER) {
                		me.handleLogin();
                	}
                }
        	},
        	'#user-logout-btn': {
        		click: me.handleLogout
        	},
        	'#help-btn': {
        		click: me.handleHelp
        	}
		});
    	me.getModel('Session').load('',{
    		success: function(session, operation) {
	   	    	me.session = session;
	   	    },
	   	    callback: function(session, operation) {
	   			me.handleStage();
	   	    }
    	});
		me.viewport = me.getView('Viewport').create();
		me.viewport.add(me.getHeader());
	},
	sessionTimer:0,
	sessionPing: function() {
		var me = this;
		Ext.Ajax.request({
		    url: Scanstore.serverurl+'index.cfm?ping',
		    success: function(response){
		    	me.sessionTimer = setTimeout(function(){ me.sessionPing(); },1800000);
		    },
			failure:  function(response){
		        me.showLoginWindow();
		    }
		});
	},
	handleStage: function() {
		var me = this;
		if(!me.isLoggedIn()){
			me.getHeader().getComponent('user-session-box').hide();
			me.showLoginWindow();
			clearTimeout(me.sessionTimer)
		} else if(!me.workspace){
			var header = me.getHeader();
			header.queryById('user-session-info').setText(
				'Logged in as <b>'+me.session.getName()+'</b> from <b>'+me.session.get('institutionID')+'</b>'
			);
			header.getComponent('user-session-box').show();
			workspace = me.getContextPanel();
			me.viewport.add(workspace)
			// Enable panels
			workspace.queryById('main-import-tab').setDisabled(false);
			workspace.queryById('main-scan-tab').setDisabled(false);
			workspace.queryById('main-file-tab').setDisabled(false);
			if(me.session.get('admin')){
				workspace.queryById('main-user-tab').setDisabled(false);
			} else {
				workspace.queryById('main-user-tab').destroy();
			}
			// Set session timer
			me.sessionTimer = setTimeout(function(){ me.sessionPing(); },600000);
		}
	},
	showLoginWindow: function() {
    	var me = this,
    	loginWindow = me.getLoginWindow();
    	loginWindow.down('form').loadRecord(
    		me.getModel('Session').create()
    	);
    	loginWindow.show();
    },
    hideLoginWindow: function(button, e) {
        this.getLoginWindow().close();
    },
    showBackgroundProcess: function(info) {
		var me = this,
			panel = me.getHeader().getComponent('main-header-info');
		Scanstore.closemessage = 'There are pending processes, '+info.toLowerCase()+', please wait after they are finihed before closing this window';
		panel.addCls('main-progress');
		panel.setText(info);
		panel.show();
    },
    hideBackgroundProcess: function() {
		var me = this,
			panel = me.getHeader().getComponent('main-header-info');
		Scanstore.closemessage = '';
		panel.removeCls('main-progress');
		panel.setText('');
		panel.hide();
    },
    handleLogin: function(item, e) {
        var me = this,
        	loginWindow = me.getLoginWindow(),
        	form = loginWindow.down('form').getForm(),
        	session = form.getRecord();
	    if(form.isValid()) {
	    	form.updateRecord(session);
	    	session.save({
	    		success: function(session, operation) {
		   	    	me.session = session;
	    	    	loginWindow.close();
	    	    	me.handleStage();
		   	    },
	            failure: function(session, operation) {
		            Ext.MessageBox.show({
	                    title: 'Login failed',
	                    msg: 'Your credentials are incorrect, please try again',
	                    icon: Ext.Msg.ERROR,
	                    buttons: Ext.Msg.OK
	                });
	            }
	    	});
	    } else {
	    	Ext.MessageBox.show({
                title: 'Form validation error ',
                msg: form.getValidationHTML(),
                icon: Ext.Msg.WARNING,
                buttons: Ext.Msg.OK
            });
	    }
    },
	handleLogout: function(item, e) {
        var me = this;
        me.session.destroy('');
        delete me.session;
        me.getContextPanel().destroy();
        me.handleStage();
	},
	handleHelp: function(item, e) {
        window.open('./manual/');
	},
    isLoggedIn: function() {
    	if(this.session){
    		return true;
    	} else{
    		return false;
    	}
    }
});