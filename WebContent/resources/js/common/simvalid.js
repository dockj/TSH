(function(factory){
    'use strict'
    if(typeof define === "function" && define.amd){
        define(['jquery'],factory);
    }else{
        factory(jQuery)
    }
})(function($,undefined){
	var reg = {
		num: /^\d+$/,            //数字
		int: /^[1-9]\d*$/,        //正整数
		az: /^[a-z]+$/,          //小写字母
		AZ: /^[A-Z]+$/,          //大写字母
		aZ: /^[a-zA-Z]+$/,       //大小写字母
		aznum: /^[a-zA-Z0-9]+$/,  //大小写字母或数字
		chinese: /^[\u4e00-\u9fa5]+$/,  //中文
		email: /^\w+(?:[-+.]\w+)*@\w+(?:[-.]\w+)*\.\w+(?:[-.]\w+)*$/,  //email
		phone: /^1[3-9]\d{9}$/,     //手机号码
		tel: /^0\d{2,3}-\d{6,8}$/,
		telarea: /^0\d{2,3}$/,
		telnum: /^\d{6,8}$/,
		amt: /^\d+(?:\.\d{1,2})?$/,
		realname: /^[\u4E00-\u9FA5\sa-zA-Z]{2,20}$/
	};
	
	function Valid(opts){
		this.elid = opts.elid || this.elid;
		this.el = $('#' + this.elid);
		this.btnid = opts.btnid || this.btnid;
		this.btn = $('#' + this.btnid);
		this.item = $.extend({}, opts.item);
		this.opts = opts;
		this.init(opts);
	}
	Valid.prototype = {
		elid: 'error',
		btnid: 'subBtn',
		init: function(opts){
			var bt = this.btn, _t = this;
			bt.off('click.simvalid').on('click.simvalid', function(){
				if(bt.hasClass('disabled')){
					return;
				}
				_t.disabled(bt);
				if(!_t.valid()){
					_t.enable(bt);
					return;
				}
				_t.el.hide();
				if(typeof _t.opts.ckfun == 'function') _t.opts.ckfun.call(_t);
			});
		},
		valid: function(){
			var flag = true, _t = this;
			if(_t.item){
				$.each(_t.item, function(inp, item){
					var $p = $('#' + inp);
					if($p.length > 0 && $p.is(':visible')){
						var v = $.trim($p.val()), pty = $p.attr('type');
						if(pty == 'text' && v!=''){
							$p.val(v);
						}
						if(pty == 'checkbox' || pty == 'radio'){
							var pnm = $p.attr('name');
							if(item.required){
								if($p.parents('form').find('[name="'+pnm+'"]:checked').length == 0){
									flag = false;
									_t.showError(item.required);
									return false;
								}
							}
						}else{
							if(v!=''){
								if(item.reg && !item.reg.test(v)){
									flag = false;
									$p.focus();
									_t.showError(item.ertip);
									return false;
								}
								if(item.fun && !item.fun.call(this, inp, item)){
									flag = false;
									$p.focus();
									_t.showError(item.ertip);
									return false;
								}
							}else{
								if(item.required){
									flag = false;
									$p.focus();
									_t.showError(item.required);
									return false;
								}
							}
						}
					}
				});
			}
			return flag;
		},
		showError: function(t){
			this.el.html(t).show();
		},
		hideError: function(){
			this.el.hide();
		},
		disabled: function(btn){
			btn.attr('disabled', true).addClass('disabled');
		},
		enable: function(btn){
			btn.removeAttr('disabled').removeClass('disabled');
		}
	};
	
	window.simreg = reg;
	window.simvalid = function(opts){
		return new Valid(opts);
	};
});