package shop.dao;

import java.sql.*;
import java.util.*;


public class CategorysDao {
	
	//모든 카테고리 리스트와 합계 찾기
	public static ArrayList<HashMap<String, Object>> selectCategoryList() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		// goodsList 카테고리와 카테고리 합계 가져오기
		String sql1 = "SELECT category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category ASC;";
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		stmt = conn.prepareStatement(sql1);	
		rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> categoryList =  new ArrayList<HashMap<String, Object>>();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			categoryList.add(m);
		}
		
		conn.close();
		return categoryList;
		
	}
	
	//카테고리 삭제하기
	public static int deleteCategoryOne(String category,String createDate) throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		String sql1 = "DELETE FROM category WHERE category = ? AND create_date = ?";
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql1);	
		stmt.setString(1,category);
		stmt.setString(2,createDate);
		int row = stmt.executeUpdate();

		conn.close();
		return row;
		
	}
	
	//모든 카테고리 리스트 보기
	public static ArrayList<HashMap<String, Object>> selectCateogrys () throws Exception{
		
		Connection conn = DBHelper.getConnection();
		String sql1 = "SELECT *,(SELECT COUNT(*) FROM category) cnt FROM category;";
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		stmt = conn.prepareStatement(sql1);	
		rs = stmt.executeQuery();

		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		
		int totalCount = 0;
		
		while(rs.next()){
			if(totalCount == 0){
				totalCount = rs.getInt("cnt");
			}
			
			HashMap<String, Object> list = new HashMap<String, Object>();
			list.put("category", rs.getString("category"));
			list.put("createDate", rs.getString("create_date"));
			list.put("cnt", rs.getInt("cnt"));
			categoryList.add(list);
		}
		
		conn.close();
		return categoryList;
		
	}
}
