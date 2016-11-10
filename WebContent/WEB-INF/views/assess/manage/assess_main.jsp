<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
<script type="text/javascript" src="../CacheableResource/ckeditor/ckeditor.js"></script>
</head>
<body>
	<form id="paginateForm"> 
		<div class="layout_div" >
			<div class="navigation_div">
				<span class="font_heading1">甲亢管理>>甲亢自评表管理</span>
			</div>
			<fieldset class="fieldsetdefault">
				<legend>查询</legend>
				<table class="layouttable" id="input_info">
					<tr>
						<td class="layouttable_td_label">题目编码:</td>
						<td class="layouttable_td_widget">
							<input name="assCode" id="qryAssCode" class="input_text" />
						</td>  
						<td class="layouttable_td_label">题目名称:</td>
						<td class="layouttable_td_widget">   
							<input name="title" id="qryTitle" class="input_text" />
						</td> 
					</tr>  
					<tr>
						<td class="layouttable_td_label">类型:</td>
						<td class="layouttable_td_widget">
							<select id="qryTypeCode" name="typeCode">  
								<option value="">全部</option>
								<c:forEach items="${dicts}" var="item">
									<option value="${item.dataKey}">${item.dataValue}</option>
								</c:forEach>
							</select>
						</td> 
						<td class="layouttable_td_label">状态:</td>
						<td class="layouttable_td_widget">
							<select name="status">
								<option value="">全部</option>
								<option value="0">保存</option>
								<option value="1">发布</option>
								<option value="2">禁用</option>
							</select>
						</td>  
					</tr> 
					<tr>
						<td align="right" colspan="4">
							<a class="easyui-linkbutton" iconCls="icon-search" id="search">查询</a> 
							<a class="easyui-linkbutton" onclick="javascript:$('#paginateForm')[0].reset();" iconCls="icon-cancel" id="reset">重置</a>
						</td>
					</tr>
				</table>   
			</fieldset>
			<div class="layout_div_top_spance" title="双击编辑">
				<table id="tableList" width="1130"  title="双击编辑"></table>
			</div>
		</div> 
		</form>
		
			<!-- 新增加或修改 -->
		<div style="display: none">
			<div id="win" iconCls="icon-save" title="新增或修改">
				 <form  id="frmAdd" method="post">	
					<fieldset style="width:850px">
					    <legend><b>患者基本信息</b></legend>
						<table width="850px">
							<tr>
								<td>题目编码:</td>
								<td><input type="text" name="assCode" id="assCode" maxlength='6'/></td>
								<td>题目类型:</td>
								<td>
									<select id="typeCode" name="typeCode">  
										<c:forEach items="${dicts}" var="item">
											<option value="${item.dataKey}">${item.dataValue}</option>
										</c:forEach>
									</select>
								</td>
								<td>状态:</td>
								<td>
									<select id="status" name="status">  
										<option value="0">保存</option>
										<option value="1">发布</option>
										<option value="2">禁用</option>
									</select>
								</td>
							</tr>
							<tr >
								<td>标题:</td>
					    		<td colspan="5"><input type="text" name="title" id="title" size="120" maxlength='200'/></td>
							</tr>
							<tr>
								<td>备注:</td>
								<td colspan="5"><input type="text" name="remark" id="remark" size="120" maxlength='200'/></td>
							</tr>
							
						</table>
					</fieldset> 
					<br />
					<fieldset style="width:850px">
					    <legend><b>选项说明：</b></legend>
					    <table width="850" id="scoreTable">
					    	<tr height="30">
								<td>选项:</td>
								<td><input type="text" name="option"  size="120" maxlength='200' value=""/></td>
							</tr>
							<tr>
								<td>分数:</td>
								<td><input type="text" name="score"  size="6" maxlength='2' value=""/><input type="hidden" value=""  name="ids" />
									<input type="button" name="delBtn" value="删除" onclick="delRow(this)" style="display:none"/>
								</td>
							</tr>
					    </table>
					    <div align="center"><input type="button" value="添 加" id="addScore"/></div>
					</fieldset>
					<br/>
					<input type="hidden" value="" id="assessId" name="id" />
					<div align="center">
						<input type="button"  value=" 提 交 " id="btnSubmit" /> 
						<input type="button" value="修 改" id="btnEdit" style="display:none"/>
						<input type="reset"  value=" 重 置 " id="btnReset" /> 
					</div>
				</form>
			</div>
		</div>
	
		<!-- 新增加或修改 -->
			
	

	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ddic.min.js"></script>
