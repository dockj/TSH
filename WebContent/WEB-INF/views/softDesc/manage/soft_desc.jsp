<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
<%@ include file="/WEB-INF/views/commons/pts/ptsHead.jsp"%>
</head>
<body class="B_register B_reg_tel">
	<body class="B_register B_reg_tel ">
	<div class="W_nologin">
		<div class="W_nologin_main main_radius_bg">
			<div class="main_tab_line">
				<a class="W_f22 W_Yahei cur" href="javascript:void(0);">软件说明</a>
			</div>
				<div class="W_reg_info clearfix" id="pl_account_regmobile">
					<div class="W_reg_form">
						<div class="info_list clearfix" node-type="mobilesea_wrapper">
							<div class="tips" node-type="mobilesea_tip"></div>
						</div>
						<div class="info_list clearfix">
							<h4>一、软件用途</h4>
							<br />
							<p>1、甲亢患者病情管理</p>
							<p>2、定期评测甲亢患者甲亢病情</p>
							<br />
							<br />
							<h4>二、操作流程</h4>
							<br />
							<p>1、出院患者登入注册页面</p>
							<p>2、患者注册，输入出院时间</p>
							<p>3、医生根据患者患者出院时间，管理设定随访时间</p>
							<p>4、患者可以进入甲亢自评模块，对自身甲亢病情做评估</p>
							<p>5、自评完成后，可进入自评结果，查看自评历史记录及自评结果，及医生对此次自评结果的诊断结论</p>
							<p>6、患者可进入我的随访时间模块，可查看，医生设定的随访时间，以及所有的随访记录</p>
							<p>7、医患交流模块，患者可以发布帖子，与所有的患友、医生讨论甲亢相关问题</p>
							<p>8、修改用户注册信息，可以修改用户注册填写的注册信息</p>
							<p>9、修改用户密码</p>
							<p>10、说明软件的使用流程</p>
						</div>
					</div>

				</div>
		</div>
	</div>
	<script>
	$(function() {
			$(".content ul li:eq(7)").attr("class", "current");
			$(".assess_content:even").css("background-color", "#fbfbfb");
			$(".assess_content:odd").css("background-color", "#fbfaee");
		});
	</script>
</body>
</html>
