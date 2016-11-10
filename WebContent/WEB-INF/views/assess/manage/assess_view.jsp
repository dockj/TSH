<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
</head>
<body>
	</script>
	<link rel="stylesheet" type="text/css"
		href="${pageContext.request.contextPath}/styles/assessDetail/reset.css" />
	<link rel="stylesheet" type="text/css"
		href="${pageContext.request.contextPath}/styles/assessDetail/tiku.css" />
	<link rel="stylesheet" type="text/css"
		href="${pageContext.request.contextPath}/styles/assessDetail/treeview.css" " />
</head>

<body>
	<div class="content">
		<div id="mainbar">
			<div class="test">

				<div class="test_container">
					<form id="assessForm" method="post">
						<c:forEach items="${rows }" var="assess" varStatus="count">
							<div class="assess_content">
								<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${count.count}、${assess.title }</h4>
								<input type="hidden" value="${assess.id }" name="assessIds" />
								<p>
									<c:forEach items="${assess.scores }" var="score"
										varStatus="scoreCount">
										<label for="socre_${score.id }"> <input type="radio"
											value="${score.id }_${score.score}"
											name="score_${assess.id }" id="socre_${score.id }"> <a>${scoreCount.count }、${score.option }(${score.score }分)</a>
										</label>
										<br />
									</c:forEach>
								</p>
							</div>
						</c:forEach>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
