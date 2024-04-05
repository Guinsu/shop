<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>

<!-- Controller layer -->
<%
	// 인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
%>    

<!-- model layer -->
<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "SELECT category FROM category;";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql1);	
	rs = stmt.executeQuery();
	
	ArrayList<String> categoryList =  new ArrayList<String>();
	
	while(rs.next()){
		categoryList.add(rs.getString("category"));
		
	}
	
	//디버깅
	//System.out.println(categoryList);
	
	
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
	<title>empGoodsForm</title>
	<style>
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
		input{
			width: 500px;
			border-radius: 10px;
		}
		select{
			width: 500px;
			border-radius: 10px;
		}
		textarea {
			width: 500px;
			border-radius: 10px;
		}
		button{
			margin-top: 40px;
			width: 400px;
			border-radius: 20px;
		}
		#goodsForm{
			width: 700px;
		}
		#goodsContentLabel{
			padding-top: 80px;
		}
	</style>
</head>
<body>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<main class="d-flex justify-content-center  align-items-center flex-column">
		<h1>상품등록</h1>
		<form action="/shop/emp/addGoodsAction.jsp" method="post" class="mt-5" id="goodsForm" enctype="multipart/form-data">
			<div class="d-flex justify-content-between">
				category :
				<select name="category">
					<option value="">선택</option>
					<%
						for(String c : categoryList){
					%>
						<option value="<%=c%>"><%=c%></option>
					<%	
						}
					%>
				</select>
			</div>
			
			<!-- emp_id 값은 action쪽에서 세션변수에서 바인딩-->
			<div class="mt-2 d-flex justify-content-between">
				goodsTitle :
				<input type="text" name="goodsTitle">
			</div>
			<div class="mt-2 d-flex justify-content-between">
				goodsImg :
				<input type="file" name="goodsImg">
			</div>
			<div class="mt-2 d-flex justify-content-between">
				goodsPrice :
				<input type="text" name="goodsPrice">
			</div>
			<div class="mt-2 d-flex justify-content-between">
				goodsAmount :
				<input type="text" name="goodsAmount">
			</div>
			<div class="mt-2 d-flex justify-content-between">
				<label id="goodsContentLabel">
					goodsContent :
				</label>
				<textarea rows="5" cols="50" name="goodsContent"></textarea>
			</div>
			<div class="mt-2 d-flex justify-content-center">
				<button type="submit">상품등록</button>
			</div>
		</form>
	</main>
</body>
</html>



