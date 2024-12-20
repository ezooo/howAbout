package com.springproject.repository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Course;
import com.springproject.domain.Location;
import com.springproject.domain.Member;

@Repository
public class CourseRepositoryImpl implements CourseRepository{
	
	private JdbcTemplate template;
	
	List<Course> courses;
	Course course;
	@Autowired
	public void setJdbcTemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}
	Location location;
	public void addCourse(Course course, HttpSession session) {
		System.out.println("CourseRepository의 addCourse 실행됨");
		course.setCourse_id(System.currentTimeMillis());
		course.setCreation_date(LocalDateTime.now());
		//course.setLocation_names(NewCourse);
		Member member=(Member)session.getAttribute("userStatus");
		course.setUserId(member.getUserId());
		System.out.println("add courseId : " + course.getCourse_id());
		System.out.println("add 시간 : "+course.getCreation_date());
		String SQL = "INSERT INTO course (course_id, course_name, userId, creation_date)"+ "VALUES (?,?,?,?)";
		template.update(SQL, course.getCourse_id(), course.getCourse_name(), course.getUserId(),course.getCreation_date());
		List<String> location_names = course.getLocation_names();
		List<Long> location_sequences = course.getLocation_sequence();
		System.out.println("for문 돌기 전 location_sequences : "+ location_sequences);
		for(int i = 0; i<location_names.size(); i++) {
			String location_name = location_names.get(i);
			System.out.println("1번까지 됨");
			location_sequences.add(i, (long)i);
			System.out.println("2번까지 됨");
			Long location_sequence = location_sequences.get(i);
			System.out.println("3번까지 됨");
			SQL = "INSERT INTO course_location (course_id, location_name, location_sequence)"+ "VALUES (?,?,?)";
			System.out.println("4번까지 됨");
			template.update(SQL, course.getCourse_id(), location_name, location_sequence);
			System.out.println("5번까지 됨");
		}
	}
	
	public List<Course> getCourseFindById(String submitId) throws Exception {
		System.out.println("CourseRepository의 getCourseById 실행됨");
		System.out.println("repository로 온 submitId : "+submitId);
		String SQL ="select c.course_id, c.course_name, c.userId, c.creation_date, l.location_name, l.location_sequence "
				+ "from course c "
				+ "join course_location l on c.course_id = l.course_id " 
				+ "where c.userId='"+submitId+"'";
//		int rowCount = template.queryForObject(SQL,Integer.class,submitId);
//		System.out.println("rowCount : "+ rowCount);
//		if(rowCount != 0) {
//			System.out.println("if rowCount !=0 입장");
//			SQL = "SELECT * FROM course where userId=?";
//			courses = template.query(SQL,new CourseRowMapper(),submitId);
//			System.out.println("courses : "+courses);
//		}
		List<Course> courses = getCourseList(SQL);
		if (courses == null) {
			System.out.println("출력할 course가 존재하지 않습니다.");
			throw new Exception(submitId);
		}
			return courses;
	}
	
	public Course getOneCourse(long course_id) throws Exception{
		System.out.println("CourseRepository의 getOneCourse 실행됨");
		String SQL = "select c.course_id, c.course_name, c.userId, c.creation_date, l.location_name, l.location_sequence "
				+ "from course c "
				+ "join course_location l on c.course_id = l.course_id "
				+ "where c.course_id="+course_id;
//		int rowCount = template.queryForObject(SQL, Integer.class,course_id);
//		
//		if(rowCount != 0) {
//			SQL = "SELECT * FROM course where course_id=?";
//			course = template.queryForObject(SQL, new Object[] {course_id}, new CourseRowMapper());
//		}
//		if (course == null)
//			throw new Exception();
		List<Course> listOfCourses = getCourseList(SQL);
		System.out.println("getOneCourse에서 getCourseList까지 실행됨");
		System.out.println("listOfCourses 출력 : "+listOfCourses);
		if (!listOfCourses.isEmpty()) {
			System.out.println("비어있지 않음");
		course = listOfCourses.get(0);
		System.out.println("실행 완료");
		}
		return course;
	}
	
	
	public List<Course> getAllCourse(){
		String SQL = "select c.course_id, c.course_name, c.userId, c.creation_date, l.location_name, l.location_sequence "
				+ "from course c "
				+ "join course_location l on c.course_id = l.course_id";
		
		List<Course> listOfCourses = getCourseList(SQL);
		System.out.println("CourseRepository의 getAllCourse 실행 완료. 가져온 리스트 :" + listOfCourses);
		return listOfCourses;
	}
	
	public List<Course> getCourseList(String SQL){
		System.out.println("getCourseList 입장");
		Map<Long, Course> courseMap = new HashMap<>();
		List<Map<String, Object>> results = template.queryForList(SQL);
		
		for(int i = 0 ; i <results.size(); i++) {
			Map<String, Object> row = results.get(i);
			long course_id = (Long)row.get("course_id");
			
			Course course = courseMap.get(course_id);
			
			if(course==null) {
				course = new Course();
				course.setCourse_id(course_id);
				course.setCourse_name((String)row.get("course_name"));
				course.setUserId((String)row.get("userId"));
				course.setCreation_date((LocalDateTime)row.get("creation_date"));
				courseMap.put(course_id,course);
			}
			
			String location_name = (String) row.get("location_name");
			Long location_sequence = (Long) row.get("location_sequence");
			System.out.println("location_name : "+location_name);
			System.out.println("location_sequence : "+location_sequence);
			if(location_name != null && location_sequence != null) {
				System.out.println("location_name if문 입장");
				course.getLocation_names().add(location_name);
				course.getLocation_sequence().add(location_sequence);
			}
		}
		List<Course> courseList = new ArrayList<>(courseMap.values());
		return courseList;
	}
	public void updateCourse(Course course) throws Exception {
		System.out.println("CourseRepository의 updateCourse 실행됨");
		course.setCreation_date(LocalDateTime.now());
		System.out.println("updateCourse 에서 출력한 course.getLocation_names :"+course.getLocation_names());
		System.out.println("updateCourse 에서 출력한 : ");

		String SQL = "UPDATE course SET course_name=?, userId=?, creation_date=? where course_id=?";
		template.update(SQL,course.getCourse_name(), course.getUserId(), course.getCreation_date(), course.getCourse_id());
		List<String> location_names = course.getLocation_names();
		List<Long> location_sequences = course.getLocation_sequence();
		
		Course originalCourse = getOneCourse(course.getCourse_id());
		List<String> originalLocations = originalCourse.getLocation_names();
		System.out.println("여기까지 완료1");
		List<Long> originalSequences = originalCourse.getLocation_sequence();
		System.out.println("여기까지 완료2");
		System.out.println("originalSequences 출력 "+originalSequences);
		
		for(int i = 0; i<originalLocations.size();i++) {
			System.out.println("updateCourse의 첫번째 for문 입장");
			String location_name = location_names.get(i);
			System.out.println("여기까지 완료3");
			location_sequences.add(i, (long)i);
			Long location_sequence = location_sequences.get(i);
			System.out.println("여기까지 완료4");
			System.out.println("for문1 안에서 출력한 이름 : "+ location_name);
			System.out.println("for문1 안에서 출력한 순서 : "+ location_sequence);
			System.out.println("======="+i+"번 완료======");
			SQL = "UPDATE course_location SET location_name=? where course_id=? and location_sequence=?";
			template.update(SQL, location_name, course.getCourse_id(), location_sequence);
		}
		System.out.println("location_names 출력 : " + location_names);
		System.out.println("originalLocations 출력 : " + originalLocations);
		System.out.println("location_sequences 출력 : " + location_sequences);
		System.out.println("originalSequences 출력 : " + originalSequences);
		if(location_names.size()>originalLocations.size()) {
			for(int i = originalLocations.size(); i < location_names.size(); i++) {
				String location_name = location_names.get(i);
				location_sequences.add(i, (long)i);
				Long location_sequence = location_sequences.get(i);
				System.out.println("for문2 안에서 출력한 이름 : "+ location_name);
				System.out.println("for문2 안에서 출력한 순서 : "+ location_sequence);
				System.out.println("======="+i+"번 완료======");
				SQL = "INSERT INTO course_location (course_id, location_name, location_sequence)"+ "VALUES (?,?,?)";
				template.update(SQL, course.getCourse_id(), location_name, location_sequence);
			}
		}
	}
	
	public void deleteCourse(long course_id) {
		System.out.println("CourseRepository의 deleteCourse 실행됨");
		String SQL = "DELETE from course_location where course_id=?";
		this.template.update(SQL, course_id);
		SQL = "DELETE from course where course_id=?";
		this.template.update(SQL, course_id);
	}
}
