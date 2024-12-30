package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springproject.domain.WeatherNow;

public class WeatherNowRowMapper implements RowMapper<WeatherNow>{

	@Override
	public WeatherNow mapRow(ResultSet rs, int rowNum) throws SQLException {
		WeatherNow weatherNow = new WeatherNow();
		weatherNow.setNx(rs.getString(1));
		weatherNow.setNy(rs.getString(2));
		return weatherNow;
	}
	
}
