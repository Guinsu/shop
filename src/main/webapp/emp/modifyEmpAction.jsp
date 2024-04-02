<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>    
<%
	String active = request.getParameter("active");
	String empId = request.getParameter("empId");
	
	//디버깅
	//System.out.println(active);
	//System.out.println(empId);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	int row = 0;
	
	if(active.equals("OFF")){
		String sql2 = "UPDATE emp SET active = ? WHERE emp_id= ?";
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null; 
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, "ON");
		stmt2.setString(2, empId);
		row = stmt2.executeUpdate();
		System.out.println("하이");
		
	}else if(active.equals("ON")){
		String sql2 = "UPDATE emp SET active = ? WHERE emp_id= ?";
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null; 
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, "OFF");
		stmt2.setString(2, empId);
		row = stmt2.executeUpdate();
		System.out.println("이하");
	}
	
	if(row>0){
		response.sendRedirect("/shop/emp/empList.jsp");		
	}
	
	
	
%>