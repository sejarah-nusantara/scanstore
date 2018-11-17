Ext.define('Scanstore.view.scans.ViewerPanel', {
	extend: 'Ext.panel.Panel',
	xtype: 'scanViewerPanel',
    iconCls: 'image-viewer',
    header: false,
    closable: true,
    style: {
        border: '1px solid #000000'
    },
    bodyPadding:1,
    bodyStyle: {
    	backgroundColor: '#666666'
    },
    initComponent: function() {
    	var me = this;
        me.callParent(arguments);
        me.frame = document.createElement('iframe');
        me.frame.frameborder = false;
        me.frame.allowtransparency = true;
        me.frame.style.width = '100%';
        me.frame.style.height = '100%';
        me.frame.style.border = 'none';
    },
	listeners:{
		'boxready':{
			fn:function(){
				this.body.dom.appendChild(this.frame);
			}
		}
	},
    setSource: function(src){
		var source = encodeURIComponent(src)
    	if(this.frame.src.indexOf(source) < 0){
			this.frame.src = 'imageviewer/?image='+source;
		}
	}
});