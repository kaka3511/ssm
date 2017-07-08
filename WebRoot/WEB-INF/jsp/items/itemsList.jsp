<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.4.4.min.js"></script>

<script type="text/javascript">
	function deleteMuchItems(){
		document.itemsForm.action="${pageContext.request.contextPath }/Items/deleteMuchItems.do";
		 var msg = "您真的确定要删除吗？\n\n请确认！"; 
		  if (confirm(msg)==true){ 
				document.itemsForm.submit();
		  }else{ 
		    	return false; 
		  } 

	}
	
	function addItems(){
		document.itemsForm.action="${pageContext.request.contextPath }/Items/addItems.do";
		document.itemsForm.submit();
	}
	function editMuchItems(){
		document.itemsForm.action="${pageContext.request.contextPath }/Items/editMuchItems.do";
		document.itemsForm.submit();
	}
	function selectItemsType(){
		document.itemsForm.action="${pageContext.request.contextPath }/Items/selectItemsType.do";
		document.itemsForm.submit();
	}
	
	function logout(){
		document.itemsForm.action="${pageContext.request.contextPath }/logout.do";
		document.itemsForm.submit();
	}
	
	function responseJson(name) {
		 $.ajax({
			type:'post',
			url:'${pageContext.request.contextPath }/responseJson.do',
			data:'name='+name,
			success:function(data){
				alert("名称:"+data.name+"\n"+"价格:"+data.price+"元"
						+"\n"+"商品图片:"+data.pic+"\n"+"生产日期:"+data.createtime);
			}
			
		}); 
	}
</script>
<title>查询商品列表</title>
</head>
<body>
	<label >当前登录用户：${username }</label>
	<c:if test="${username!=null }">
		<input type="button" onclick="logout()" value="退出"/> 
	</c:if>
	<form
		name="itemsForm"
		action="${pageContext.request.contextPath }/Items/queryItems.do"
		method="post">
		查询条件：
		<table border=1>
			<tr>
				<td>
					<input name="itemsCustom.name" />
					<input type="submit" value="查询" />
				</td>
				<td>
				<input type="button" value="批量删除" onclick="deleteMuchItems()" />
				</td>
				<td>
				<input type="button" value="批量修改" onclick="editMuchItems()" />
				</td>
				<td>
				<input type="button" value="添加商品" onclick="addItems()" />
				</td>
				
				<td>
					<select name="itemsType" onchange="selectItemsType()">
						<option > ------</option>
						<c:forEach items="${itemsType }" var="item">
							<option value="${item.key }"> ${item.value }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			
		</table>

		商品列表：
		<table class="table table-striped">
			<tr>
				<td>选择</td>
				<td>商品名称</td>
				<td>商品价格</td>
				<td>商品图片</td>
				<td>生产日期</td>
				<td>商品描述</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${itemsList }" var="item">
				<tr>
					<td><input type="checkbox" name="ids" value="${item.id }"/></td>
					<td><div title="${item.name }">${item.name }</div></td>
					<td>${item.price }元</td>
					<td>
						<c:choose>
   							<c:when test="${item.pic !=null}">
   							<img src="/pic/${item.pic}" width=100 height=100/>
   							 </c:when>
						   <c:otherwise> 
							<img src="/pic/aa.png" width=100 height=100/>
						   </c:otherwise>		
					   </c:choose>			
					</td>
					<td><fmt:formatDate value="${item.createtime}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${item.detail }</td>

					<td><a
						href="${pageContext.request.contextPath }/Items/editItems.do?id=${item.id}">修改</a>
						<br/>
						<a
						href="${pageContext.request.contextPath }/Items/deleteItems.do?id=${item.id}">删除</a>
						<br/>
						
						<input type="button" value="key/value请求json" onclick="responseJson('${item.name }')" />
						<br/>
						
						<a
						href="${pageContext.request.contextPath }/Items/itemsView/${item.id }">restful请求</a>
						<br/>
						<a
						href="${pageContext.request.contextPath }/pic/${item.pic}">图片静态资源测试</a>
						
					</td>

				</tr>
			</c:forEach>

		</table>
	</form>
</body>

</html>