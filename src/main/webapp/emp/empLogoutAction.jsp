<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
session.invalidate(); // ���� ���ǰ����� �ʱ�ȭ(����)
//System.out.println(session.getId() + "<---- session.invalidate() ȣ�� �� Ȯ���ϱ� ");
response.sendRedirect("/shop/emp/empLoginForm.jsp");

%>