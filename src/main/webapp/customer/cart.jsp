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

	ArrayList<HashMap<String, Object>> list = OrderDao.selectOrders(customerId);
	
	//orders 테이블에 있는 모든 제품보기
	//System.out.println(list);

%>

<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
		
	<meta charset="UTF-8">
	<title>cart page</title>
	<style>
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
  			background-color: #FCE4EC;
		}
		a{
			text-decoration: none;
			color:black;
		}
		h1{
			font-size: 100px;
			margin-left: 50px;
		}
		h3{
			font-size: 50px;
			text-align: center;
		}
		
		button{
			width: 100px;
			height: 100%;
		}
		header{
			border-bottom: 1px solid black
		}
		
		input{
			width: 500px;
		}
		
		table{
			border: 3px solid black;
			margin-left: 40px;
			margin-top: 20px;
		 	border-collapse: separate;
        	border-spacing: 0;
        	border-radius: 20px;
        	overflow: hidden;
		}
		
		th,td{
			border: 1px solid black;
			text-align: center;
			font-size: 30px;
			height: 30px;
			width: 200px;
			padding: 10px;
		}
		
		th {
    		background-color: #f8f8ff;
  		}
  		
  		td{
  			background-color: #f0ffff;	
  		}
  		
		#mainImg{
			width: 150px;
			height: 150px;
		}
		#customerId{
			font-size: 30px;
		}
		#logoutAtag{
			height: 40px;
			border: 1px solid black;
			border-radius: 10px;
			padding-right: 20px;
			padding-left: 20px;
			font-size: 30px;
			color: black;
		}
		#customerOneAtag{
			height: 40px;
			border: 1px solid black;
			border-radius: 10px;
			padding-right: 20px;
			padding-left: 20px;
			font-size: 30px;
			color: black;
		}
		#emptyCartDiv{
			width: 100%;
		}
	</style>
</head>
<body>
	<header class="m-2 d-flex justify-content-between">
		<div>
			<img alt="하츄핑" src="/shop/img/hachuping.png" id="mainImg">
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<h1>장바구니</h1>
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<div id="customerId"><%=loginMember.get("customerId")%> 님 환영합니다.</div>
			<a href="/shop/customer/customerOne.jsp?customerId=<%=loginMember.get("customerId")%>" class="ms-2"id="customerOneAtag">개인정보보기</a>
			<a href="/shop/customer/logoutAction.jsp" class="ms-2"id="logoutAtag">로그아웃</a>
		</div>
	</header>
	<main class="d-flex">
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
					</tr>
					<%
						for(HashMap m : list){
						
					%>
						<tr>
							<td><%=(Integer)m.get("orderNo")%></td>
							<td><%=(Integer)m.get("no")%></td>
							<td><%=(String)m.get("goodsTitle")%></td>
							<td><%=(Integer)m.get("price")%></td>
							<td>1</td>
						</tr>
					<%
						}
					%>
				</table>
				<div class="ms-4">
					<h3>배송지 주소를 입력해주세요.</h3>
					<form action="/shop/customer/paymentGoodsAction.jsp" method="post">
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
						<button type="submit">결제하기</button>
						<button><a href="/shop/customer/goodsList.jsp">뒤로가기</a></button>
					</form>
				</div>
		<%
			}else{
		%>
				<div class="d-flex flex-column justify-content-center align-items-center" id="emptyCartDiv">
					<h3>장바구니에 아무런 제품이 없습니다!</h3>
					<button>
						<a href="/shop/customer/goodsList.jsp" id="goBackATag">뒤로가기</a>
					</button>
				</div>
		<%
			}
		%>
	</main>
</body>
</html>