<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!-- Controller layer -->
<%
	// 인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	String empName = String.valueOf(loginEmp.get("empName"));
	
	
	String searchWord = "";
	
	//현재 페이지 값 
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 전체 회원수 
	int totalRow = OrderDao.orderCount(searchWord);
	
	// 한 페이지에 보이는 인원수
	int rowPerPage = 10;
	
	
	// DB에서 시작 페이지 값 설정 = (현재 페이지-1) *   한 페이지에 보이는 인원수
	int startRow = (currentPage-1)* rowPerPage;
	
	
	if(request.getParameter("searchWord") != null ){
		searchWord = request.getParameter("searchWord");
	}
	
	// 마지막 페이지 계산하기 = 전체 회원수 / 한 페이지에서 보이는 인원수
	int lastPage = totalRow / rowPerPage;
	
	//인원수가 남을 때 마지막 페이지는 +1 해준다. 
	//예) 회원수가 11명이라면 한 페이지당 10명씩 1페이지가 나와야하는데 1명이 더 있기 때문에 총 페이지는 2페이지가 된다.
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	//디버깅
	//System.out.println(lastPage + " lastPage 회원보기 페이지");
	//System.out.println(totalRow + "<----totalRow 전체 회원수 ");
	//System.out.println(rowPerPage + "<----rowPerPage 한 페이지당 보고싶은 인원수");
	//System.out.println(startRow);
	//System.out.println(rowPerPage);
%>    

<!-- model layer -->
<%

	//모든 order 정보 가져오기
	ArrayList<HashMap<String, Object>> selectAllOrder = OrderDao.selectAllOrder(empName, searchWord, startRow, rowPerPage);
	
	//디버깅
	//System.out.println(selectAllOrder);
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
	<title>paymentOrderForm page</title>
	<style>
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
		}
		a{
			text-decoration: none;
			color: black;
		}
		h1{
			font-size: 40px;
			text-align: center;
			width: 100%;
			border-bottom: 2px solid black;
		}
		input{
			width: 500px;
			border-radius: 10px;
		}
		
		button{
			margin-top: 20px;
			width: 100px;
			height:40px;
			border-radius: 20px;

		}
		table{
			border: 3px solid black;
			width:80%;
			margin-top: 20px;
		 	border-collapse: separate;
        	border-spacing: 0;
        	border-radius: 20px;
        	overflow: hidden;
		}
		
		th,td{
			border: 1px solid black;
			text-align: center;
			font-size: 25px;
			height: 20px;
			width: 300px;
			padding: 2px;
		}
		
		th {
    		background-color: #f8f8ff;
  		}
  		
  		td{
  			background-color: #f0ffff;	
  		}
  		
  		#currentNum{
			font-size: 30px;
			color: black;
		}
		.formBtn{
			width: 50px;
			border-radius: 20px;
			margin: 0px;
		}
  		.aTags{
			
		}
		.tableDiv{
			display: flex;
			justify-content: center;
			align-items: center;
			flex-direction: column;
		}
		
	</style>
</head>
<body>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<main class="d-flex justify-content-center  align-items-center flex-column">
		<h1>배송정보</h1>
		<div class="tableDiv">
			<table>
				<tr>
					<th>주문번호</th>
					<th>제품번호</th>
					<th>주문자 아이디</th>
					<th>제품이름</th>
					<th>제품가격</th>
					<th>제품주소</th>
					<th>진행상태</th>
					<th>진행상태 수정</th>
					<th>제품개수</th>
					<th>주문취소</th>
				</tr>
			<%
				for(HashMap m : selectAllOrder){
				
			%>
					<tr>
						<td><%=(Integer)m.get("orderNo")%></td>
						<td><%=(Integer)m.get("no")%></td>
						<td><%=(String)m.get("email")%></td>
						<td><%=(String)m.get("goodsTitle")%></td>
						<td><%=(Integer)m.get("price")%></td>
						<td><%=(String)m.get("address")%></td>
						<td><%=(String)m.get("state")%></td>
						<td>
							<form action="/shop/emp/modifyPaymentOrderStateAction.jsp" method="post">
								<input type="hidden" name="orderNo" value="<%=(Integer)m.get("orderNo")%>">
								<input type="hidden" name="no" value="<%=(Integer)m.get("no")%>">
								<input type="hidden" name="customerId" value="<%=(String)m.get("email")%>">
								<input type="hidden" name="totalAmount" value="<%=(Integer)m.get("totalAmount")%>">
								<input type="hidden" name="currentPage" value="<%=currentPage%>">		
								<select name="orderState">
									<option value="결제완료">결제완료</option>
									<option value="배송중">배송중</option>
									<option value="배송완료">배송완료</option>
								</select>
								<button type="submit" class="formBtn">수정</button>
							</form>
						</td>
						<td>1</td>
						<td>
							<form action="/shop/emp/deleteOrderAction.jsp" method="post">
								<input type="hidden" name="orderNo" value="<%=(Integer)m.get("orderNo")%>">
								<input type="hidden" name="goodsNo" value="<%=(Integer)m.get("no")%>">
								<div>								
									<button type="submit" class="formBtn">취소</button>
								</div>
							</form>
						</td>
					</tr>
			<%
				}
			%>
			</table>
			<div>
				<button type="button" >
					<%
						if(currentPage > 1){
					%>
							<a href="/shop/emp/paymentOrderForm.jsp?currentPage=<%=currentPage -1%>" class="aTags">이전</a>
					<%
						}else{
					%>
							<a style="color: grey; cursor: not-allowed;" class="aTags" >이전</a>
					<%
						}
					%>
				</button>
				<button id="currentNum"><%=currentPage%></button>
				<button type="button" >
					<%	if(currentPage < lastPage ){
					%>
							<a href="/shop/emp/paymentOrderForm.jsp?currentPage=<%=currentPage +1%>" class="aTags">다음</a>		
					<%
						}else{
					%>
							<a style="color: grey; cursor: not-allowed;" class="aTags">다음</a>
					<%
						}
					%>
				</button>
			</div>				
		</div>
	</main>
	<footer>
		<div class="d-flex justify-content-center">
			<form action="/shop/emp/paymentOrderForm.jsp">
				<label>
					주문자 아이디 검색 : 
				</label>
				<input type="text" name="searchWord">
				<button type="submit" id="searchBtn">확인</button>			
			</form>
		</div>
	</footer>
</body>
</html>




