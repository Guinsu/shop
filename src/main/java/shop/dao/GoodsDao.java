package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDao {
	
	//goods 저장하기
	public static int addGoodsAction(
		String category, String empName, String goodsTitle, String filename, 
		String goodsContent, int goodsPrice, int goodsAmount ) throws Exception{
			
		PreparedStatement stmt = null;
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "INSERT INTO goods (category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) VALUES (?,?,?,?,?,?,?,NOW(),NOW());";
		stmt = conn.prepareStatement(sql1);	
		stmt.setString(1,category);
		stmt.setString(2,empName);
		stmt.setString(3,goodsTitle);
		stmt.setString(4,filename);
		stmt.setString(5,goodsContent);
		stmt.setInt(6,goodsPrice);
		stmt.setInt(7,goodsAmount);
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	//goods페이지에 category 모두 가져오기
	public static ArrayList<String> insertGoodsOne() throws Exception{
			
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "SELECT category FROM category;";
		stmt = conn.prepareStatement(sql1);	
		rs = stmt.executeQuery();
		
		ArrayList<String> categoryList =  new ArrayList<String>();
		
		while(rs.next()){
			categoryList.add(rs.getString("category"));
			
		}
		
		conn.close();
		return categoryList;
	}
	
	//goods 삭제하기
	public static int deleteGoodsOne(int no, String category, String totalRow) throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "DELETE FROM goods WHERE goods_no =?;";
		stmt = conn.prepareStatement(sql1);	
		stmt.setInt(1,no);
		int row =  stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	//goodsList 가져오기
	public static ArrayList<HashMap<String, Object>> selectGoodsList(String category,int startRow, int rowPerPage) throws Exception{
	
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null; 
		Connection conn = DBHelper.getConnection();
		
		String sql2 = "SELECT goods_no no, category, goods_title title, filename, left(goods_content,500) content, goods_price price, goods_amount amount, create_date createDate  FROM goods WHERE category = ? ORDER BY goods_no DESC limit ?,?;";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, category);
		stmt2.setInt(2,startRow);
		stmt2.setInt(3,rowPerPage);
		rs2 = stmt2.executeQuery();
		
		ArrayList<HashMap<String, Object>> categoryList =  new ArrayList<HashMap<String, Object>>();
		
		while(rs2.next()){
			HashMap<String, Object> m2 = new HashMap<String, Object>();
			m2.put("no", rs2.getInt("no"));
			m2.put("category", rs2.getString("category"));
			m2.put("title", rs2.getString("title"));
			m2.put("filename", rs2.getString("filename"));
			m2.put("content", rs2.getString("content"));
			m2.put("price", rs2.getInt("price"));
			m2.put("amount", rs2.getInt("amount"));
			m2.put("createDate", rs2.getString("createDate"));
			categoryList.add(m2);
		}
		
		
		conn.close();
		return categoryList;
	}
	
	//goodsList 내용 가져오기
	public static ArrayList<HashMap<String, Object>> selectGoodsContent(int startRow, int rowPerPage) throws Exception{
			
		PreparedStatement stmt3 = null;
		ResultSet rs3 = null; 
		Connection conn = DBHelper.getConnection();
		
		String sql3 = "SELECT goods_no no, category, goods_title title,filename, left(goods_content,500) content, goods_price price, goods_amount amount, create_date createDate, (SELECT COUNT(*) FROM goods) AS cnt FROM goods ORDER BY goods_no DESC limit ?,?;";
		stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, startRow);
		stmt3.setInt(2, rowPerPage);
		rs3 = stmt3.executeQuery();
		
		ArrayList<HashMap<String, Object>> categoryList3 =  new ArrayList<HashMap<String, Object>>();
		
		while(rs3.next()){
			HashMap<String, Object> m3 = new HashMap<String, Object>();
			m3.put("no", rs3.getInt("no"));
			m3.put("category", rs3.getString("category"));
			m3.put("title", rs3.getString("title"));
			m3.put("filename", rs3.getString("filename"));
			m3.put("content", rs3.getString("content"));
			m3.put("price", rs3.getInt("price"));
			m3.put("amount", rs3.getInt("amount"));
			m3.put("createDate", rs3.getString("createDate"));
			m3.put("cnt", rs3.getInt("cnt"));
			categoryList3.add(m3);
		}
		
		conn.close();
		return categoryList3;
	}
	
	//goodsList 합계 가져오기
	public static int selectGoodsContent() throws Exception{
		
		PreparedStatement stmt4 = null;
		ResultSet rs4 = null; 
		Connection conn = DBHelper.getConnection();
		
		String sql4 = "SELECT COUNT(*) cnt FROM goods";
		stmt4 = conn.prepareStatement(sql4);	
		rs4 = stmt4.executeQuery();

		int goodsTotalCnt = 0;
		
		if(rs4.next()){
			goodsTotalCnt = rs4.getInt("cnt");
		}
		
		conn.close();
		return goodsTotalCnt;
	}
	
	//goodsOne
	public static HashMap<String, Object> selectGoodsOne(int no) throws Exception{
		
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		Connection conn = DBHelper.getConnection();
		HashMap<String, Object> list = new HashMap<>();
		
		String sql = "SELECT goods_no no, category, goods_title title, filename, goods_content content, goods_price price, goods_amount amount, create_date createDate FROM goods WHERE goods_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, no);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			list.put("no",rs.getInt("no"));
			list.put("category",rs.getString("category"));
			list.put("title",rs.getString("title"));
			list.put("filename",rs.getString("filename"));
			list.put("content",rs.getString("content"));
			list.put("price",rs.getInt("price"));
			list.put("amount",rs.getInt("amount"));
			list.put("createDate",rs.getString("createDate"));
		}
		
		return  list;
	}

}