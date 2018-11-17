Ext.define('Scanstore.controller.Scans', {
	extend: 'Ext.app.Controller',
	models: ['Scan','Status','Type','Language','Archive','Institution','File'],
	stores: ['Scans','Status','Types','Languages','Archives','Institutions','Files'],
	views: [
		'scans.Grid',
		'scans.GridBar',
		'scans.EditPanel',
		'scans.edit.EditTabIdentification',
		'scans.edit.EditTabImage',
		'scans.edit.EditTabTranscription',
		'scans.edit.EditTabOther',
		'scans.ViewerPanel',
		'scans.ContextPanel',
		'scans.ContextMenu'
	],
	refs: [
		{
			ref: 'editPanel',
			selector: 'scanEditPanel',
			xtype: 'scanEditPanel',
			forceCreate: true
		},{
			ref: 'viewerPanel',
			selector: 'scanViewerPanel',
			xtype: 'scanViewerPanel',
			forceCreate: true
		},{
			ref: 'gridBar',
			selector: 'scanGridBar'
		},{
			ref: 'grid',
			selector: 'scanGrid'
		},{
			ref: 'contextMenu',
			selector: 'scanContextMenu',
			xtype: 'scanContextMenu',
			autoCreate: true
		},{
			ref: 'contextPanel',
			selector: 'scanContextPanel'
		}
	],
	init: function() {
		var me = this;
        me.control({
    		'scanGrid': {
                deleteclick: me.handleDeleteRowClick,
                viewerpanelclick: me.handleViewerPanelRowClick,
                editclick: me.handleEditRowClick,
                itemcontextmenu: me.showContextMenu
            },
        	'#main-scan-tab': {
        		afterrender: me.loadData
        	},
            'scanGridBar textfield': {
            	change: me.handleChangeFilterScans
            },
            'scanGridBar combobox': {
            	change: me.handleChangeFilterScans
            },
            '#scan-context-viewer-window-item': {
                click: me.handleViewerWindowContextClick
            },
            '#scan-context-viewer-panel-item': {
                click: me.handleViewerPanelContextClick
            },
            '#scan-context-delete-item': {
                click: me.handleDeleteContextClick
            },
            '#scan-context-edit-item': {
                click: me.handleEditContextClick
            },
            '#scan-overview-save-btn': {
                click: me.handleSaveOverviewClick
            },
            '#scan-overview-delete-btn': {
                click: me.handleDeleteOverviewClick
            },
            '#scan-overview-cancel-btn': {
                click: me.handleCancelOverviewClick
            },
            '#scan-overview-search-btn': {
                click: me.handleSearchFilterScans
            },
            '#scan-overview-clear-btn': {
                click: me.handleClearOverviewClick
            }
		});
	},
	loadData: function(item, e) {
		var me = this,
			status = me.getStore("Status"),	
			language = me.getStore("Languages"),
			archive = me.getStore("Archives"),
			institution = me.getStore("Institutions"),
			file = me.getStore("Files");
		me.getGrid().setLoading(true);
		status.load(function(records, operation, success) {
			me.inititalLoadScans();
		});
		language.load(function(records, operation, success) {
			me.inititalLoadScans();
		});
		file.load(function(records, operation, success) {
			me.inititalLoadScans();
		});
		archive.load(function(records, operation, success) {
			me.inititalLoadScans();
		});
		institution.load(function(records, operation, success) {
			me.inititalLoadScans();
		});
	},
	inititalLoadScans: function(item, e) {
		var me = this,
			scans = me.getStore("Scans"),
			status = me.getStore("Status"),	
			language = me.getStore("Languages"),
			archive = me.getStore("Archives"),
			institution = me.getStore("Institutions"),
			file = me.getStore("Files");
		if(!status.isLoading() && !language.isLoading() && !archive.isLoading() && !institution.isLoading() && !file.isLoading()){
			// Default filter
			me.getGridBar().getComponent('scan-filter').queryById('scan-filter-status').setValue(1);
		    scans.getProxy().extraParams = { statusID:1 };
		    me.getGrid().setLoading(false);
		    scans.load();
		}
	},
	filterTimer: 0,
	filterParams: {},
	filterSuspended: false,
	handleChangeFilterScans: function(item, e) {
		var me = this,
			scans = me.getStore("Scans");	
		if(!me.filterSuspended){
			me.filterSuspended = true;
			clearTimeout(me.filterTimer);
			if(item.value || item.rawValue){
				me.filterParams[item.name] = item.value || item.rawValue;
			} else {
				delete me.filterParams[item.name];
			}
			if(me.getGridBar().queryById('scan-filter-auto').getValue()){;
				me.filterTimer = setTimeout(function(){
					var params = me.filterParams,
						proxy = scans.getProxy();
					proxy.extraParams = params;
					scans.currentPage = 1;
					scans.load();
				},350);
			}
			me.filterSuspended = false;
		}
	},
	handleSearchFilterScans: function(item, e) {
		var me = this,
			scans = me.getStore("Scans"),
			params = me.filterParams,
			proxy = scans.getProxy();
		proxy.extraParams = params;
		scans.currentPage = 1;
		scans.load();
	},
	handleClearOverviewClick: function(item, e) {
		var me = this,
			scans = me.getStore('Scans'),
			proxy = scans.getProxy(),
			toolbar = me.getGridBar(),
			items = [
			    'scan-filter-number',
			    'scan-filter-archive',
			    'scan-filter-file',
			    'scan-filter-status'
			];
		me.filterSuspended = true;
		proxy.extraParams = me.filterParams = {};
		scans.currentPage = 1;
		scans.load();
		for(var i=0;i<items.length;i++){
			var field =  toolbar.queryById(items[i]);
			field.reset();
		}
		me.filterSuspended = false;
	},
	handleSaveOverviewClick: function(item, e) {
		var me = this,
			grid = me.getGrid(),
			scans = me.getStore('Scans'),
			records = scans.getModifiedRecords();
		if(records.length>0){
			grid.setLoading(true);
			var reload = false; 
			for(var i=0;i<records.length;i++){
				if('sequenceNumber' in records[i].getChanges())
					reload = true; break;
			}
			scans.sync({
				success:function(){
					scans.commitChanges();
					grid.setLoading(false);
					if(reload) scans.load();
				},
				failure: function(result, operation) {
					var error = operation.getError(),
						msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
					grid.setLoading(false);
					Ext.MessageBox.show({
						title: 'Update scans failed',
						msg: msg,
						icon: Ext.Msg.ERROR,
						buttons: Ext.Msg.OK
					});
				}
			});
		} else {
	    	Ext.MessageBox.show({
                title: 'No changes found',
                msg: 'No pending changes have been found, please change some columns before trying to save mutiple scans.',
                icon: Ext.Msg.INFO,
                buttons: Ext.Msg.OK
            });
		}
    },
	handleDeleteOverviewClick: function(item, e) {
		var me = this,
			scans = me.getStore('Scans'),
			records = me.getGrid().getSelectionModel().getSelection();
		if(records.length>0){
			Ext.MessageBox.show({
	            title: 'Deleting scans',
	            msg: 'Are you sure you want to delete the selected scans?',
	            icon: Ext.Msg.QUESTION,
	            buttons: Ext.Msg.YESNO,
	            fn: function (btn){
	                if(btn=='yes'){     
	        			var delay = 0;
	        			for(var i=records.length-1;i>=0;i--){
	        				setTimeout(function(scan,suppress){			
	        					return function(){
	        						me.deleteScan(scan,suppress);
	        					}
	        				}(records[i],(i>0)),delay);
	        				delay += 250;
	        			}
	                }
	            }
	        });	
		} else {
	    	Ext.MessageBox.show({
	            title: 'No scans selected',
	            msg: 'No scans have been selected, please select some records before trying to delete mutiple scans.',
	            icon: Ext.Msg.INFO,
	            buttons: Ext.Msg.OK
	        });
		}
    },
	handleCancelOverviewClick: function(item, e) {
		var me = this,
			scans = me.getStore('Scans');
		scans.rejectChanges();
    },
	handleSavePanelClick: function(item, e) {
		var form = item.up('panel').getForm(),	
			scan = form.getRecord();
		if(form.isValid()) {
	    	form.updateRecord(scan);
	    	this.saveScan(scan,false); 
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
		var scan = item.up('panel').getForm().getRecord(),
			panel = this.hasPanel(scan,'edit');
		scan.reject();
		if(panel) panel.close();
    },
	handleDeletePanelClick: function(item, e) {
		var scan = item.up('panel').getForm().getRecord();
		this.deleteScanConfirm(scan);
    },
    handleViewerPanelContextClick: function(item, e) {
        this.showViewerPanel(this.getContextMenu().getScan());
    },
    handleViewerWindowContextClick: function(item, e) {
        this.showViewerWindow(this.getContextMenu().getScan());
    },
    handleEditContextClick: function(item, e) {
        this.showEditPanel(
        	this.getContextMenu().getScan()
        );
    },
    handleDeleteContextClick: function(item, e) {
        this.deleteScanConfirm(
           	this.getContextMenu().getScan()
        );
    },
    handleViewerPanelRowClick: function(view, rowIndex, colIndex, column, e) {
        this.showViewerPanel(view.store.getAt(rowIndex));
    },
    handleEditRowClick: function(view, rowIndex, colIndex, column, e) {
        this.showEditPanel(
        	view.store.getAt(rowIndex)
        );
    },
    handleDeleteRowClick: function(view, rowIndex, colIndex, column, e) {
    	this.deleteScanConfirm(
    		view.store.getAt(rowIndex)
    	);
    },
    // Scan actions
    createScanTitle: function(scan,cap){
		var title = '';
		if(cap && scan.get('title').length > cap){
			title += (scan.get('title').substr(0,cap-3)).trim()+'...';
		} else if(scan.get('title').length > 0){
			title += scan.get('title');
		}
		if(scan.get('archiveID').length > 0){
			if(title.length > 0) title += ' ';
        	try {
        		title += 'Ar:'+Ext.getStore('Archives').getById(scan.get('archiveID')).get('name');
        	} catch(e){
        		title += 'Ar:'+scan.get('archiveID');
        	}
		}
		if(scan.get('archiveFileID').length > 0){
			if(title.length > 0) title += ' ';
        	try {
        		title += 'Fi:'+Ext.getStore('Files').getById(scan.get('archiveFileID')).get('number');
        	} catch(e){
        		title += 'Fi:'+scan.get('archiveFileID');
        	}
		}
		if(scan.get('number') > 0){
			if(title.length > 0) title += ' ';
	    	title += 'Nr.:'+scan.get('number');
		}
		if(scan.get('folioNumber').length > 0){
			if(title.length > 0) title += ' ';
			title += 'Fo:'+scan.get('folioNumber');
		}
		return title;
    },
    deleteScanConfirm: function(scan) {
    	var me = this;
    	Ext.MessageBox.show({
            title: 'Deleting scan',
            msg: 'Are you sure you want to delete this scan?',
            icon: Ext.Msg.QUESTION,
            buttons: Ext.Msg.YESNO,
            fn: function (btn){
                if(btn=='yes'){     
                	me.deleteScan(scan,false);
                }
            }
        });	
    },
    deleteScan: function(scan,suppress) {
    	var me = this,
    		grid = me.getGrid(),
    		store = Ext.getStore('Scans'),
    		panel = me.hasPanel(scan,'edit');
    	if(!panel) grid.setLoading(true); else panel.setLoading(true);
    	scan.destroy({
            success: function(scan, operation) {
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
            failure: function(scan, operation) {
           		if(!suppress) {
           			if(!panel) grid.setLoading(false); else panel.setLoading(false); 
           		}
                var error = operation.getError(),
                    msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	                Ext.MessageBox.show({
                    title: 'Deleting scan failed',
                    msg: msg,
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        });
    },
    saveScan: function(scan,suppress) {
    	var me = this,
    		grid = me.getGrid(),
    		store = Ext.getStore('Scans'),
    		panel = me.hasPanel(scan,'edit');
    	if(!panel) grid.setLoading(true); else panel.setLoading(true); 
    	scan.save({
            success: function(scan, operation) {
           		if(!suppress) {
           			if(!panel) grid.setLoading(false); else panel.setLoading(false); 
           			store.reload();
           		}
                if(panel) panel.close();
            },
            failure: function(scan, operation) {
           		if(!suppress) {
           			if(!panel) grid.setLoading(false); else panel.setLoading(false); 
           		}
            	var error = operation.getError(),
                    msg = Ext.isObject(error) ? error.status + ' ' + error.statusText : error;
	                Ext.MessageBox.show({
                    title: 'Scan save failed',
                    msg: msg,
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }
        });
    },
    showContextMenu: function(view, scan, node, rowIndex, e) {
        var contextMenu = this.getContextMenu();
        contextMenu.setScan(scan);
        contextMenu.showAt(e.getX(), e.getY());
        e.preventDefault();
    },
    showViewerWindow: function(scan,image) {
    	if(image){
    		window.open('imageviewer/?image='+image.get('fileUrl'));
    	} else {
    		window.open('imageviewer/?image='+scan.get('imageUrl'));
    	}
    },
    showViewerPanel: function(scan,image) {
        var me = this,
	    	contextPanel = me.getContextPanel(),
	    	title = 'Image viewer - '+me.createScanTitle(scan,10),
	        viewPanel = me.hasPanel(scan,'view'),
	        source;
    	if(image){
    		source = image.get('fileUrl');
    	} else {
    		source = scan.get('imageUrl');
    	}
	    if(viewPanel){
	    	viewPanel.setSource(source)
	    	contextPanel.setActiveTab(viewPanel);
	    } else {
	    	viewPanel = me.getViewerPanel();
	    	viewPanel.setTitle('Image viewer - ' + me.createScanTitle(scan,10));
	    	contextPanel.addTab(viewPanel);
	    	viewPanel.setSource(source);
	    	me.panelHashTable.view[scan.get('number')] = viewPanel;
	        viewPanel.on('destroy',function(){
	        	delete me.panelHashTable.view[scan.get('number')];
	        });
	        contextPanel.setActiveTab(viewPanel);
	    }
    },
    panelHashTable: { edit:{}, view:{} },
    showEditPanel: function(scan) {
        var me = this,
        	contextPanel = me.getContextPanel(),
            editPanel = me.hasPanel(scan,'edit');
        if(editPanel){
        	contextPanel.setActiveTab(editPanel);
        } else {
        	editPanel = me.getEditPanel();
        	var id = editPanel.id,
    	    	controllers  = {};
	        editPanel.setTitle('Edit scan - ' + me.createScanTitle(scan,10));
	        contextPanel.addTab(editPanel);
	        editPanel.loadRecord(scan);
	        me.panelHashTable.edit[scan.get('number')] = editPanel;
	        editPanel.on('destroy',function(){
	        	delete me.panelHashTable.edit[scan.get('number')];
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
	        contextPanel.setActiveTab(editPanel);
        }
    },
    hasPanel: function(scan,type) {
        var me = this,
        	id = scan.get('number'),
        	panel;
        if(!type && me.panelHashTable[id]){
			panel = me.panelHashTable[id];
        } else if(me.panelHashTable[type] && me.panelHashTable[type][id]){
        	panel = me.panelHashTable[type][id];
        }
        return panel;
    }
});