<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<!--controller layer  -->
<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
	
	String customerId = request.getParameter("customerId");
	String customerOriginalPw = request.getParameter("customerOriginalPw");
	String customerChangePw = request.getParameter("customerChangePw");
	String customerName = request.getParameter("customerName");
	String customerBirth = request.getParameter("customerBirth");
	String customerGender = request.getParameter("customerGender");
	
	//디버깅
	//System.out.println(customerId);
	//System.out.println(customerOriginalPw);
	//System.out.println(customerChangePw);
	//System.out.println(customerName);
	//System.out.println(customerBirth);
	//System.out.println(customerGender);
%>

<!-- model layer -->
<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	//기존 비밀번호 확인하기
	String sql = "SELECT pw FROM customer WHERE pw = PASSWORD(?)";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,customerOriginalPw);
	rs = stmt.executeQuery();
	
	
	
	if(rs.next()){
		String sql2 = "UPDATE customer SET email = ?, pw = PASSWORD(?), name = ?, birth = ?, gender = ?, update_date = NOW() WHERE email = ?";
		PreparedStatement stmt2 = null;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1,customerId);
		stmt2.setString(2,customerChangePw);
		stmt2.setString(3,customerName);
		stmt2.setString(4,customerBirth);
		stmt2.setString(5,customerGender);
		stmt2.setString(6,customerId);
		stmt2.executeUpdate();
	}
	
	
	response.sendRedirect("/shop/customer/customerOne.jsp?customerId="+customerId);
%>