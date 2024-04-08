<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")!= null){
		response.sendRedirect("/shop/customer/goodsList.jsp");
	}

	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	String sql = "SELECT email customerId, pw customerPw FROM customer WHERE email=? AND pw = password(?)";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerId);
	stmt.setString(2, customerPw);
	rs = stmt.executeQuery();

	
	if(rs.next()){
		//로그인 성공시
		//하나의 세션변수안에 여러개의 값을 저장하기 위해서 HashMap타입을 사용
		HashMap<String, Object> loginCustomer = new HashMap<String, Object>();
		loginCustomer.put("customerId",rs.getString("customerId")); //로그인된 id
		loginCustomer.put("customerPw",rs.getString("customerPw")); // 로그인된 name
		
		session.setAttribute("loginCustomer", loginCustomer);
	
		response.sendRedirect("/shop/customer/goodsList.jsp");

		//디버깅 (loginEmp 세션변수)	
		//HashMap<String, Object> m = (HashMap<String, Object>)session.getAttribute("loginCustomer");
		//System.out.println((String) m.get("customerId"));
		//System.out.println((String) m.get("customerPw"));
	}else{
		//로그인 실패시 
		response.sendRedirect("/shop/customer/loginForm.jsp");
	}
	
	
%>    