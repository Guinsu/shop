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

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
		

	//디버깅
	//System.out.println(orderNo);
	//System.out.println(goodsNo);
	
%>

<!-- model layer -->
<%
	//장바구니 제품 취소하기
	OrderDao.deleteOrders(orderNo, goodsNo);
	response.sendRedirect("/shop/customer/cart.jsp");
	
	
%>
