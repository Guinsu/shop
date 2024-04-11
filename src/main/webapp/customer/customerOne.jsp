<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<!--controller layer  -->
<%
	//인증 분기  
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}

	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginCustomer");

	String customerId = request.getParameter("customerId");
%>

<!-- model layer -->
<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "SELECT email, name, birth, gender FROM customer WHERE email = ?";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,customerId);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> customerList =  new ArrayList<HashMap<String, Object>>();
	
	if(rs.next()){
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("email", rs.getString("email"));
		list.put("name", rs.getString("name"));
		list.put("birth", rs.getString("birth"));
		list.put("gender", rs.getString("gender"));
		customerList.add(list);
	}
	
	//디버깅
	//System.out.println(customerId);
%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
<meta charset="EUC-KR">
<title>customerOne page</title>
	<style>
	
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
		}
		main{
			margin-top: 50px;
		}
		form{
			border: 1px solid black;
			border-radius : 20px;
			padding: 60px;
			width: 500px;
		}
		button{
			width: 200px;
			height: 50px;
			background: white;
			border-radius: 20px;
		}
		a{
			text-decoration: none;
			color: black;
			width: 200px;
			height: 50px;
			background: white;
			border: 2px solid black;
			border-radius: 20px;
			text-align: center;
		}
		input{
			height: 40px;
			border-radius: 10px;
			width: 250px;
		}
		select{
			width: 250px;
		}
		
		#formDiv{
			margin-top: 25px;
		}
		#loginBtnDiv{
			margin-top: 70px;
		}
		.loginDivTags{
			width: 100%;
		}
	</style>
</head>
<body >
	<main>
		<div class="d-flex justify-content-center">
			<h1>개인정보</h1>
		</div>
		<div  class="d-flex justify-content-center" id="formDiv">
			<form action="/shop/customer/modifyCustomerAction.jsp" method="post">
				<div>
					<%
						for(HashMap list : customerList){
					%>
					<div class="d-flex justify-content-between loginDivTags">
						<label>아이디</label>
						<input type="text" name="customerId" value="<%=(String)(list.get("email"))%>">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDivTags">
						<label>비밀번호</label>
						<input type="password" name="customerOriginalPw"  placeholder="비밀번호를 입력해주세요.">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDivTags">
						<label>변경 비밀번호</label>
						<input type="password" name="customerChangePw" placeholder="새로운 비밀번호를 입력해주세요.">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDivTags">
						<label>이름</label>
						<input type="text" name="customerName" value="<%=(String)(list.get("name"))%>">
					</div>
					<div class="mt-4 d-flex justify-content-between  loginDivTags">
						<label>생년월일</label>
						<input type="date" name="customerBirth" value="<%=(String)(list.get("birth"))%>">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDivTags">
						<label>성별</label>
						<select name="customerGender">
							<option value="" >성별을 선택해 주세요.</option>
						<%
							if((list.get("gender")).equals("남")){	
						%>
							<option value="남" selected>남</option>
							<option value="여">여</option>						
						<%
							}else{
						%>
							<option value="남" >남</option>
							<option value="여" selected>여</option>	
						<% 	
							}
						%>
						</select>
					</div >
					<%
						}
					%>
				</div>
				<div class="d-flex justify-content-center" id="loginBtnDiv">				
					<button type="submit">수정하기</button>
					<a href="/shop/customer/deleteCustomerAction.jsp">회원탈퇴</a>
				</div>
			</form>
		</div>
	</main>
</body>
</html>