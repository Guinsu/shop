<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
    
<%
	//���� �б� 
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
	<h1>�α��� ������</h1>
	<form action="empLoginAction.jsp" method="post" >
		<div>
			<div class="loginDiv">
				<label>���̵�</label>
				<input type="text" name="empId">
			</div>
			<div class="loginDiv">
				<label>��й�ȣ</label>
				<input type="password" name="empPw">
			</div>
			<button type="submit">�α���</button>
		</div>
	</form>
</body>
</html>