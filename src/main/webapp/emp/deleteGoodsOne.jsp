<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>

<!-- controller layer-->
<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

%>

<!--Model layer -->
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String category = request.getParameter("category");
	String totalRow = request.getParameter("totalRow");
	
	//디버깅
	//System.out.println(category);
	//System.out.println(totalRow);
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	// goods_no 삭제하기
	String sql1 = "DELETE FROM goods WHERE goods_no =?;";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql1);	
	stmt.setInt(1,no);
	int row =  stmt.executeUpdate();
	
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