<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!-- controller layer-->
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	int no = Integer.parseInt(request.getParameter("no"));
	String category = request.getParameter("category");
	String totalRow = request.getParameter("totalRow");

	
%>

<!--Model layer -->
<%
	int row = GoodsDao.deleteGoodsOne(no, category, totalRow);
	
	if(row > 0) {
	    String mainUrl = "/shop/emp/goodsList.jsp";
	    if(category != null && !category.equals("null")) {
	    	mainUrl += "?category=" + URLEncoder.encode(category, "UTF-8") + "&totalRow=" + totalRow;
	    } else {
	    	mainUrl += "?totalRow=" + totalRow;
	    }
	    response.sendRedirect(mainUrl);
	}
	
	
%>