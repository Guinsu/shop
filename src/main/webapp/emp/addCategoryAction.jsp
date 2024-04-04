<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>

<!-- controller layer -->
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	String newCategory = request.getParameter("newCategory");
	
	//디버깅
	//System.out.println(newCategory);

%>


<!-- Model layer -->

<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "INSERT INTO category (category, create_date) VALUES (?,NOW());";
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql1);	
	stmt.setString(1,newCategory);
	int row = stmt.executeUpdate();

	if(row > 0){
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else{
		response.sendRedirect("/shop/emp/addCategoryForm.jsp");
	}
	
%>
