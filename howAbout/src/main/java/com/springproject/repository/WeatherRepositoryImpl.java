package com.springproject.repository;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class WeatherRepositoryImpl implements WeatherRepository
{
	private JdbcTemplate template;
	@Autowired
	public void setJdbcTemplate(DataSource dataSource)
	{
		this.template = new JdbcTemplate(dataSource);
	}
	String sql;

	@Override
	public String getRegCode(String areaname) 
	{
		System.out.println("WeatherRepositoryImpl getRegCode in");
		sql = "select areacode from weatherarea where areaname=?";
		String areacode = template.queryForObject(sql, String.class, areaname);
		if(areacode!= null)
		{
			return areacode;
		}
		return "11H20301";
	}
	
	
	

}
