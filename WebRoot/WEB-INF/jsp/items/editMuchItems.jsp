<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

<title>查询商品列表</title>
<script type="text/javascript">
function editItemsAllSubmit(){
	//提交form
	document.itemsForm.action="${pageContext.request.contextPath }/Items/editMuchItemsSubmit.do";
	document.itemsForm.submit();
}

</script>
</head>
<body> 
<form name="itemsForm" method="post" enctype="multipart/form-data">

商品列表：
<table class="table table-striped" >
<tr>
	<td>商品名称</td>
	<td>商品价格</td>
	<td>商品图片</td>
	<td>生产日期</td>
	<td>商品描述</td>

</tr>
<c:forEach items="${itemsList }" var="item" varStatus="status">
<tr >	
	<input type="hidden" name="itemsList[${status.index }].id" value="${item.id }"/>
	<td><input name="itemsList[${status.index }].name" value="${item.name }"/></td>
	<td><input name="itemsList[${status.index }].price" value="${item.price }"/></td>
	<td><input name="itemsList[${status.index }].createtime" value="<fmt:formatDate value="${item.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/></td>
	<td><input name="itemsList[${status.index }].detail" value="${item.detail }"/></td>


</tr>
</c:forEach>
<tr>

<td>
<input type="button" value="批量修改提交" onclick="editItemsAllSubmit()"/>
</td>
</tr>
</table>
</form>
</body>

</html>