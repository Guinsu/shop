package shop.dao;
import java.sql.*;
import java.util.*;

public class CommentDao {
	
	//comment 정보 저장
	public static int addCommentAndScore(
		int orderNo, int goodsNo, int score, String content) throws Exception{
			
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "INSERT INTO comment (order_no, goods_no, score, content, update_date, create_date) VALUES (?,?,?,?,NOW(),NOW());";
		stmt = conn.prepareStatement(sql1);	
		stmt.setInt(1,orderNo);
		stmt.setInt(2,goodsNo);
		stmt.setInt(3,score);
		stmt.setString(4,content);
		
		int row = stmt.executeUpdate();
		int row2 = 0;
		
		if(row > 0) {
			String sql2 = "UPDATE orders SET comment_state = ? WHERE order_no = ? AND goods_no =?";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1,"Y");
			stmt2.setInt(2,orderNo);
			stmt2.setInt(3,goodsNo);
			
			row2 = stmt2.executeUpdate();
		}
		
		conn.close();
		return row2;
	}
	
	//선택된 제품의 comment 정보 가져오기 
	public static ArrayList<HashMap<String, Object>> commentList(int goodsNo,int startRow, int rowPerPage)throws Exception{
			
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
			
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "SELECT comment_no commentNo, goods_no goodsNo, content, score, create_date createDate FROM comment WHERE goods_no = ? ORDER BY comment_no ASC limit ?,?";
		stmt = conn.prepareStatement(sql2);
		stmt.setInt(1, goodsNo);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("commentNo", rs.getInt("commentNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("content", rs.getString("content"));
			m.put("score", rs.getInt("score"));
			m.put("createDate", rs.getString("createDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	
	
	//선택된 제품의 모든 comment 개수 가져오기 
	public static int commentCount()throws Exception{
			
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		int commentCount = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "SELECT COUNT(*) cnt FROM comment";
		stmt = conn.prepareStatement(sql2);
		rs = stmt.executeQuery();
		
		while(rs.next()){
			commentCount = rs.getInt("cnt");
		}
		
		conn.close();
		return commentCount;
	}
	

	//선택된 제품의 모든 comment score 개수 가져오기 
	public static ArrayList<HashMap<String, Object>> commentScoreSum(int goodsNo)throws Exception{
			
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		int commentScoreSum = 0;
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
		
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "SELECT SUM(score) sum, COUNT(*) cnt FROM comment WHERE goods_no = ?";
		stmt = conn.prepareStatement(sql2);
		stmt.setInt(1,goodsNo);
		rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("sum", rs.getInt("sum"));
			m.put("cnt", rs.getInt("cnt"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
		
}

