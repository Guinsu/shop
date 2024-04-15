<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %> 
<%@ page import="shop.dao.*" %>   
<%
	String active = request.getParameter("active");
	String empId = request.getParameter("empId");
	
	//디버깅
	//System.out.println(active);
	//System.out.println(empId);
	
	EmpDao.modifyEmpAction(empId, active);
	
	response.sendRedirect("/shop/emp/empList.jsp");		
	
%>