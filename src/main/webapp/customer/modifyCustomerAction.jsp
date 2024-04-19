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


	String orginalId = (String)loginMember.get("customerId");
	String changeId = request.getParameter("customerId");
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
	int row = CustomerDao.modifyCustomer(orginalId, changeId ,customerOriginalPw, customerName, customerBirth, customerGender);
	
	if (row > 0){
		session.invalidate(); // 현재 세션 무효화
		session = request.getSession(true);
		
		HashMap<String, Object> loginCustomer = new HashMap<String, Object>();
		loginCustomer.put("customerId", changeId);
		loginCustomer.put("customerName", customerName);
		loginCustomer.put("customerBirth", customerBirth);
		
		session = request.getSession(true); // 새 세션 생성
		session.setAttribute("loginCustomer", loginCustomer); // 새 세션에 데이터 다시 설정
		
		response.sendRedirect("/shop/customer/customerOne.jsp?customerId="+changeId);
		
		//디버깅
		//System.out.println((String)loginMember.get("customerId") + "<-----loginMember");
	}else{
		response.sendRedirect("/shop/customer/goodsList.jsp");	
	}

%>