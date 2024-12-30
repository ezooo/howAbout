package com.springproject.repository;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.introspect.TypeResolutionContext.Empty;
import com.springproject.domain.WeatherNow;
import com.springproject.domain.WeatherNowByDate;

import java.io.BufferedReader;
import java.io.IOException;
@Repository
public class WeatherCallNow {
	private static JdbcTemplate template;
	@Autowired
	public void setJdbcTemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}
	
	
	static List<WeatherNow>  weatherNowList= new ArrayList<>();
	
    public static List<WeatherNow> mainCall(String si, String dong) throws Exception {
    	 LocalDate nowDate = LocalDate.now(); 
    	 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd"); //date 변환 형식 지정
    	 String date = nowDate.format(formatter); //date 형식 변환한 String
    	 
    	 
    	 int nowMinute = LocalTime.now().getMinute();
    	 int nowHour = LocalTime.now().getHour();
    	 if(nowMinute >= 45) {
    		 nowMinute = 30;
    	 }else {
    		 nowMinute = 30;
    		 nowHour = nowHour-1;
    	 }
    	 System.out.println("변환한 minute : " + nowMinute);
    	// System.out.println("localTime 출력 : "+nowTime);
    	 String time = String.format("%02d%02d", nowHour, nowMinute);
    	 System.out.println("time 출력 : "+time);
    	 //선택한 시, 동의 좌표를 데이터베이스에서 검색
    	 List<WeatherNow> weatherBaseList = new ArrayList();
    	 if(!(dong.equals("noOption"))&& !(si.equals("noOption"))) {
    		 String SQL = "SELECT latiX, logiY FROM gnLatiInfo WHERE si=? and dongEupMyeon=?";
    		 weatherBaseList= template.query(SQL, new WeatherNowRowMapper(), si, dong);
    	 }else if((dong.equals("noOption"))&& !(si.equals("noOption"))){
    		 String SQL = "SELECT latiX, logiY FROM gnLatiInfo WHERE si=? and dongEupMyeon is null";
    		 weatherBaseList= template.query(SQL, new WeatherNowRowMapper(), si);	 
    	 } else {
    		 String SQL = "SELECT latiX, logiY FROM gnLatiInfo WHERE gsndo='경상남도' and si is null and dongEupMyeon is null";
    		 weatherBaseList= template.query(SQL, new WeatherNowRowMapper());
    	 }
    	 WeatherNow weatherBase = weatherBaseList.get(0);
    	 String nx = weatherBase.getNx();
    	 String ny = weatherBase.getNy();
    	 
    	 StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst"); /*URL*/
         urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=WrmKloGjwEzpg3VwrKAyuT8RGfFrbTdSVvzthl5e%2FWL6P5aC2uwyAIssv9jYkPGVewrBzFqweTj%2FNURFqIpr0g%3D%3D"); /*Service Key*/
         urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
         urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
         urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
         urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(date, "UTF-8")); /*‘21년 6월 28일 발표*/
         urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(time, "UTF-8")); /*06시30분 발표(30분 단위)*/
         urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); /*예보지점 X 좌표값*/
         urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")); /*예보지점 Y 좌표값*/
         URL url = new URL(urlBuilder.toString());
         HttpURLConnection conn = (HttpURLConnection) url.openConnection();
         conn.setRequestMethod("GET");
         conn.setRequestProperty("Content-type", "application/json");
         System.out.println("Response code: " + conn.getResponseCode());
         BufferedReader rd;
         if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
             rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
         } else {
             rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
         }
         StringBuilder sb = new StringBuilder();
         String line;
         while ((line = rd.readLine()) != null) {
             sb.append(line);
         }
         rd.close();
         conn.disconnect();
         System.out.println(sb.toString());
         JSONTokener tokener = new JSONTokener(sb.toString());
         JSONObject object = new JSONObject(tokener);
         System.out.println("object 출력 : " +object.toString());
         
         JSONObject response = object.getJSONObject("response");
         System.out.println("response 출력 : " +response.toString());
         JSONObject body = response.getJSONObject("body");
         System.out.println("body 출력 : " +body.toString());
         JSONObject items = body.getJSONObject("items");
         System.out.println("items 출력 : " +items.toString());
         JSONArray arr = items.getJSONArray("item");
         System.out.println("arr 출력 : " +arr.toString());
         for(int i=0; i<arr.length(); i++) {
         	JSONObject temp = (JSONObject)arr.get(i);
         	WeatherNow weather = new WeatherNow();
         	weather.setBaseDate(temp.getString("baseDate"));
         	weather.setBaseTime(temp.getString("baseTime"));
         	weather.setCategory(temp.getString("category"));
         	weather.setFcstDate(temp.getString("fcstDate"));
         	weather.setFcstTime(temp.getString("fcstTime"));
         	weather.setFcstValue(temp.getString("fcstValue"));
         	weather.setNx(String.valueOf(temp.getInt("nx")));
         	weather.setNy(String.valueOf(temp.getInt("ny")));
         	weatherNowList.add(weather);
         	System.out.println("weatherNow add "+i+"번 완료");
         }
         return weatherNowList;
     }
    
    public List<WeatherNowByDate> getWeatherByDate(List<WeatherNow> weatherList){
    	//List<WeatherNowByDate>
    	//Map<String,Map<String,String>>
    	System.out.println("WeatherCallDay 의 getWeatherByDate 실행");
    	
    	//Map<String,Map<String,String>> weatherByDate = new HashMap<>();
    	
//    	String PTY = null;
//    	String REH = null;
//    	String RN1 = null;
//    	String SKY = null;
//    	String T1H = null;
//    	String WSD = null;
    	List<Map<String,String>> weatherByDateList = new ArrayList();
    	for(int i = 0; i <weatherList.size(); i++) {
	    		WeatherNow weatherNow = weatherList.get(i);
	    	    String date = weatherNow.getFcstDate() + weatherNow.getFcstTime();
	    	    
	    	    boolean dateExists = false;
	
	    	    // 날짜가 이미 존재하는지 확인
	    	    for (Map<String, String> weatherByDate : weatherByDateList) {
	    	        if (weatherByDate.get("date").equals(date)) {
	    	            dateExists = true;
	
	    	            // 기존 데이터 업데이트
	    	            if (weatherNow.getCategory().equals("PTY")) {
	    	                weatherByDate.put("PTY", weatherNow.getFcstValue());
	    	            } else if (weatherNow.getCategory().equals("REH")) {
	    	                weatherByDate.put("REH", weatherNow.getFcstValue());
	    	            } else if (weatherNow.getCategory().equals("RN1")) {
	    	                weatherByDate.put("RN1", weatherNow.getFcstValue());
	    	            } else if (weatherNow.getCategory().equals("SKY")) {
	    	                weatherByDate.put("SKY", weatherNow.getFcstValue());
	    	            } else if (weatherNow.getCategory().equals("T1H")) {
	    	                weatherByDate.put("T1H", weatherNow.getFcstValue());
	    	            } else if (weatherNow.getCategory().equals("WSD")) {
	    	                weatherByDate.put("WSD", weatherNow.getFcstValue());
	    	            }
	
	    	            // 공통 속성 업데이트
	    	            weatherByDate.put("fcstDate", weatherNow.getFcstDate());
	    	            weatherByDate.put("fcstTime", weatherNow.getFcstTime());
	    	            weatherByDate.put("nx", weatherNow.getNx());
	    	            weatherByDate.put("ny", weatherNow.getNy());
	    	            break; // 날짜가 존재하면 루프 종료
	    	        }
	    	    }
	
	    	    // 날짜가 존재하지 않는 경우에만 추가
	    	    if (!dateExists) {
	    	        Map<String, String> weatherCategory = new HashMap<>();
	    	        weatherCategory.put("date", date);
	    	        
	    	        // 새로운 데이터 추가
	    	        if (weatherNow.getCategory().equals("PTY")) {
	    	            weatherCategory.put("PTY", weatherNow.getFcstValue());
	    	        } else if (weatherNow.getCategory().equals("REH")) {
	    	            weatherCategory.put("REH", weatherNow.getFcstValue());
	    	        } else if (weatherNow.getCategory().equals("RN1")) {
	    	            weatherCategory.put("RN1", weatherNow.getFcstValue());
	    	        } else if (weatherNow.getCategory().equals("SKY")) {
	    	            weatherCategory.put("SKY", weatherNow.getFcstValue());
	    	        } else if (weatherNow.getCategory().equals("T1H")) {
	    	            weatherCategory.put("T1H", weatherNow.getFcstValue());
	    	        } else if (weatherNow.getCategory().equals("WSD")) {
	    	            weatherCategory.put("WSD", weatherNow.getFcstValue());
	    	        }
	
	    	        // 공통 속성 추가
	    	        weatherCategory.put("fcstDate", weatherNow.getFcstDate());
	    	        weatherCategory.put("fcstTime", weatherNow.getFcstTime());
	    	        weatherCategory.put("nx", weatherNow.getNx());
	    	        weatherCategory.put("ny", weatherNow.getNy());
	
	    	        weatherByDateList.add(weatherCategory);
	    	    }
    		}
    		
    		List<WeatherNowByDate> weatherNowByDateList = new ArrayList<>();
    		
    		for(int i=0; i<weatherByDateList.size(); i++) {

    		Map<String, String> innerMap = weatherByDateList.get(i);
    		
    		WeatherNowByDate weatherNowByDate = new WeatherNowByDate();
    		weatherNowByDate.setDate(innerMap.get("date"));
    		weatherNowByDate.setPTY(innerMap.get("PTY"));
    		weatherNowByDate.setRN1(innerMap.get("RN1"));
    		weatherNowByDate.setREH(innerMap.get("REH"));
    		weatherNowByDate.setSKY(innerMap.get("SKY"));
    		weatherNowByDate.setT1H(innerMap.get("T1H"));
    		weatherNowByDate.setWSD(innerMap.get("WSD"));
    		weatherNowByDate.setFcstDate(innerMap.get("fcstDate"));
    		weatherNowByDate.setFcstTime(innerMap.get("fcstTime"));
    		weatherNowByDateList.add(weatherNowByDate);
    		}
    		System.out.println("weatherNowByDateList 출력 : "+weatherNowByDateList);
    		for(int i=0;i<weatherNowByDateList.size();i++) {
    			WeatherNowByDate oneWeather = weatherNowByDateList.get(i);
//    			System.out.println("하나씩 출력해 보기 : "+oneWeather.getDate());
    			System.out.println("하나씩 출력해 보기 : "+oneWeather.getFcstDate());
    			System.out.println("하나씩 출력해 보기 : "+oneWeather.getFcstTime());
//    			System.out.println("하나씩 출력해 보기 : "+oneWeather.getPTY());
//    			System.out.println("하나씩 출력해 보기 : "+oneWeather.getT1H());
//    			System.out.println("하나씩 출력해 보기 : "+oneWeather.getRN1());
    		}
    	return weatherNowByDateList;
    }
    public List<String> getAddrInfo(){
    	Map<String, List<String>> resultMap = new HashMap<>();
    	List<String> siList = new ArrayList();
    	
    	String SQL = "SELECT DISTINCT si FROM gnLatiInfo WHERE si IS NOT NULL";
    	List<Map<String, Object>> outList = template.queryForList(SQL);
    	System.out.println("outList 출력해 보기 : " + outList);
    	for(int i = 0; i <outList.size(); i++) {
    		Map<String, Object> row = outList.get(i);
    		siList.add((String)row.get("si"));
    		//System.out.println("add하는 si : "+(String)row.get("si"));
    	}
    	resultMap.put("siList",siList);
    	System.out.println("siList 잘 담겼는지 확인 : "+siList);
    	return siList;
    }

	public List<String> getDongInfo(String selectedSi){
		List<String> dongList = new ArrayList();
		String SQL = "SELECT DISTINCT dongEupMyeon FROM gnLatiInfo WHERE dongEupMyeon IS NOT NULL AND si = '"+selectedSi+"'";
		List<Map<String, Object>> outList = template.queryForList(SQL);
		System.out.println("outList2 출력해 보기 :" +outList);
		for(int i = 0; i <outList.size(); i++) {
			Map<String, Object> row = outList.get(i);
			dongList.add((String)row.get("dongEupMyeon"));
			//System.out.println("add 하는 dong : "+(String)row.get("dongEupMyeon"));
		}
		System.out.println("dongList 잘 담겼는지 확인 : "+dongList);
		return dongList;
	}
}