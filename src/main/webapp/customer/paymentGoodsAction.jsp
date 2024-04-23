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

	String address = request.getParameter("address");
	String payment = request.getParameter("payment");
	String customerId = request.getParameter("customerId");
	String[] orderNo = request.getParameterValues("orderNo");
		

	//디버깅
	//System.out.println(address);
	//System.out.println(payment);
	//System.out.println(customerId);
	/*
	for (String list : orderNo) {
        System.out.println("Received orderNo: " + list);   
    }
	*/
%>

<!-- model layer -->
<%
	//장바구니 제품 결제하기
	int paymentGoods = OrderDao.paymentGoods(address, payment, customerId, orderNo);
	
	if(paymentGoods > 0){		
		response.sendRedirect("/shop/customer/goodsList.jsp");
	}else{
		response.sendRedirect("/shop/customer/cart.jsp");
	}

	
	
%>