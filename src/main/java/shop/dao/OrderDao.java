package shop.dao;
import java.sql.*;
import java.util.*;

public class OrderDao {
	
	//order 정보 저장
	public static int addOrderAction(
		String email, int goodsNo,  String goodsTitle, int price, int totalAmount) throws Exception{
			
		PreparedStatement stmt = null;
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "INSERT INTO orders (email, goods_no, goods_title, price, total_amount, address, state, update_date, create_date) VALUES (?,?,?,?,?,?,?,NOW(),NOW());";
		stmt = conn.prepareStatement(sql1);	
		stmt.setString(1,email);
		stmt.setInt(2,goodsNo);
		stmt.setString(3,goodsTitle);
		stmt.setInt(4,price);
		stmt.setInt(5,totalAmount);
		stmt.setString(6,"입력대기");
		stmt.setString(7,"결제대기");
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// "결제대기" 상태인 모든 order 정보 가져오기
	public static ArrayList<HashMap<String, Object>> selectOrders(String email)throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		
		String sql = "SELECT order_no orderNo, email, goods_no no, goods_title goodsTitle, price, total_amount amount, create_date createDate FROM orders WHERE email = ? AND state = ?;";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, email);
		stmt.setString(2, "결제대기");
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("orderNo",rs.getInt("orderNo"));
			m.put("no",rs.getInt("no"));
			m.put("goodsTitle",rs.getString("goodsTitle"));
			m.put("price",rs.getInt("price"));
			m.put("amount",rs.getInt("amount"));
			m.put("createDate",rs.getString("createDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	
	//모든 order 가져오기
	public static ArrayList<HashMap<String, Object>> selectAllOrder(String searchWord, int startRow, int rowPerPage )throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			
	
		String sql = "SELECT order_no orderNo, email, goods_no no, goods_title goodsTitle, price, total_amount totalAmount, address, state, comment_state commentState ,update_date updateDate FROM orders WHERE state != '결제대기' AND email LIKE ? ORDER BY order_no DESC limit ?,?;";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("orderNo",rs.getInt("orderNo"));
			m.put("email",rs.getString("email"));
			m.put("no",rs.getInt("no"));
			m.put("goodsTitle",rs.getString("goodsTitle"));
			m.put("price",rs.getInt("price"));
			m.put("totalAmount",rs.getInt("totalAmount"));
			m.put("address",rs.getString("address"));
			m.put("state",rs.getString("state"));
			m.put("commentState",rs.getString("commentState"));
			m.put("updateDate",rs.getString("updateDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	
	
	// "결제대기" 상태인 order 전체 개수 가져오기
	public static int selectOrderCount()throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		int orderTotalCount = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT count(order_no) cnt FROM orders WHERE state = ?;";
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, "결제대기");
		rs = stmt.executeQuery();
		
		if(rs.next()){
			orderTotalCount = rs.getInt("cnt");
		}
		
		conn.close();
		return orderTotalCount;
	}
	
	// order 전체 개수 구하기
	public static int orderCount(String searchWord)throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT count(*) cnt FROM orders WHERE email LIKE ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		rs = stmt.executeQuery();
		
		int totalRow = 0;
		
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		conn.close();
		return totalRow;
	}
	
	//장바구니 제품 결제하기 
	public static int paymentGoods(String address, String state, String email, String[] orderNo) throws Exception{
		
		PreparedStatement stmt = null;
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		
		String sql = "UPDATE orders SET address = ? ,state = ? , update_date = NOW() WHERE email = ?  AND order_no = ? ";
		stmt = conn.prepareStatement(sql);
		
		for(String list : orderNo) {
			stmt.setString(1, address);
			stmt.setString(2, state);
			stmt.setString(3, email);
			stmt.setInt(4, Integer.parseInt(list)); 
			row += stmt.executeUpdate();			
		}
		
		return row;
	}
	
	// 배송진행상태 "결제완료" 를 배송중,배송완료로 상태변경 
	public static int modifyOrderState(int orderNo, String customerId, int no, int totalAmount, String orderState) throws Exception{
		PreparedStatement stmt = null;
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		
		String sql = "UPDATE orders SET total_amount = ?, state = ?, update_date = NOW() WHERE email = ?  AND order_no = ? AND goods_no = ? ";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, totalAmount - 1);
		stmt.setString(2, orderState);
		stmt.setString(3, customerId);
		stmt.setInt(4, orderNo); 
		stmt.setInt(5, no); 
		row  = stmt.executeUpdate();			
		
		return row;
	}
}
