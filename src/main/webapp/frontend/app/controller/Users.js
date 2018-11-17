Ext.define('Scanstore.controller.Users', {
	extend: 'Ext.app.Controller',
	models: ['User','Institution'],
	stores: ['Users','Institutions'],
	views: [
		'users.Grid',
		'users.GridBar',
		'users.ContextPanel',
		'users.ContextMenu',
		'users.EditPanel'
	],
	refs: [
		{
			ref: 'editPanel',
			selector: 'userEditPanel',
			xtype: 'userEditPanel',
			forceCreate: true
		},{
			ref: 'gridBar',
			selector: 'userGridBar'
		},{
			ref: 'grid',
			selector: 'userGrid'
		},{
			ref: 'contextMenu',
			selector: 'userContextMenu',
			xtype: 'userContextMenu',
			autoCreate: true
		},{
			ref: 'contextPanel',
			selector: 'userContextPanel'
		}
	],
	init: function() {
		var me = this;
		me.control({
			'userGrid': {
				deleteclick: me.handleDeleteRowClick,
			    editclick: me.handleEditRowClick,
			    itemcontextmenu: me.showContextMenu
			},
        	'#main-user-tab': {
        		afterrender: me.loadData
        	},
			'#user-context-add-item': {
			    click: me.handleAddContextClick
			},
			'#user-context-edit-item': {
			    click: me.handleEditContextClick
			},
			'#user-context-delete-item': {
			    click: me.handleDeleteContextClick
			},
			'#user-overview-save-btn': {
                click: me.handleSaveOverviewClick
            },
            '#user-overview-delete-btn': {
                click: me.handleDeleteOverviewClick
            },
            '#user-overview-cancel-btn': {
                click: me.handleCancelOverviewClick
            },
            '#user-overview-add-btn': {
                click: me.handleAddOverviewClick
            }
		});
	},
	loadData: function(item, e) {
		var me = this;
		me.getStore("Users").load();
	},
    handleAddContextClick: function(item, e) {
    	var user = Ext.create('Scanstore.model.User', {});
		this.showEditPanel(user);
		//this.getStore('Users').add(user);
    },
	handleEditContextClick: function(item, e) {
    	this.showEditPanel(
    		this.getContextMenu().getUser()
        )
    },
    handleDeleteContextClick: function(item, e) {
        this.deleteUserConfirm(
           	this.getContextMenu().getUser()
        );
    },
    handleEditRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.showEditPanel(
       		this.getStore('Users').getAt(rowIndex)
    	)
    },
    handleDeleteRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.deleteUserConfirm(
    		this.getStore('Users').getAt(rowIndex)
    	);
    },
    handleAddOverviewClick: function(view, rowIndex, colIndex, column, e) {
    	var user = Ext.create('Scanstore.model.User', {});
    	this.showEditPanel(user);
    	//this.getStore('Users').add(user);
    },
    handleSaveOverviewClick: function(item, e) {
		var me = this,
			users = me.getStore('Users'),
			records = users.getModifiedRecords();
		if(records.length>0){
			var delay = 0;
			for(var i=records.length-1;i>=0;i--){
				setTimeout(function(user,suppress){			
					return function(){
						me.saveUser(user,suppress);
					}
				}(records[i],(i>0)),delay);
				delay += 250;
			}
			users.commitChanges();
		} else {
	    	Ext.MessageBox.show({
                title: 'No changes found',
                msg: 'No pending changes have been found, please change some columns before trying to save mutiple users.',
                icon: Ext.Msg.INFO,
                buttons: Ext.Msg.OK
            });
		}
    },
	handleDeleteOverviewClick: function(item, e) {
		var me = this,
			scans = me.getStore('Users'),
			records = me.getGrid().getSelectionModel().getSelection();
		if(records.length>0){
			Ext.MessageBox.show({
	            title: 'Deleting users',
	            msg: 'Are you sure you want to delete the selected users?',
	            icon: Ext.Msg.QUESTION,
	            buttons: Ext.Msg.YESNO,
	            fn: function (btn){
	                if(btn=='yes'){     
	        			var delay = 0;
	        			for(var i=records.length-1;i>=0;i--){
	        				setTimeout(function(user,suppress){			
	        					return function(){
	        						me.deleteUser(user,suppress);
	        					}
	        				}(records[i],(i>0)),delay);
	        				delay += 250;
	        			}
	                }
	            }
	        });	
		} else {
	    	Ext.MessageBox.show({
	            title: 'No users selected',
	            msg: 'No users have been selected, please select some records before trying to delete mutiple users.',
	            icon: Ext.Msg.INFO,
	            buttons: Ext.Msg.OK
	        });
		}
    },
	handleCancelOverviewClick: function(item, e) {
		var me = this,
			users = me.getStore('Users');
		users.rejectChanges();
    },
	handleSavePanelClick: function(item, e) {
		var form = item.up('panel').getForm(),	
			user = form.getRecord();
		if(form.isValid()) {
	    	form.updateRecord(user);
	    	this.saveUser(user,false); 
	    } else {
	    	Ext.MessageBox.show({
                title: 'Form validation error ',
                msg: form.getValidationHTML(),
                icon: Ext.Msg.WARNING,
                buttons: Ext.Msg.OK
            });
	    }
    },
	handleCancelPanelClick: function(item, e) {
		var user = item.up('panel').getForm().getRecord(),
			panel = this.hasPanel(user);
		user.reject();
		if(panel) panel.close();
    },
	handleDeletePanelClick: function(item, e) {
		var user = item.up('panel').getForm().getRecord();
		this.deleteUserConfirm(user);
    },
    showContextMenu: function(view, user, node, rowIndex, e) {
        var contextMenu = this.getContextMenu();
        contextMenu.setUser(user);
        contextMenu.showAt(e.getX(), e.getY());
        e.preventDefault();
    },
    panelHashTable: {},
    showEditPanel: function(user) {
        var me = this,
	    	contextPanel = me.getContextPanel(),
	        editPanel = me.hasPanel(user);
	    if(editPanel){
	    	contextPanel.setActiveTab(editPanel);
	    } else {
	    	editPanel = me.getEditPanel();
	    	var id = editPanel.id,
		    	controllers  = {};
	        editPanel.setTitle('Edit user - ' + user.getName());
	        contextPanel.addTab(editPanel);
	        editPanel.loadRecord(user);
	        me.panelHashTable[user.get('id')] = editPanel;
	        editPanel.on('destroy',function(){
	        	delete me.panelHashTable[user.get('id')];
	        });
	        controllers['#'+id+'-panel-cancel-btn'] = {
	        	click: me.handleCancelPanelClick	
	        }
	        controllers['#'+id+'-panel-save-btn'] = {
	        	click: me.handleSavePanelClick
	        }
	        controllers['#'+id+'-panel-delete-btn'] = {
	            click: me.handleDeletePanelClick
	        }
	        me.control(controllers);
	        editPanel.show();
	    }
    },
    // User actions
    saveUser: function(user,suppress) {
    	var me = this,
    		grid = me.getGrid(),
    		store = Ext.getStore('Users'),
    		panel = me.hasPanel(user);
    	if(!panel) grid.setLoading(true); else panel.setLoading(true); 
    	user.save({
            success: function(user, operation) {
           		if(!suppress) {
           			if(!panel) grid.setLoading(false); else panel.setLoading(false); 
           			store.reload();
           		}
                if(panel) panel.close();
            },
            failure: function(user, operation) {
           		if(!suppress) {
           			if(!panel) grid.setLoading(false); else panel.setLoading(false); 
           		}
            	var error = operation.getError(),
                    msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	                Ext.MessageBox.show({
                    title: 'Scan user failed',
                    msg: msg,
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        });
    },
    deleteUserConfirm: function(user) {
    	var me = this;
    	Ext.MessageBox.show({
            title: 'Deleting user',
            msg: 'Are you sure you want to delete this user?',
            icon: Ext.Msg.QUESTION,
            buttons: Ext.Msg.YESNO,
            fn: function (btn){
                if(btn=='yes'){     
                	me.deleteUser(user,false);
                }
            }
        });	
    },
    deleteUser: function(user,suppress) {
    	var me = this,
    		grid = me.getGrid(),
    		store = Ext.getStore('Users'),
    		panel = me.hasPanel(user);
    	if(!panel) grid.setLoading(true); else panel.setLoading(true); 
		user.destroy({
            success: function(user, operation) {
           		if(!suppress) {
           			if(!panel) grid.setLoading(false); else panel.setLoading(false); 
           		}
            	if(store.currentPage>1 && (store.getTotalCount()-1)/25 <= store.currentPage-1){
            		store.previousPage();
            	} else {
            		if(!suppress) store.reload();
            	}
                if(panel) panel.close();
            },
            failure: function(user, operation) {
           		if(!suppress) {
           			if(!panel) grid.setLoading(false); else panel.setLoading(false); 
           		}
                var error = operation.getError(),
                    msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	                Ext.MessageBox.show({
                    title: 'Deleting user failed',
                    msg: msg,
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        });
    },
    hasPanel: function(user,type) {
        var me = this,
        	id = user.get('id'),
        	panel;
        if(!type && me.panelHashTable[id]){
			panel = me.panelHashTable[id];
        } else if(me.panelHashTable[type] && me.panelHashTable[type][id]){
        	panel = me.panelHashTable[type][id];
        }
        return panel;
    }
});