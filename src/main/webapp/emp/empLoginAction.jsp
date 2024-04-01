<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>



<%
	//인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	String sql = "SELECT emp_id empId FROM emp WHERE active='ON' AND emp_id=? AND emp_pw = password(?)";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	rs = stmt.executeQuery();
	

	if(rs.next()){
		//로그인 성공시
		session.setAttribute("loginEmp", rs.getString("empId"));
		System.out.println(session.getAttribute("loginEmp"));
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		//로그인 실패시 
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	}
	
	
%>    
