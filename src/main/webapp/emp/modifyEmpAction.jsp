<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
	String sql2 = null;
	int row = 0;
	
	if(active.equals("OFF")){
	 	sql2 = "UPDATE emp SET active = 'ON' WHERE emp_id= ?";
		//System.out.println("ON 으로 변경 성공");
		
	}else if(active.equals("ON")){
	 	sql2 = "UPDATE emp SET active = 'OFF' WHERE emp_id= ?";
		//System.out.println("OFF 으로 변경 성공");
	}
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null; 
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, empId);
	row = stmt2.executeUpdate();
	
	if(row>0){
		response.sendRedirect("/shop/emp/empList.jsp");		
	}
	
%>