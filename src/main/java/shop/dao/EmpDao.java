package shop.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

// emp 테이블을 CRUD하는 static 메서드의 컨테이너
public class EmpDao {
	
	//emp 회원가입
	public static int insertEmp(String empId,String empPw,String empName ,String empJob) throws Exception {
		
		PreparedStatement stmt = null;

		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "insert...?,?,?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		row = stmt.executeUpdate();
		
		if(row > 0) {
			
		}
		
		conn.close();
		return row;
	}
	
	
	//emp로그인
	//HashMap<String, Object> : null 이면 로그인 실패, 아니면 성공
	//String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
	public static HashMap<String, Object> empLogin(String empId, String empPw)throws Exception{
		
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		PreparedStatement stmt = null;
		ResultSet rs = null; 

		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT emp_id empId, emp_name empName, grade FROM emp WHERE emp_id=? AND emp_pw = password(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId",rs.getString("empId")); 
			resultMap.put("empName",rs.getString("empName")); 
			resultMap.put("grade",rs.getInt("grade")); 
		}
		
		conn.close();
		return resultMap;
		
	}
	
	//emp리스트
	public static ArrayList<HashMap<String, Object>> empList(String searchWord, int startRow, int rowPerPage )throws Exception{
			
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		
		// DB 접근
		PreparedStatement stmt = null;
		ResultSet rs = null; 
	
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active FROM emp WHERE emp_name LIKE ? ORDER BY hire_date DESC limit ?,?";
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null; 
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, "%"+searchWord+"%");
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		rs2 = stmt2.executeQuery();
		
		while(rs2.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("empId", rs2.getString("empid"));
			m.put("empName", rs2.getString("empName"));
			m.put("empJob", rs2.getString("empJob"));
			m.put("hireDate", rs2.getString("hireDate"));
			m.put("active", rs2.getString("active"));
			list.add(m);
		}
		
		conn.close();
		return list;
		
	}
	
	//emp리스트 전체 인원수 구하기
	public static int empCount(String searchWord)throws Exception{
		
		PreparedStatement stmt3 = null;
		ResultSet rs3 = null; 
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT count(*) cnt FROM emp WHERE emp_id LIKE ?";
		stmt3 = conn.prepareStatement(sql);
		stmt3.setString(1, "%"+searchWord+"%");
		rs3 = stmt3.executeQuery();
		
		int totalRow = 0;
		
		if(rs3.next()) {
			totalRow = rs3.getInt("cnt");
		}
		
		conn.close();
		return totalRow;
	}
	
	//empOne 정보보기
	public static ArrayList<HashMap<String, Object>> empOne(String empId,String empName,int grade )throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active FROM emp WHERE emp_id = ? AND emp_name = ? AND grade = ?";
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null; 
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, empId);
		stmt2.setString(2, empName);
		stmt2.setInt(3, grade);
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
		
		conn.close();
		return empList;
	}
	
	
	//emp 정보 수정하기
	public static int modifyEmpAction(String empId, String active)throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String sql2 = null;
		int row = 0;
		
		if(active.equals("OFF")){
		 	sql2 = "UPDATE emp SET active = 'ON' WHERE emp_id= ?";
			//System.out.println("ON 으로 변경 성공");
			
		}else if(active.equals("ON")){
		 	sql2 = "UPDATE emp SET active = 'OFF' WHERE emp_id= ?";
			//System.out.println("OFF 으로 변경 성공");
		}
		
		PreparedStatement stmt2 = null;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, empId);
		row = stmt2.executeUpdate();
		
		conn.close();
		return row;
	}
	
}
