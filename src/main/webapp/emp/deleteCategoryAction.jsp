<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!-- controller layer -->
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	String category = request.getParameter("category");
	String createDate = request.getParameter("createDate");
	
	//디버깅
	//System.out.println(category);
	//System.out.println(createDate);

%>
<!-- Model layer -->

<%

	CategorysDao.deleteCategoryOne(category, createDate);
	response.sendRedirect("/shop/emp/categoryList.jsp");
	
%>