</body>
</html>
<script type="text/javascript">
	var timeId = "" ;
	var count = 0;
	var main = {
		init: function(){
			 main.query(true);
			 $("#btnSubmit").bind("click",main.submit);
			 $("#search").bind("click",function(){main.query(false)}); 
			 $("#addScore").bind("click",main.addScore);
			 $("#btnEdit").bind("click",main.submitEdit);
		}, 
		
	    
	    query: function(isFirst){
	    	if(!isFirst){
				$('#tableList').datagrid('loadData',{total:0,rows:[]});
			}
	    	
			$('#tableList').html("");
			var wd = $("#paginateForm").width()-70; 
			var data = encodeURI($("#paginateForm").serialize());
			var send_url = "${pageContext.request.contextPath}/assess/qryAssessList?"+data;
			var col_size = 8;
			var tb = null;
			
			$('#tableList').datagrid({
			        title:'甲亢自评查询',
			        width:wd,
			        url:send_url,		   
			        columns:[[ 
							  {field:'assCode',title:'标题编码',align:'center',width:"100"},
		                      {field:'title',title:'标题',align:'center',width:"620"},
		                      {field:'type',title:'类型',align:'center',width:"100"},
		                      {field:'flushDate',title:'更新时间',align:'center',width:"110"},
		                      {field:'status',title:'状态',align:'center',width:"105",
		                    	  formatter:function(value){  
		                      		if(value == 0){
		                      			return '保存';
		                      		}else if(value==1){
		                      			return '发布';
		                      		}else if(value==2){
		                      			return '禁用';
		                      		}
		                      	}}
			        ]],
			        pagination:true,
			        rownumbers:true, 
			        singleSelect:true,
			        toolbar:[
						       {
							            text:' 新 增 ',
							            align:'right',
							            iconCls:'icon-add',
							            handler:function(){
							                main.add();
							            }
							     },
						        {
						            text:' 删 除 ',
						            align:'right',
						            iconCls:'icon-remove',
						            handler:function(){
						            	var row = $('#tableList').datagrid('getSelected');
						            	if(row == null){ 
						            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
						            	}else{
						            		$.messager.confirm('确认', '您确定要删除吗？', function(r){
						        				if (r){
									                main.remove(row.id);
						        				}
						        			});
						            	}
						            }
						         },
						         {
							            text:' 修 改 ',
							            align:'right',
							            iconCls:'icon-edit',
							            handler:function(){
							            	var row = $('#tableList').datagrid('getSelected');
							            	if(row == null){ 
							            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
							            	}else{
										         main.edit(row.id);
							            	}
							            }
							         }
				       ],
					onDblClickRow:function(rowIndex,rowData){
						alert("dockj");
					}
			    }); 
	    },
		
		add:function()
		{
		    main.resetAddWin(); 
		    main.openAddWin("");
		},
	    resetAddWin: function(){
	    	$("#scoreTable > tbody > tr:gt(1)").remove();
			$("#btnSubmit").removeAttr("style");
			$("#btnEdit").attr("style","display:none");
			$("#addScore").removeAttr("style");
	    	$('#btnReset').click();
	    },
	    openAddWin: function(pred){   
		    $('#win').window({
	    	    width:900,
	    	    height:550,
	    	    modal:true
	    	 }); 
	    },
	    submit:function(){
	    	$.ajax({
	    		url:"${pageContext.request.contextPath}/assess/addAssess",
	    		type:"POST", 
	    		data:$("#frmAdd").serialize(),
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			main.query(false);
		    			//main.resetAddWin();
		    	    	$('#win').window('close');
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
	    },
	    remove :function(id)
	    {
	    	$.ajax({
	    		url:"${pageContext.request.contextPath}/assess/delAssess",
	    		type:"POST", 
	    		data:{id:id},
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			main.query(false);
		    			//main.resetAddWin();
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
	    },
	    edit:function(id)
	    {
	    	$.ajax({
	    		url:"${pageContext.request.contextPath}/assess/qryAssess",
	    		type:"POST", 
	    		data:{id:id},
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			main.openAddWin("");
		    			$("#scoreTable > tbody > tr:gt(1)").remove();
		    			$("#assCode").val(data.assess.assCode);
		    			$("#typeCode").val(data.assess.typeCode);
		    			$("#status").val(data.assess.status);
		    			$("#title").val(data.assess.title);
		    			$("#remark").val(data.assess.remark);
		    			$("#assessId").val(data.assess.id);
		    			for(var i=0;i<data.scores.length;i++)
		    			{
		    				if(i==1)
		    				{
		    					$("#scoreTable input:first").val(data.scores[i].option);
		    					$("#scoreTable input:eq(1)").val(data.scores[i].score);
		    					$("#scoreTable input:eq(2)").val(data.scores[i].id);
		    				}
		    				else
		    				{
		    					var option=$("<tr height='30'><td>选项:</td><td><input type='text' name='option'  size='120' maxlength='200' value='"+data.scores[i].option+"'/></td></tr>")
		    					var score=$("<tr><td>分数:</td><td><input type='text' name='score'  size='6' maxlength='2' value='"+data.scores[i].score+"'/><input type='hidden' name='ids' value='"+data.scores[i].id+"' /></td></tr>")
		    					
		    					$("#scoreTable > tbody").append(option);
			    				$("#scoreTable > tbody").append(score);
			    				
		    				}
		    				
		    			}
		    			$("#btnSubmit").attr("style","display:none");
		    			$("#btnEdit").removeAttr("style");
		    			$("#addScore").attr("style","display:none");
		    			//main.query(false);
		    			//main.resetAddWin();
		    	    	//$('#win').window('close');
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
	    },
	    submitEdit:function(){
	    	$.ajax({
	    		url:"${pageContext.request.contextPath}/assess/editAssess",
	    		type:"POST", 
	    		data:$("#frmAdd").serialize(),
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			main.query(false);
		    			//main.resetAddWin();
		    	    	$('#win').window('close');
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
	    },
	    addScore:function()
	    {
	    	$("#scoreTable > tbody").append($("#scoreTable > tbody > tr:first,#scoreTable > tbody > tr:eq(1)").clone(true));
	    	$("#scoreTable input[name='delBtn']").removeAttr("style");
	    	$("#scoreTable > tbody > tr:eq(1) > td:eq(1) > input[name='delBtn']").attr("style","display:none");
	    }
	    
	    
	}
	
	
	$(function(){
		main.init();
	})
	
	
	function delRow(obj)
	{
		var input=$(obj);
		var thisTr=input.parent().parent();
		var prevTr=thisTr.prev();
		thisTr.remove();
		prevTr.remove();
	}
</script>