// EXT extensions
Ext.override(Ext.form.Field,{
	setFieldLabel : function(text) {
		if (this.rendered) {
			this.labelEl.update(text);
		}
		this.fieldLabel = text;
	},
	getFieldLabel : function() {
		if (this.rendered) {
			return this.labelEl.getHTML();
		}
		return this.fieldLabel;
	}
});
Ext.override(Ext.form.Basic,{
	getValidationHTML : function() {
		var fields = this.getFields().items;
		var html = '<ul style="padding:10px;">';
		for(var i=0;i<fields.length;i++){
			var errors = fields[i].getErrors();
			for(var j=0;j<errors.length;j++){
				html += '<li>'+fields[i].getFieldLabel().replace(':','')+', '+errors[j].toLowerCase()+'</li>'
			}
		}
		return '<p>The following fields did not validate properly:</p><br />'+html+'</ul>';
	}
});
Ext.apply(Ext.form.VTypes, {
    strength: function(val, field) {
        return field.score > field.strength;
    },
    strengthText: "Password is not strong enough"
});
Ext.override(Ext.panel.Panel, { animCollapse: false });
//Set timeout to 15 minutes
Ext.Ajax.timeout = 900000;
Ext.override(Ext.data.proxy.Server, { timeout: Ext.Ajax.timeout });
Ext.override(Ext.data.Connection, { timeout: Ext.Ajax.timeout });
// Application base properties
var Scanstore = {
	initiated: false,
	dateformat:'j/n/Y',
	timeformat:'H:i:s',
	version: 'Unknown',
	pagesize: 25,
	chunkSize: 2621440,
	retryCount: 10,
	closemessage: '',
	serverurl: '',
	bytesize: function(bytes){
		var rtn = Math.round(bytes/102.4)/10;
		if(rtn>1024){
			rtn = Math.round(rtn/102.4)/10;
			rtn += rtn!=Math.round(rtn)?'MiB':'.0MiB';
		} else {
			rtn += rtn!=Math.round(rtn)?'KiB':'.0KiB';
		}
		return rtn;
	},
	relaformatter: function(date){
		var now = new Date();
		if(date-now < 43200000 && date-now > 0){
			var rtn = 'in '+Scanstore.secformatter((date-now)/1000);
		} else if(now-date < 43200000 && now-date > 0){
			var rtn = 'over '+Scanstore.secformatter((now-date)/1000);
		} else {
			var rtn = 'on '+Scanstore.dateformatter(date);
		}
		return rtn;
	},
	dateformatter: function(date){
		var rtn = Ext.util.Format.date(date,Scanstore.timeformat);
		var now = new Date();
		if(date && (date.getDate()!=now.getDate() || date.getMonth()!=now.getMonth() || date.getYear()!=now.getYear())){
			rtn += ' '+Ext.util.Format.date(date,Scanstore.dateformat);
		}
		return rtn;
	},
	secformatter: function(seconds){
		var rtn = '';
		if(seconds>=3600){
			var hours = Math.floor(seconds/3600);
			seconds -= (hours*3600);
			rtn += Scanstore.zerofiller(hours,2)+':';
		}
		if(!hours) rtn += '00:';
		var mins = Math.floor(seconds/60);
		seconds -= (mins*60);
		rtn += Scanstore.zerofiller(mins,2)+':';
		rtn += Scanstore.zerofiller(Math.floor(seconds),2);
		return rtn;
	},
	zerofiller: function(value,count){
		while(value.toString().length<count){
			value = '0'+value;
		}
		return value;
	}
}
var loaderTimer = 0;
function showLoader(){
	loaderTimer = setTimeout(function(){
		if(!Scanstore.initiated && document.getElementById('loader')){
			document.getElementById('loader').style.display = 'block';
		}
	},100);
}
window.onbeforeunload = function(e) {
	if(Scanstore.closemessage.length>0){
		return Scanstore.closemessage;
	}
};
window.onload = function(e) {
	clearTimeout(loaderTimer);
	Scanstore.initiated = true;
	document.getElementById('loader').style.display = 'none';
	Ext.application({
		name: 'Scanstore',
		autoCreateViewport: true,
		controllers: ['Main','Scans','Imports','Files','Images','Users']
	});
};