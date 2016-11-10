var JSCoverController = {
	createCover : function(frameName) {
		frameName.document
				.write("<div id='waitingCover' style='position:absolute; z-index:10; visibility:hidden'><TABLE WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=0><tr height='100'><td></td></tr><TR><td width=30%></td><TD><table WIDTH=100% bgcolor=6699CC BORDER=0 CELLPADDING=1><tr><td><TABLE WIDTH=100% height=70 BORDER=0 cellspacing=0 ><TR><td bgcolor=FFFFFF align=center><img src='/image/gears_an.gif' width='80' height='70'></td></tr><td bgcolor=FFFFFF align=center><font size=-1><span id=loadingText contenteditable=true>���ڴ���, ���Ժ�...</span></font></td></tr></table></td></tr></table></td><td width=30%></td></tr><tr height='100'><td></td></tr></table></div>");
	},
	showCover : function(frameName, messageStr) {
		if (!frameName.document.all.waitingCover) {
			this.createCover(frameName);
		}
		frameName.scroll(0, 0);
		if (messageStr != null)
			frameName.document.all.loadingText.innerHTML = messageStr;
		frameName.document.all.waitingCover.style.visibility = "visible";
	},
	showBlock : function(id1, msg) {
		$('#' + id1).click(function() {
			if (msg == undefined) {
				//$.blockUI();
				$.blockUI( {
					message : '<h2><img src="'+path+'busy.gif" />正在处理，请稍后...</h2>'
				});
			} else {
				$.blockUI( {
					message : '<h1><img src="'+path+'busy.gif" /> ' + msg + '</h1>'
				});
			}
		});
	},
	showDiv:function(msg){
		 var messages = '<br/><h5><img src="'+path+'busy.gif"/>'+msg+'<h5>';
		 $.blockUI({ 
			      message:messages,
			      css: { 
			      padding:0,
	           	  margin:0,
	           	  width:"30%",
	           	  top:"40%",
	           	  left:"35%",
	           	  textAlign:"center",
	           	  color:"#000",
	           	  border:"1px solid #aaa",
	           	  backgroundColor:"#E1E1E1",
	           	  cursor:"wait",
	           	  "height":"30px",    
	           	  "line-height":"30px",
	           	  "font-weight":"bold"		      
		      },   
		      overlayCSS:
		      {
		    	 backgroundColor:"#fff",	
		    	 opacity:0.6 
		      }     
		 }); 		
	},
	stopShowDiv:function(time){
		 setTimeout($.unblockUI,time); 
	}
}
