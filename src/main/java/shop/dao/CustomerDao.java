package shop.dao;

import java.sql.*;
import java.util.*;

public class CustomerDao {
	
	//고객 회원가입 중복 아이디 체크 
	public static boolean addCustomerIdCheck(String customerId)throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		
		// 회원의 아이디가 중복되는지 확인하기
		String sql1 = "SELECT email FROM customer WHERE email = ? ;";
		stmt = conn.prepareStatement(sql1);	
		stmt.setString(1,customerId);
		rs = stmt.executeQuery();
		
		boolean checkId = false;
		
		if(rs.next()){
			checkId = true;
		}
		
		conn.close();
		return checkId;
	}
		
	//고객 회원가입
	public static int addCustomer(String customerId, String customerPw, String customerName, 
			String customerBirth, String customerGender) throws Exception{
		
		PreparedStatement stmt2 = null;
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "INSERT INTO customer (email, pw, name, birth, gender, update_date, create_date) VALUES(?,PASSWORD(?),?,?,?, NOW(),NOW());";
		stmt2 = conn.prepareStatement(sql2);	
		stmt2.setString(1, customerId);
		stmt2.setString(2, customerPw);
		stmt2.setString(3, customerName);
		stmt2.setString(4, customerBirth);
		stmt2.setString(5, customerGender);
		
		row = stmt2.executeUpdate();
		
		conn.close();
		return row;
	}
	
	//고객 로그인
	public static HashMap<String, Object> customerLogin(String customerId, String customerPw)throws Exception{
		
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		PreparedStatement stmt = null;
		ResultSet rs = null; 
	
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT email customerId, pw customerPw FROM customer WHERE email=? AND pw = password(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("customerId",rs.getString("customerId")); 
			resultMap.put("customerPw",rs.getString("customerPw")); 
		}
		
		conn.close();
		return resultMap;
		
	}
	
	//고객정보 수정
	public static int modifyCustomer(String customerId, String customerOriginalPw, 
			String customerName, String customerBirth, String customerGender) throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		PreparedStatement stmt2 = null;
		int row = 0;

		//사용자의 기존 비밀번호 확인
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT pw FROM customer WHERE pw = PASSWORD(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerOriginalPw);
		rs = stmt.executeQuery();
		
		
		if(rs.next()){
			String sql2 = "UPDATE customer SET email = ?, name = ?, birth = ?, gender = ?, update_date = NOW() WHERE email = ? AND pw = PASSWORD(?)";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1,customerId);
			stmt2.setString(2,customerName);
			stmt2.setString(3,customerBirth);
			stmt2.setString(4,customerGender);
			stmt2.setString(5,customerId);
			stmt2.setString(6,customerOriginalPw);
			row = stmt2.executeUpdate();
		}
		
		conn.close();
		return row;
		
	}
	
	
	//고객 비밀번호 변경
	public static int modifyCustomerPw(String customerOriginalPw, String customerChangePw, String customerId) throws Exception {

		PreparedStatement stmt = null;
		ResultSet rs = null; 
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		//사용자의 기존 비밀번호 확인
		String sql = "SELECT pw FROM customer WHERE pw = PASSWORD(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerOriginalPw);
		rs = stmt.executeQuery();
	
		
		if(rs.next()){
			String sql2 = "UPDATE customer SET pw = PASSWORD(?),update_date = NOW() WHERE email = ? AND pw = PASSWORD(?)";
			PreparedStatement stmt2 = null;
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1,customerChangePw);
			stmt2.setString(2,customerId);
			stmt2.setString(3,customerOriginalPw);
			
			row = stmt2.executeUpdate();
		}
		
		conn.close();
		return row;
	}
	
	//고객정보 탈퇴
	public static int deleteCustomer(String customerId, String customerPw) throws Exception {
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		
		//기존 비밀번호 확인하기
		String sql = "DELETE FROM customer WHERE email =? AND pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		stmt.setString(2,customerPw);
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
}
