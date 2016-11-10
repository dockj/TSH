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
			<b>已随访时间</b>
		</legend>
		<table  class="layouttable">
			<c:forEach items="${followeds }" var="followed">
				<tr>
					<td class="layouttable_td_label">随访时间:</td>
					<td class="layouttable_td_widget">${followed.followDate }</td>
					<td class="layouttable_td_label">是否随访:</td>
					<td class="layouttable_td_widget">${followed.status eq "1" ? '否':'是' }</td>
					<td class="layouttable_td_label">真实随访时间:</td>
					<td class="layouttable_td_widget">${followed.followedDate }</td>
				</tr>
				<tr>
					<td class="layouttable_td_label">随访结果:</td>
					<td class="layouttable_td_widget">${followed.result }</td>
				</tr>
			</c:forEach>
		</table>
	</fieldset>
	<form id="editFollowForm">
		<fieldset style="margin-top: 20px" class="fieldsetdefault">
			<legend>
				<b>修改随访时间</b>
			</legend>
				<table  class="layouttable" id="followTable">
					<c:forEach items="${follows }" var="follow">
						<tr>
							<td class="layouttable_td_label">随访时间:</td>
							<td class="layouttable_td_widget">
								<input type="text" value="${follow.followDate }"  name="followDate" />
								<input type="hidden" value="${follow.id }" name="followId" />
							</td>
						</tr>
					</c:forEach>
				</table>
				<input type="hidden" value="${patient.id }" name="userId" />
		</fieldset>
		
		
		<br />
		<input type="hidden" value="" id="assessId" name="id" />
		<div align="center">
			<input type="submit" value="修 改" id="btnEdit"  /> <input
				type="reset" value=" 重 置 " id="btnReset" />
		</div>
	</form>
</body>
</html>
<script type="text/javascript">
	$(function() {
		$("#editFollowForm").submit(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/patients/editFollows",
				type : "POST",
				data : $("#editFollowForm").serialize(),
				dataType : "json",
				success : function(data) {
					if (data.resultCode == "0") {
						window.location.href="${pageContext.request.contextPath}/patients/toMain"
					} else {
						$.messager.alert('提示', data.note, 'error');
					}
				}
			});
			return false;
		});
	})

</script>