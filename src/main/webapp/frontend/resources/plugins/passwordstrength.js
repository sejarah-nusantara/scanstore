(function() {
	/**
	 * @class Ext.plugin.extjs.form.PasswordStrength
	 *
	 * Plugin for testing password strength
	 *
	 * @author <a href="mailto:mvanworkum@nmera.com">M. van Workum</a>
	 *
	 * @copyright (c) 2013 nMera - Interactive
	 * @license Ext.plugin.extjs.form.PasswordStrength is released under the
	 * <a target="_blank" href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>.
	 *
	 */
	Ext.define("Ext.plugin.form.PasswordStrength", {
		extend : "Ext.AbstractPlugin",
		alias : "plugin.passwordstrength",
		colors : ["660000", "663300", "666600", "336600", "006600"],
		init: function(field) {
			var me = this;
			field.on("change", me.onFieldChange, me);
			field.on("boxready",function(){
				me.tip = Ext.create('Ext.tip.ToolTip',{
					target: field.getEl(),
					disabled: true
				});
			});
			field.on("validitychange",function(){
				me.tip.setDisabled(!field.isValid());
			});
		},
		onFieldChange: function(field, newVal, oldVal) {
			if (newVal === "") {
				field.inputEl.setStyle({ "color" : null });
				field.score = 0;
				return;
			}
			var me = this,
				score = me.scorePassword(newVal);
			field.score = score;
			me.processValue(field, score);
		},
		processValue: function(field, score) {
			var me = this,
				colors = me.colors,
				color,
				text;
			if (score < 16) {
				color = colors[0];
				text = 'very bad';
			} else if (score > 15 && score < 25) {
				color = colors[1];
				text = 'bad';
			} else if (score > 24 && score < 35) {
				color = colors[2];
				text = 'mediocre';
			} else if (score > 34 && score < 45) {
				color = colors[3];
				text = 'good';
			} else {
				color = colors[4];
				text = 'very good';
			}
			field.inputEl.setStyle({
				"color" : "#" + color,
			});
			me.tip.update('Password is of '+text+' quality');
		},
		scorePassword: function(passwd) {
			var score = 0;
			if (passwd.length < 5) score += 3;
			else if (passwd.length > 4 && passwd.length < 8) score += 6;
			else if (passwd.length > 7 && passwd.length < 16) score += 12;
			else if (passwd.length > 15) score += 18;
			if (passwd.match(/[a-z]/)) score += 1;
			if (passwd.match(/[A-Z]/)) score += 5;
			if (passwd.match(/\d+/)) score += 5;
			if (passwd.match(/(.*[0-9].*[0-9].*[0-9])/)) score += 5;
			if (passwd.match(/.[!,@,#,$,%,^,&,*,?,_,~]/)) score += 5;
			if (passwd.match(/(.*[!,@,#,$,%,^,&,*,?,_,~].*[!,@,#,$,%,^,&,*,?,_,~])/)) score += 5;
			if (passwd.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) score += 2;
			if (passwd.match(/([a-zA-Z])/) && passwd.match(/([0-9])/)) score += 2;
			if (passwd.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) score += 2;
			return score;
		}
	});
})();