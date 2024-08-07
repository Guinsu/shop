<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
//controller layer

	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	// session에서 로그인한 emp 정보 가져오기
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	
	//로그인한 괸리자 이름 가져오기
	String empName = (String)loginEmp.get("empName");
	
	//로그인한 괸리자 아이디 가져오기
	String empId = (String)loginEmp.get("empId");
	
	//로그인한 괸리자 아이디 가져오기
	String empActive = (String)loginEmp.get("active");
		
	
	//디버깅
	//System.out.println(empName);
	//System.out.println(empId);
	System.out.println(empActive);
	
	
	//카테고리 가져오기
	String category = request.getParameter("category");
	
	
	int totalRow = 0;
	
	if(request.getParameter("totalRow") != null){	
		totalRow = Integer.parseInt(request.getParameter("totalRow"));
	}
	
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보이는 수
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
	//카테고리 리스트 가져오기
	ArrayList<HashMap<String, Object>> categoryList = CategorysDao.selectCategoryList();

	//굿즈 리스트 가져오기
	ArrayList<HashMap<String, Object>> categoryList2 = GoodsDao.selectGoodsList(category, startRow, rowPerPage);

	//굿즈 정보 가져오기
	ArrayList<HashMap<String, Object>> categoryList3 = GoodsDao.selectGoodsContent(startRow, rowPerPage);
	
	//모든 굿즈의 개수 가져오기
	int goodsTotalCnt = GoodsDao.selectGoodsContent();
	
	//디버깅
	//System.out.println("categoryList : " + categoryList);
	//System.out.println("categoryList2 : " + categoryList2);
	//System.out.println("categoryList3 : " + categoryList3);
	
%>

<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="/shop/upload/hachuping.png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<meta charset="UTF-8">
	<title>goodsList page</title>
	<style>
		
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 20px;
  			font-style: normal;
  			background-color: #FCE4EC;
			}
		img{
			margin-top: 5px;
			width: 250px;
			height: 250px;
		}
		a{
			text-decoration: none;
		}
		
		button{
			width: 200px;
		}
		nav{
			border-top: 3px solid white;
			border-bottom: 3px solid white;
			padding-top: 10px;
			padding-bottom: 10px; 
		}
		
		.borderDiv{
			border-bottom: 1px solid black;
		}
		.listAtags{
			font-size: 25px; 
			margin-right: 20px;
			color: black;
			border: 1px solid black;
			border-radius: 10px;
			padding-right : 10px;
			padding-left: 10px;
		}
		.aTags{
			color: black;
			font-size: 25px;
			padding-left: 60px;
			padding-right: 60px;
		}
		.listATag{
			text-decoration: none;
			color: black;
			font-size: 30px;
			border: 1px solid black;
			border-radius: 10px;
			padding: 3px;
			margin-right: 10px;
		}
		#contents{
			border: 3px solid white;
			border-radius: 10px;
			margin-right: 10px;
			margin-left: 10px;
		}
		#imgDiv{
			width: 100%;
			
		}
		#contentDiv{
			width: 400px;
			height: 250px;
			max-height: 600px;
		}
		#btnDiv{
			margin-top:20px;
			margin-left:25%;
			width: 50%;
		}
		#currentNum{
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
		#empMenu{
			margin-left: 0px;
		}
		
	</style>
</head>
<body>
	<!-- 메인메뉴 -->
	<header class="m-2 d-flex justify-content-between">
		<div id="empMenu">
			<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		</div>
		<div></div>
		<a href="/shop/emp/empLogoutAction.jsp" class="mt-4" id="logoutAtag">로그아웃</a>
	</header>
	
	<!-- 서브메뉴 / 카테고리별 상품 리스트-->
	<nav class="m-4 d-flex justify-content-between">
		<div class="ms-4 d-flex align-items-center">
			
			<a href="/shop/emp/goodsList.jsp?totalRow=<%=goodsTotalCnt%>" class="listAtags">전체</a>
			
			<%
				for(HashMap m : categoryList){
			%>
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>&totalRow=<%=(Integer)(m.get("cnt"))%>" class="listAtags">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
				</a>
			<%
				}
			%>
		</div>
		<div></div>
		<div class="d-flex align-items-center">
			<%
				if(empActive.equals("ON")){
			%>
				<a href="/shop/emp/empGoodsForm.jsp" class="listAtags">상품등록</a>			
			<%
				}
			%>
			<a href="/shop/emp/paymentOrderForm.jsp" class="listAtags">상품배송정보</a>
		</div>
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
						<div>생성 날짜 : <%=(String)(m3.get("createDate"))%></div>
					</div>
					<div class="mb-2">
						<% 
							if(empName.equals((String)m3.get("empName")) || empId.equals("admin")){	
						%>
							<a href="deleteGoodsOne.jsp?no=<%=(Integer)(m3.get("no"))%>&category=<%=category%>&totalRow=<%=totalRow%>" class="listATag">삭제</a>						
						<%
							}
						%>
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
						<div>생성 날짜 : <%=(String)(m2.get("createDate"))%></div>
					</div>
					<div class="mb-2">
						<% 
							if(empName.equals((String)m2.get("empName")) || empId.equals("admin")){	
						%>
							<a href="deleteGoodsOne.jsp?no=<%=(Integer)(m2.get("no"))%>&category=<%=category%>&totalRow=<%=totalRow%>" class="listATag">삭제</a>
						<%
							}
						%>
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
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage -1%>&totalRow=<%=totalRow%>" class="aTags">이전</a>
			<% 
					}else{
			%>
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage -1%>&category=<%=category %>&totalRow=<%=totalRow%>" class="aTags">이전</a>
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
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage +1%>&totalRow=<%=totalRow%>" class="aTags">다음</a>
			<%
				}else{
			%>
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage +1%>&category=<%=category %>&totalRow=<%=totalRow%>" class="aTags">다음</a>		
			
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
</body>
</html>