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

	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");
	
	String customerId = (String)loginMember.get("customerId");
	String searchWord = "";
	
	
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
	//카테고리 리스트 가져오기
	ArrayList<HashMap<String, Object>> categoryList = CategorysDao.selectCategoryList();
	
	//모든 굿즈 개수 가져오기
	int goodsTotalCnt = GoodsDao.selectGoodsContent();

	//장바구니에 추가한 개수 가져오기
	int selectOrderCount = OrderDao.selectOrderCount(customerId);

	//orders 테이블에 있는 모든 제품보기
	ArrayList<HashMap<String, Object>> list = OrderDao.selectMyAllOrder(customerId, searchWord, startRow, rowPerPage);
	
	//디버깅
	//System.out.println(list);
	//System.out.println(customerId);
	//System.out.println(no);
%>


<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/customerOrderDetails.css" />
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
			if(!list.isEmpty() && customerId.equals((String)list.get(0).get("email"))){
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
									<button class="reviewBtn">
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
			<div class="btnGroup">
				<button type="button" >
					<%
						if(currentPage > 1){
					%>
							<a href="/shop/customer/orderDetails.jsp?currentPage=<%=currentPage -1%>" class="aTags">이전</a>
					<%
						}else{
					%>
							<a style="color: grey; cursor: not-allowed;" class="aTags">이전</a>
					<%
						}
					%>
				</button>
				<button><%=currentPage%></button>
				<button type="button">
					<%	
						if(currentPage < lastPage ){
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
				<a  href="/shop/customer/goodsList.jsp">뒤로가기</a>
			</div>
		<%
			}else{
		%>
			<h3>주문하신 내역이 없습니다.</h3>
			<div class="btnGroup">
				<button>
					<a href="/shop/customer/goodsList.jsp" >뒤로가기</a>
				</button>
			</div>
		<%
			}
		%>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
</body>
</html>