Ext.define('Scanstore.view.scans.ContextMenu', {
    extend: 'Ext.menu.Menu',
    xtype: 'scanContextMenu',
    items: [
        {
            text: 'View published image in external viewer',
            iconCls: 'image-viewer-window',
            id: 'scan-context-viewer-window-item'
        },
        {
            text: 'View published image in viewer',
            iconCls: 'image-viewer-panel',
            id: 'scan-context-viewer-panel-item'
        },
        {
            text: 'Edit scan',
            iconCls: 'scan-edit',
            id: 'scan-context-edit-item'
        },
        {
            text: 'Delete scan',
            iconCls: 'scan-delete',
            id: 'scan-context-delete-item'
        }
    ],
    setScan: function(scan) {
        this.scan = scan;
    },
    getScan: function() {
        return this.scan;
    }
});