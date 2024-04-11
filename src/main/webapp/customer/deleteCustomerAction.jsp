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
	
	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");	

	//디버깅
	//System.out.println(customerId);
	//System.out.println(customerPw);
	
%>

<!-- model layer -->
<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	//기존 비밀번호 확인하기
	String sql = "DELETE FROM customer WHERE email =? AND pw = ?";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,(String)loginMember.get("customerId"));
	stmt.setString(2,(String)loginMember.get("customerPw"));
	int row = stmt.executeUpdate();
	
	if(row > 0){
		session.invalidate();
		response.sendRedirect("/shop/customer/loginForm.jsp");	
	}else{
		response.sendRedirect("/shop/customer/customerOne.jsp?customerId="+loginMember.get("customerId"));	
	}
	
%>