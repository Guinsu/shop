<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<!--controller layer  -->
<%
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	String category = request.getParameter("category");
	String modifyCategory = request.getParameter("modifyCategory");
	
%>
<!-- model layer -->
<%

/*



	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql1 = "UPDATE category SET category = ? WHERE category =?;";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql1);
	stmt.setString(1, modifyCategory);
	stmt.setString(2, category);
	int row = stmt.executeUpdate();

	if(row > 0){
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
*/
	
	
%>

