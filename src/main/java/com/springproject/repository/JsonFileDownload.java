package com.springproject.repository;

import java.io.InputStream;

import javax.sql.DataSource;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JsonFileDownload {

		private JdbcTemplate template;
		
		@Autowired
		public void setJdbcTemplate(DataSource dataSource) {
			this.template = new JdbcTemplate(dataSource);
		}
		
		public void insertJsonData() {
		System.out.println("JsonFileDownload의 insertJsonDate 실행");
		String src="/festivalList.json";
		InputStream is = JsonFileDownload.class.getResourceAsStream(src);
		if(is==null) {
			throw new NullPointerException("Cannot find resource file");
		}
		JSONTokener tokener = new JSONTokener(is);
		JSONObject object = new JSONObject(tokener);
		JSONArray records = object.getJSONArray("records");
		
		String SQL = "INSERT INTO festival_db (fstvlNm,opar,fstvlStartDate,fstvlEndDate,fstvlCo,mnnstNm,auspcInsttNm,suprtInsttNm,phoneNumber,homepageUrl,relateInfo,rdnmadr,lnmadr,latitude,longitude,referenceDate)"
				+"VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		for(int i=0; i<records.length(); i++) {
			JSONObject fes=(JSONObject)records.get(i);
			String value1 = fes.getString("축제명");
			String value2 = fes.getString("개최장소");
			String value3 = fes.getString("축제시작일자");
			String value4 = fes.getString("축제종료일자");
			String value5 = fes.getString("축제내용");
			String value6 = fes.getString("주관기관명");
			String value7 = fes.getString("주최기관명");
			String value8 = fes.getString("후원기관명");
			String value9 = fes.getString("전화번호");
			String value10 = fes.getString("홈페이지주소");
			String value11 = fes.getString("관련정보");
			String value12 = fes.getString("소재지도로명주소");
			String value13 = fes.getString("소재지지번주소");
			String value14 = fes.getString("위도");
			String value15 = fes.getString("경도");
			String value16 = fes.getString("데이터기준일자");
			
			template.update(SQL, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16);
			System.out.println("update 완료 "+i+"번째 성공");
		}
	}
}
