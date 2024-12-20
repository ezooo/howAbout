package com.springproject.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Course;
import com.springproject.repository.CourseRepositoryImpl;
@Service
public class CourseServiceImpl implements CourseService {
	@Autowired
	private CourseRepositoryImpl courseRepository;
	
	@Override
	public List<Course> getAllCourse() {
		System.out.println("CourseService의 getAllCouse 실행됨");
		return courseRepository.getAllCourse();
	}

	@Override
	public void addCourse(Course course, HttpSession session) {
		courseRepository.addCourse(course,session);

	}

	@Override
	public List<Course> getCourseFindById(String submitId) throws Exception {
		System.out.println("CourseServiceImpl의 getCourseById 실행됨");
		System.out.println("service로 온 submitId : "+submitId);
		return courseRepository.getCourseFindById(submitId);
	}

	@Override
	public Course getOneCourse(long course_id) throws Exception {
		Course courseByCourseId = courseRepository.getOneCourse(course_id);
		return courseByCourseId;
	}

	@Override
	public void updateCourse(Course course) throws Exception {
		courseRepository.updateCourse(course);

	}

	@Override
	public void deleteCourse(long course_id) {
		courseRepository.deleteCourse(course_id);

	}

}
