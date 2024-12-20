package com.springproject.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.springproject.domain.Course;
import com.springproject.domain.Location;

public interface CourseRepository {
	void addCourse(Course course,HttpSession session);
	List<Course> getCourseFindById(String userId) throws Exception;
	Course getOneCourse(long course_id) throws Exception;
	List<Course> getAllCourse();
	void updateCourse(Course course) throws Exception;
	void deleteCourse(long course_id);
}
