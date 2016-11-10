
//Release Form
	function releaseForm(){
		var oForm = document.getElementById("centerForm");
		oForm.innerHTML = "<fieldset><legend><img src='Image\\page\\title4.jpg'></legend>&nbsp;</fieldset>"
	}

//Show Message Using Alert
	function showMessage(str){
		alert(str);
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

