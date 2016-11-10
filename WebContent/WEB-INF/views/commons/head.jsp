
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ include file="/WEB-INF/views/commons/taglibs.jsp"%>


<!-- 新定义的css文件 -->

<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/css_v1_01/layout.css"/>
<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/jquery_v1_01/jquery-ui-1.8.6.custom.css"/>
<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/jquery-easyui-1.3.1/themes/default/easyui.css"/>
<!--easyui的iocn图标文件-->
<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/jquery-easyui-1.3.1/themes/icon.css"/>
<!--分页组件样式-->
<link rel=stylesheet type="text/css" href="${ctx}CacheableResource/pagination_v1_01/pagination.css"/>

<script type="text/javascript" src="${ctx}CacheableResource/jquery_v1_01/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/jquery_v1_01/jquery-ui-1.8.6.custom.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/jquery-easyui-1.3.1/easyloader.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/easyui1.2.1/jquery.bgiframe.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/jquery_v1_01/jquery.blockUI.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/pagination_v1_01/pagination.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/common_v1_01/Zxb.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/common_v1_01/coverController.js"></script>
<script type="text/javascript" src="${ctx}CacheableResource/validform/Validform_v5.1.js"></script>

<!--日期控件-->
<script type="text/javascript" src="${ctx}CacheableResource/DatePicker/WdatePicker.js"></script>
<!--UM中可以控制系统是否允许右键菜单-->
<script>
document.oncontextmenu=function(){ return ${_sf_disable_right_menu}};
</script>

<!--让panel能自适应窗口的的变化--> 
<script type="text/javascript">
    $(window).resize(function(){
      var rwidth = $(".navigation_div").width();
	  $(".easyui-panel").panel("resize",{width:rwidth});
	}); 

</script>

<!--只读文本框样式-->
<script type="text/javascript">
var path = "${ctx}CacheableResource/images_v1_01/";
$(function(){
    $(":input[readonly]").addClass("readOnly_input");
})
</script>
