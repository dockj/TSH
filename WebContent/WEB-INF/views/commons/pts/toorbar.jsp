<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="topbar">
		<div class="content">
			<span class="fl">欢迎来到甲亢管理中心！</span> 
			<c:if test="${user!=null }">
				<span class="fr" style="color:black">用户名：<a
					href="${pageContext.request.contextPath }/ptsUsers/toModify" class="toplink" >${user.username }</a>
						<a href="${pageContext.request.contextPath }/ptsUsers/logout">退出</a></span>
			</c:if>
				
		</div>
	</div>
	<div id="logo_area">
		<img
			src="${pageContext.request.contextPath }/images/jkgl.png"
			alt="甲亢管理" title="甲亢管理"  style="width:400px;margin-top:10px;"/>
	</div>
	<div id="nav">
		<div class="content">
			<ul>
				<li><a href="${pageContext.request.contextPath }/ptsUsers/index">首页</a></li>
				<li><a href="${pageContext.request.contextPath }/ptsAssess/generateAssess">甲亢症状自评</a></li>
				<li><a href="${pageContext.request.contextPath }/ptsAssess/viewAssessResult">查看评测结果</a></li>
				<li><a href="${pageContext.request.contextPath }/ptsPatients/toMain">我的随访时间</a></li>
				<li><a href="${pageContext.request.contextPath }/ptsBBS/toMain">医患交流</a></li>
				<li><a href="${pageContext.request.contextPath }/ptsUsers/toModify">修改注册信息</a></li>
				<li><a href="${pageContext.request.contextPath }/ptsUsers/toModifyPwd">修改密码</a></li>
				<li><a href="${pageContext.request.contextPath }/softs/ptsDesc">软件说明</a></li>
			</ul>
		</div>
	</div>
	<div class="content mb10">
		<div class="pad10 boxb" >
			<img alt="甲亢管理" src="${pageContext.request.contextPath }/images/jkgl_bg1.jpg" style="width:960px">
		</div>
	</div>
		
