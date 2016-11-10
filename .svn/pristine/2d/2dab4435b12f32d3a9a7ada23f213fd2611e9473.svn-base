<%@ page language="java" pageEncoding="utf-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	var global = {
		ctx: '${pageContext.request.contextPath}',
		rescPath: '${pageContext.request.contextPath}/resources',
		getCss: function(url){
			var cssLink = document.createElement("link");
            cssLink.rel = "stylesheet";
            cssLink.rev = "stylesheet";
            cssLink.type = "text/css";
            cssLink.media = "screen";
            cssLink.href = url;
            document.getElementsByTagName("head")[0].appendChild(cssLink);
		},
		getScript: function(jsl, callback){
			var jl = jsl.length - 1;
			$.each(jsl,function(a,b){
				$.getScript(global.rescPath + '/js/' + b + '.js', function(){
					a===jl && $.type(callback) == 'function' && callback();
				});
			});
		},
		loadCss: function(cn){
			main.getCss(main.rescPath + 'cn' + '.css');
		}
	};
</script>