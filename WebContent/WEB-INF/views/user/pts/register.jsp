<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/scripts/jquery-1.8.3.min.js"></script>
<!--注册登录header-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link
	href="${pageContext.request.contextPath }/resources/css/register.css"
	type="text/css" rel="stylesheet" />

<link
	href="${pageContext.request.contextPath }/resources/css/register2.css"
	type="text/css" rel="stylesheet" />
<link
	href="${pageContext.request.contextPath }/resources/css/registerFrame.css"
	type="text/css" rel="stylesheet" />
<title>用户注册</title>
</head>
<body class="B_register B_reg_tel ">
	<div class="W_nologin">
		<div class="W_nologin_main main_radius_bg">
			<div class="main_tab_line">
				<a class="W_f22 W_Yahei cur" href="javascript:void(0);">个人注册</a>
			</div>

			<form class="lgform" method="post" AUTOCOMPLETE="OFF"
				id="registerForm">
				<div class="W_reg_info clearfix" id="pl_account_regmobile">
					<div class="W_reg_form">
						<div class="info_list clearfix" node-type="mobilesea_wrapper">
							<div class="tips" node-type="mobilesea_tip"></div>
						</div>
						<div class="info_list clearfix">
							<div class="tit">
								<i>*</i>用户名：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="username" type="text" class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>设置密码：
							</div>
							<div class="inp">
								<input node-type="password" action-data=""
									action-type="text_copy" name="password" type="password"
									class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>确认密码：
							</div>
							<div class="inp">
								<input node-type="password" action-data=""
									action-type="text_copy" name="rePassword" type="password"
									class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>真实姓名：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="realname" type="text" class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>身份证：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="certiCode" type="text" class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>性别：
							</div>
							<div class="inp">
								<select name="sex">
									<option value="1">男</option>
									<option value="2">女</option>
								</select>
							</div>
							<br />
							<div class="tit">
								<i>*</i>年龄：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="age" type="text" class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>电子邮箱：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="email" type="text" class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>联系方式：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="mobilePhone" type="text" class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>家庭详细地址：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="address" type="text" class="W_input" value="" />
							</div>

							<br />
							<div class="tit">
								<i>*</i>出院日期：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="levHosDate" type="text" class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>用户类型：
							</div>
							<div class="inp">
								<select name="roleNo">
									<option value="">请选择用户类型</option>
									<c:forEach items="${roles }" var="role">
										<option value="${role.roleNo }">${role.name }</option>
									</c:forEach>
								</select>
							</div>
						</div>
							<div class="info_submit clearfix">
								<div class="inp">
									<span id="errorInfo"
										style="color: red; font-size: 12px; margin-left: 20px"></span>
								</div>
								<br />
								<div class="inp">
									<a action-type="btn_submit" class="W_btn_big"
										suda-uatrack="key=tblog_register_page&value=register_now_button"
										href="javascript:submit();" refake-type="submit"
										node-type="btn_submit"><span>立即注册</span></a>
								</div>
							</div>
							<div class="info_list clearfix">
								<div class="inp verify">
									<p class="agreement"></p>
									<p class="agreement"></p>
									<p class="agreement"></p>
								</div>
							</div>
						</div>
						<div class="W_reg_sidebar">
							<p class="p1 line">
								已有帐号，<a href="${pageContext.request.contextPath }/users/toLogin">直接登录»</a>
							</p>
							
						</div>
					</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function submit() {
			$('#registerForm').submit();
		}
		$(function() {

			$('#registerForm')
					.submit(
							function() {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/ptsUsers/register',
											type : "POST",
											data : $('#registerForm')
													.serialize(),
											dataType : "json",
											success : function(data) {
												if (data.resultCode == "0") {
													window.location.href = "${pageContext.request.contextPath}/ptsUsers/index";
												} else {
													$("#errorInfo").text(
															data.note);
												}
											}
										});
								return false;
							});
		});
	</script>
</body>
</html>
