<%@page import="java.awt.geom.Arc2D.Double"%>
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

	//세션에서 loginMember 가져오기
	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");
	String customerId = String.valueOf(loginMember.get("customerId"));
	
	// 주문번호, 제품번호 받기
	int goodsNo = Integer.parseInt(request.getParameter("no"));
	String orderString = request.getParameter("orderNo");		
	
	//주문번호
	int orderNo = 0;
	
	//별점
	double totalScore = 0;
	
	// 제품을 구매하고 배송완료된 사람만 후기 작성할 수 있게 분기
	if(orderString != null && !orderString.equals("null")){
		orderNo = Integer.parseInt(orderString);
	}
	
	// 선택된 goods의 전체 댓글 수 가져오기 
	int totalRow = CommentDao.commentCount();
	
	if(request.getParameter("totalRow") != null){	
		totalRow = Integer.parseInt(request.getParameter("totalRow"));
	}
	
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보이는 수
	int rowPerPage = 12;
	
	// DB에서 시작 페이지 값 설정 = (현재 페이지-1) *   한 페이지에 보이는 인원수
	int startRow = (currentPage-1)* rowPerPage;
	

	
	// 마지막 페이지 계산하기 = 전체 회원수 / 한 페이지에서 보이는 인원수
	int lastPage = totalRow / rowPerPage;
	
	//인원수가 남을 때 마지막 페이지는 +1 해준다. 
	//예) 회원수가 11명이라면 한 페이지당 10명씩 1페이지가 나와야하는데 1명이 더 있기 때문에 총 페이지는 2페이지가 된다.
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	//디버깅
	//System.out.println(goodsNo);
	//System.out.println(orderString +  "< - orderString");
	//System.out.println(orderNo);
	
%>


<!-- model layer -->
<%
	//카테고리 리스트 가져오기
	ArrayList<HashMap<String, Object>> categoryList = CategorysDao.selectCategoryList();
	
	//모든 굿즈 개수 가져오기
	int goodsTotalCnt = GoodsDao.selectGoodsContent();

	//장바구니에 추가한 개수 가져오기
	int selectOrderCount = OrderDao.selectOrderCount(customerId);
	
	// 선택된 goods 제품 정보 가져오기
	HashMap<String, Object> goodsOne = GoodsDao.selectGoodsOne(goodsNo);

	// 선택된 goods 제품의 댓글 가져오기
	ArrayList<HashMap<String, Object>> list = CommentDao.commentList(goodsNo, startRow, rowPerPage);
	ArrayList<HashMap<String, Object>> comment = CommentDao.commentScoreSum(goodsNo);
	
	
	int sum = (int)comment.get(0).get("sum");
	int cnt = (int)comment.get(0).get("cnt");
		
	totalScore = sum;
	
	
	double averageScore = 0;
	
	if (cnt > 0) {
	    averageScore = totalScore / cnt;
	} 

	//디버깅
	//System.out.println(goodsNo + "< -- goodsNo");
	//System.out.println(orderNo + "< -- orderNo");
	//System.out.println(list + "< -- list");
	//System.out.println(list.size() + "< -- list.size");
	//System.out.println(totalScore + "< -- 선택된 제품 리뷰 합계");
%>


<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta charset="UTF-8">
	<title>goodsOne page</title>
	<link rel="stylesheet" href="/shop/css/customerGoodsOne.css" />
