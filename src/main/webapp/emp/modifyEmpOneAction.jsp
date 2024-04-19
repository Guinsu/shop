<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}


	String empId = request.getParameter("empId");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	String empDate = request.getParameter("empDate");
	
	//디버깅
	//System.out.println(empId);
	//System.out.println(empName);
	//System.out.println(empJob);
	//System.out.println(empDate);
	
	
	
%>
