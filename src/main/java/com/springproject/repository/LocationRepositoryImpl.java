package com.springproject.repository;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import javax.sql.DataSource;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.springproject.domain.Location;

@Repository
public class LocationRepositoryImpl implements LocationRepository
{
	private JdbcTemplate template;
	@Autowired
	public void setJdbctemplate(DataSource dataSource)
	{
		this.template = new JdbcTemplate(dataSource);
	}
	String SQL;
	
	@Override
	public void addLocationAPI(JSONObject lt) 
	{
		System.out.println("LocationRepositoryImpl addLocationAPI in");
		// 이미지 주소 가공하기
		String fileurl1 = lt.getString("fileurl1");
		if(fileurl1.isBlank()) { fileurl1 ="/howAbout/resources/images/00000000image.png"; }
		String fileurl2 = lt.getString("fileurl3");
		if(fileurl2.isBlank()) { fileurl2 ="/howAbout/resources/images/00000000image.png"; }
		String fileurl3 = lt.getString("fileurl4");
		if(fileurl3.isBlank()) { fileurl3 ="/howAbout/resources/images/00000000image.png"; }
		String fileurl4 = lt.getString("fileurl5");
		if(fileurl4.isBlank()) { fileurl4 ="/howAbout/resources/images/00000000image.png"; }
		
		SQL = "insert into location values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		template.update(SQL, lt.getString("data_title"), lt.getString("user_address"), lt.getString("lattitude"), lt.getString("logitude"), 
				lt.getString("insttnm"), lt.getString("category_name1"), lt.getString("category_name2"), lt.getString("data_content"), lt.getString("telno"), 
				fileurl1, fileurl2, fileurl3, fileurl4, null);
	}

	@Override
	public List<String> getAlltitle() 
	{
		System.out.println("LocationRepositoryImpl getAlltitle in");
		SQL = "select data_title from location order by data_title asc";
		List<String> titleList= template.query(SQL, new LocationTitleRowMapper());
		
		return titleList;
	}

	@Override
	public List<Location> getAllLocation() 
	{
		System.out.println("LocationRepositoryImpl getAllLocation in");
		SQL = "select * from location order by data_title asc";
		List<Location> locations = template.query(SQL, new LocationRowMapper());
		
		return locations;
	}

	
	@Override
	public Location getOneLocation(int num) 
	{
		System.out.println("LocationRepositoryImpl getOneLocation in");
		SQL = "select * from location where num=?";
		Location location = template.queryForObject(SQL, new LocationRowMapper(), new Object[] {num});
		return location;
	}

	
	@Override
	public List<Location> getLocationOfCategory(String category) 
	{
		System.out.println("LocationRepositoryImpl getLocationOfCategory in");
		SQL = "select * from location where category_name1=? order by data_title asc";
		List<Location> locations = template.query(SQL, new LocationRowMapper(), new Object[] {category});
		
		return locations;
	}

	@Override
	public List<Location> getAllCategory() 
	{
		System.out.println("LocationRepositoryImpl getAllCategory in");
		SQL = "select a.category_name1, "
				+ "(select b.fileurl1 from location b where b.category_name1 = a.category_name1 LIMIT 1) as fileurl1"
				+ " from location a group by a.category_name1"
				+ " order by a.category_name1 asc";
		List<Location> categoryList = template.query(SQL, new LocationCategoryRowMapper());
		
		return categoryList;
	}

	@Override
	public void createLocation(Location lt) 
	{
		System.out.println("LocationRepositoryImpl createLocation in");
		SQL = "insert into location values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		template.update(SQL, lt.getData_title(), lt.getUser_address(), lt.getLatitude(), lt.getLongitude(), lt.getInsttnm(), lt.getCategory_name1(), 
				lt.getCategory_name2(), lt.getData_content(), lt.getTelno(), lt.getFileurl1(), lt.getFileurl2(), lt.getFileurl3(), lt.getFileurl4(), null);
	}

	@Override
	public Location findLocation(String[] find) 
	{
		System.out.println("LocationRepositoryImpl findLocation in");
		String lat = find[0];
		System.out.println(lat);
		String log = find[1];
		
		SQL = "select * from location where latitude=? and longitude=?";
		Location location = template.queryForObject(SQL, new LocationRowMapper(), lat, log);
		if(location != null)
		{
			System.out.println("수정할 로케이션 찾아옴");
			return location;
		}
		System.out.println("수정할 로케이션 못찾음....");
		return null;
	}

	@Override
	public void submitUpdateLocation(Location lt) 
	{
		System.out.println("LocationRepositoryImpl submitUpdateLocation in");
		SQL = "update location set data_title=?, user_address=?, latitude=?, longitude=?, insttnm=?, category_name1=?, category_name2=?,"
				+ " data_content=?, telno=?, fileurl1=?, fileurl2=?, fileurl3=?, fileurl4=?"
				+ " where num=?";
		System.out.println("수정할 제목 : "+lt.getData_title()+", 수정할 카테고리 : "+lt.getCategory_name1()+", 수정할 넘버 : "+lt.getNum());
		template.update(SQL, lt.getData_title(), lt.getUser_address(), lt.getLatitude(), lt.getLongitude(), lt.getInsttnm(), lt.getCategory_name1(), 
				lt.getCategory_name2(), lt.getData_content(), lt.getTelno(), lt.getFileurl1(), lt.getFileurl2(), lt.getFileurl3(), lt.getFileurl4(), 
				lt.getNum());
	}

	@Override
	public void deleteLocation(String lat, String log) 
	{
		System.out.println("LocationRepositoryImpl deleteLocation in");
		
		SQL= "delete from location where latitude=? and longitude=?";
		template.update(SQL, lat, log);
	}

	@Override
	public List<Location> findLocationByTitle(String title) 
	{
		System.out.println("LocationRepositoryImpl findLocationByTitle in");
		SQL = "select data_title, user_address from location where data_title like ? order by data_title asc";
		return template.query(SQL, new LocationFindRowMapper(), new Object[] {"%" + title + "%"});
	}

	@Override
	public String[] getAPIContents(String jsonaddr) 
	{	//공공데이터에서 받아 온 주소, 위도, 경도 가공을 위한 함수
		System.out.println("LocationRepositoryImpl getAPIContents in");
		String[] result = null;
		try 
		{
			String addr = URLEncoder.encode(jsonaddr, "UTF-8");
			String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query="+addr;
			String REST_API_KEY = "d1b75ca528c7355eb5a8b379d289c649";
			URL url = new URL(apiUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "KakaoAK " + REST_API_KEY);
			BufferedReader br;
			int respCode = conn.getResponseCode();
			if(respCode==200)
			{
				System.out.println("getAPIContents 응답코드 정상");
				br = new BufferedReader( new InputStreamReader(conn.getInputStream()) );
			}
			else
			{
				System.out.println("getAPIContents 응답코드 에러에러");
				br = new BufferedReader( new InputStreamReader(conn.getErrorStream()) );
			}
			StringBuffer sb = new StringBuffer();
			String line;
			while( (line=br.readLine())!= null )
			{
				sb.append(line);
			}
			br.close();

			JSONTokener tokener = new JSONTokener(sb.toString());
			JSONObject object = new JSONObject(tokener);
			//가져다 쓸 것 : 주소, 위도, 경도
			JSONArray documents = object.getJSONArray("documents");
			if(documents!=null && !(documents.isEmpty()) )
			{
				JSONObject ob = documents.getJSONObject(0);
				result = new String[3];
				result[0]= ob.getString("address_name");
				result[1]= ob.getString("y");
				result[2]= ob.getString("x");
			}
		} 
		catch (Exception e) 
		{
			System.out.println("LocationRepositoryImpl getAPIContents catch 에러에러");
			e.printStackTrace();
		}
		System.out.println("LocationRepositoryImpl getAPIContents 종료. 리턴합니다.");
		return result;
	}

	@Override
	public List<String> getAlladdr() 
	{
		System.out.println("LocationRepositoryImpl getAPIContents in");
		SQL = "select user_address from location";
		
		return template.query(SQL, new LocationTitleRowMapper());
	}

	@Override
	public List<String> getAllArea() 
	{
		System.out.println("LocationRepositoryImpl getAllArea in");
		SQL = "select distinct substr(insttnm,1,2) from location order by substr(insttnm,1,2)";
		List<String> areaList = template.query(SQL, new LocationTitleRowMapper());
		return areaList;
	}

	@Override
	public List<Location> getLocationOfArea(String area) 
	{
		System.out.println("LocationRepositoryImpl getLocationOfArea in");
		SQL = "select * from location where substr(insttnm,1,2)=?";
		return template.query(SQL, new LocationRowMapper(), area);
	}
}
