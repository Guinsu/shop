<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
    
<!-- Controller layer -->
<%
	//인증 분기 
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");

	//디버깅
	//System.out.println(session.getAttribute("loginEmp"));
%>

<!-- model layer -->
<%
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql2 = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active FROM emp WHERE emp_id = ? AND emp_name = ? AND grade = ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null; 
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,(String)loginEmp.get("empId"));
	stmt2.setString(2,(String)loginEmp.get("empName"));
	stmt2.setInt(3,(Integer)loginEmp.get("grade"));
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> empList = new ArrayList<HashMap<String, Object>>();
	
	while(rs2.next()){
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("empId", rs2.getString("empid"));
		list.put("empName", rs2.getString("empName"));
		list.put("empJob", rs2.getString("empJob"));
		list.put("hireDate", rs2.getString("hireDate"));
		list.put("active", rs2.getString("active"));
		empList.add(list);
	}
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
<title>empOne page</title>
	<style>
	
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-size: 30px;
  			font-style: normal;
		}
		main{
			margin-top: 100px;
		}
		form{
			border: 1px solid black;
			border-radius : 20px;
			padding: 100px;
		}
		button{
			width: 200px;
			height: 50px;
			background: white;
			border-radius: 20px;
		}
		input{
			height: 40px;
			border-radius: 10px;
			width: 250px;
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
		
		#formDiv{
			margin-top: 50px;
		}
		#loginBtnDiv{
			margin-top: 70px;
		}
		.loginDiv{
			width: 100%;
		}
	</style>
</head>
<body >
	<main>
		<div class="d-flex justify-content-center">
			<h1>관리자 정보</h1>
		</div>
		<div  class="d-flex justify-content-center" id="formDiv">
			<form action="modifyEmpOneAction.jsp" method="post">
				<div>
				<%
					for(HashMap list : empList){
				%>
					<div class="d-flex justify-content-between loginDiv">
						<label>아이디</label>
						<input type="text" name="empId" value="<%=(String)(list.get("empId"))%>">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDiv">
						<label>이름</label>
						<input type="text" name="empName" value="<%=(String)(list.get("empName"))%>">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDiv">
						<label>부서</label>
						<input type="text" name="empJob" value="<%=(String)(list.get("empJob"))%>">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDiv">
						<label>입사일</label>
						<input type="date" name="empDate" value="<%=(String)(list.get("hireDate"))%>">
					</div>
					<div class="mt-4 d-flex justify-content-between loginDiv">
						<label>권한</label>
						<input type="text" name="empActive" value="<%=(String)(list.get("active"))%>" readonly> 
					</div>
				</div>
				<%
					}
				%>
				<div class="d-flex justify-content-center" id="loginBtnDiv">				
					<button type="submit">수정하기</button>
					<a>탈퇴하기</a>
				</div>
			</form>
		</div>
	</main>
</body>
</html>