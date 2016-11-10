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
						<td class="layouttable_td_label">随访状态:</td>
						<td class="layouttable_td_widget">
							<select name="followStatus">
								<option value="">全部</option>
								<option value="1" selected="selected">未随访</option>
								<option value="2">已随访</option>
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
			<div id="win" iconCls="icon-save" title="新增随访结果">
			<br />
			<form  id="addFollowResult" method="post">	
				<fieldset class="fieldsetdefault">
					<legend>随访结果</legend>
					<table class="layouttable" id="input_info">
						<tr>
							<td class="layouttable_td_label">随访时间:</td>
							<td class="layouttable_td_widget">
								<input name="followedDate" id="followedDate" class="input_text" />
							</td> 
							
						</tr> 
						<tr>
							<td class="layouttable_td_label">随访结果:</td>
							<td > 
								 <textarea rows="3" cols="100" name="result"></textarea> 
							</td> 
						</tr> 
					</table>   
				</fieldset>
				<br/>
					<input type="hidden" value="" id="followId" name="id" />
					
					<div align="center">
						<input type="button"  value=" 提 交 " id="btnSubmit" /> 
						<input type="reset"  value=" 重 置 " id="btnReset" /> 
					</div>
				</form>
			</div>
		</div>
	
			<!-- 新增加或修改 -->
	
</body>
</html>
<script type="text/javascript">
	var main = {
		init: function(){
			 main.query(true);
			 $("#search").bind("click",function(){main.query(false)}); 
			 $("#btnSubmit").bind("click",main.submit);
		}, 
		
	    
	    query: function(isFirst){
	    	if(!isFirst){
				$('#tableList').datagrid('loadData',{total:0,rows:[]});
			}
	    	
			$('#tableList').html("");
			var wd = $("#paginateForm").width()-70; 
			var data = encodeURI($("#paginateForm").serialize());
			var send_url = "${pageContext.request.contextPath}/patients/qryFollowsList?"+data;
			var col_size = 8;
			var tb = null;
			
			$('#tableList').datagrid({
			        title:'随访时间查询',
			        width:wd,
			        url:send_url,		   
			        columns:[[ 
							  {field:'username',title:'患者用户名',align:'center',width:"100"},
		                      {field:'realname',title:'患者真实姓名',align:'center',width:"100"},
		                      {field:'mobilePhone',title:'患者联系方式',align:'center',width:"100"},
		                      {field:'levHosDate',title:'出院日期',align:'center',width:"110"},
		                      {field:'followDate',title:'访问时间',align:'center',width:"105"},
		                      {field:'followedDate',title:'真实访问时间',align:'center',width:"105"},
		                      {field:'followStatus',title:'访问状态',align:'center',width:"105",
		                    	  formatter:function(value){  
		                      		if(value == 1){
		                      			return '未访问';
		                      		}else if(value==2){
		                      			return '已访问';
		                      		}
		                      	}},
		                      {field:'result',title:'访问结果',align:'center',width:"300"}
			        ]],
			        pagination:true,
			        rownumbers:true, 
			        singleSelect:true,
			        toolbar:[
						       {
							            text:'标记随访时间',
							            align:'right',
							            iconCls:'icon-add',
							            handler:function(){
							            	var row = $('#tableList').datagrid('getSelected');
							            	if(row == null){ 
							            		$.messager.alert('提示','请选择一行，然后再执行此操作！','error');
							            	}else{
							            		main.flagFollowed(row.followId);
							            	}
							                
							            }
							     }
				       ]
			    }); 
	    },
	 
	    openAddWin: function(pred){   
		    $('#win').window({
	    	    width:900,
	    	    height:550,
	    	    modal:true
	    	 }); 
	    },
	    flagFollowed: function(id)
	    {
	    	$("#followId").val(id);
	    	 main.openAddWin("");
	    },
	    submit:function(){
	    	$("#addFollowResult").submit();
		    		
	    },
	    
	}
	    
	
	$(function(){
		main.init();
		$("#addFollowResult").submit(function(){
    		$.ajax({
	    		url:"${pageContext.request.contextPath}/patients/flagFollowed",
	    		type:"POST", 
	    		data:$("#addFollowResult").serialize(),
	    		dataType:"json",
	    		success:function(data){ 
		    		if(data.resultCode=="0"){
		    			window.location.href="${pageContext.request.contextPath}/patients/toFollowMain"
		    		}else{ 
		        		$.messager.alert('提示',data.note,'error');
		    		}
	    		}
	    	});
    		return false;
    	});
	})
	
	
</script>