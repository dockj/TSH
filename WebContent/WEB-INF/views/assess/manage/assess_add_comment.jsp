<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
</head>
<body>

	<fieldset style="margin-top: 20px" class="fieldsetdefault">
		<legend>
			<b>患者基本信息</b>
		</legend>
		<table  class="layouttable">
			<tr>
				<td class="layouttable_td_label">患者用户名:</td>
				<td class="layouttable_td_widget">${patient.username }</td>
				<td class="layouttable_td_label">患者真实姓名:</td>
				<td class="layouttable_td_widget">${patient.realname }</td>
				
			</tr>
			<tr>
				<td class="layouttable_td_label">患者性别:</td>
				<td class="layouttable_td_widget">${patient.sex eq '1' ? '男':'女' }</td>
				<td class="layouttable_td_label">患者年龄:</td>
				<td class="layouttable_td_widget">${patient.age }</td>
			</tr>
			<tr>
				<td class="layouttable_td_label">患者证件号码:</td>
				<td class="layouttable_td_widget">${patient.certiCode }</td>
				<td class="layouttable_td_label">患者联系方式:</td>
				<td class="layouttable_td_widget">${patient.mobilePhone }</td>
					
			</tr>
			<tr>
				<td class="layouttable_td_label">患者家庭住址:</td>
				<td class="layouttable_td_widget">${patient.address }</td>
				<td class="layouttable_td_label">患者出院日期:</td>
				<td class="layouttable_td_widget">${patient.levHosDate }</td>
			</tr>
		</table>
	</fieldset>
	
		<fieldset style="margin-top: 20px" class="fieldsetdefault">
		<legend>
			<b>评测结果</b>
		</legend>
		<table  class="layouttable">
			<tr>
				<td class="layouttable_td_label">评测日期:</td>
				<td class="layouttable_td_widget">${result.strEvaDate }</td>
				<td class="layouttable_td_label">总分:</td>
				<td class="layouttable_td_widget">${result.totalScore }</td>
				
			</tr>
			<tr>
				<td class="layouttable_td_label">评测项目数量:</td>
				<td class="layouttable_td_widget">${result.totalItem }</td>
				<td class="layouttable_td_label">评测平均分:</td>
				<td class="layouttable_td_widget">${result.avgScore }</td>
			</tr>
		</table>
	</fieldset>
	
	<fieldset style="margin-top: 20px" class="fieldsetdefault">
		<legend>
			<b>评测类型结果</b>
		</legend>
		<table  class="layouttable">
			<c:forEach items="${types }" var="type">
				<tr>
					<td class="layouttable_td_label">题目类型:</td>
					<td class="layouttable_td_widget">${type.type }</td>
					<td class="layouttable_td_label">类型数量:</td>
					<td class="layouttable_td_widget">${type.sumType }</td>
				</tr>
				<tr>
					<td class="layouttable_td_label">类型总分:</td>
					<td class="layouttable_td_widget">${type.sumTypeScore }</td>
					<td class="layouttable_td_label">类型平均分:</td>
					<td class="layouttable_td_widget">${type.avgTypeScore }</td>
				</tr>
			</c:forEach>
		</table>
	</fieldset>
	<form id="addCommentForm">
		<fieldset style="margin-top: 20px" class="fieldsetdefault">
			<legend>
				<b>添加评测结果</b>
			</legend>
			
				<table  class="layouttable" id="followTable">
					<tr>
						<td class="layouttable_td_label">评测结果:</td>
						<td class="layouttable_td_widget">
							<textarea rows="5" cols="200" name="result" id="resultTextArea" >${result.result }</textarea>
						</td>
					</tr>
				</table>
				<input type="hidden" value="${result.id }" name="id" />
		</fieldset>
		<br />
		<div align="center">
			<input type="submit" value=" 提 交 " id="btnSubmit" /> <input
				type="submit" value="修 改" id="btnEdit" style="display: none" /> <input
				type="reset" value=" 重 置 " id="btnReset" />
				<input type="button" value="返回" onclick="history.go(-1)" />
		</div>
	</form>
</body>
</html>
<script type="text/javascript">
	var main = {
		init : function() {
		},
	}

	$(function() {
		$("#addCommentForm").submit(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/assess/addComment",
				type : "POST",
				data : $("#addCommentForm").serialize(),
				dataType : "json",
				success : function(data) {
					if (data.resultCode == "0") {
						window.location.href="${pageContext.request.contextPath }/assess/toAssessResult"
					} else {
						$.messager.alert('提示', data.note, 'error');
					}
				}
			});
			return false;
		});
		if("${operation}"=="2")
		{
			$("#btnSubmit").attr("style","display:none");
			$("#btnEdit").removeAttr("style");
		}
		if("${operation=3}")
		{
			$("#btnSubmit").attr("style","display:none");
			$("#btnReset").attr("style","display:none");
			$("#resultTextArea").attr("readonly","readonly");
		}
		main.init();
	})
</script>