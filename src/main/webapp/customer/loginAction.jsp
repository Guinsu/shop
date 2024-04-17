<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")!= null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
	}

	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	HashMap<String, Object> loginCustomer = CustomerDao.customerLogin(customerId, customerPw);
	
	
	if(loginCustomer != null){
		session.setAttribute("loginCustomer", loginCustomer);
		response.sendRedirect("/shop/customer/goodsList.jsp");
		
	}else{
		//로그인 실패시 
		response.sendRedirect("/shop/customer/loginForm.jsp");
	}
	
%>    