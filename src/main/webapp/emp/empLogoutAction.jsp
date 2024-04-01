<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
session.invalidate(); // 기존 세션공간을 초기화(포멧)
//System.out.println(session.getId() + "<---- session.invalidate() 호출 후 확인하기 ");
response.sendRedirect("/shop/emp/empLoginForm.jsp");

%>