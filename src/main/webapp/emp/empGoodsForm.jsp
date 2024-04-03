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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<h1>상품등록</h1>
	<form action="/shop/emp/addGoodsAction.jsp" method="post">
		<div>
			category:
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
		<div>
			goodsTitle:
			<input type="text" name="goodsTitle">
		</div>
		<div>
			goodsPrice:
			<input type="text" name="goodsPrice">
		</div>
		<div>
			goodsAmount:
			<input type="text" name="goodsAmount">
		</div>
		<div>
			goodsContent
			<textarea rows="5" cols="50" name="goodsContent"></textarea>
		</div>
		<div>
			<button type="submit">상품등록</button>
		</div>
	</form>
</body>
</html>



