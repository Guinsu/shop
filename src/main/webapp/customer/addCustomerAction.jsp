<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
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
	boolean checkId = CustomerDao.addCustomerIdCheck(customerId);
	
	//디버깅
	//System.out.println(checkId + "<---------checkId");
	
	if(checkId == true){

		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId);
		//디버깅
		
	}
		
	int row = CustomerDao.addCustomer(customerId, customerPw, customerName, customerBirth, customerGender);
	
	if(row > 0) {
		response.sendRedirect("/shop/customer/loginForm.jsp");
	}else{
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
		
	
%>