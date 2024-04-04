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

	String category = request.getParameter("category");
	String createDate = request.getParameter("createDate");
	
	//디버깅
	//System.out.println(category);
	//System.out.println(createDate);

%>
<!-- Model layer -->

<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "DELETE FROM category WHERE category = ? AND create_date = ?";
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql1);	
	stmt.setString(1,category);
	stmt.setString(2,createDate);
	int row = stmt.executeUpdate();

	
	response.sendRedirect("/shop/emp/categoryList.jsp");
	
%>