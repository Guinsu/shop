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

	String customerId = request.getParameter("customerId");
%>

<!-- model layer -->
<%
	
	//카테고리 리스트 가져오기
	ArrayList<HashMap<String, Object>> categoryList = CategorysDao.selectCategoryList();
	
	//모든 굿즈 개수 가져오기
	int goodsTotalCnt = GoodsDao.selectGoodsContent();

	//장바구니에 추가한 개수 가져오기
	int selectOrderCount = OrderDao.selectOrderCount(customerId);
	
	ArrayList<HashMap<String, Object>> customerList =  CustomerDao.selectCustomer(customerId);
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<meta charset="UTF-8">
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/customerOne.css" />
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
	
	<nav>  
		<a href="/shop/customer/goodsList.jsp">홈</a>
	     <div class="dropdown">
            <a href="/shop/customer/goodsList.jsp?totalRow=<%=goodsTotalCnt%>">상품 목록</a>
            <div class="dropdownContent">
            
            	<!-- 카테고리 종류 가져오기 -->
                <% for(HashMap m : categoryList) { %>
                    <a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>&totalRow=<%=(Integer)(m.get("cnt"))%>">
                        <%=(String)(m.get("category"))%> (<%=(Integer)(m.get("cnt"))%>)
                    </a>
                <% } %>
            </div>
        </div>
	    <a href="/shop/customer/cart.jsp" id="customerOneAtag" class="ms-3">장바구니 보기(<%=selectOrderCount%>)</a>
		<a href="/shop/customer/orderDetails.jsp" id="customerOneAtag" class="ms-3">주문내역 보기</a>
	    <a href="/shop/customer/customerOne.jsp?customerId=<%=customerId%>">개인정보보기</a>
   		<a href="/shop/customer/logoutAction.jsp">로그아웃</a>
	</nav>
	
	<main>
		<div>
			<h1>개인정보</h1>
		</div>
		<div class="container">
			<form name="customerForm" action="/shop/customer/modifyCustomerAction.jsp" method="post" onsubmit="return validateForm()">
				<div>
					<%
						for(HashMap list : customerList){
					%>
					<div class="formField">
						<label>아이디</label>
						<input type="text" name="customerId" value="<%=(String)(list.get("email"))%>">
					</div>
					<div class="formField">
						<label>이름</label>
						<input type="text" name="customerName" value="<%=(String)(list.get("name"))%>" readonly="readonly">
					</div>
					<div class="formField">
						<label>생년월일</label>
						<input type="date" name="customerBirth" value="<%=(String)(list.get("birth"))%>" readonly="readonly">
					</div>
					<div class="formField">
						<label>성별</label>
						<select name="customerGender">
							<option value="" >성별을 선택해 주세요.</option>
						<%
							if((list.get("gender")).equals("남")){	
						%>
							<option value="남" selected>남</option>
							<option value="여">여</option>						
						<%
							}else{
						%>
							<option value="남" >남</option>
							<option value="여" selected>여</option>	
						<% 	
							}
						%>
						</select>
					</div >
					<div class="formField">
						<label>비밀번호 확인</label>
						<input type="password" name="customerOriginalPw"  placeholder="비밀번호를 입력해주세요.">
					</div>
					<%
						}
					%>
				</div>
				<div id="buttonGroup">
					<button>
						<a href="/shop/customer/goodsList.jsp">뒤로가기</a>				
					</button>
					<button type="submit">수정하기</button>
					<button>
						<a href="/shop/customer/modifyCustomerPwForm.jsp?customerId=<%=customerId%>">비밀번호 변경</a>					
					</button>
					<button>
						<a href="/shop/customer/deleteCustomerForm.jsp">회원탈퇴</a>
					</button>
				</div>
			</form>
		</div>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
	<script>
		function validateForm() {
			let customerId = document.forms["customerForm"]["customerId"].value;
			let customerGender = document.forms["customerForm"]["customerGender"].value;
			let customerOriginalPw = document.forms["customerForm"]["customerOriginalPw"].value;

			if (customerId == "") {
				alert("아이디를 입력해 주세요.");
				return false;
			}
			if (customerGender == "") {
				alert("성별을 선택해 주세요.");
				return false;
			}
			if (customerOriginalPw == "") {
				alert("비밀번호를 입력해 주세요.");
				return false;
			}

			return true;
		}
	</script>
</body>
</html>