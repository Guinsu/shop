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

	String newCategory = request.getParameter("newCategory");
	
	//디버깅
	//System.out.println(newCategory);

%>


<!-- Model layer -->

<%
	int row = CategorysDao.addCategory(newCategory);

	if(row > 0){
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else{
		response.sendRedirect("/shop/emp/addCategoryForm.jsp");
	}
	
%>
