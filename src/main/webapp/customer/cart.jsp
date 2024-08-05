<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}

	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");

	String customerId = (String)loginMember.get("customerId");
	//디버깅
	//System.out.println(no);
%>
	
<!-- model layer -->
<%
	//카테고리 리스트 가져오기
	ArrayList<HashMap<String, Object>> categoryList = CategorysDao.selectCategoryList();
	
	//모든 굿즈 개수 가져오기
	int goodsTotalCnt = GoodsDao.selectGoodsContent();

	//장바구니에 추가한 개수 가져오기
	int selectOrderCount = OrderDao.selectOrderCount(customerId);
	
	ArrayList<HashMap<String, Object>> list = OrderDao.selectOrders(customerId);
	
	//orders 테이블에 있는 모든 제품보기
	//System.out.println(list);

%>

<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<meta charset="UTF-8">
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/customerCart.css">
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
	    <a href="/shop/customer/customerOne.jsp?customerId=<%=loginMember.get("customerId")%>">개인정보보기</a>
   		<a href="/shop/customer/logoutAction.jsp">로그아웃</a>
	</nav>
	
	<main>
		<%
			if(list.size() > 0){
		%>
				<table>
					<tr>
						<th>주문번호</th>
						<th>제품번호</th>
						<th>제품이름</th>
						<th>제품가격</th>
						<th>제품개수</th>
						<th>취소여부</th>
					</tr>
					<%
						for(HashMap m : list){
						
					%>
						<tr>
							<td><%=(Integer)m.get("orderNo")%></td>
							<td><%=(Integer)m.get("no")%></td>
							<td><%=(String)m.get("goodsTitle")%></td>
							<td><%=(Integer)m.get("price")%>원</td>
							<td>1</td>
							<td>
								<form action="/shop/customer/deleteCartAction.jsp" method="post">
									<input type="hidden" name="orderNo" value="<%=(Integer)m.get("orderNo")%>">
									<input type="hidden" name="goodsNo" value="<%=(Integer)m.get("no")%>">
									<div class="cancelDiv">
										<button type="submit">취소</button>
									</div>
								</form>
							</td>
						</tr>
					<%
						}
					%>
				</table>
				<div class="addressForm">
					<h3>배송지 주소를 입력해주세요.</h3>
					<form name="paymentForm" action="/shop/customer/paymentGoodsAction.jsp" method="post" onsubmit="return validateForm()">
						<label>입력 : </label>
						<input type="text" name="address">
						<input type="hidden" name="payment" value="결제완료">
						<input type="hidden" name="customerId" value="<%=customerId%>">
						<%
							for(HashMap m : list){
								int orderNo = (Integer)m.get("orderNo");
						%>
							<input type="hidden" name="orderNo" value="<%=orderNo%>">
						<%
							}
						%>
						<div class="btnDiv">
							<button type="submit">결제하기</button>
							<button><a href="/shop/customer/goodsList.jsp">뒤로가기</a></button>
						</div>
					</form>
				</div>
		<%
			}else{
		%>
				<div class="emptyCartDiv">
					<h3>장바구니에 아무런 제품이 없습니다!</h3>
				</div>
		<%
			}
		%>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
	<script>
		function validateForm() {
			let address = document.forms["paymentForm"]["address"].value;
			
			if (address == "") {
				alert("주소를 입력하세요.");
				return false;
			}
			
			return true;
		}
	</script>
</body>
</html>