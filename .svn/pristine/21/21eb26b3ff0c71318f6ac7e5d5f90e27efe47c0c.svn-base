<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ include file="/WEB-INF/views/commons/taglibs.jsp"%>


<!-- 新定义的css文件 -->

<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/css_v1_01/layout.css"/>
<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/jquery-easyui-1.3.1/themes/default/easyui.css"/>
<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/jquery-easyui-1.3.1/themes/icon.css"/>

<script type="text/javascript" src="${ctx}CacheableResource/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/jquery-easyui-1.3.1/easyloader.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>

<script type="text/javascript" src="${ctx}CacheableResource/jquery_v1_01/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/common_v1_01/Zxb.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/common_v1_01/coverController.js"></script>
<script type="text/javascript" src="${ctx}sf_home/resources/sf-jquery-patch.js"></script>

<!--日期控件-->
<script type="text/javascript" src="${ctx}CacheableResource/DatePicker/WdatePicker.js"></script>

<!--UM中可以控制系统是否允许右键菜单-->
<script>
document.oncontextmenu=function(){ return ${_sf_disable_right_menu}};
easyloader.locale = "zh_CN";
</script>
<%
	boolean authPresent = false;
	boolean authAudit = false;
	boolean authReport = false;
	boolean authConfig = false;
	List<String> roleList = (List<String>)session.getAttribute("roleList");
	if(roleList.contains("发放审核")){
		authAudit = true;
	}
	if(roleList.contains("发放")){
		authPresent = true;
	}
	if(roleList.contains("报表")){
		authReport = true;
	}
	if(roleList.contains("系统配置")){
		authConfig = true;
	}
%>
<!--让panel能自适应窗口的的变化--> 
<script type="text/javascript">
    /*
    $(window).resize(function(){
      var rwidth = $(".navigation_div").width();
	  $(".easyui-panel").panel("resize",{width:rwidth});
	}); 
     */
</script>

<!--只读文本框样式-->
<script type="text/javascript">
var path = "${ctx}CacheableResource/images_v1_01/";
$(function(){
    $(":input[readonly]").addClass("readOnly_input");
})
</script>


<script type="text/javascript">

	function setDate(elementid, datetype) {
		var d, rst;
		d = new Date();
		if (datetype == 1) {
			rst = dateformatter(d).substring(0, 8) + '01';
		} else if (datetype == 2) {
			rst = dateformatter(d);
		}
		document.getElementById(elementid).value = rst;
	}

	function dateformatter(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		var d = date.getDate();
		return y + '-' + (m < 10 ? ('0' + m) : m) + '-'
				+ (d < 10 ? ('0' + d) : d);
	}
	
	function dateparser(s) {
		if (!s)
			return new Date();
		var sss = s.split('-');
		var y = parseInt(ss[0], 10);
		var m = parseInt(ss[1], 10);
		var d = parseInt(ss[2], 10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
			return new Date(y, m - 1, d);
		} else {
			return new Date();
		}
	}

	function formatPercent(val, row) {
		return (val * 100).toFixed(2) + '%';
	}
	
	function formatNumber1(val, row) {
		return val.toFixed(1);
	}
	
    function queryUpdateDate(report_id){
		$.ajax({
			   type: "POST",
			   url: "${ctx}cesSysEtlrunlog/query.do?reportId="+report_id,
			   success: function(msg){
				   //var h = msg.split("<br>").length * 20 + 10;
				   $('#p').panel({
					   title: "报表说明",
					   content: msg,
					   style:{
						   fontSize:12
					   }
				   });
			   }
		});
    }
    
/*     function export_file(url) {
        OpenWindow = window.open('','','toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
        　　	OpenWindow.document.write("<TITLE>导出</TITLE>");
        OpenWindow.document.write("<BODY>");
        OpenWindow.document.write("<div id='loader' align='center'><img src='/ces/styles/images/loader.gif'></img></div>");
        OpenWindow.document.write("<div align='center'>正在生成文件，请稍等...</div>");
        OpenWindow.document.write("<iframe name='download' src='"+url+"' height=0 width=0></iframe>");
        OpenWindow.document.write("</BODY>");
        OpenWindow.document.write("</HTML>");
        OpenWindow.document.close();
    } */
    function export_file(url) {
        //OpenWindow = window.open('','','toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
        //OpenWindow.location = "${ctx}export_file.do?" + url;
        window.open(url);
    }
</script>

<!-- easyui 重写默认 deafults -->
<script type="text/javascript">
$.extend($.fn.datagrid.defaults, {
	nowrap : false
});
$.extend($.fn.datagrid.defaults.editors, {
    select: {
		init: function(container, options){
			var input = $('<select id="'+ options.id +'" valtype="'+options.valtype	+	
					'" class="combo" style="height:22px;"></select>').appendTo(container);
			return input;
		},
		destroy: function(target){
			$(target).remove();
		},
		getValue: function(target){
			var val = "";
			if('txt' == $(target).attr("valtype")) {				
				val = $(target).find("option:selected").text();
			} else if('val' == $(target).attr("valtype")) {
				val = $(target).val();
			} else {				
				val = $(target).val() + "," +  $(target).find("option:selected").text();
			}
			return val;
		},
		setValue: function(target, value){
			$(target).val(value);
		},
		resize: function(target, width){
			$(target)._outerWidth(width);
		}
    },
    sizeText: {
		init: function(container, options){
			var input = $('<input type="text" id="' + options.id + '" maxlength="' + options.maxlength + '" class="datagrid-editable-input">').appendTo(container);
			return input;
		},
		destroy: function(target){
			$(target).remove();
		},
		getValue: function(target){
			return $(target).val();
		},
		setValue: function(target, value){
			$(target).val(value);
		},
		resize: function(target, width){
			$(target)._outerWidth(width);
		}
    }
});
</script>