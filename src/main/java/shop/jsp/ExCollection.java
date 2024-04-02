package shop.jsp;
import java.util.*;
public class ExCollection {

	public static void main(String[] args) {
		//1. 배열
		String[] arr = new String[3];
		arr[0] = "루피"; // 배열에 데이터 할당 시 인덱스를 알아야한다.
		arr[1] = "조로"; // 인덱스를 가지고는 데이터를 추측이 힘들다.
		arr[2] = "루피"; // 중복된 데이터가 들어간다.
		//arr[3] = "우솝" // 인덱스 범위를 초과할 수 없다.
		
		for (String a : arr) {
			System.out.println(a);
		}
		
		
		System.out.println("------------------");
		
		//2. 컬렉션 프레임워크(자바 기본 API 제공)
		// 1) 리스트 
		ArrayList<String> list = new ArrayList<String>();
		list.add("루피"); // a)
		list.add("조로");
		list.add("나미"); // d)
		list.add("루피");
		
		for (String s : list) {
			System.out.println(s);
		}
		
		System.out.println("------------------");
		// 2) 셋   
		HashSet<String> set = new HashSet<String>();
		set.add("루피");
		set.add("조로");
		set.add("루피"); // 중복된 데이터를 허용하지 않는다.  인덱스가 존재하지 않는다.
		
		for (String a : set) {
			System.out.println(a);
		}
		
		System.out.println("------------------");
		// 3) map
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("선장","루피");
		map.put("부선장","조로");
		map.put("항해사","나미");
		
		System.out.println(map.get("부선장"));  // 인덱스 대신에 원하는 문자열도 가능  key, value 처럼 사용가능 
	
		
		// 4) List + Map  => 이제 ResultSet을 사용하지 않는 이유는 ResultSet을 사용할려면 마리아DB 라이브러리를 다운받아서 사용해야하기 때문
		// 그렇기 때문에 이제는 컬렉션 프레임워크를 사용해서 ArrayList를 사용해서 DB에서 보내주는 값을 넣어서 사용하자.
		
		ArrayList<HashMap<String, String>> mapList = new ArrayList<HashMap<String, String>>();
		
		HashMap<String, String> m1 = new HashMap<String, String>();
		m1.put("name", "루피");
		m1.put("pirateName", "밀짚모자해적단");
		
		HashMap<String, String> m2 = new HashMap<String, String>();
		m2.put("name", "샹크스");
		m2.put("pirateName", "빨간머리해적단");
		
		mapList.add(m1);
		mapList.add(m2);
		
		for(HashMap<String, String> m : mapList) {
			System.out.println(m.get("name")+","+m.get("pirateName"));
		}
		
	}
}
