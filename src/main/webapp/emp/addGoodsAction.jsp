<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>    
<!-- Controller layer -->
<%
	request.setCharacterEncoding("UTF-8");

	// 인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
%>  

<!-- Session 설정값 : 입력시 로그인 emp의 emp_id 값이 필요해서 -->
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginEmp");

	//디버깅
	//System.out.println(loginMember.get("empName"));

%>


<!-- Model layer -->

<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "INSERT INTO goods (category, emp_id, goods_title, goods_content, goods_price, goods_amount, update_date, create_date) VALUES (?,?,?,?,?,?,NOW(),NOW());";
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql1);	
	stmt.setString(1,category);
	stmt.setString(2,(String)loginMember.get("empName"));
	stmt.setString(3,goodsTitle);
	stmt.setString(4,goodsContent);
	stmt.setInt(5,goodsPrice);
	stmt.setInt(6,goodsAmount);
	int row = stmt.executeUpdate();

	
%>

<!-- Controller layer -->
<%
	if(row > 0){
	//성공시
		response.sendRedirect("/shop/emp/goodsList.jsp");	
	}

	//실패시
%>