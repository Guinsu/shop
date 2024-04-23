<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
	
	String searchWord = "";
	
	//현재 페이지 값 
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 전체 회원수 가져오기
	int totalRow = EmpDao.empCount(searchWord);
	
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
	
	ArrayList<HashMap<String, Object>> list = EmpDao.empList(searchWord, startRow, rowPerPage);
	
%>    



<!-- View layer : 모델 ArrayList<HashMap<String, Object>> 출력 -->
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<meta charset="UTF-8">
	<style>
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 25px;
  			font-style: normal;
		}
		a{
			text-decoration: none;
			font-size: 30px;
			color: black;
		}
		h1{
			font-size: 70px;
			margin-right: 350px;
		}
		button{
			height: 50px;
		}
		input{
			width: 500px;
			height: 40px;
		}
		
		#currentNum{
			font-size: 30px;
			color: black;
		}
		#logoutAtag{
			height: 40px;
			border: 1px solid black;
			border-radius: 10px;
			padding-right: 20px;
			padding-left: 20px;
		}
		#searchBtn{
			width: 60px;
			height: 40px;
		}
		.aTags{
			padding-left: 200px;
			padding-right: 200px;
		}
	</style>
	<title>empList page</title>
	
</head>
<body>
	<header class="m-2 d-flex justify-content-between">
		<div>
			<!-- empMenu.jsp include : 주체(서버) vs redirect 주체(클라언트) -->
			<!-- 주체가 서버이기 때문에 include할때는 절대 주소가 /shop/...시작하지 않는다. -->
			<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		</div>
		<h1>직원 리스트</h1>
		<a href="/shop/emp/empLogoutAction.jsp" class="mt-4" id="logoutAtag">로그아웃</a>
	</header>
	<main>
		<table border="1"  class="table table-hover">
			<tr>
				<th>empId</th>
				<th>empName</th>
				<th>empJob</th>
				<th>hireDate</th>
				<th>active</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list){
			%>
				<tr>
					<%
						HashMap<String, Object> sm = (HashMap<String, Object>)session.getAttribute("loginEmp"); 
						if((Integer)sm.get("grade") > 0){
					%>
					<td><%=(String)(m.get("empId"))%></td>
					<td><%=(String)(m.get("empName"))%></td>
					<td><%=(String)(m.get("empJob"))%></td>
					<td><%=(String)(m.get("hireDate"))%></td>
					<td>
						<a href="modifyEmpAction.jsp?active=<%=(String)(m.get("active"))%>&empId=<%=(String)(m.get("empId"))%>">
							<%=(String)(m.get("active"))%>
						</a>
					</td>
					
					<%	
						}
					%>
				</tr>
			<%
				}
			%>
		</table>
		<div class="d-flex justify-content-center btn-group" role="group" aria-label="Basic example">
			<button type="button" class="btn btn-light border border-secondary"  >
				<%
					if(currentPage > 1){
				%>
					<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage -1%>" class="aTags">이전</a>
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
					<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage +1%>" class="aTags">다음</a>		
				<%
				}else{
				%>
					<a style="color: grey; cursor: not-allowed;" class="aTags">다음</a>
				<%
				}
				%>
			</button>
		</div>
	</main>
	<footer>
		<div  class="m-4 d-flex justify-content-center">
			<form action="/shop/emp/empList.jsp">
				<label>
					이름으로 검색 : 
				</label>
				<input type="text" name="searchWord">
				<button type="submit" id="searchBtn">확인</button>			
			</form>
		</div>
	</footer>
</body>
</html>