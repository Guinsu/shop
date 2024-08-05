<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
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
	
	//세션에서 loginCustomer의 정보를 가져오기
	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");
	//System.out.println(loginMember);
	
	//세션에서 key가 customerId인 값 가져오기 
	String customerId = String.valueOf(loginMember.get("customerId"));
	//System.out.println(customerId);
	
	//카테고리 가져오기
	String category = request.getParameter("category");
	//System.out.println(category);
	
	// 전체 개수
	int totalRow = 0;
	
	if(request.getParameter("totalRow") != null){	
		totalRow = Integer.parseInt(request.getParameter("totalRow"));
	}
	
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보이는 굿즈의 개수
	int rowPerPage = 4;
	
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
	
	//굿즈리스트 가져오기
	ArrayList<HashMap<String, Object>> categoryList2 = GoodsDao.selectGoodsList(category,startRow,rowPerPage);
	
	//굿즈 내용 가져오기
	ArrayList<HashMap<String, Object>> categoryList3 = GoodsDao.selectGoodsContent(startRow, rowPerPage);
	
	//모든 굿즈 개수 가져오기
	int goodsTotalCnt = GoodsDao.selectGoodsContent();
	
	//장바구니에 추가한 개수 가져오기
	int selectOrderCount = OrderDao.selectOrderCount(customerId);
	
	//디버깅
	//System.out.println(categoryList);
	//System.out.println(categoryList2);
	//System.out.println(categoryList3);
	//System.out.println(goodsTotalCnt);
	//System.out.println(selectOrderCount);
%>

<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>굿즈 쇼핑몰</title>
	<link rel="stylesheet" href="/shop/css/customerGoodsList.css" />
</head>
<body>

	<!-- header 영역 / 광고 이미지-->
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
	
	<!-- 서브메뉴 / 카테고리별 상품 리스트 및 사용자 정보-->
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
	
	<!-- main -->
	<main>
		<div class="mainDiv">
			<%
				if(category == null){
					for(HashMap m3: categoryList3){
			%>
						<div class="contents">
							<div class="imgDiv">
								<img alt="이미지" class="goodsImg" src="/shop/upload/<%=(String)(m3.get("filename"))%>">
							</div>
							<div class="contentDiv">
								<div class="borderDiv"><%=(String)(m3.get("title"))%></div>
								<div class="borderDiv"><%=(Integer)(m3.get("price"))%>원</div>
								<div class="buttons">
									<a href="/shop/customer/addToCartAction.jsp?no=<%=(Integer)(m3.get("no"))%>">장바구니 추가</a>
									<a href="/shop/customer/goodsOne.jsp?no=<%=(Integer)(m3.get("no"))%>">상세보기</a>
								</div>
							</div>
						</div>
			<%		
					}
				}else{
					for(HashMap m2: categoryList2){
					
			%>
						<div class="contents">
							<div class="imgDiv" >
								<img alt="이미지" class="goodsImg" src="/shop/upload/<%=(String)(m2.get("filename"))%>">
							</div>
							<div class="contentDiv">
								<div class="borderDiv"><%=(String)(m2.get("title"))%></div>
								<div class="borderDiv"><%=(Integer)(m2.get("price"))%>원</div>
								<div class="buttons">
									<a href="/shop/customer/addToCartAction.jsp?no=<%=(Integer)(m2.get("no"))%>">장바구니 추가</a>
									<a href="/shop/customer/goodsOne.jsp?no=<%=(Integer)(m2.get("no"))%>">상세보기</a>
								</div>
							</div>
						</div>
			<%
					}
				}
			%>
		</div>
	</main>
	<div id="btnDiv">
		<button type="button">
			<%
				if(currentPage > 1){
					if(category == null || category.equals("null")){
			%>
						<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage -1%>&totalRow=<%=totalRow%>" class="aTags">이전</a>
			<% 
					}else{
			%>
						<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage -1%>&category=<%=category %>&totalRow=<%=totalRow%>" class="aTags">이전</a>
			<%
					}
				}else{
			%>
						<a style="color: grey; cursor: not-allowed;" class="aTags" >이전</a>
			<%
				}
			%>
		</button>
		<button id="currentNum"><%=currentPage%></button>
		<button type="button" >
			<%if(currentPage < lastPage ){
				if(category == null || category.equals("null")){
			%>
					<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage +1%>&totalRow=<%=totalRow%>" class="aTags">다음</a>
			<%
				}else{
			%>
					<a href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage +1%>&category=<%=category %>&totalRow=<%=totalRow%>" class="aTags">다음</a>		
			
			<%
					}
				}else{
			%>
					<a style="color: grey; cursor: not-allowed;" class="aTags">다음</a>
			<%
				}
			%>
		</button>
	</div>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
</body>
</html>