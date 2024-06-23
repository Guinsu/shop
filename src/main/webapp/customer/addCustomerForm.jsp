<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")!= null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}

	String checkUserId = null;

	boolean checkId = Boolean.parseBoolean(request.getParameter("checkId"));
	
	//디버깅
	//System.out.println(checkId + "<--------checkId");
	
	if(checkId == true){
		checkUserId = "중복된 아이디 입니다.";
	}

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/addCustomerForm.css"/>
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
			<h1>회원가입 페이지</h1>
		</div>
		<div class="container">
			<form action="/shop/customer/addCustomerAction.jsp" method="post">
				<div>
					<div class="formField">
						<label>아이디</label>
						<input type="text" name="customerId">
					</div>
					<div class="formField">
						<label>비밀번호</label>
						<input type="password" name="customerPw">
					</div>
					<div class="formField">
						<label>이름</label>
						<input type="text" name="customerName">
					</div>
					<div class="formField">
						<label>생년월일</label>
						<input type="date" name="customerBirth">
					</div>
					<div class="formField">
						<label>성별</label>
						<select name="customerGender">
							<option value="" >성별을 선택해 주세요.</option>
							<option value="남">남</option>
							<option value="여">여</option>
						</select>
					</div >
					<%
						if(checkId == true){
					%>
						<div id="warningMsg">
							<%=checkUserId%>
						</div>
					<%	
						}
					%>
				</div>
				<div  id="buttonGroup">
					<button>
						<a href="/shop/customer/loginForm.jsp">뒤로가기</a>				
					</button>				
					<button type="submit">가입</button>
				</div>
			</form>
		</div>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
</body>
</html>