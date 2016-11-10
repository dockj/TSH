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
					<b>未随访记录</b>
				</h1>
				<div class="test_container">
					<c:forEach items="${follows }" var="follow" varStatus="count">
					<div class="assess_content">
						<h4 style="color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${count.count}、<span style="margin-left:20px;">随访时间：${follow.followDate }</span></h4>
					</div>
					</c:forEach>
				</div>
			</div>
		
			<div class="test">
				<h1>
					<b>已随访记录</b>
				</h1>
				<div class="test_container">
					<c:forEach items="${followeds }" var="followed" varStatus="count">
					<div class="assess_content">
						<h4 style="color:black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${count.count}、<span style="margin-left:20px;">随访时间：${followed.followDate }</span><span style="margin-left:20px">已随访时间：${followed.followedDate }</span></h4>
						<p>
							<span style="color: gray;" >随访结果：</span><span style="margin-left:10px;color: black;">${followed.result }</span>
						</p>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>

	<!--底部加载内容-->
	<script>
		$("#assessForm").submit(function(){
			$.ajax({
	    		url:"${pageContext.request.contextPath}/assess/submitAssess",
	    		type:"POST", 
	    		data:$("#assessForm").serialize(),
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    	    	$('#win').window('close');
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
			return false;
		});
		$(function(){
			$(".content ul li:eq(3)").attr("class","current");
			$(".assess_content:even").css("background-color","#fbfbfb");
			$(".assess_content:odd").css("background-color","#fbfaee");
		});
	</script>

</body>
</html>
