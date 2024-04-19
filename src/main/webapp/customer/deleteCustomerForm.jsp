<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<!--controller layer  -->
<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}

	
%>

<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
<meta charset="EUC-KR">
<title>deleteCustomerForm page</title>
	<style>
	
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
		}
		main{
			margin-top: 50px;
		}
		form{
			border: 1px solid black;
			border-radius : 20px;
			padding: 60px;
			width: 600px;
		}
		button{
			width: 200px;
			height: 50px;
			background: white;
			border-radius: 20px;
		}
		a{
			text-decoration: none;
			color: black;
			width: 200px;
			height: 50px;
			background: white;
			border: 2px solid black;
			border-radius: 20px;
			text-align: center;
		}
		input{
			height: 40px;
			border-radius: 10px;
			width: 250px;
		}
		select{
			width: 250px;
		}
		
		#formDiv{
			margin-top: 25px;
		}
		#loginBtnDiv{
			margin-top: 70px;
		}
		.loginDivTags{
			width: 100%;
		}
	</style>
</head>
<body >
	<main>
		<div class="d-flex justify-content-center">
			<h1>회원탈퇴</h1>
		</div>
		<div  class="d-flex justify-content-center" id="formDiv">
			<form action="/shop/customer/deleteCustomerAction.jsp" method="post">
				<div>고객님의 모든 회원정보는 안전하게 삭제 됩니다.</div>
				<div>
					<div class="d-flex justify-content-between loginDivTags">
						<label>비밀번호 입력</label>
						<input type="password" name="customerPw" >
					</div>
				</div>
				<div class="d-flex justify-content-center" id="loginBtnDiv">
					<a href="/shop/customer/goodsList.jsp">뒤로가기</a>				
					<button type="submit">탈퇴하기</button>
				</div>
			</form>
		</div>
	</main>
</body>
</html>