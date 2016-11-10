<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/WEB-INF/views/commons/head.jsp"%>
<script type="text/javascript" src="../CacheableResource/ckeditor/ckeditor.js"></script>
<style type="text/css">
.datagrid-body{height: auto !important;}
</style>
</head>
<body>
	<form id="paginateForm"> 
		<div class="layout_div" >
			<div class="navigation_div">
				<span class="font_heading1">甲亢管理>>医患交流</span>
			</div>
			<fieldset class="fieldsetdefault">
				<legend>查询</legend>
				<table class="layouttable" id="input_info">
					<tr>
						<td class="layouttable_td_label">话题名称:</td>
						<td class="layouttable_td_widget">
							<input name="topicName" id="topicName" class="input_text" />
						</td>
						<td class="layouttable_td_label">话题状态:</td>
						<td class="layouttable_td_widget">
							<select name="status">
								<option value="">全部</option>
								<option value="1">暂存</option>
								<option value="2">发布</option>
								<option value="3">禁用</option>
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
			<div id="win" iconCls="icon-save" title="新增话题">
			<br />
			<form  id="addTopic" method="post">	
				<fieldset class="fieldsetdefault">
					<legend>新增话题</legend>
					<table class="layouttable" id="input_info">
						<tr>
							<td class="layouttable_td_label">主题名称:</td>
							<td class="layouttable_td_widget">
								<input name="topicName" id="topicNameEdit" class="input_text" />
							</td> 
							
						</tr> 
						<tr>
							<td class="layouttable_td_label">主题状态:</td>
							<td > 
								<select name="status" id="statusEdit">
									<option value="1">暂存</option>
									<option value="2">发布</option>
									<option value="3">禁用</option>
								</select>
							</td> 
						</tr> 
					</table>   
				</fieldset>
				<br/>
					<input type="hidden" value="" id="topicId" name="id" />
					
					<div align="center">
						<input type="button"  value=" 提 交 " id="btnSubmit" /> 
						<input type="button" value="修改" id="btnEdit" style="display:none"/>
						<input type="reset"  value=" 重 置 " id="btnReset" /> 
					</div>
				</form>
			</div>
		</div>
	
			<!-- 新增加或修改 -->
			
	

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
			 $("#btnEdit").bind("click",main.submitEdit);
		}, 
		
	    
	    query: function(isFirst){
	    	if(!isFirst){
				$('#tableList').datagrid('loadData',{total:0,rows:[]});
			}
	    	
			$('#tableList').html("");
			var wd = $("#paginateForm").width()-70; 
			var data = encodeURI($("#paginateForm").serialize());
			var send_url = "${pageContext.request.contextPath}/bbs/qryTopicList?"+data;
			var col_size = 8;
			var tb = null;
			
			$('#tableList').datagrid({
			        title:'主题管理查询',
			        width:wd,
			        url:send_url,		   
			        columns:[[ 
							  {field:'topicName',title:'话题名称',align:'center',width:"300"},
		                      {field:'postNum',title:'发布帖子数量',align:'center',width:"80"},
		                      {field:'savePostNum',title:'暂存帖子数量',align:'center',width:"80"},
		                      {field:'unUsePostNum',title:'禁用帖子数量',align:'center',width:"80"},
		                      {field:'createTime',title:'创建时间',align:'center',width:"200"},
		                      {field:'updateTime',title:'更新时间',align:'center',width:"200"},
		                      {field:'status',title:'状态',align:'center',width:"100",formatter:function(value){  
		                      		if(value == 1){
		                      			return '暂存';
		                      		}else if(value==2){
		                      			return '发布';
		                      		}else if(value==3){
		                      			return '禁用';
		                      		}
		                      	}},
			        ]],
			        pagination:true,
			        rownumbers:true, 
			        singleSelect:true,
			        toolbar:[
						       {
							            text:'新增话题',
							            align:'right',
							            iconCls:'icon-add',
							            handler:function(){
							                main.addTopic();
							            }
							     },
						         {
							            text:' 修改话题 ',
							            align:'right',
							            iconCls:'icon-edit',
							            handler:function(){
							            	var row = $('#tableList').datagrid('getSelected');
							            	if(row == null){ 
							            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
							            	}else{
										         main.toEditTopic(row.id);
							            	}
							            }
							         },
							         {
								            text:' 新增帖子 ',
								            align:'right',
								            iconCls:'icon-edit',
								            handler:function(){
								            	var row = $('#tableList').datagrid('getSelected');
								            	if(row == null){ 
								            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
								            	}else{
											         main.toAddPost(row.id);
								            	}
								            }
								         }
				       ],
					onDblClickRow:function(rowIndex,rowData){
						alert("dockj");
					}
			    }); 
	    },
		
	    addTopic:function(){
	    	main.openAddWin("");
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
	    		url:"${pageContext.request.contextPath}/bbs/addTopic",
	    		type:"POST", 
	    		data:$("#addTopic").serialize(),
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			main.query(false);
		    	    	$('#win').window('close');
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
	    },
	    toEditTopic:function(id)
	    {
	    	$.ajax({
	    		url:"${pageContext.request.contextPath}/bbs/qryTopic",
	    		type:"POST", 
	    		data:{id:id},
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			main.openAddWin("");
		    			$("#topicNameEdit").val(data.topic.topicName);
		    			$("#statusEdit").val(data.topic.status);
		    			$("#topicId").val(data.topic.id);
		    			$("#btnSubmit").attr("style","display:none");
		    			$("#btnEdit").removeAttr("style");
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
	    },
	    submitEdit:function(){
	    	$.ajax({
	    		url:"${pageContext.request.contextPath}/bbs/editTopic",
	    		type:"POST", 
	    		data:$("#addTopic").serialize(),
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			main.query(false);
		    	    	$('#win').window('close');
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
	    },
	    toAddPost:function(id)
	    {
	    	window.location.href="${pageContext.request.contextPath}/bbs/toAddPost?topicId="+id;
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