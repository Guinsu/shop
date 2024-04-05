<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%

	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginEmp");

	//디버깅
	//System.out.println(loginMember.get("empName"));
%>


<style>
	.menuATags{
		text-decoration: none;
		margin-left: 20px;
		padding-right : 10px;
		padding-left: 10px;
		font-size: 30px;
		border: 1px solid black;
		border-radius: 10px;
		color: black;
	}
	.menuEmpName{
		padding-right : 10px;
		padding-left: 10px;
		text-decoration: none;
		margin-left: 20px;
		font-size: 30px;
		color: black;
	}
	#menuDiv{
		display: flex;
		justify-content: space-between;
		margin-top: 10px;
		margin-right: 0px;
	}
	
	span{
		font-size: 20px;
	}
</style>

<div id="menuDiv">
	<div>
		<a href="/shop/emp/empList.jsp" class="menuATags">사원관리</a>
		<!-- category CRUD -->
		<a href="/shop/emp/categoryList.jsp" class="menuATags">카테고리관리</a>
		<a href="/shop/emp/goodsList.jsp" class="menuATags">상품관리</a>
	</div>
	<span>
		<a href="/shop/emp/empOne.jsp" class="menuEmpName">
			<%=loginMember.get("empName")%>님
		</a>반갑습니다.
	</span>
</div>


