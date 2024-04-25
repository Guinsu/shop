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

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int score = Integer.parseInt(request.getParameter("rating"));
	String content = request.getParameter("comment");
	
	//디버깅
	//System.out.println(orderNo + " < -- orderNo");
	//System.out.println(goodsNo + " < -- goodsNo");
	//System.out.println(comment + " < -- comment");
	//System.out.println(rating + " < -- rating");
	
%>

<!-- model layer -->
<%
	//상품 댓글 및 점수 저장하기
	CommentDao.addCommentAndScore(orderNo, goodsNo, score, content);
	response.sendRedirect("/shop/customer/goodsOne.jsp?no="+goodsNo);
%>

