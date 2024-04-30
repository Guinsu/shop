<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!--controller layer-->
<%
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int no = Integer.parseInt(request.getParameter("no"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));

	//디버깅
	//System.out.println(commentNo);
	//System.out.println(orderNo);
	//System.out.println(goodsNo);
	
%>

<!-- model layer -->
<%
	int row = CommentDao.deleteComment(commentNo, orderNo, goodsNo);
	
	if(row > 0){
		response.sendRedirect("/shop/customer/goodsOne.jsp?no="+no+"&currentPage="+currentPage);
	}
%>
