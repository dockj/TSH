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
					<b>评测结果</b>
				</h1>
				
				<div class="test_container">
				<form id="assessForm" method="post">
					<c:forEach items="${rows }" var="result" varStatus="count">
					<div class="assess_content">
						<h4 style="color:black">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${count.count}、<span style="margin-left:20px;color:black">评测时间：${result.strEvaDate}</span><span style="margin-left:20px;color:black">评测总分：${result.totalScore }</span><span style="margin-left:20px;color:black">评测平均分：${result.avgScore }</span>
						<span style="margin-left:20px;color:black">评测题目数量：${result.totalItem }</span>
						</h4>
							<c:forEach items="${result.types }" var="type"
								varStatus="postCount">
								<p>
									<span style="color: #0a8cd2;" >${postCount.count}、：</span><span style="margin-left:10px;color: black;">题目类型名称：${type.type }</span><span style="margin-left:10px;color: black;">类型总分：${type.sumTypeScore }</span><span style="margin-left:10px;color: black;">该类型题目数量：${type.sumType }</span>
									<span style="margin-left:10px;color: black;">类型平均分：${type.avgTypeScore }</span>
									<br />
								</p>
							</c:forEach>
					</div>
					<br />
					<div style=" margin-left:20px">
						<h4 style="color:gray">评论结果:</h4>
						<br />
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:coral;margin-left:10px;">${result.result }</span>
					</div>
					</c:forEach>
					<br />
					<br />
					<div style="text-align: center;">
						<input type="hidden" value="${pageSize }" id="pageSize"/>
						<input type="hidden" value="${total }" id="total" />
						<input type="hidden" value="${currPage }" id="currPage" />
						<input type="hidden" value="${pageCount }" id="pageCount" />
						<input type="hidden" value="${result.id }" id="resultId" />
						<button id="pre" >上一页</button>&nbsp;&nbsp;当前页：${currPage }&nbsp;&nbsp;总页数：${pageCount }&nbsp;&nbsp;<button id="next">下一页</button>&nbsp;&nbsp;<input type="text" value="" name="currPage" id="currPageInput" style="width:30px;" />&nbsp;&nbsp;<button id="go">go</button>
					</div>
					
				</form>
				</div>
			</div>
		</div>
		</div>
	<!--底部加载内容-->
	<script>
		$(function(){
			$(".content ul li:eq(2)").attr("class","current");
			$(".assess_content:even").css("background-color","#fbfbfb");
			$(".assess_content:odd").css("background-color","#fbfaee");
			
			
			
			var pageSize=$("#pageSize").val();
			var total=$("#total").val();
			var currPage=$("#currPage").val();
			var pageCount=$("#pageCount").val();
			var resultId=$("#resultId").val();
			if(currPage==1)
			{
				$("#pre").attr("disabled","disabled");
			}
			if(currPage==pageCount){
				$("#next").attr("disabled","disabled");
			}
			
			$("#next").click(function(){
				currPage=++currPage;
				window.location.href="${pageContext.request.contextPath }/ptsAssess/viewAssessResult?id="+resultId+"&page="+currPage;
			})
			$("#pre").click(function(){
				currPage=--currPage;
				window.location.href="${pageContext.request.contextPath }/ptsAssess/viewAssessResult?id="+resultId+"&page="+currPage;
			})
			$("#go").click(function(){
				var re = /^[0-9]+.?[0-9]*$/;
				if(!re.test($("#currPageInput").val()))
				{
					alert("请输入数字！");
					return;
				}
				currPage=$("#currPageInput").val();
				window.location.href="${pageContext.request.contextPath }/ptsAssess/viewAssessResult?id="+resultId+"&page="+currPage;
			})
			
		});
	</script>

</body>
</html>
