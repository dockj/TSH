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
				<h1>
					<b>甲亢自我测评</b>
				</h1>
				<div class="test_container">
					<form id="assessForm" method="post">
						<c:forEach items="${rows }" var="assess" varStatus="count">
							<div class="assess_content">
								<h4 style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${count.count}、${assess.title }</h4>
								<input type="hidden" value="${assess.id }" name="assessIds" />
								<p>
									<c:forEach items="${assess.scores }" var="score"
										varStatus="scoreCount">
										<label for="socre_${score.id }"> <input type="radio"
											value="${score.id }_${score.score}"
											name="score_${assess.id }" id="socre_${score.id }"> <a style="color:gray;">${scoreCount.count }、${score.option }(${score.score }分)</a>
										</label>
										<br />
									</c:forEach>
								</p>
							</div>
						</c:forEach>
						<input type="submit" value="提交" id="submitAssess" />
					</form>
				</div>
			</div>
		</div>
	</div>

	<!--底部加载内容-->
	<script>
		$("#assessForm").submit(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/ptsAssess/submitAssess",
				type : "POST",
				data : $("#assessForm").serialize(),
				dataType : "json",
				success : function(data) {
					if (data.resultCode == "0") {
						window.location.href="${pageContext.request.contextPath}/ptsAssess/viewAssessResult";
					} else {
						$.messager.alert('提示', data.note, 'error');
					}
				}
			});
			return false;
		});
		$(function() {
			$(".content ul li:eq(1)").attr("class", "current");
			$(".assess_content:even").css("background-color", "#fbfbfb");
			$(".assess_content:odd").css("background-color", "#fbfaee");
		});
	</script>

</body>
</html>
