<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<!-- controller -->
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")!= null){
		response.sendRedirect("/shop/emp/empList.jsp");
	}

	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
%>

<%
	// 2. model
	HashMap<String, Object> loginEmp = EmpDao.empLogin(empId,empPw);  // 이런 방식이 모델 1 방식이다.  model을 분리한다.
	// 모델 2는 컨트롤러를 분리한다.
	
	// 1. controller
	if(loginEmp != null){
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		//로그인 실패시 
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	}
	
%>    
