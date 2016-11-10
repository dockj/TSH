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
				<span class="font_heading1">甲亢管理>>甲亢自评结果管理</span>
			</div>
			<fieldset class="fieldsetdefault">
				<legend>查询</legend>
				<table class="layouttable" id="input_info">
					<tr>
						<td class="layouttable_td_label">患者用户名:</td>
						<td class="layouttable_td_widget">
							<input name="username" id="username" class="input_text" />
						</td>  
						<td class="layouttable_td_label">状态:</td>
						<td class="layouttable_td_widget">
							<select name="status">
								<option value="">全部</option>
								<option value="0">未评论</option>
								<option value="1">已评论</option>
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
</body>
</html>
<script type="text/javascript">
	var timeId = "" ;
	var count = 0;
	var main = {
		init: function(){
			 main.query(true);
			 $("#search").bind("click",function(){main.query(false)}); 
		}, 
		
	    
	    query: function(isFirst){
	    	if(!isFirst){
				$('#tableList').datagrid('loadData',{total:0,rows:[]});
			}
	    	
			$('#tableList').html("");
			var wd = $("#paginateForm").width()-70; 
			var data = encodeURI($("#paginateForm").serialize());
			var send_url = "${pageContext.request.contextPath}/assess/qryAssessResultList?"+data;
			var col_size = 8;
			var tb = null;
			
			$('#tableList').datagrid({
			        title:'甲亢自评查询',
			        width:wd,
			        url:send_url,		   
			        columns:[[ 
							  {field:'username',title:'患者用户名',align:'center',width:"200"},
		                      {field:'strEvaDate',title:'评测时间',align:'center',width:"250"},
		                      {field:'totalScore',title:'总分',align:'center',width:"150"},
		                      {field:'totalItem',title:'总项目数',align:'center',width:"150"},
		                      {field:'avgScore',title:'平均分',align:'center',width:"150"},
		                      {field:'status',title:'状态',align:'center',width:"125",
		                    	  formatter:function(value){  
		                      		if(value == 0){
		                      			return '未评论';
		                      		}else if(value==1){
		                      			return '已评论';
		                      		}
		                      	}}
			        ]],
			        pagination:true,
			        rownumbers:true, 
			        singleSelect:true,
			        toolbar:[
						       {
							            text:'评 论',
							            align:'right',
							            iconCls:'icon-add',
							            handler:function(){
							            	var row = $('#tableList').datagrid('getSelected');
							            	if(row == null){ 
							            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
							            	}else if(row.status==1){
							            		$.messager.alert('提示','已评论无法添加评论！','error');
							            	}else
							            	{
							            		window.location.href="${pageContext.request.contextPath}/assess/toAddComment?evaId="+row.id+"&userId="+row.userId+"&operation="+1;
							            	}
							            }
							     },
							     {
							            text:'修改评论',
							            align:'right',
							            iconCls:'icon-edit',
							            handler:function(){
							            	var row = $('#tableList').datagrid('getSelected');
							            	if(row == null){ 
							            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
							            	}else if(row.status==0){
							            		$.messager.alert('提示','未评论无法修改评论！','error');
							            	}else
							            	{
							            		window.location.href="${pageContext.request.contextPath}/assess/toAddComment?evaId="+row.id+"&userId="+row.userId+"&operation="+2;
							            	}
							            }
							     },
							     {
							            text:'查看评论',
							            align:'right',
							            iconCls:'icon-edit',
							            handler:function(){
							            	var row = $('#tableList').datagrid('getSelected');
							            	if(row == null){ 
							            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
							            	}else if(row.status==0){
							            		$.messager.alert('提示','未评论无法修改评论！','error');
							            	}else
							            	{
							            		window.location.href="${pageContext.request.contextPath}/assess/toAddComment?evaId="+row.id+"&userId="+row.userId+"&operation="+3;
							            	}
							            }
							     }
						       
				       ],
					onDblClickRow:function(rowIndex,rowData){
						alert("dockj");
					}
			    }); 
	    }
		
	}
		
	$(function(){
		main.init();
	})
	
	
	
</script>