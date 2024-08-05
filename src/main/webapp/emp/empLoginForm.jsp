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
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<meta charset="EUC-KR">
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/empLoginForm.css"/>
	
</head>
<body >
	<header>
		<div class="slider">
	        <div class="slides">
	        	<div class="siteName">
	        		Tiniping World
	        	</div>
	            <a href="https://www.emotioncastle.com/products/118208055">
	                <img src="/shop/img/firstPic.png" alt="slide1" id="slide1" />
	            </a>
	            <a href="https://www.emotioncastle.com/products/118207999">
	                <img src="/shop/img/secondPic.png" alt="slide2" id="slide2"/>
	            </a>
	            <div>
	        		<img alt="" src="/shop/img/hachuping.png">
	        	</div>
	        </div>
	        <div class="dots">
	            <span class="dot" id="firstDot" onclick="clickEvent(1)"></span>
	            <span class="dot" id="secondDot" onclick="clickEvent(2)"></span>
	        </div>
         </div>
	</header>
	
	<main>
		<div>
			<h1>관리자님 로그인 부탁드립니다.</h1>
		</div>
		<div id="container">
			<form action="/shop/emp/empLoginAction.jsp" method="post">
				<div>
					<div class="formField">
						<label>아이디</label>
						<input type="text" name="empId" value="admin">
					</div>
					<div class="formField">
						<label>비밀번호</label>
						<input type="password" name="empPw" value='1234'>
					</div>
				</div>
				<div id="buttonGroup">				
					<button>
						<a href="/shop/index.jsp">뒤로가기</a>
					</button>
					<button type="submit">로그인</button>
				</div>
			</form>
		</div>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
</body>
</html>
			