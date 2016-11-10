<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/WEB-INF/inc/init.jsp"%>
<title>甲亢管理登入</title>
</head>
<body class="xls-login-bg">
	<!-- header start -->
	<%@ include file="/WEB-INF/inc/header.jsp"%>
	<!-- /header end -->
	<!-- main start -->
	<div class="page-warp xls-login">

		<form class="form xls-login-form" id="loginForm" method="post">
			<div class="tac">
				<i class="iconfont icon-head fc-org"></i>
				<h2 class="page-title">用户登录</h2>
			</div>
			<div class="form-item mt-30">
				<i class="iconfont icon-user"></i><input type="text" id="user"
					name="username" class="form-input">
			</div>
			<div class="form-item mt-10">
				<i class="iconfont icon-psw"></i><input type="password"
					id="password" class="form-input" name="password">
			</div>
			<div class="roleType">
				<select name="roleNo" class="form-input">
					<option value="">请选择用户类型</option>
					<c:forEach items="${roles }" var="role">
						<option value="${role.roleNo }">${role.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="tac form-erbox">
				<span id="error" class="fc-red"></span>
			</div>
			<div class="tac mt-10">
				<input type="submit" class="btn xls-login-btn" id="lgbtn"
					value="登 录"> <input type="button" class="btn xls-login-btn"
					id="registerBtn" value="注 册">
			</div>
		</form>
	</div>
	<!-- /main end -->
	<!-- footer start -->
	<%@ include file="/WEB-INF/inc/footer.jsp"%>
	<!-- /footer end -->
	<script type="text/javascript"
		src="<%=ctx%>/resources/js/common/simvalid.js"></script>
	<script type="text/javascript"
		src="<%=ctx%>/resources/js/common/md5.min.js"></script>
	<script type="text/javascript">
		$(function() {

			$("#registerBtn")
					.click(
							function() {
								window.location.href = "${pageContext.request.contextPath}/ptsUsers/toRegister";
							});

			$("#loginForm")
					.submit(
							function() {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/users/login',
											type : "POST",
											data : $('#loginForm').serialize(),
											dataType : "json",
											success : function(data) {
												if (data.resultCode == "0") {
													if (data.roleNo!=1) {
														window.location.href = "${pageContext.request.contextPath}/ptsUsers/index";
													} else {
														window.location.href = "${pageContext.request.contextPath}/users/index";
													}
												} else {
													$("#error").text(data.note);
												}
											}
										});
								return false;
							});
		});
	</script>
</body>
</html>