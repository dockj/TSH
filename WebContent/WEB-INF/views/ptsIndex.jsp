<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
<%@ include file="/WEB-INF/views/commons/pts/ptsHead.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/views/commons/pts/toorbar.jsp"%>
		<div class="content">
			<div id="mainbar">
				<div class="test">
					<div class="test_container">
						<div class="assess_content">
							<h4></h4>
							<p style="color:black">
							欢迎登入甲亢管理中心
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>

	<!--底部加载内容-->
	<script>
		
		$(function(){
			$(".content ul li:eq(0)").attr("class","current");
		});
	</script>

</body>
</html>
