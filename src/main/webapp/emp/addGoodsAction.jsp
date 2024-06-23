<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
    
<!-- Controller layer -->
<%
	request.setCharacterEncoding("UTF-8");

	// 인증 분기  
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	Part part = request.getPart("goodsImg");
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
	
	String originalName = part.getSubmittedFileName();
	
	// 원본 이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);
	
	UUID uuid = UUID.randomUUID();
	String filename = (uuid.toString()).replace("-", "");
	filename = filename + ext;
	//System.out.println(filename);
	
%>  

<!-- Session 설정값 : 입력시 로그인 emp의 emp_id 값이 필요해서 -->
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)session.getAttribute("loginEmp");

	//디버깅
	//System.out.println(loginMember.get("empName"));

%>


<!-- Model layer -->

<%
	
	int row = GoodsDao.addGoodsAction(category,(String)loginMember.get("empName"), goodsTitle, filename, goodsContent, goodsPrice, goodsAmount);
	
	if(row > 0){ // insert 성공 -> 파일도 업로드 시키자 
		// part -> inputStream -> outputStream -> 빈파일
		String uploadPath = request.getServletContext().getRealPath("upload"); // 저장될 위치
		File file = new File(uploadPath, filename);
		
		InputStream inputStream = part.getInputStream(); // part객체안에 파일(바이너리)을 메모로리 불러 옴
		OutputStream outputStream = Files.newOutputStream(file.toPath()); // 메모리로 불러온 파일(바이너리)을 빈파일에 저장
		inputStream.transferTo(outputStream);
		
		
		/*
		삭제하는 방법
		File df = new File(filePath, rs.getString("filename"));
		df.delete();
		*/
		
		inputStream.close();
		outputStream.close();
		
		response.sendRedirect("/shop/emp/goodsList.jsp");	
	}
	
%>
