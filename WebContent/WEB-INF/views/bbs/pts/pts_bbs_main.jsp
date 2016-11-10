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
					<b>交流主题</b>
				</h1>
				
				<div class="test_container">
				<form id="assessForm" method="post">
					<c:forEach items="${topics }" var="topic" varStatus="count">
					<div class="assess_content">
						<h4 style="color:black">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${count.count}、<span style="margin-left:20px;color:black">主题：${topic.topicName}</span><span style="margin-left:20px;color:black">帖子总数：${topic.postNum }</span><span style="margin-left:20px;color:black">创建时间：${topic.createTime }</span>
						<span style="margin-left:20px;"><a href="${pageContext.request.contextPath }/ptsBBS/toSeeMore?topicId=${topic.id}" style="color:gray;text-decoration: none">更多</a></span>
						<a href="${pageContext.request.contextPath }/ptsBBS/toAddPost?topicId=${topic.id}" style="float: right;text-decoration: none"><span style="margin-right:20px;color:green;">创建帖子</span></a>
						</h4>
							<c:forEach items="${topic.posts }" var="post"
								varStatus="postCount">
								<a href="${pageContext.request.contextPath }/ptsBBS/toViewReply?postId=${post.id}" style="text-decoration: none">
								<p>
									<span style="color: #0a8cd2;" >${postCount.count}、：</span><span style="margin-left:10px;color: coral;">帖子名称：${post.postName }</span><span style="margin-left:10px;color: coral;">回复数量：${post.replyNum }</span><span style="margin-left:10px;color: coral;">作者：${post.username }</span>
									<br />
									<span style="color:black;margin-right:40px;margin-left:20px;">${post.postContent }.....</span>
								</p>
								</a>
							</c:forEach>
					</div>
					</c:forEach>
					<br />
					<div style="text-align: center;">
						<input type="hidden" value="${pageSize }" id="pageSize"/>
						<input type="hidden" value="${total }" id="total" />
						<input type="hidden" value="${currPage }" id="currPage" />
						<input type="hidden" value="${pageCount }" id="pageCount" />
						<input type="hidden" value="${topic.id }" id="topicid" />
						<button id="pre" >上一页</button>&nbsp;&nbsp;当前页：${currPage }&nbsp;&nbsp;总页数：${pageCount }&nbsp;&nbsp;<button id="next">下一页</button>&nbsp;&nbsp;<input type="text" value="" name="currPage" id="currPageInput" style="width:30px;" />&nbsp;&nbsp;<button id="go">go</button>
					</div>
					
				</form>
				</div>
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
			$(".content ul li:eq(4)").attr("class","current");
			$(".assess_content:even").css("background-color","#fbfbfb");
			$(".assess_content:odd").css("background-color","#fbfaee");
			
			
			
			var pageSize=$("#pageSize").val();
			var total=$("#total").val();
			var currPage=$("#currPage").val();
			var pageCount=$("#pageCount").val();
			var topicId=$("#topicid").val();
			if(currPage==1)
			{
				$("#pre").attr("disabled","disabled");
			}
			if(currPage==pageCount){
				$("#next").attr("disabled","disabled");
			}
			
			$("#next").click(function(){
				currPage=++currPage;
				window.location.href="${pageContext.request.contextPath }/ptsBBS/toMain?topicId="+topicId+"&page="+currPage;
			})
			$("#pre").click(function(){
				currPage=--currPage;
				window.location.href="${pageContext.request.contextPath }/ptsBBS/toMain?topicId="+topicId+"&page="+currPage;
			})
			$("#go").click(function(){
				var re = /^[0-9]+.?[0-9]*$/;
				if(!re.test($("#currPageInput").val()))
				{
					alert("请输入数字！");
					return;
				}
				currPage=$("#currPageInput").val();
				window.location.href="${pageContext.request.contextPath }/ptsBBS/toMain?topicId="+topicId+"&page="+currPage;
			})
			
		});
	</script>

</body>
</html>
