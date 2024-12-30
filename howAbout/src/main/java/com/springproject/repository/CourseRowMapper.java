package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;


import com.springproject.domain.Course;

public class CourseRowMapper implements RowMapper<Course>{
	public Course mapRow(ResultSet rs,int rowNum) throws SQLException{
		Course course = new Course();
		course.setCourse_id(rs.getLong(1));
		course.setCourse_name(rs.getString(2));
		course.setUserId(rs.getString(3));
		Timestamp timestamp = rs.getTimestamp(4);
		course.setCreation_date(timestamp.toLocalDateTime());
		return course;
	}
}