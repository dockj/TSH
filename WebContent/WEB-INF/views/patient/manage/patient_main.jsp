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
				<span class="font_heading1">甲亢管理>>患者管理</span>
			</div>
			<fieldset class="fieldsetdefault">
				<legend>查询</legend>
				<table class="layouttable" id="input_info">
					<tr>
						<td class="layouttable_td_label">患者用户名:</td>
						<td class="layouttable_td_widget">
							<input name="username" id="username" class="input_text" />
						</td>  
						<td class="layouttable_td_label">患者手机号:</td>
						<td class="layouttable_td_widget">   
							<input name="mobilePhone" id="mobilePhone" class="input_text" />
						</td> 
						<td class="layouttable_td_label">患者真实姓名:</td>
						<td class="layouttable_td_widget">   
							<input name="realname" id="realname" class="input_text" />
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
			var send_url = "${pageContext.request.contextPath}/patients/qryPatientsList?"+data;
			var col_size = 8;
			var tb = null;
			
			$('#tableList').datagrid({
			        title:'患者查询',
			        width:wd,
			        url:send_url,		   
			        columns:[[ 
							  {field:'username',title:'患者用户名',align:'center',width:"100"},
		                      {field:'realname',title:'患者真实姓名',align:'center',width:"100"},
		                      {field:'mobilePhone',title:'患者联系方式',align:'center',width:"100"},
		                      {field:'email',title:'电子邮箱',align:'center',width:"130"},
		                      {field:'address',title:'家庭住址',align:'center',width:"390"},
		                      {field:'levHosDate',title:'出院日期',align:'center',width:"110"},
		                      {field:'newestfollowDate',title:'最近访问时间',align:'center',width:"105"}
			        ]],
			        pagination:true,
			        rownumbers:true, 
			        singleSelect:true,
			        toolbar:[
						       {
							            text:'查询自评结果',
							            align:'right',
							            iconCls:'icon-add',
							            handler:function(){
							                main.view();
							            }
							     },
						        {
						            text:' 新增随访时间 ',
						            align:'right',
						            iconCls:'icon-remove',
						            handler:function(){
						            	var row = $('#tableList').datagrid('getSelected');
						            	if(row == null){ 
						            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
						            	}else{
									         main.addFollow(row.id);
						            	}
						            }
						         },
						         {
							            text:' 修改随访时间 ',
							            align:'right',
							            iconCls:'icon-remove',
							            handler:function(){
							            	var row = $('#tableList').datagrid('getSelected');
							            	if(row == null){ 
							            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
							            	}else{
										         main.editFollow(row.id);
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
		
	    view:function()
		{
	    	var row = $('#tableList').datagrid('getSelected');
        	if(row == null){ 
        		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
        	}else{
		         main.viewAssessResult(row.id);
        	}
		},
		viewAssessResult:function(id)
		{
			window.location.href="${pageContext.request.contextPath}/patients/qryAssessResult?id="+id;	
		},
		addFollow:function(id)
		{
			window.location.href="${pageContext.request.contextPath}/patients/toAddFollow?id="+id;
		},
		editFollow: function(id){
			window.location.href="${pageContext.request.contextPath}/patients/toEditFollow?id="+id;
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