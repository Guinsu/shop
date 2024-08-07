<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>

<!--controller layer  -->
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<meta charset="UTF-8">
	<title>addCategoryForm page</title>
	<style>
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
			}
		h1{
			font-size: 100px;
		}
	</style>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<main class="d-flex justify-content-center  align-items-center flex-column">
		<h1>카테고리 추가</h1>
		<div>
			<form name="categoryForm" action="/shop/emp/addCategoryAction.jsp" method="post" onsubmit="return validateForm()">
				<label>추가할 카테고리 이름:</label>
				<input type="text" name="newCategory">
				<button type="submit">추가</button>
			</form>
		</div>
	</main>
	<script>
		function validateForm() {
			let newCategory = document.forms["categoryForm"]["newCategory"].value;
			
			if (newCategory == "") {
				alert("카테고리 이름을 입력하세요.");
				return false;
			}

			return true;
		}
	</script>
</body>
</html>