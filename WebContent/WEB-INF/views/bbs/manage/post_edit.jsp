<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
</head>
<body>

	<fieldset style="margin-top: 20px" class="fieldsetdefault">
		<legend>
			<b>话题基本信息</b>
		</legend>
		<table  class="layouttable">
			<tr>
				<td class="layouttable_td_label">话题名称:</td>
				<td class="layouttable_td_widget">${topic.topicName }</td>
				<td class="layouttable_td_label">话题状态:</td>
				<td class="layouttable_td_widget">${topic.status eq "1" ? "暂存" : topic.status eq "2" ? "发布" : "禁用" }</td>
				
			</tr>
			<tr>
				<td class="layouttable_td_label">发布帖子数量:</td>
				<td class="layouttable_td_widget">${topic.postNum }</td>
				<td class="layouttable_td_label">暂存帖子数量:</td>
				<td class="layouttable_td_widget">${topic.savePostNum }</td>
				<td class="layouttable_td_label">禁用帖子数量:</td>
				<td class="layouttable_td_widget">${topic.unUsePostNum }</td>
			</tr>
		</table>
	</fieldset>
	<form id="addPostFrom">
		<fieldset style="margin-top: 20px" class="fieldsetdefault">
			<legend>
				<b>修改帖子</b>
			</legend>
			
				<table  class="layouttable" id="followTable">
					<tr>
						<td class="layouttable_td_label">帖子标题:</td>
						<td class="layouttable_td_widget">
							<input type="text" value="${post.postName }"  name="postName" />
						</td>
					</tr>
					<tr>
						<td class="layouttable_td_label">帖子状态:</td>
						<td class="layouttable_td_widget">
							<select name="status">
								<option value="1" ${post.status eq '1' ? 'selected=selected':'' }>暂存</option>
								<option value="2" ${post.status eq '2' ? 'selected=selected':'' }>发布</option>
								<option value="3" ${post.status eq '3' ? 'selected=selected':'' }>禁用</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="layouttable_td_label">帖子内容:</td>
						<td class="layouttable_td_widget">
							<textarea rows="20" cols="150" name="postContent">${post.postContent }</textarea>
						</td>
					</tr>
				</table>
				<input type="hidden" value="${post.id }" name="id" />
		</fieldset>
		
		
		<br />
		<input type="hidden" value="" id="assessId" name="id" />
		<div align="center">
			<input type="submit" value=" 修 改 " id="btnEdit" /> 
			<input type="reset" value=" 重 置 " id="btnReset" />
		</div>
	</form>

</body>
</html>
<script type="text/javascript">

	$(function() {
		$("#addPostFrom").submit(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/bbs/editPost",
				type : "POST",
				data : $("#addPostFrom").serialize(),
				dataType : "json",
				success : function(data) {
					if (data.resultCode == "0") {
						window.location.href="${pageContext.request.contextPath}/bbs/toPostMain"
					} else {
						$.messager.alert('提示', data.note, 'error');
					}
				}
			});
			return false;
		});
		main.init();
	})
</script>