<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!-- Controller layer -->
<%
	// 인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	String orderState = request.getParameter("orderState");
	String customerId = request.getParameter("customerId");
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int no = Integer.parseInt(request.getParameter("no"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	//디버깅
	//System.out.println(orderState);
	//System.out.println(customerId);
	//System.out.println(totalAmount);
	//System.out.println(orderNo);
	//System.out.println(no);
	//System.out.println(currentPage);
	
%>

<!-- model layer -->
<%

	//배송진행상태 수정하기
	OrderDao.modifyOrderState(orderNo, customerId, no, totalAmount, orderState);
	response.sendRedirect("/shop/emp/paymentOrderForm.jsp?currentPage="+currentPage);
	
%>

