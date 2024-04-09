<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    
<%
	//인증 분기 
	if(session.getAttribute("loginCustomer")!= null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}
	
	//System.out.println(session.getAttribute("loginEmp"));
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
<title>login page</title>
	<style>
	
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
		}
		main{
			margin-top: 200px;
			
		}
		form{
			border: 1px solid black;
			border-radius : 20px;
			padding: 60px;
		}
		button{
			width: 200px;
			height: 50px;
			background: white;
			border-radius: 20px;
		}
		input{
			height: 40px;
			border-radius: 10px;
		}
		a{
			text-decoration: none;
			color: black;
			border: 2px solid black;
			border-radius: 20px;
			width: 200px;
			height: 50px;
			text-align: center;
		}
		#formDiv{
			margin-top: 50px;
		}
		#loginBtnDiv{
			margin-top: 70px;
			width: 100%;
		}
		.loginDiv{
			width: 100%;
		}
	</style>
</head>
<body >
	<main>
		<div class="d-flex justify-content-center">
			<h1>로그인 페이지</h1>
		</div>
		<div  class="d-flex justify-content-center" id="formDiv">
			<form action="/shop/customer/loginAction.jsp" method="post">
				<div>
					<div class="d-flex justify-content-between loginDiv">
						<label>아이디</label>
						<input type="text" name="customerId">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDiv">
						<label>비밀번호</label>
						<input type="password" name="customerPw">
					</div>
				</div>
				<div class="d-flex justify-content-center" id="loginBtnDiv">				
					<a href="/shop/customer/addCustomerForm.jsp" class="me-3">회원가입</a>
					<button type="submit">로그인</button>
				</div>
			</form>
		</div>
	</main>
</body>
</html>