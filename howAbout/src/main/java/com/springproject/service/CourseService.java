package com.springproject.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.springproject.domain.Course;

public interface CourseService {
	List<Course> getAllCourse();
	void addCourse(Course course, HttpSession session);
	List<Course> getCourseFindById(String userId) throws Exception;
	Course getOneCourse(long course_id) throws Exception;
	void updateCourse(Course course) throws Exception;
	void deleteCourse(long course_id);
}
