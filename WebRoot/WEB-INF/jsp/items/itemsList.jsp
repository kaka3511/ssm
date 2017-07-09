<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://static.runoob.com/assets/js/jquery-treeview/jquery.treeview.css" />
	<link rel="stylesheet" href="http://static.runoob.com/assets/js/jquery-treeview/screen.css" />

	<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="http://static.runoob.com/assets/js/jquery-treeview/jquery.cookie.js"></script>
	<script src="http://static.runoob.com/assets/js/jquery-treeview/jquery.treeview.js" type="text/javascript">
 <link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.4.4.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
	
	});



	function deleteMuchItems(){
		document.itemsForm.action="${pageContext.request.contextPath }/Items/deleteMuchItems.do";
		 var msg = "您真的确定要删除吗？\n\n请确认！"; 
		  if (confirm(msg)==true){ 
				document.itemsForm.submit();
		  }else{ 
		    	return false; 
		  } 

	}
	
	function searchInput(){
		document.getElementById("search").value='';
	}
	
	function searchTree(){
		name = prompt("请输入商品名称:",""); 
		if(name == null)
			return;
		if (name!=null && name!=""){
			alert(name);
			document.getElementById("search").value=name;
			document.itemsForm.action="${pageContext.request.contextPath }/Items/queryItems.do";
			document.itemsForm.submit();
		}
	}
	

	function addItems(){
		document.itemsForm.action="${pageContext.request.contextPath }/Items/addItems.do";
		document.itemsForm.submit();
	}
	function editMuchItems(){
		document.getElementById("search").value='';
		document.itemsForm.action="${pageContext.request.contextPath }/Items/editMuchItems.do";
		document.itemsForm.submit();
	}
	function selectItemsType(){
		if(document.getElementById("search").value="请输入查询关键字..")
		searchInput();
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
<body >

<table border="2px" cellspacing="50px">
	<tr>
		
		<td align="left">
		<img src="/pic/QQ.png" align="top"/>
		<div id="main">
	
	<ul id="browser" class="filetree treeview-famfamfam">
		<li><span class="folder">菜单栏</span>
			<ul>
				<li><span class="folder">查询</span>
					<ul>
						<li><span class="file" onclick="searchTree()"><a href="#">查询商品</a></span></li>
					</ul>
				</li>
				<li><span class="folder">删除</span>
				
							<ul id="folder21">
								<li><span class="file">单个删除</span></li>
								<li><span class="file">批量删除</span></li>
							</ul>
				<li><span class="folder">修改</span>
							<ul>
								<li><span class="file">单个修改</span></li>
								<li><span class="file">批量修改</span></li>
							</ul>
				</li>
					
				</li>
				<li><span class="folder">添加</span>
					<ul>
						<li><span class="file">添加商品</span></li>
					</ul>
				</li>
				<li><span class="file">退出登录</span></li>
			</ul>
		</li>
	</ul>
</div>
		</td>
		
		
		<td align="right">
		<form
		
		name="itemsForm"
		action="${pageContext.request.contextPath }/Items/queryItems.do"
		method="post">
		
		<table border=1 style="width: 100%">
			<tr>
				<td>
					<input 
					id=search
					class="form-control"
					name="itemsCustom.name" 
					value="请输入查询关键字.."
					onclick="searchInput()" 
					 />
					<input type="submit" value="查询"  style="width: 100%"/>
				</td>
				<td>
				<input style="height: 110%;width: 100%" type="button" value="批量删除" onclick="deleteMuchItems()" />
				</td>
				<td>
				<input style="height: 110%;width: 100%" type="button" value="批量修改" onclick="editMuchItems()" />
				</td>
				<td>
				<input style="height: 110%;width: 100%" type="button" value="添加商品" onclick="addItems()" />
				</td>
				
				<td>
					<select  style="height: 110%;width: 100%"
					class="form-control"
					name="itemsType" onchange="selectItemsType()">
						<option > 商品类型</option>
						<c:forEach items="${itemsType }" var="item">
							<option value="${item.key }"> ${item.value }</option>
						</c:forEach>
					</select>
				</td>
				<td>
				<div align="right">
		 		 <label class="btn btn-info" style="width:100%" >当前登录用户：${username }</label>
					<c:if test="${username!=null }">
					<br>
				<input style="width:100%" type="button" onclick="logout()" value="退出"/> 
					</c:if>
					</div>
				</td>
			</tr>
			
		</table>

		商品列表：
		<table class="table table-bordered">
			<tr align="center" class="danger">
				<td>选择</td>
				<td>商品名称</td>
				<td>商品价格</td>
				<td>商品图片</td>
				<td>生产日期</td>
				<td>商品描述</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${itemsList }" var="item">
				<tr class="success" align="center" >
					<td><input type="checkbox" name="ids" value="${item.id }"/></td>
					<td><div title="${item.name }">${item.name }</div></td>
					<td>${item.price }元</td>
					<td>
						<c:choose>
   							<c:when test="${item.pic !=null}">
   							<img 
   							class="img-responsive"
   							src="/pic/${item.pic}" width=100 height=100/>
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
	</form></td>
	</tr>
</table>


	
	
</body>

</html>