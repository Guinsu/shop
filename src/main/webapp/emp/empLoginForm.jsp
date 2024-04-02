<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
    
<%
	//인증 분기 
	if(session.getAttribute("loginEmp")!= null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
	
	//System.out.println(session.getAttribute("loginEmp"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login page</title>
	<style>
		.loginDiv{
			width: 300px;
		}
	</style>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="empLoginAction.jsp" method="post" >
		<div>
			<div class="loginDiv">
				<label>아이디</label>
				<input type="text" name="empId">
			</div>
			<div class="loginDiv">
				<label>비밀번호</label>
				<input type="password" name="empPw">
			</div>
			<button type="submit">로그인</button>
		</div>
	</form>
</body>
</html>