<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<!--controller layer  -->
<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}

	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");

	String customerId = request.getParameter("customerId");
	String customerOriginalPw = request.getParameter("customerOriginalPw");
	String customerChangePw = request.getParameter("customerChangePw");
%>

<!-- model layer -->
<%
	
	int row = CustomerDao.modifyCustomerPw(customerOriginalPw, customerChangePw, customerId);
	
	if(row > 0){
		response.sendRedirect("/shop/customer/goodsList.jsp?customerId="+customerId);
	}else{
		response.sendRedirect("/shop/customer/modifyCustomerPwForm.jsp?customerId="+customerId);
	}
	//디버깅
	//System.out.println(customerId);
%>