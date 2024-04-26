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
	
	// 주문번호, 제품번호 받기
	int goodsNo = Integer.parseInt(request.getParameter("no"));
	String orderString = request.getParameter("orderNo");		
	int orderNo = 0;
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
	// 선택된 goods 제품 정보 가져오기
	HashMap<String, Object> goodsOne = GoodsDao.selectGoodsOne(goodsNo);

	// 선택된 goods 제품의 댓글 가져오기
	ArrayList<HashMap<String, Object>> list = CommentDao.commentList(goodsNo, startRow, rowPerPage);

	ArrayList<HashMap<String, Object>> comment = CommentDao.commentScoreSum(goodsNo);
	
	
	int sum = (int)comment.get(0).get("sum");
	int cnt = (int)comment.get(0).get("cnt");
		
	totalScore = sum;
	
	
	double averageScore =  totalScore / cnt;
	
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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
		
	<meta charset="UTF-8">
	<title>goodsOne page</title>
	<style>
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
  			background-color: #FCE4EC;
			}
		img{
			width: 450px;
			height: 400px;
		}
		a{
			text-decoration: none;
			color:black;
		}
		h1{
			font-size: 100px;
			margin-left: 50px;
		}
		
		button{
			width: 200px;
			height: 100%;
		}
		header{
			border-bottom: 1px solid black
		}
		
		input{
			width: 500px;
		}
		
		label{
			width: 70px;
		}
		
		hr{
			border: 3px solid white;
			margin: 0px;
		}
		
		.borderDiv{
			border-bottom: 1px solid white;
		}
		
		.aTags{
			color: black;
			font-size: 25px;
			padding-left: 60px;
			padding-right: 60px;
		}
		
		#contentDiv{
			width: 600px;
			max-height: 600px;
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
		
		#contents{
			border: 3px solid white;
			border-radius: 10px;
			margin-right: 10px;
			margin-left: 10px;
		}
		
		#commentDiv{
			width: 100%;
			display: flex;
			flex-direction: column;
			margin-right: 10px;
		}
		
		#goodsComment{
			height: 100%;
			max-height:100%;
			border: 3px solid white;
			border-radius: 10px;
		}
		
		#goBackATag{
			padding-left: 50px;
			padding-right: 50px;
		}
		
		#customerCmt{
			display: flex;
			justify-content: space-between;
		}
		
		.startRadio{
			width: 30px;
		}
		
		.star-rating span {
		    font-size: 40px;
		    position: relative;
		    display: inline-block;
		    color: white;
		}
		
		.star-rating span.full, .star-rating span.half:before {
		    color: black; 
		}
		
		.star-rating span.half:before {
		    content: '★';
		    position: absolute;
		    left: 0;
		    width: 50%; 
		    overflow: hidden;
		}
		
	</style>
</head>
<body>
	<header class="m-2 d-flex justify-content-between">
		<div>
			<img alt="하츄핑" src="/shop/img/hachuping.png" id="mainImg">
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<h1>캐치! 티니핑</h1>
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<div id="customerId"><%=loginMember.get("customerId")%> 님 환영합니다.</div>
			<a href="/shop/customer/cart.jsp" id="customerOneAtag" class="ms-3">장바구니 보기</a>
			<a href="/shop/customer/customerOne.jsp?customerId=<%=loginMember.get("customerId")%>" class="ms-2"id="customerOneAtag">개인정보보기</a>
			<a href="/shop/customer/logoutAction.jsp" class="ms-2"id="logoutAtag">로그아웃</a>
		</div>
	</header>
	<main class="d-flex">
		<div class="ms-3 d-flex flex-column justify-content-center align-items-center" id="contents">
			<div id="imgDiv" class="d-flex justify-content-center">
				<img alt="이미지" src="/shop/upload/<%=(String)(goodsOne.get("filename"))%>">
			</div>
			<div id="contentDiv">
				<div class="borderDiv">번호 : <%=(Integer)(goodsOne.get("no"))%></div>
				<div class="borderDiv">카테고리 : <%=(String)(goodsOne.get("category"))%></div>
				<div class="borderDiv">제목 : <%=(String)(goodsOne.get("title"))%></div>
				<div class="borderDiv">내용 : <%=(String)(goodsOne.get("content"))%></div>
				<div class="borderDiv">가격 : <%=(Integer)(goodsOne.get("price"))%></div>
				<div class="borderDiv">수량 : <%=(Integer)(goodsOne.get("amount"))%></div>
				<div>생성 날짜 : <%=(String)(goodsOne.get("createDate"))%></div>
			</div>
		</div>
		<div id="commentDiv">
			<div id="goodsComment">
				<%
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
								 <a>수정</a>
								 <a>삭제</a>
							</div>												
						</div>
						<hr>
				<%
					}
				%>
			</div>
			<%
				// 제품을 구매하고 배송완료된 사람만 후기 작성할 수 있게 분기
				if(orderNo > 0){
			%>
					<div style="background-color:yellow;">
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
					<div  class="d-flex justify-content-between">
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
						<div class="mt-4 d-flex justify-content-center btn-group" role="group" aria-label="Basic example">
							<button type="button" class="btn btn-light border border-secondary"  >
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
							<button class="btn btn-light border border-secondary" id="currentNum"><%=currentPage%></button>
							<button type="button" class="btn btn-light border border-secondary">
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
						<div class="mt-3">
							<button class="btn btn-light border border-secondary">
								<a class="aTags" href="/shop/customer/goodsList.jsp">뒤로가기</a>
							</button>
						</div>
					</div>
			<%
				}
			%>
		</div>
	</main>
</body>
</html>