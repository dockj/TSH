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
			<b>历史随访时间</b>
		</legend>
		<table  class="layouttable">
			<c:forEach items="${follows }" var="follow">
				<tr>
					<td class="layouttable_td_label">随访时间:</td>
					<td class="layouttable_td_widget">${follow.followDate }</td>
					<td class="layouttable_td_label">是否随访:</td>
					<td class="layouttable_td_widget">${follow.status eq "1" ? '否':'是' }</td>
					<c:if test="${follow.status eq '2'}">
						<td class="layouttable_td_label">真实随访时间:</td>
						<td class="layouttable_td_widget">${follow.followedDate }</td>
					</c:if>
				</tr>
				<c:if test="${follow.status eq '2'}">
				<tr>
					<td class="layouttable_td_label">随访结果:</td>
					<td class="layouttable_td_widget">${follow.result }</td>
				</tr>
				</c:if>
			</c:forEach>
		</table>
	</fieldset>
	<form id="addFollowFrom">
		<fieldset style="margin-top: 20px" class="fieldsetdefault">
			<legend>
				<b>添加随访时间</b>
			</legend>
			
				<table  class="layouttable" id="followTable">
					<tr>
						<td class="layouttable_td_label">随访时间:</td>
						<td class="layouttable_td_widget">
							<input type="text" value=""  name="followDate" />
							<input type="button" name="delBtn" value="删除" onclick="delRow(this)" style="display:none"/>
						</td>
					</tr>
				</table>
				<input type="hidden" value="${patient.id }" name="userId" />
			
			 <div align="center"><input type="button" value="添 加" id="addFollow"/></div>
		</fieldset>
		
		
		<br />
		<input type="hidden" value="" id="assessId" name="id" />
		<div align="center">
			<input type="submit" value=" 提 交 " id="btnSubmit" /> <input
				type="button" value="修 改" id="btnEdit" style="display: none" /> <input
				type="reset" value=" 重 置 " id="btnReset" />
		</div>
	</form>





	<script type="text/javascript"
		src="<%=request.getContextPath()%>/scripts/ddic.min.js"></script>
</body>
</html>
<script type="text/javascript">
	var main = {
		init : function() {
			$("#addFollow").bind("click", main.addFollow);
		},
		
		addFollow : function() {
			$("#followTable > tbody").append($("#followTable > tbody > tr:first").clone(true));
			$("#followTable input[name='delBtn']").removeAttr("style");
			$("#followTable > tbody > tr:eq(0) > td:eq(1) > input[name='delBtn']").attr("style", "display:none");
		}
	}

	$(function() {
		$("#addFollowFrom").submit(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/patients/addFollows",
				type : "POST",
				data : $("#addFollowFrom").serialize(),
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
		main.init();
	})

	function delRow(obj) {
		var input = $(obj);
		var thisTr = input.parent().parent();
		thisTr.remove();
	}
</script>