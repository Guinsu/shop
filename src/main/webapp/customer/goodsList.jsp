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
	
	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");
	String customerId = String.valueOf(loginMember.get("customerId"));
	
	String category = request.getParameter("category");
	
	int totalRow = 0;
	
	if(request.getParameter("totalRow") != null){	
		totalRow = Integer.parseInt(request.getParameter("totalRow"));
	}
	
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보이는 인원수
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
	
	/*
		null이면
		SELECT * FROM goods
		
		null이 아니면
		SELECT * FROM goods WHERE category = ? ORDER BY DESC limit ?,?
	*/
%>

<!-- model layer -->
<%
	ArrayList<HashMap<String, Object>> categoryList = CategorysDao.selectCategoryList();
	ArrayList<HashMap<String, Object>> categoryList2 = GoodsDao.selectGoodsList(category,startRow,rowPerPage);
	ArrayList<HashMap<String, Object>> categoryList3 = GoodsDao.selectGoodsContent(startRow, rowPerPage);
	int goodsTotalCnt = GoodsDao.selectGoodsContent();
	int selectOrderCount = OrderDao.selectOrderCount(customerId);
	
	//디버깅
	//System.out.println(goodsTotalCnt);
	//System.out.println(selectOrderCount);
%>

<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
     <meta name="viewport" content="width=device-width, initial-scale=1.0" />
     <title>굿즈 쇼핑몰</title>
	<title>goodsList</title>
	<style>
		body {
		    font-family: Arial, sans-serif;
		    margin: 0;
		    padding: 0;
		}
		
		nav {
		    display: flex;
		    justify-content: center;
		    align-items:center;
		    background-color: #ffe4e1;
		    border: 1px solid white;
		}
		nav a {
		    color: black;
		    padding: 14px 20px;
		    text-decoration: none;
		    text-align: center;
		}
		
		nav a:hover {
		    background-color: #ddd;
		}
		
        nav .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
        }

        nav .dropdown-content a {
            color: black;
            padding: 12px 16px;
            display: block;
            text-align: left;
        }

        nav .dropdown-content a:hover {
            background-color: #ddd;
        }

        nav .dropdown:hover .dropdown-content {
            display: block;
        }
        
		
		img {
		    width: 100%;
		    height: 100%;
		}
		
		.products {
		    display: flex;
		    flex-wrap: wrap;
		    justify-content: center;
		    padding: 20px;
		}
		.product {
		    border: 1px solid #ddd;
		    margin: 10px;
		    padding: 10px;
		    width: 200px;
		    text-align: center;
		}
		.product img {
		    width: 100%;
		    height: auto;
		}
		footer {
		    background-color: #ffe4e1;
		    color: black;
		    border: 2px solid white;
		    text-align: center;
		    padding: 10px 0;
		    position: fixed;
		    width: 100%;
		    bottom: 0;
		}
		
		.slider {
		    position: relative;
		    width: 100%;
		    overflow: hidden;
		    height: 300px;
		    background-color: #ffe4e1;
		}
		
		.slides {
		    display: flex;
		    justify-content: center;
		    width: 100%;
		    height: 100%;
		}
		
		.slides a {
		    display: flex;
		    justify-content: center;
		    border: 1px solid white;
		}
		
		.dots {
		    text-align: center;
		    position: absolute;
		    bottom: 10px;
		    width: 100%;
		}
		
		.dot {
		    cursor: pointer;
		    height: 15px;
		    width: 15px;
		    margin: 0 2px;
		    background-color: #bbb;
		    border-radius: 50%;
		    display: inline-block;
		}

	</style>
