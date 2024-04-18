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
	
	String customerId = request.getParameter("customerId");
	String customerOriginalPw = request.getParameter("customerOriginalPw");
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
	int row = CustomerDao.modifyCustomer(customerId, customerOriginalPw, customerName, customerBirth, customerGender);
	
	if (row > 0){
		response.sendRedirect("/shop/customer/customerOne.jsp?customerId="+customerId);		
	}else{
		response.sendRedirect("/shop/customer/goodsList.jsp");	
	}

%>