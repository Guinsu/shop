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

	int no = Integer.parseInt(request.getParameter("no"));		
	
	//디버깅
	//System.out.println(no);
%>

<!-- model layer -->
<%
	HashMap<String, Object> selectGoodsOne = GoodsDao.selectGoodsOne(no);
	
	//형변환
	String customerId = (String) loginMember.get("customerId");  
	int price = ((Integer) selectGoodsOne.get("price")).intValue();  
	int amount = ((Integer) selectGoodsOne.get("amount")).intValue();  

	OrderDao.addOrderAction(customerId ,no ,price ,amount);
	response.sendRedirect("/shop/customer/goodsList.jsp");
	
	
%>

