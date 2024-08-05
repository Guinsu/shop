<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<meta charset="UTF-8">
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/index.css"/>
</head>
<body>
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
			<h1>＊로그인을 선택해 주세요＊</h1>
			<div id="buttonGroup">
				<button>
					<a href="/shop/customer/loginForm.jsp">고객 로그인</a>
				</button>
				<button>
					<a href="/shop/emp/empLoginForm.jsp">관리자 로그인</a>
				</button>
			</div>
		</div>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
</body>
</html>