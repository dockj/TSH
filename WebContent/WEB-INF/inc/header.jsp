<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" pageEncoding="utf-8"%>
<div class="header">
	<h1><img alt="" src="${pageContext.request.contextPath}/resources/images/style/pclogo.png" alt="甲亢管理" width="223" height="29"/></h1>
	<%
		JSONObject user=(JSONObject)request.getSession().getAttribute("user");
		if(user != null) {
	%>
	<a style="float:right;margin-top:-25px; margin-right: 30px; color: #fff;" href="${pageContext.request.contextPath}/users/logout">退出</a>
	<%
		}
	%>
</div>