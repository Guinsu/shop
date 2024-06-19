<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<meta charset="UTF-8">
	<title>main page</title>
	<style>
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 20px;
  			font-style: normal;
  			background-color: #FCE4EC;
		}
		main{
			margin-top: 100px;
		}
		img{
			width: 250px;
			height: 300px;
		}
		a{
			font-size: 30px;
			text-decoration: none;
			color:black;
		}
		
		h1{
			font-size: 100px;
			margin-left: 50px;
		}
		h2{
			text-align: center;
			font-size: 70px;
			color: black;
			border: 1px solid black;
			border-radius: 30px;
			padding: 30px;
			margin-top: 30px;
		}
		h3{
			text-align: center;
			font-size: 50px;
			color: black;
		}
		button{
			width: 200px;
			height: 100px;
		}
		header{
			border-bottom: 3px solid white;
		}
		.mainImg{
			width: 150px;
			height: 150px;
		}
		.btnCustom {
            background-color: #FFEFD5;
            color: white;
            border: 1px solid black;
            padding: 10px 20px;
            font-size: 18px;
            border-radius: 10px;
            margin: 10px;
            transition: background-color 0.3s;
        }
        .btnCustom:hover {
            background-color: white;
        }
	</style>
</head>
<body>
	
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
	
	<main  class="d-flex justify-content-center align-items-center">
		<div>
			<h3>＊로그인을 선택해 주세요＊</h3>
			<div class="mt-4 d-flex justify-content-center align-items-center">
				<button  class="btnCustom">
					<a href="/shop/customer/loginForm.jsp">고객 로그인</a>
				</button>
				<button  class="btnCustom">
					<a href="/shop/emp/empLoginForm.jsp">관리자 로그인</a>
				</button>
			</div>
			<h2>환영합니다 고객님♥ 여러분의 친구 티니핑 입니다.</h2>
		</div>
	</main>
</body>
</html>