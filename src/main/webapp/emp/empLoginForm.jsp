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
<title>Insert title here</title>
</head>
<body>
	<h1>�α��� ������</h1>
	<form action="empLoginAction.jsp" method="post" > 
		<label>���̵�</label>
		<input type="text" name="empId">
		<label>��й�ȣ</label>
		<input type="password" name="empPw">
		<button type="submit">�α���</button>
	</form>
</body>
</html>