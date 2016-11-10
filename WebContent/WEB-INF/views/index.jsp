<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/inc/init.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>甲亢管理系统</title>
<style type="text/css">
#left {
	width: 190px;
	float: left;
}

#right {
	background: #fff;
	margin-left:195px;
}
</style>
</head>
<body>
	<div id="header">
		<%@ include file="../inc/header.jsp"%>
	</div>
	<div class="content" id="main">
		<div id="left">
			<iframe name="leftFrame" id="leftFrame" width="100%" height="100%"
				src="${pageContext.request.contextPath }/index/left" frameborder="0" scrolling="no"></iframe>
		</div>
		<div id="right">
			<iframe name="rightFrame" width="100%" height="100%"
				src="<%=ctx%>/welcome.jsp" frameborder="0" scrolling="auto"></iframe>
		</div>
	</div>
	<%@ include file="/WEB-INF/inc/footer.jsp"%>
	<script>
		var adh = 450;
		history.forward();
		
		var main = {
			/** 自动调整div高度 */
			autoResizeDivFunc : function () {
				var autoDivHeight = (document.documentElement.clientHeight || document.body.clientHeight) - $('#main').offset().top;
				$('#main iframe').height(autoDivHeight);
				return autoDivHeight;
			}
			<%-- logout : function () {
				window.location.href = "<%=ctx%>/login/loginOut";
			} --%>
		}

		$(document).ready(function() {
			adh = main.autoResizeDivFunc();
			$(window).bind('resize', function() {
				adh = main.autoResizeDivFunc();
				$('#leftFrame')[0].contentWindow.setMenuh(adh);
			});
		});
		window.onload = function() {
			$('#leftFrame')[0].contentWindow.setMenuh(adh);
		};
	</script>
</body>
</html>
