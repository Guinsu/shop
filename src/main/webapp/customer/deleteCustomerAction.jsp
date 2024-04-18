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

	//디버깅
	//System.out.println(customerId);
	//System.out.println(customerPw);
	
%>

<!-- model layer -->
<%
	int row = CustomerDao.deleteCustomer((String)loginMember.get("customerId"), (String)loginMember.get("customerPw"));	

	if(row > 0){
		session.invalidate();
		response.sendRedirect("/shop/customer/loginForm.jsp");	
	}else{
		response.sendRedirect("/shop/customer/customerOne.jsp?customerId="+loginMember.get("customerId"));	
	}
	
%>