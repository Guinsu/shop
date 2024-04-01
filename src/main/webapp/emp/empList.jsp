<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	// 인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "SELECT emp_name empName, emp_job empJob, create_date createDate FROM emp WHERE active='OFF'";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);	
	rs = stmt.executeQuery();

	
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		while(rs.next()){
	%>
		<div><%=rs.getString("empName") %></div>
		<div><%=rs.getString("empJob") %></div>
		<div><%=rs.getString("createDate") %></div>
	
	<%	
		}
	%>
	
	<a href="/shop/emp/empLogoutAction.jsp">로그아웃</a>
</body>
</html>