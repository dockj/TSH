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
				<a class="W_f22 W_Yahei cur" href="javascript:void(0);">修改注册信息</a>
			</div>

			<form class="lgform" method="post" AUTOCOMPLETE="OFF"
				id="modifyRegister">
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
									name="username" type="text" class="W_input"
									value="${userDTO.username }" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>真实姓名：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="realname" type="text" class="W_input"
									value="${userDTO.realname }" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>身份证：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="certiCode" type="text" class="W_input"
									value="${userDTO.certiCode }" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>性别：
							</div>
							<div class="inp">
								<select name="sex">
									<option ${userDTO.sex eq "1" ? "selected":"" } value="1">男</option>
									<option ${userDTO.sex eq "2" ? "selected":"" } value="2">女</option>
								</select>
							</div>
							<br />
							<div class="tit">
								<i>*</i>年龄：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="age" type="text" class="W_input" value="${userDTO.age }" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>电子邮箱：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="email" type="text" class="W_input"
									value="${userDTO.email }" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>联系方式：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="mobilePhone" type="text" class="W_input"
									value="${userDTO.mobilePhone }" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>家庭详细地址：
							</div>
							<div class="inp">
								<input node-type="text" action-data="" action-type="text_copy"
									name="address" type="text" class="W_input"
									value="${userDTO.address }" />
							</div>
							<br />
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
									node-type="btn_submit"><span>提交修改</span></a>
							</div>
						</div>

					</div>

				</div>
		</div>
		</form>
	</div>
	</div>
	<script type="text/javascript">
		function submit() {
			$('#modifyRegister').submit();
		}
		$(function() {

			$('#modifyRegister').submit(function() {
				$.ajax({
					url : '${pageContext.request.contextPath}/users/modify',
					type : "POST",
					data : $('#modifyRegister').serialize(),
					dataType : "json",
					success : function(data) {
						if (data.resultCode == "0") {
							alert(data.note);
							//window.location.href="${pageContext.request.contextPath}/users/toLogin";
						} else {
							$("#errorInfo").text(data.note);
						}
					}
				});
				return false;
			});
		});
	</script>
</body>
</html>
