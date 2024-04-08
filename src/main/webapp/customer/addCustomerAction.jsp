<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>

<!--controller layer-->
<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")!= null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
		return;
	}

	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String customerBirth = request.getParameter("customerBirth");
	String customerGender = request.getParameter("customerGender");
	
	if(customerGender == "" ){
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
		return;
	}
	
	
	//디버깅
	//System.out.println(customerId);
	//System.out.println(customerPw);
	//System.out.println(customerName);
	//System.out.println(customerBirth);
	//System.out.println(customerGender);

%>

<!-- model layer -->
<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	// goodsList 카테고리와 카테고리 내용들의 합계 가져오기
	String sql1 = "SELECT email FROM customer WHERE email = ? ;";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql1);	
	stmt.setString(1,customerId);
	rs = stmt.executeQuery();
	
	int row = 0;
	boolean checkId = false;
	
	if(rs.next()){
		checkId = true;
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId);
		
		//디버깅
		//System.out.println(checkId + "<---------checkId");
	}else{
		String sql2 = "INSERT INTO customer (email, pw, name, birth, gender, update_date, create_date) VALUES(?,PASSWORD(?),?,?,?, NOW(),NOW());";
		PreparedStatement stmt2 = null;
		stmt2 = conn.prepareStatement(sql2);	
		stmt2.setString(1, customerId);
		stmt2.setString(2, customerPw);
		stmt2.setString(3, customerName);
		stmt2.setString(4, customerBirth);
		stmt2.setString(5, customerGender);
		
		row = stmt2.executeUpdate();
		
		if(row > 0) {
			response.sendRedirect("/shop/customer/loginForm.jsp");
		}else{
			response.sendRedirect("/shop/customer/addCustomerForm.jsp");
		}
		
	}
	
%>