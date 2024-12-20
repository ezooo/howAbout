package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

import org.springframework.jdbc.core.RowMapper;

import com.springproject.domain.Festival;

public class FestivalRowMapper implements RowMapper<Festival>{
	public Festival mapRow(ResultSet rs,int rowNum) throws SQLException{
		Festival festival = new Festival();
		festival.setFesNo(rs.getLong(1));
		festival.setFstvlNm(rs.getString(2));
		festival.setOpar(rs.getString(3));
		Date date1 = rs.getDate(4);
		Date date2 = rs.getDate(5);
		festival.setFstvlStartDate(date1.toLocalDate());
		festival.setFstvlEndDate(date2.toLocalDate());
		festival.setFstvlCo(rs.getString(6));
		festival.setMnnstNm(rs.getString(7));
		festival.setAuspcInsttNm(rs.getString(8));
		festival.setSuprtInsttNm(rs.getString(9));
		festival.setPhoneNumber(rs.getString(10));
		festival.setHomepageUrl(rs.getString(11));
		festival.setRelateInfo(rs.getString(12));
		festival.setRdnmadr(rs.getString(13));
		festival.setLnmadr(rs.getString(14));
		festival.setLatitude(rs.getString(15));
		festival.setLongitude(rs.getString(16));
		Date date3 = rs.getDate(17);
		festival.setReferenceDate(date3.toLocalDate());
		return festival;
	}
}