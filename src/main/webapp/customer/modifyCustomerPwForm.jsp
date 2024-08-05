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
	
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<meta charset="UTF-8">
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/modifyCustomerPwForm.css" />
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
			<h1>비밀번호 변경</h1>
		</div>
		<div id="container">
			<form name="passwordForm" action="/shop/customer/modifyCustomerPwAction.jsp?customerId=<%=customerId%>" method="post" onsubmit="return validateForm()">
				<div>
					<div class="formField">
						<label>기존 비밀번호</label>
						<input type="password" name="customerOriginalPw"  placeholder="기존 비밀번호를 입력해주세요.">
					</div>
					<div class="formField">
						<label>변경 비밀번호 </label>
						<input type="password" name="customerChangePw"  placeholder="변경할 비밀번호를 입력해주세요.">
					</div>
				</div>
				<div id="buttonGroup">
					<button>
						<a href="/shop/customer/customerOne.jsp?customerId=<%=customerId%>">뒤로가기</a>				
					</button>
					<button type="submit">수정하기</button>
				</div>
			</form>
		</div>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
	<script>
		function validateForm() {
			let originalPw = document.forms["passwordForm"]["customerOriginalPw"].value;
			let changePw = document.forms["passwordForm"]["customerChangePw"].value;

			if (originalPw == "") {
				alert("기존 비밀번호를 입력해 주세요.");
				return false;
			}
			if (changePw == "") {
				alert("변경할 비밀번호를 입력해 주세요.");
				return false;
			}

			return true;
		}
	</script>
</body>
</html>