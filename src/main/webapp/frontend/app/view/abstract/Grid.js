Ext.define('Scanstore.view.abstract.Grid', {
	extend: 'Ext.grid.Panel',
	border: false,
	margin: 1,
	autoHideSpacing: 15,
	listeners: {
		afterrender:{
			fn:function(){
				var me = this, menu = me.headerCt.getMenu().queryById('columnItem').menu;
				menu.on('click', function(menu,item) {
					var column = me.queryById(item.headerId);
					if(column.importance){
						if(!item.important){
							item.important = true;
							item.setText('\u2022 '+column.text);							
							column.dynamicImportance = me.autoHideCollection[0].dynamicImportance-1;
						} else {
							item.important = false;
							item.setText(column.text);
							column.dynamicImportance = column.importance;
						}
						me.setAutoHideImportance();
						me.toggleAutoHideImportance();
					}
				});
			}
		},
		resize:{
			fn:function(){
				this.toggleAutoHideImportance();
			}
		},
	},
	setAutoHideImportance: function(){
		this.autoHideCollection.sort(function(a,b) {
			var x = a.dynamicImportance, y = b.dynamicImportance;
			return ((x < y) ? -1 : ((x > y) ? 1 : 0));
		});
	},
	toggleAutoHideImportance: function(){
		var me = this, flowRoom = me.getWidth()-me.autoHideOffset;
		if(me.isVisible()){
			me.suspendLayouts()
			me.suspendEvents();
			for(var i=0;i< me.autoHideCollection.length;i++){
				var column = me.autoHideCollection[i], width = me.autoHideSpacing+(column.width?column.width:column.minWidth);
				if(flowRoom-width > 0){
					column.show();
					flowRoom -= width;
				} else {
					column.hide();
				}
			}
			me.resumeEvents();
			me.resumeLayouts();
			me.doLayout();
		}
	},
	initComponent: function() {
		var me = this;
		me.autoHideCollection = [];
		me.autoHideOffset = 0;
		me.callParent(arguments);
		for(var i=0;i < me.columns.length;i++){
			if(me.columns[i].hideable && me.columns[i].importance){
				me.columns[i].dynamicImportance = me.columns[i].importance;
				me.autoHideCollection.push(me.columns[i]);
			} else {
				me.autoHideOffset += me.autoHideSpacing+(me.columns[i].width?me.columns[i].width:me.columns[i].minWidth);
			}
		}
		me.setAutoHideImportance();
	}
});