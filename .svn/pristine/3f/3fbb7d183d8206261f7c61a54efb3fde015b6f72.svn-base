//generate XMLRequest(Public Method)
	function getXMLRequester(){
		var xmlhttp_request = false; 
		try{
			if(window.ActiveXObject)
				{for(var i = 5; i; i-- ){ 
					try{ 
						if(i == 2){
							xmlhttp_request = new ActiveXObject("Microsoft.XMLHTTP");
						}
						else{ 
							xmlhttp_request = new ActiveXObject("Msxml2.XMLHTTP." + i + ".0"); 
							xmlhttp_request.setRequestHeader("Content-Type","text/xml"); 
							xmlhttp_request.setRequestHeader("Content-Type","utf-8"); }
						break;} 
					catch(e){xmlhttp_request = false;}}}
			else if(window.XMLHttpRequest){ 
				xmlhttp_request = new XMLHttpRequest();
				if (xmlhttp_request.overrideMimeType){ 
					xmlhttp_request.overrideMimeType('text/xml'); 
				} 
			} 
		}catch(e){xmlhttp_request = false;} 
		return xmlhttp_request; 
	}			
	
//Generate Form According the Selected Risk 			
	function factorFormCtrl(divid,url,flag){
		url=url+"?temptime="+new Date().getTime();
		var oSel;
		if(flag=="M") {oSel = document.getElementById("masterProductSelect");}
		else {oSel = document.getElementById("subProductWindow");}
		if(oSel.value!=""){
			document.getElementById(divid).innerHTML ="<fieldset style=\"padding-top: 20px;padding-bottom: 5px;\">" +
													  "		<center>数据读取中...</center>" +
													  "</fieldset>";
			var stringquery="ProductCode="+oSel.value+"&Flag="+flag;
			xmlhttp_request=getXMLRequester();
			xmlhttp_request.onreadystatechange = function(){
				if(xmlhttp_request.readyState == 4){
					if(xmlhttp_request.status == 200){ 
						alert(xmlhttp_request.responseText);
						document.getElementById(divid).innerHTML = xmlhttp_request.responseText;} 
					else{alert(xmlhttp_request.status);}
				} 
			};
			xmlhttp_request.open("POST", url, true); 
			xmlhttp_request.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			xmlhttp_request.send(stringquery);
		}else alert("未选取险种，请重新选择");
	} 
	
//Check Form Data
	function checkPrem(divid,url) {
		document.getElementById(divid).innerHTML ="&nbsp;&nbsp;&nbsp;数据读取中...";
		url=url+"?temptime="+new Date().getTime();
		//get form data
		var be = document.getElementById("be").value;
		var ponl,znnl,bznq,jfnq,lqnl,zylb;
		(document.getElementById("ponl")==null)?(ponl=""):(ponl=document.getElementById("ponl").value);
		(document.getElementById("znnl")==null)?(znnl=""):(znnl=document.getElementById("znnl").value);
		(document.getElementById("bznq")==null)?(bznq=""):(bznq=document.getElementById("bznq").value);
		(document.getElementById("jfnq")==null)?(jfnq=""):(jfnq=document.getElementById("jfnq").value);
		(document.getElementById("lqnl")==null)?(lqnl=""):(lqnl=document.getElementById("lqnl").value);
		(document.getElementById("zylb")==null)?(zylb=""):(zylb=document.getElementById("zylb").value);
		//over
		stringquery="be="+be+"&ponl="+ponl+"&znnl="+znnl+"&bznq="+bznq+"&jfnq="+jfnq+"&lqnl="+lqnl+"&zylb="+zylb;
		xmlhttp_request=getXMLRequester();
		xmlhttp_request.onreadystatechange = function(){
			if (xmlhttp_request.readyState == 4) {
				if (xmlhttp_request.status == 200) { 
					document.getElementById(divid).innerHTML = xmlhttp_request.responseText; 
					} 
				else {alert(xmlhttp_request.status);}
			} 
		};
		xmlhttp_request.open("POST", url, true); 
		xmlhttp_request.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		xmlhttp_request.send(stringquery);
	}

//Release Form
	function releaseFactorForm(){
		var oForm = document.getElementById("centerdiv");
		oForm.innerHTML = "<fieldset style=\"padding-top: 20px;padding-bottom: 5px;\">" +
						  "  <center><span style=\"font-size:15;\">请先选择产品</span></center>" +
				  		  "</fieldset>"
	}

//Show Message Using Alert
	function showMessage(str){
		alert(str);
	}
	
//Delete Selected Risk
	function delProduct(){
		url="delprotctrl.jsp?temptime="+new Date().getTime();
		var oSel = document.getElementById("selectedProductSelect");
		if(oSel.value!=""){
			var stringquery="delId="+oSel.value;
			xmlhttp_request=getXMLRequester();
			xmlhttp_request.onreadystatechange = function(){
				if(xmlhttp_request.readyState == 4){
					if(xmlhttp_request.status == 200){ 
						document.getElementById("rightdiv").innerHTML = xmlhttp_request.responseText;} 
					else{alert(xmlhttp_request.status);}
				} 
			};
			xmlhttp_request.open("POST", url, true); 
			xmlhttp_request.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			xmlhttp_request.send(stringquery);
		}else alert("未选取险种，请重新选择");
	}

//Refresh Risk
	function refreshProduct(divid,url){
		document.getElementById(divid).innerHTML ="数据读取中...";
		url=url+"?temptime="+new Date().getTime();
		var stringquery="";
		xmlhttp_request=getXMLRequester();
		xmlhttp_request.onreadystatechange = function(){
			if(xmlhttp_request.readyState == 4){
				if(xmlhttp_request.status == 200){ 
					document.getElementById(divid).innerHTML = xmlhttp_request.responseText;} 
				else{alert(xmlhttp_request.status);}
			} 
		};
		xmlhttp_request.open("POST", url, true); 
		xmlhttp_request.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		xmlhttp_request.send(stringquery);
	}
//Check The Second Page
	function secCheck(){
		var oSel = document.getElementById("rightSelect");
		if(oSel.length==0){
			alert("尚未选择保险");
			return false;
		}
		return true;
	}
	
//Conform
	function confirmGo(){
		var sexInput = document.getElementById("bbAge");
		if (sexInput.value!=""){
			var isBack = confirm("您的操作将清空已选的险种信息？");
			if (isBack)refreshRisk("hidden","MakePlan/delSession.jsp");
			else history.go(1);
		}
	}

