<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctx = request.getContextPath();
	String version = "1.8";
	Object loginInfoObj = request.getSession().getAttribute("loginInfo");
	JSONObject loginUser = null;
	if(loginInfoObj != null) {
		loginUser = (JSONObject)loginInfoObj;
	}
%>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="author" content="gjfax.com"/>
<link href="<%=ctx %>/favicon.ico" rel="icon"/>
<link href="<%=ctx %>/resources/css/css.css?v=<%=version %>" rel="stylesheet"/>