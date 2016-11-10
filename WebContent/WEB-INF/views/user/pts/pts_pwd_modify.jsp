<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
<%@ include file="/WEB-INF/views/commons/pts/ptsHead.jsp"%>
</head>
<body class="B_register B_reg_tel">
	<%@ include file="/WEB-INF/views/commons/pts/toorbar.jsp"%>
	<body class="B_register B_reg_tel ">
	<div class="W_nologin">
		<div class="W_nologin_main main_radius_bg">
			<div class="main_tab_line">
				<a class="W_f22 W_Yahei cur" href="javascript:void(0);">修改密码信息</a>
			</div>
			<form class="lgform" method="post" AUTOCOMPLETE="OFF" id="modifyPwd">
				<div class="W_reg_info clearfix" id="pl_account_regmobile">
					<div class="W_reg_form">
						<div class="info_list clearfix" node-type="mobilesea_wrapper">
							<div class="tips" node-type="mobilesea_tip"></div>
						</div>
						<div class="info_list clearfix">
							<div class="tit">
								<i>*</i>旧密码：
							</div>
							<div class="inp">
								<input node-type="password" action-data=""
									action-type="text_copy" name="oldPwd" type="password"
									class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>新密码：
							</div>
							<div class="inp">
								<input node-type="password" action-data=""
									action-type="text_copy" name="newPwd" type="password"
									class="W_input" value="" />
							</div>
							<br />
							<div class="tit">
								<i>*</i>确认密码：
							</div>
							<div class="inp">
								<input node-type="password" action-data=""
									action-type="text_copy" name="reNewPwd" type="password"
									class="W_input" value="" />
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
	<script type="text/javascript">
		function submit() {
			$('#modifyPwd').submit();
		}
		$(function() {

			$('#modifyPwd')
					.submit(
							function() {
								$
										.ajax({
											url : '${pageContext.request.contextPath}/users/modifyPwd',
											type : "POST",
											data : $('#modifyPwd').serialize(),
											dataType : "json",
											success : function(data) {
												if (data.resultCode == "0") {
													alert(data.note);
													window.location.href="${pageContext.request.contextPath}/ptsUsers/index";
												} else {
													alert(data.note);
												}
											}
										});
								return false;
							});
		});
		$(".content ul li:eq(6)").attr("class","current");
	</script>
</body>
</html>
