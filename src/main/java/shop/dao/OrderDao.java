package shop.dao;
import java.sql.*;
import java.util.*;

public class OrderDao {
	
	//order 정보 저장
	public static int addOrderAction(
		String email, int goodsNo, int price, int totalAmount) throws Exception{
			
		PreparedStatement stmt = null;
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "INSERT INTO orders (email, goods_no, price, total_amount, address, state, update_date, create_date) VALUES (?,?,?,?,?,?,NOW(),NOW());";
		stmt = conn.prepareStatement(sql1);	
		stmt.setString(1,email);
		stmt.setInt(2,goodsNo);
		stmt.setInt(3,price);
		stmt.setInt(4,totalAmount);
		stmt.setString(5,"입력대기");
		stmt.setString(6,"결제대기");
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	//order 전체 개수 가져오기
	public static int selectOrderCount()throws Exception{
		PreparedStatement stmt = null;
		Connection conn = DBHelper.getConnection();
		ResultSet rs = null; 
		int orderTotalCount = 0;
		
		String sql = "SELECT count(order_no) cnt FROM orders ;";
		stmt = conn.prepareStatement(sql);	
		rs = stmt.executeQuery();
		
		if(rs.next()){
			orderTotalCount = rs.getInt("cnt");
		}
		
		conn.close();
		return orderTotalCount;
	}
	
}
