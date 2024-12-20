package com.springproject.repository;
import java.net.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.io.*;

// JSONAPICall이라는 클래스를 생성합니다.
@Repository
public class JSONAPICall {
	
	@Value("${weather.api.key}")
    private static String authKey = "LOO4RpniTaajuEaZ4j2mkA";
	
    public static void getWeather() throws Exception {
//    	String REG_ID
        // API URL을 만듭니다.
    	String REG_ID = "11H20000";
//    	LocalDate date =LocalDate.now();
//    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        String dateString = sdf.format(date); 
//    	String TM_FC = dateString.replace("-", "") + "0600";
    	String TM_FC = "202412090600";
    	String urlString = String.format("https://apihub.kma.go.kr/api/typ01/cgi-bin/url/nph-aws2_min?regId=%s&tmFc=%s&authKey=%s",REG_ID,TM_FC,authKey);
        URL url = new URL(urlString);
        // HttpURLConnection 객체를 만들어 API를 호출합니다.
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        // 요청 방식을 GET으로 설정합니다.
        con.setRequestMethod("GET");
        // 요청 헤더를 설정합니다. 여기서는 Content-Type을 application/json으로 설정합니다.
        con.setRequestProperty("Content-Type", "application/json");

        // API의 응답을 읽기 위한 BufferedReader를 생성합니다.
        BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();

        // 응답을 한 줄씩 읽어들이면서 StringBuffer에 추가합니다.
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        // BufferedReader를 닫습니다.
        in.close();

        // 응답을 출력합니다.
         JSONTokener tokener = new JSONTokener(response.toString());
         JSONObject object = new JSONObject(tokener);
         System.out.println(response.toString());
         
         JSONArray arr=object.getJSONArray("result");
         for(int i=0; i<arr.length();i++) {
        	 JSONObject temp=(JSONObject)arr.get(i);
        	 System.out.println("REG_ID :"+temp.get("REG_ID"));
        	 System.out.println("TM_FC : "+temp.get("TM_FC"));
        	 System.out.println("SKY : "+temp.get("SKY"));
        	 System.out.println("MIN : "+temp.get("MIN"));
        	 System.out.println("MAX : "+temp.get("MIN"));
         }
         
         

    }

}