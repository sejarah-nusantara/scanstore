Ext.define('Scanstore.view.abstract.ContextPanel', {
    extend: 'Ext.panel.Panel',
    border: false,
    layout: {
        type: 'hbox',
        align: 'stretch'
    },
    toggleWidth:1000,
    initComponent: function() {
    	var me = this;
        me.callParent(arguments);
        if(me.gridConfig){
        	me.grid = Ext.create('Ext.panel.Panel',{
				iconCls: me.gridConfig.iconCls,
				title: me.gridConfig.title,
			    layout: 'fit',
			    bodyPadding:1,
		    	collapsible: true,
		    	collapseDirection: 'left',
				flex: me.gridConfig.flex
			});
	        delete me.gridConfig.iconCls;
	        delete me.gridConfig.title;
	        delete me.gridConfig.flex;
	        me.gridConfig.margin = 0;
	        me.gridConfig.layout = 'fit';
	        me.grid.add(me.gridConfig);
        	me.grid.on('beforecollapse',function(){
        		if(me.tabs.items.length > 0){
        			if(me.getWidth() < me.toggleWidth){
    					setTimeout(function(){
    						me.tabs.show()
    					},0);
        				return true;
        			} else {
	        			if(me.tabs.isHidden()){
		        			me.grid.tools['right'].show();
							me.tabs.show()
		        			return false;
		        		} else {
		        			return true;
		        		}
        			}
	        	} else {
	        		return false;
	        	}
        	});
        	me.grid.on('beforeexpand',function(){
        		if(me.getWidth() < me.toggleWidth){
    				if(!me.tabs.isHidden()) me.tabs.hide()
        			me.grid.tools['right'].hide();
        		} else {
        			me.grid.tools['right'].show();
        		}
        		return true;
        	});
			me.grid.on('afterrender',function(){
        		var header = me.grid.getHeader();
        		me.grid.tools['collapse-left'].getEl().set({
                    'data-qtip': 'Collapse grid / show open panels'
                });
        		header.addTool({
        			type:'right',
        			qtip: 'Expand grid',
            	    handler: function(){
            	    	me.tabs.hide();
            	    	me.grid.tools['right'].hide();
            	    }
        		});
        		header.addTool({
        			type:'close',
        			qtip: 'Close all open panels',
            	    handler: function(){
            	    	me.tabs.hide();
            	    	me.tabs.removeAll();
            	    }
        		});
        		header.hide();
        	});
	        me.on('resize',function(){
	        	if(!me.tabs.isHidden()){
		        	if(me.getWidth() < me.toggleWidth){
		        		if(!me.grid.getCollapsed()) me.grid.collapse();
		        	} else {
		        		if(me.grid.getCollapsed()) me.grid.expand();
		        	}
	        	}
	        })
	        me.add(me.grid);
	        me.panelConfig.hidden = true,
	        me.panelConfig.margin = '0 0 0 1';
	        me.panelConfig.layout = 'fit';
	        me.tabs = Ext.create('Ext.tab.Panel',me.panelConfig);
			me.add(me.tabs);
        }
    },
    addTab: function(panel){
    	var me = this;
    	panel.on('destroy',function(){
        	if(me.grid && me.tabs.items.length <= 0){
        		me.tabs.hide();
        		me.grid.getHeader().hide();
        		me.grid.expand();
        	}
    	});
    	me.tabs.add(panel);
    	if(me.tabs.isHidden()){
    		me.grid.getHeader().show();
    		if(me.grid && me.getWidth() < me.toggleWidth){
    			me.grid.collapse();
    		} else {
    			me.grid.tools['right'].show();
    		}
    		me.tabs.show();
    	}
    },
    setActiveTab: function(panel){
    	var me = this;
    	if(!me.grid.getCollapsed() && me.grid.tools['right'].isHidden()) me.grid.collapse();
    	me.tabs.setActiveTab(panel);
    }
});