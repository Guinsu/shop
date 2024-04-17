package shop.dao;

import java.sql.*;
import java.util.*;

public class CustomerDao {
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
	
	
	
	
}
