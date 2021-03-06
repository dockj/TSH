<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/inc/init.jsp"%>

<!DOCTYPE html>
<head>
<title>left menu</title>
<link href="${pageContext.request.contextPath }/resources/css/left.css"
	type="text/css" rel="stylesheet" />
</head>

<body>

	<div class="urbangreymenu">
		<h3 class='headerbar'>
			<div class="arowd">症状自评管理</div>
		</h3>
		<ul class="menuul">

			<li><a href='${pageContext.request.contextPath }/assess/main'
				target='rightFrame'>&nbsp;&nbsp;自评管理</a></li>
			<li><a
				href='${pageContext.request.contextPath }/assess/viewAssess'
				target='rightFrame'>&nbsp;&nbsp;预览自评表</a></li>
				<li><a
				href='${pageContext.request.contextPath }/assess/toAssessResult'
				target='rightFrame'>&nbsp;&nbsp;自评结果管理</a></li>
		</ul>
	</div>
	<div class="urbangreymenu">

		<h3 class='headerbar'>
			<div class="arowd">患者管理</div>
		</h3>
		<ul class="menuul">

			<li><a
				href='${pageContext.request.contextPath }/patients/toMain'
				target='rightFrame'>&nbsp;&nbsp;患者查询列表</a>
				<li><a
				href='${pageContext.request.contextPath }/patients/toFollowMain'
				target='rightFrame'>&nbsp;&nbsp;随访时间管理</a>
		
		</ul>
	</div>
		<div class="urbangreymenu">

		<h3 class='headerbar'>
			<div class="arowd">医患交流</div>
		</h3>
		<ul class="menuul">

			<li><a
				href='${pageContext.request.contextPath }/bbs/toTopicMain'
				target='rightFrame'>&nbsp;&nbsp;话题管理</a></li>
				<li><a
				href='${pageContext.request.contextPath }/bbs/toPostMain'
				target='rightFrame'>&nbsp;&nbsp;帖子管理</a></li>
		
		</ul>
	</div>
	<div class="urbangreymenu">

		<h3 class='headerbar'>
			<div class="arowd">个人信息</div>
		</h3>
		<ul class="menuul">

			<li><a href='${pageContext.request.contextPath }/users/toModify'
							target='rightFrame'>&nbsp;&nbsp;修改信息</a></li>
			
			<li><a href='${pageContext.request.contextPath }/users/toModifyPwd' target='rightFrame'>&nbsp;&nbsp;修改密码</a></li>
		</ul>
	</div>
	
	<div class="urbangreymenu">
		<h3 class='headerbar'>
			<div class="arowd">软件说明</div>
		</h3>
		<ul class="menuul">

			<li><a href='${pageContext.request.contextPath }/softs/desc'
							target='rightFrame'>&nbsp;&nbsp;软件说明</a></li>
		</ul>
	</div>


	<%@ include file="/WEB-INF/inc/footer.jsp"%>
	<script>
		var um = $('.urbangreymenu'), hd = $('.headerbar'), mul = $('.menuul'), lia = $('.urbangreymenu li a'), h = 200;
		function setMenuh(bh) {
			//console.log(bh, h);
			var uh = bh - h;
			$('.menuul').height(uh);
		}

		$(document).ready(function() {
			h = (hd.outerHeight() + 2) * hd.length;
			um.eq(0).addClass('ulopen');
			lia.click(function() {
				$('.urbangreymenu li a').removeClass('currentClickMenu');
				$(this).addClass('currentClickMenu');
			});

			hd.click(function() {
				um.removeClass('ulopen');
				$(this).parent().addClass('ulopen');
			});
		});
	</script>

			</body>
</html>
