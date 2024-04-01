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
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="empLoginAction.jsp" method="post" > 
		<label>아이디</label>
		<input type="text" name="empId">
		<label>비밀번호</label>
		<input type="password" name="empPw">
		<button type="submit">로그인</button>
	</form>
</body>
</html>