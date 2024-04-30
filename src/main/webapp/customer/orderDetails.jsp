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
	String searchWord = "";
	
	//디버깅
	//System.out.println(no);
	
	int totalRow = OrderDao.orderCount(searchWord);
	
	if(request.getParameter("totalRow") != null){	
		totalRow = Integer.parseInt(request.getParameter("totalRow"));
	}
	
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보이는 인원수
	int rowPerPage = 8;
	
	// DB에서 시작 페이지 값 설정 = (현재 페이지-1) *   한 페이지에 보이는 인원수
	int startRow = (currentPage-1)* rowPerPage;
	

	
	// 마지막 페이지 계산하기 = 전체 회원수 / 한 페이지에서 보이는 인원수
	int lastPage = totalRow / rowPerPage;
	
	//인원수가 남을 때 마지막 페이지는 +1 해준다. 
	//예) 회원수가 11명이라면 한 페이지당 10명씩 1페이지가 나와야하는데 1명이 더 있기 때문에 총 페이지는 2페이지가 된다.
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
%>
	
<!-- model layer -->
<%

	//orders 테이블에 있는 모든 제품보기
	ArrayList<HashMap<String, Object>> list = OrderDao.selectAllOrder(searchWord, startRow, rowPerPage);
	
	//디버깅
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
	<title>orderDetails page</title>
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
			font-size: 30px;
			color: black;
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
			margin-top: 20px;
			width: 400px;
			border-radius: 20px;
		}
		header{
			border-bottom: 1px solid black
		}
		
		input{
			width: 500px;
		}
		
		table{
			border: 3px solid black;
			width: 80%;
			margin-left: 40px;
			margin-right: 40px;
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
		#currentNum{
			font-size: 30px;
			color: black;
		}
		#formBtn{
			width: 140px;
			border-radius: 20px;
			margin: 0px;
		}
		#backBtn{
			margin-left: 20px;
		}
		.aTags{
			padding-left: 100px;
			padding-right: 100px;
		}
		.goBackHomeTag{
			border: 1px solid black;
			border-radius : 10px;
			margin-top: 20px;
			margin-left: 20px;
			height: 59px;
			padding-left: 20px;
			padding-right: 20px;
			padding-top: 10px;
		}
	</style>
</head>
<body>
	<header class="m-2 d-flex justify-content-between">
		<div>
			<img alt="하츄핑" src="/shop/img/hachuping.png" id="mainImg">
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<h1>주문내역 보기</h1>
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<div id="customerId"><%=loginMember.get("customerId")%> 님 환영합니다.</div>
			<a href="/shop/customer/customerOne.jsp?customerId=<%=loginMember.get("customerId")%>" class="ms-2"id="customerOneAtag">개인정보보기</a>
			<a href="/shop/customer/logoutAction.jsp" class="ms-2"id="logoutAtag">로그아웃</a>
		</div>
	</header>
	<main class="d-flex justify-content-center  align-items-center flex-column">
		<%
			if(customerId.equals((String)list.get(0).get("email"))){
		%>
			<table>
				<tr>
					<th>주문번호</th>
					<th>제품이름</th>
					<th>진행상태</th>
					<th>제품가격</th>
					<th>제품개수</th>
					<th>후기작성</th>
				</tr>
				<%
					for(HashMap m : list){
						if("N".equals((String)m.get("commentState")) && "배송완료".equals((String)m.get("state"))){
							//디버깅 
							//System.out.println((String)m.get("commentState"));
				%>
							<tr>
								<td><%=(Integer)m.get("orderNo")%></td>
								<td><%=(String)m.get("goodsTitle")%></td>
								<td><%=(String)m.get("state")%></td>
								<td><%=(Integer)m.get("price")%></td>
								<td>1</td>
								<td>
									<button id="formBtn">
										<a href="/shop/customer/goodsOne.jsp?no=<%=m.get("no")%>&orderNo=<%=(Integer)m.get("orderNo")%>">후기작성 하기</a>
									</button>
								</td>
							</tr>
				<%	
						}else if("Y".equals((String)m.get("commentState")) && "배송완료".equals((String)m.get("state"))){
				%>
							<tr>
								<td><%=(Integer)m.get("orderNo")%></td>
								<td><%=(String)m.get("goodsTitle")%></td>
								<td><%=(String)m.get("state")%></td>
								<td><%=(Integer)m.get("price")%></td>
								<td>1</td>
								<td>
									후기 작성 완료
								</td>
							</tr>
				<%
						}else{	
				%>
							<tr>
								<td><%=(Integer)m.get("orderNo")%></td>
								<td><%=(String)m.get("goodsTitle")%></td>
								<td><%=(String)m.get("state")%></td>
								<td><%=(Integer)m.get("price")%></td>
								<td>1</td>
								<td>배송진행 중 입니다.</td>
							</tr>
				<%
						}
					}
				%>
			</table>
			<div class="d-flex justify-content-center btn-group" role="group" aria-label="Basic example">
				<button type="button" class="btn btn-light border border-secondary"  >
					<%
						if(currentPage > 1){
					%>
							<a href="/shop/customer/orderDetails.jsp?currentPage=<%=currentPage -1%>" class="aTags">이전</a>
					<%
						}else{
					%>
							<a style="color: grey; cursor: not-allowed;" class="aTags" >이전</a>
					<%
						}
					%>
				</button>
				<button class="btn btn-light border border-secondary" id="currentNum"><%=currentPage%></button>
				<button type="button" class="btn btn-light border border-secondary">
					<%	if(currentPage < lastPage ){
					%>
							<a href="/shop/customer/orderDetails.jsp?currentPage=<%=currentPage +1%>" class="aTags">다음</a>		
					<%
						}else{
					%>
							<a style="color: grey; cursor: not-allowed;" class="aTags">다음</a>
					<%
						}
					%>
				</button>
				<a class="goBackHomeTag" href="/shop/customer/goodsList.jsp">뒤로가기</a>
			</div>
		<%
			}else{
		%>
			<h3>주문하신 내역이 없습니다.</h3>
			<button>
				<a href="/shop/customer/goodsList.jsp" id="goBackATag">뒤로가기</a>
			</button>
		<%
			}
		%>
	</main>
</body>
</html>