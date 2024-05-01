<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    
<%
	//인증 분기 
	if(session.getAttribute("loginEmp")!= null){
		response.sendRedirect("/shop/emp/empList.jsp");
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
<title>loginForm page</title>
	<style>
	
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 40px;
  			font-style: normal;
  			background-color: #FCE4EC;
		}
		main{
			margin-top: 30px;
			
		}
		form{
			border: 1px solid white;
			border-radius : 20px;
			padding: 30px;
		}
		button{
			width: 200px;
			height: 50px;
			background: none;
			border-radius: 20px;
			font-size: 30px;
			color: white;
			border: 2px solid white;
		}
		input{
			height: 40px;
			width: 300px;
			border-radius: 8px;
		}
		a{
			text-decoration: none;
			color: white;
			border: 2px solid white;
			border-radius: 20px;
			width: 200px;
			height: 50px;
			text-align: center;
			font-size: 30px;
		}
		h1{
			font-size: 100px;
			margin-left: 50px;
		}
		h3{
			text-align: center;
			font-size: 50px;
			color: white;
		}
		header{
			border-bottom: 3px solid white;
		}
		label{
			color: white;
		}
		.loginDiv{
			width: 100%;
		}
		.mainImg{
			width: 150px;
			height: 150px;
		}
		#formDiv{
			margin-top: 20px;
		}
		#loginBtnDiv{
			margin-top: 40px;
			width: 100%;
		}
	</style>
</head>
<body >
	<header class="m-2 d-flex justify-content-between">
		<div>
			<img alt="하츄핑" src="/shop/img/hachuping.png" class="mainImg">
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<h1>캐치! 티니핑</h1>
		</div>
		<div>
			<img alt="하츄핑" src="/shop/img/hachuping.png" class="mainImg">
		</div>
	</header>
	
	<main>
		<div class="d-flex justify-content-center">
			<h3>관리자님 로그인 부탁드립니다.</h3>
		</div>
		<div  class="d-flex justify-content-center" id="formDiv">
			<form action="/shop/emp/empLoginAction.jsp" method="post">
				<div>
					<div class="d-flex justify-content-between loginDiv">
						<label>아이디</label>
						<input type="text" name="empId">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDiv">
						<label>비밀번호</label>
						<input type="password" name="empPw">
					</div>
				</div>
				<div class="d-flex justify-content-center" id="loginBtnDiv">				
					<button class="me-4" type="submit">로그인</button>
					<a href="/shop/index.jsp">뒤로가기</a>
				</div>
			</form>
		</div>
	</main>
</body>
</html>
			