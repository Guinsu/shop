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
	
	int no = Integer.parseInt(request.getParameter("no"));
%>


<!-- model layer -->
<%

	HashMap<String, Object> goodsOne = GoodsDao.selectGoodsOne(no);
	//디버깅
	//System.out.println(no);
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
			width: 800px;
		}
		
		.borderDiv{
			border-bottom: 1px solid white;
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
			display: flex;
			flex-grow: 1;
			background-color: red;
		}
		#goBackATag{
			padding-left: 50px;
			padding-right: 50px;
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
			<a href="/shop/customer/orderGoodsForm.jsp" id="customerOneAtag" class="ms-3">장바구니 보기</a>
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
			<div id="goodsComment">다른분들 후기는 여기
			<%
				for(int i=0; i<5; i++){
			%>
			
			<%
				}
			%>
			</div>
			<div style="background-color:yellow;">
				후기 남기기 / order 테이블에서 state 상태가 배송완료면 보이게 하기
				<form action="/shop/customer/addCommentAction.jsp?no=<%=no%>" method="post">
					<input type="text" name="comment">
					<button type="submit">입력</button>
					<button>
						<a href="/shop/customer/goodsList.jsp" id="goBackATag">뒤로가기</a>
					</button>
				</form>
			</div>
		</div>
	</main>
</body>
</html>