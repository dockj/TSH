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
				<h2>
					<b>${post.postName }</b>
				</h2>
				<div class="test_container">
					
					<div class="assess_content">
						<h4 style="color:black;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="margin-left:20px">作者：${post.username }</span><span style="margin-left:20px">回复总数：${post.replyNum }</span><span style="margin-left:20px">创建时间：${post.createTime }</span>
						<span style="margin-left:20px">更新时间：${post.updateTime }</span>
						</h4>
						<p style="color:black">
							&nbsp;&nbsp;&nbsp;&nbsp;${post.postContent }
						</p>
							<c:forEach items="${rows }" var="reply"
								varStatus="count">
								<p>
									<span style="color: #0a8cd2;" >${reply.floor}楼：</span><span style="margin-left:20px;color: coral;">回复人：${reply.username }</span><span style="margin-left:20px;color: coral;">回复时间：${reply.createTime }</span>
									<br />
									<span style="color:black;margin-right:40px;margin-left:20px;">${reply.replyContent }</span>
								</p>
							</c:forEach>
					</div>
					<br />
					<div>
					<br />
					<div style="text-align: center;">
						<input type="hidden" value="${pageSize }" id="pageSize"/>
						<input type="hidden" value="${total }" id="total" />
						<input type="hidden" value="${currPage }" id="currPage" />
						<input type="hidden" value="${pageCount }" id="pageCount" />
						<input type="hidden" value="${post.id }" id="postid" />
						<button id="pre" >上一页</button>&nbsp;&nbsp;当前页：${currPage }&nbsp;&nbsp;总页数：${pageCount }&nbsp;&nbsp;<button id="next">下一页</button>&nbsp;&nbsp;<input type="text" value="" name="currPage" id="currPageInput" style="width:30px;" />&nbsp;&nbsp;<button id="go">go</button>
					</div>
					<br />
					<form id="addReply">
						<textarea rows="5" cols="160" name="replyContent" ></textarea>
						<input type="hidden" value="${post.id }" name="postId" />
						<input type="hidden" value="${post.postName }" name="postName" />
						<br />
						<input type="submit" value="回复"  id="submitAssess"/>
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--底部加载内容-->
	<script>
		$("#addReply").submit(function(){
			$.ajax({
	    		url:"${pageContext.request.contextPath}/ptsBBS/addReply",
	    		type:"POST", 
	    		data:$("#addReply").serialize(),
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			window.location.href="${pageContext.request.contextPath}/ptsBBS/toViewReply?postId=${post.id}"
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
			return false;
		});
		$(function(){
			$(".content ul li:eq(4)").attr("class","current");
			$(".assess_content:even").css("background-color","#fbfbfb");
			$(".assess_content:odd").css("background-color","#fbfaee");
			
			var pageSize=$("#pageSize").val();
			var total=$("#total").val();
			var currPage=$("#currPage").val();
			var pageCount=$("#pageCount").val();
			var topicId=$("#postid").val();
			if(currPage==1)
			{
				$("#pre").attr("disabled","disabled");
			}
			if(currPage==pageCount){
				$("#next").attr("disabled","disabled");
			}
			
			$("#next").click(function(){
				currPage=++currPage;
				window.location.href="${pageContext.request.contextPath }/ptsBBS/toViewReply?postId="+topicId+"&page="+currPage;
			})
			$("#pre").click(function(){
				currPage=--currPage;
				window.location.href="${pageContext.request.contextPath }/ptsBBS/toViewReply?postId="+topicId+"&page="+currPage;
			})
			$("#go").click(function(){
				var re = /^[0-9]+.?[0-9]*$/;
				if(!re.test($("#currPageInput").val()))
				{
					alert("请输入数字！");
					return;
				}
				currPage=$("#currPageInput").val();
				window.location.href="${pageContext.request.contextPath }/ptsBBS/toViewReply?postId="+topicId+"&page="+currPage;
			})
			
		});
	</script>

</body>
</html>