</head>
<body>
	<!-- 메인메뉴 -->
	
	<!-- 
		<div>
			<img alt="하츄핑" src="/shop/img/hachuping.png" id="mainImg">
		</div>
		<div>
			<div id="emptyDiv">&nbsp;</div>
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<h1>캐치! 티니핑</h1>
		</div>
		<div class="d-flex justify-content-center align-items-center" id="userMenuBar">
			<div id="customerId"><%=loginMember.get("customerId")%> 님 환영합니다.</div>
			<a href="/shop/customer/cart.jsp" id="customerOneAtag" class="ms-3">장바구니 보기(<%=selectOrderCount%>)</a>
			<a href="/shop/customer/orderDetails.jsp" id="customerOneAtag" class="ms-3">주문내역 보기</a>
			<a href="/shop/customer/customerOne.jsp?customerId=<%=loginMember.get("customerId")%>" class="ms-2"id="customerOneAtag">개인정보보기</a>
			<a href="/shop/customer/logoutAction.jsp" class="ms-2"id="logoutAtag">로그아웃</a>
		</div>	
	 -->
	<header>	
		<div class="slider">
	        <div class="slides">
	            <a href="https://www.emotioncastle.com/products/118208055">
	                <img src="/shop/img/firstPic.png" alt="slide1" id="slide1" />
	            </a>
	            <a href="https://www.emotioncastle.com/products/118207999">
	                <img src="/shop/img/secondPic.png" alt="slide2" id="slide2"/>
	            </a>
	        </div>
	        <div class="dots">
	            <span class="dot" id="firstDot" onclick="clickEvent(1)"></span>
	            <span class="dot" id="secondDot" onclick="clickEvent(2)"></span>
	        </div>
         </div>
	</header>
	
	<!-- 서브메뉴 / 카테고리별 상품 리스트-->
	<nav>  
		<a href="/shop/customer/goodsList.jsp">홈</a>
	     <div class="dropdown">
            <a href="/shop/customer/goodsList.jsp?totalRow=<%=goodsTotalCnt%>">상품 목록</a>
            <div class="dropdown-content">
            
            	<!-- 카테고리 종류 가져오기 -->
                <% for(HashMap m : categoryList) { %>
                    <a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>&totalRow=<%=(Integer)(m.get("cnt"))%>">
                        <%=(String)(m.get("category"))%> (<%=(Integer)(m.get("cnt"))%>)
                    </a>
                <% } %>
            </div>
        </div>
	    <a href="#">이벤트</a>
	    <a href="#">고객센터</a>
	    <a href="#">로그인</a>
	
		<!-- 
			<div class="ms-4 d-flex align-items-center">
				<a href="/shop/customer/goodsList.jsp?totalRow=<%=goodsTotalCnt%>" class="listAtags">전체보기</a>
				
				<%
					for(HashMap m : categoryList){
				%>
						<a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>&totalRow=<%=(Integer)(m.get("cnt"))%>" class="listAtags">
							<%=(String)(m.get("category"))%>
							(<%=(Integer)(m.get("cnt"))%>)
						</a>
				<%
					}
				%>
			</div>
			<div>
			</div>		
		 -->
	</nav>
	<div class="ms-5 d-flex justify-content-center" >
		<div class="ms-5 d-flex align-content-start flex-wrap" >
			<%
				if(category == null){
					for(HashMap m3: categoryList3){
			%>
						<div class="mb-3 d-flex flex-column justify-content-center align-items-center" id="contents">
							<div id="imgDiv" class="d-flex justify-content-center">
								<img alt="이미지" src="/shop/upload/<%=(String)(m3.get("filename"))%>">
							</div>
							<div id="contentDiv">
								<div class="borderDiv">번호 : <%=(Integer)(m3.get("no"))%></div>
								<div class="borderDiv">카테고리 : <%=(String)(m3.get("category"))%></div>
								<div class="borderDiv">제목 : <%=(String)(m3.get("title"))%></div>
								<div class="borderDiv">내용 : <%=(String)(m3.get("content"))%></div>
								<div class="borderDiv">가격 : <%=(Integer)(m3.get("price"))%></div>
								<div class="borderDiv">수량 : <%=(Integer)(m3.get("amount"))%></div>
								<div class="mt-2 mb-2 d-flex justify-content-center">
									<a class="me-3 saveGoodsATag" href="/shop/customer/addToCartAction.jsp?no=<%=(Integer)(m3.get("no"))%>">장바구니 추가</a>
									<a class="saveGoodsATag" href="/shop/customer/goodsOne.jsp?no=<%=(Integer)(m3.get("no"))%>">상세보기</a>
								</div>
							</div>
						</div>
			<%		
					}
				}else{
					for(HashMap m2: categoryList2){
					
			%>
						<div class="mb-3 d-flex flex-column justify-content-center align-items-center" id="contents">
							<div id="imgDiv" class="d-flex justify-content-center">
								<img alt="이미지" src="/shop/upload/<%=(String)(m2.get("filename"))%>">
							</div>
							<div id="contentDiv">
								<div class="borderDiv">번호 : <%=(Integer)(m2.get("no"))%></div>
								<div class="borderDiv">카테고리 : <%=(String)(m2.get("category"))%></div>
								<div class="borderDiv">제목 : <%=(String)(m2.get("title"))%></div>
								<div class="borderDiv">내용 : <%=(String)(m2.get("content"))%></div>
								<div class="borderDiv">가격 : <%=(Integer)(m2.get("price"))%></div>
								<div class="borderDiv">수량 : <%=(Integer)(m2.get("amount"))%></div>
								<div class="mt-2 mb-2 d-flex justify-content-center">
									<a class="me-3 saveGoodsATag" href="/shop/customer/addToCartAction.jsp?no=<%=(Integer)(m2.get("no"))%>">장바구니 추가</a>
									<a class="saveGoodsATag" href="/shop/customer/goodsOne.jsp?no=<%=(Integer)(m2.get("no"))%>">상세보기</a>
								</div>
							</div>
						</div>
			<%
					}
				}
			%>
		</div>
	</div>
	<div class="btn-group" role="group" aria-label="Second group" id="btnDiv">
		<button type="button" class="btn btn-light border border-secondary"  >
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
		<button class="btn btn-light border border-secondary" id="currentNum"><%=currentPage%></button>
		<button type="button" class="btn btn-light border border-secondary">
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
	<script src="/shop/js/customerGoodsList.js"></script>
</body>
</html>