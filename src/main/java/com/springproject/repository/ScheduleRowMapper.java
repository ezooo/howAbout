package com.springproject.repository;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;


import com.springproject.domain.Schedule;

public class ScheduleRowMapper implements RowMapper<Schedule>{
	public Schedule mapRow(ResultSet rs,int rowNum) throws SQLException{
		Schedule schedule = new Schedule();
		schedule.setSchedule_id(rs.getLong(1));
		schedule.setSchedule_record(rs.getString(2));
		Date date = rs.getDate(3);
		schedule.setSchedule_date(date.toLocalDate());
		schedule.setWeather(rs.getString(4));
		
		return schedule;
	}
}