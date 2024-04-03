<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%
//controller layer

	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
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
	int rowPerPage = 20;
	
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
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "SELECT category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category ASC;";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql1);	
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList =  new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs.getString("category"));
		m.put("cnt", rs.getInt("cnt"));
		categoryList.add(m);
	}
	
	//디버깅
	//System.out.println(categoryList);
	//System.out.println(totalRow);
	
	
	String sql2 = "SELECT goods_no no, category, goods_title title, left(goods_content,500) content, goods_price price, goods_amount amount, create_date createDate  FROM goods WHERE category = ? ORDER BY goods_no DESC limit ?,?;";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null; 
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, category);
	stmt2.setInt(2,startRow);
	stmt2.setInt(3,rowPerPage);
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList2 =  new ArrayList<HashMap<String, Object>>();
	
	while(rs2.next()){
		HashMap<String, Object> m2 = new HashMap<String, Object>();
		m2.put("no", rs2.getInt("no"));
		m2.put("category", rs2.getString("category"));
		m2.put("title", rs2.getString("title"));
		m2.put("content", rs2.getString("content"));
		m2.put("price", rs2.getInt("price"));
		m2.put("amount", rs2.getInt("amount"));
		m2.put("createDate", rs2.getString("createDate"));
		categoryList2.add(m2);
	}
	
	String sql3 = "SELECT goods_no no, category, goods_title title, left(goods_content,500) content, goods_price price, goods_amount amount, create_date createDate, (SELECT COUNT(*) FROM goods) AS cnt FROM goods ORDER BY goods_no DESC;";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null; 
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList3 =  new ArrayList<HashMap<String, Object>>();
	
	while(rs3.next()){
		HashMap<String, Object> m3 = new HashMap<String, Object>();
		m3.put("no", rs3.getInt("no"));
		m3.put("category", rs3.getString("category"));
		m3.put("title", rs3.getString("title"));
		m3.put("content", rs3.getString("content"));
		m3.put("price", rs3.getInt("price"));
		m3.put("amount", rs3.getInt("amount"));
		m3.put("createDate", rs3.getString("createDate"));
		m3.put("cnt", rs3.getInt("cnt"));
		categoryList3.add(m3);
	}
	
%>

<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<meta charset="UTF-8">
	<title>goodsList</title>
	<style>
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 20px;
  			font-style: normal;
			}
		img{
			margin-top: 5px;
			width: 200px;
			height: 100px;
		}
		a{
			text-decoration: none;
		}
		div{
			margin-right: 10px;
			margin-left: 10px;
		}
		button{
			width: 200px;
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
		#contents{
			border: 1px solid #c4c8cb;
			border-radius: 10px;
		}
		#imgDiv{
			width: 100%;
			
		}
		#contentDiv{
			width: 400px;
			height: 500px;
			max-height: 600px;
			
		}
		#btnDiv{
			padding-right: 100px;
		}
		#currentNum{
			font-size: 30px;
		}
	</style>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<!-- 서브메뉴 / 카테고리별 상품 리스트-->
	<div class="m-4 d-flex justify-content-between">
		<div class="ms-4 d-flex align-items-center">
			
			<a href="/shop/emp/goodsList.jsp" class="listAtags">전체</a>
			
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
		<div class="btn-group me-2" role="group" aria-label="Second group" id="btnDiv">
			<button type="button" class="btn btn-light border border-secondary"  >
				<%
					if(currentPage > 1){
				%>
					<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage -1%>&category=<%=category %>&totalRow=<%=totalRow%>" class="aTags">이전</a>
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
					<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage +1%>&category=<%=category %>&totalRow=<%=totalRow%>" class="aTags">다음</a>		
				<%
				}else{
				%>
					<a style="color: grey; cursor: not-allowed;" class="aTags">다음</a>
				<%
				}
				%>
			</button>
		</div>
		<div class="d-flex align-items-center">
			<a href="/shop/emp/addGoods.jsp" class="listAtags">상품등록</a>
		</div>
	</div>
	<div class="ms-5 d-flex justify-content-center" >
		<div class="d-flex align-content-start flex-wrap" >
			<%
				if(category == null){
					for(HashMap m3: categoryList3){
			%>
				<div class="mb-3 d-flex flex-column justify-content-center align-items-center" id="contents">
					<div id="imgDiv" class="d-flex justify-content-center">
						<img alt="이미지" src="/shop/emp/img.jpg">
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
				</div>
			
			
			<%		
					}
				}else{
					for(HashMap m2: categoryList2){
					
			%>
				<div class="mb-3 d-flex flex-column justify-content-center align-items-center" id="contents">
					<div id="imgDiv" class="d-flex justify-content-center">
						<img alt="이미지" src="/shop/emp/img.jpg">
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
				</div>
			<%
					}
				}
			%>
		</div>
	</div>
</body>
</html>