<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!--controller layer  -->
<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}

	int no = Integer.parseInt(request.getParameter("no"));
%>

<!-- model layer -->
<%
	// 댓글추가 action 페이지
	
%>

<h1>하이</h1>