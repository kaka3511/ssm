<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Json解析测试</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">

	function requestJson(){
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath }/requestJson.do',
			contentType:'application/json;charset=utf-8',
			//数据格式是json串，商品信息
			data:'{"name":"笔记本","price":99}',
			success:function(data){//返回json结果
				alert(data.name+":"+data.price+"元");
			}
		});
		
	}


	function responseJson() {
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath }/responseJson.do',
			data:'name=笔记本',
			success:function(data){
				alert(data.name+":"+data.price+"元");
			}
			
		});
	}
</script>
</head>
<body>
<input type="button" value="Json请求" onclick="requestJson()" />
<input type="button" value="key/value请求" onclick="responseJson()" />

 

</body>
</html>