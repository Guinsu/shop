<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<!--controller layer  -->
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	HashMap<String, Object> sm = (HashMap<String, Object>)session.getAttribute("loginEmp");
%>

<!-- model layer -->
<%
	
	ArrayList<HashMap<String, Object>> categoryList = CategorysDao.selectCateogrys();

	int totalCount = 0;
	
  	if (!categoryList.isEmpty()) {
       Object cntObject = categoryList.get(0).get("cnt");
       if (cntObject != null) {
           totalCount = Integer.parseInt(cntObject.toString()); // String을 int로 변환
       }
    }
  	
  	//디버깅
  	//System.out.println(totalCount);
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
	<title>categoryList page</title>
	<style >
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
			}
		h1{
			font-size: 100px;
		}
		#categoryDiv{
			width: 600px;
		}
		#logoutAtag{
			text-decoration: none;
			color: black;
			height: 40px;
			border: 1px solid black;
			border-radius: 10px;
			padding-right: 20px;
			padding-left: 20px;
		}
		.categoryATag{
			text-decoration: none;
			color: black;
			border: 1px solid black;
			border-radius: 10px;
			padding-right: 10px;
			padding-left: 10px;
		}
	</style>
</head>
<body>
<!-- 메인메뉴 -->
	<header class="m-2 d-flex justify-content-between">
		<div>
			<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		</div>
		<div></div>
		<a href="/shop/emp/empLogoutAction.jsp" class="mt-4" id="logoutAtag">로그아웃</a>
	</header>
	<main class="d-flex justify-content-center  align-items-center flex-column">
		<h1>카테고리 관리</h1>
		<div>
			<%
				if((Integer)sm.get("grade") > 0){
					for(HashMap list : categoryList){
			%>	
						<div class="d-flex justify-content-between" id="categoryDiv">
							<div>
								<div>제목 :<%=(String)list.get("category")%></div>
								<div>작성일 :<%=(String)list.get("createDate")%></div>
							</div>
							<div>
								<a class="categoryATag" href="/shop/emp/modifyCategoryForm.jsp?category=<%=(String)list.get("category")%>">수정</a>
								<a class="categoryATag" href="/shop/emp/deleteCategoryAction.jsp?category=<%=(String)list.get("category")%>&createDate=<%=(String)list.get("createDate")%>">삭제</a>
							</div>
						</div>
						<hr>
						<div class="d-flex justify-content-between" >
							<div>전체 카테고리 합계 : <%=totalCount%> </div>
							<div>
								<a class="categoryATag" href="/shop/emp/addCategoryForm.jsp">카테고리 추가</a>
							</div>
						</div>
			<%
					}
				}
			%>
		</div>
	</main>
</body>
</html>