</head>
<body>
	<header >
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
            <div class="dropdown-content">
            
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
		<div id="contents">
			<div>
				<img id="contentImg" alt="이미지" src="/shop/upload/<%=(String)(goodsOne.get("filename"))%>">
			</div>
			<div id="contentDiv">
				<div class="borderDiv">카테고리 : <%=(String)(goodsOne.get("category"))%></div>
				<div class="borderDiv">제목 : <%=(String)(goodsOne.get("title"))%></div>
				<div class="borderDiv">내용 : <%=(String)(goodsOne.get("content"))%></div>
				<div class="borderDiv">가격 : <%=(Integer)(goodsOne.get("price"))%>원</div>
			</div>
		</div>
		<div id="commentDiv">
			<div id="goodsComment">
				<%
					if(list.size() > 0){
						for(HashMap m : list){
				%>
							<div id="customerCmt">
								<div>
									익명 : <%=(String)m.get("content")%>
								</div>
								<div>
									평가점수 : <%=(Integer)m.get("score")%> 점
									&nbsp;&nbsp;&nbsp;
									 <%=(String)m.get("createDate")%> 
									 <%
									 	if(customerId.equals((String)m.get("email"))){
							 		%>
									 <a href="deleteCommentAction.jsp?commentNo=<%=(Integer)m.get("commentNo")%>&orderNo=<%=(Integer)m.get("orderNo")%>&goodsNo=<%=(Integer)m.get("goodsNo")%>&no=<%=goodsNo%>&currentPage=<%=currentPage%>">삭제</a>						 		
							 		<%
									 	}
									 %>
								</div>												
							</div>
							<hr>
				
				<%		
						}
					}else{
				%>
						<h3>후기가 존재하지 않습니다.</h3>
				<%
					}
				%>
			</div>
			<%
				// 제품을 구매하고 배송완료된 사람만 후기 작성할 수 있게 분기
				if(orderNo > 0){
			%>
					<div>
						<form action="/shop/customer/addCommentAction.jsp" method="post">
							<div>
								<input type="hidden" value="<%=orderNo%>" name="orderNo">
								<input type="hidden" value="<%=goodsNo%>" name="goodsNo">
								<span>&nbsp;&nbsp;상품 만족도 평가 : </span>
								<label>
							    	<input type="radio" name="rating" value="1"  class="startRadio"/> 1점
							  	</label>
							  	<label>
							    	<input type="radio" name="rating" value="2" class="startRadio"/> 2점
							  	</label>
							  	<label>
								    <input type="radio" name="rating" value="3" class="startRadio"/> 3점
							  	</label>
							  	<label>
								    <input type="radio" name="rating" value="4" class="startRadio"/> 4점
								  </label>
							  	<label>
								    <input type="radio" name="rating" value="5" class="startRadio"/> 5점
							  	</label>
							</div>
							<input type="text" name="comment">
							<button type="submit">입력</button>
							<button>
								<a href="/shop/customer/goodsList.jsp" id="goBackATag">뒤로가기</a>
							</button>
						</form>
					</div>
			<%
				}else{
			%>
				<div id="buttons">
					<div>
						 평균 별점: <%= String.format("%.1f", averageScore) %> / 5
					    <div class="star-rating">
				        	<% 
						    	for (int i = 1; i <= 5; i++) {
							        if (i <= (int)averageScore) {
							    %>
							        <span class="full">&#9733;</span>
							    <% 
							        } else if (i - averageScore > 0 && i - averageScore < 1) { 
							    %>
							        <span class="half">&#9733;</span>
							    <% 
							        } else { 
							    %>
							        <span>&#9733;</span>
							    <% 
							        }
							    }
						    %>
					    </div>
					</div>
					<div>
						<button type="button">
							<%
								if(currentPage > 1){
							%>
								<a href="/shop/customer/goodsOne.jsp?no=<%=goodsNo%>&currentPage=<%=currentPage -1%>" class="aTags">이전</a>
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
							<%if(currentPage < lastPage ){
							%>
								<a href="/shop/customer/goodsOne.jsp?no=<%=goodsNo%>&currentPage=<%=currentPage +1%>" class="aTags">다음</a>		
							<%
							}else{
							%>
								<a style="color: grey; cursor: not-allowed;" class="aTags">다음</a>
							<%
							}
							%>
						</button>
					</div>
					<div>
						<button >
							<a class="aTags" href="/shop/customer/goodsList.jsp">뒤로가기</a>
						</button>
					</div>
				</div>
			<%
				}
			%>
		</div>
	</main>
	<footer>&copy; 티니핑 쇼핑몰 made by 김인수</footer>
	<script src="/shop/js/goodsSlider.js"></script>
</body>
</html>