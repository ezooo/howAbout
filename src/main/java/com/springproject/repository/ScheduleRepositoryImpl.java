package com.springproject.repository;


import java.sql.Date;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Member;
import com.springproject.domain.Schedule;
@Repository
public class ScheduleRepositoryImpl {
	
	private JdbcTemplate template;
	
	Schedule schedule = null;
	@Autowired
	public void setJdbcTemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}
	
	public void addSchedule(Schedule schedule,HttpSession session) {
		System.out.println("ScheduleRepository의 addSchedule 실행됨");
		schedule.setSchedule_id(System.currentTimeMillis());
		System.out.println("session member 정보 출력 : "+session.getAttribute("userStatus"));
		Member member=(Member)session.getAttribute("userStatus");
		schedule.setUserId(member.getUserId());
		System.out.println("getuserId 출력 : "+schedule.getUserId());
		String SQL = "INSERT INTO schedule (schedule_id, schedule_date, schedule_record, userId)"+ "VALUES (?,?,?,?)";
		template.update(SQL, schedule.getSchedule_id(), schedule.getSchedule_date(), schedule.getSchedule_record(), schedule.getUserId());
	}
	public Schedule getScheduleById(long schedule_id) throws Exception {
		System.out.println("ScheduleRepository의 getScheduleById 실행됨");
		String SQL = "SELECT count(*) FROM schedule where schedule_id=?";
		int rowCount = template.queryForObject(SQL,Integer.class,schedule_id);
		
		if(rowCount != 0) {
			SQL = "SELECT * FROM schedule where schedule_id=?";
			schedule = template.queryForObject(SQL, new ScheduleRowMapper(),schedule_id);
		}
		if (schedule == null)
			throw new Exception();
		System.out.println("getscheduleid로 꺼낸 id : "+schedule.getSchedule_id());
		return schedule;
	}
	
	public List<Schedule> getScheduleByMonth(Date selectedMonth) {
		System.out.println("ScheduleRepository의 getScheduleByMonth 실행됨");
		System.out.println("타입: " + selectedMonth.getClass());
//		System.out.println("instanceof java.sql.Date: " + (selectedMonth instanceof java.sql.Date));
		System.out.println("selectedMonth 타입: " + selectedMonth.getClass());
	    System.out.println("selectedMonth 값: " + selectedMonth);
//	    System.out.println("selectedMonth 밀리초: " + selectedMonth.getTime());
	    

	    String SQL = "SELECT * FROM schedule WHERE YEAR(schedule_date) = YEAR(?) AND MONTH(schedule_date) = MONTH(?)";
		List<Schedule> schedulesByMonth = template.query(SQL,new ScheduleRowMapper(),selectedMonth,selectedMonth);
		
		return schedulesByMonth;
	}
	
	public List<Schedule> getScheduleByWeek(Date selectedDate) {
		System.out.println("ScheduleRepository의 addSchedule 실행됨");
		
		String SQL = "SELECT * FROM schedule WHERE YEAR(schedule_date) = YEAR(?) AND WEEK(schedule_date, 1) = WEEK(?, 1)";
		List<Schedule> schedulesByWeek = template.query(SQL, new Object[]{selectedDate, selectedDate}, new ScheduleRowMapper());
		return schedulesByWeek;
	}
	public List<Schedule> getAllSchedule(){
		String SQL = "SELECT * FROM schedule";
		List<Schedule> listOfSchedules = template.query(SQL, new ScheduleRowMapper());
		System.out.println("ScheduleRepository의 getAllSchedule 실행 완료. 가져온 리스트 :" + listOfSchedules);
		return listOfSchedules;
	}
	public void updateSchedule(Schedule schedule) {
		System.out.println("수정할 date : "+schedule.getSchedule_date());
		System.out.println("수정할 record : "+schedule.getSchedule_record());
		System.out.println("수정할 id : "+schedule.getSchedule_id());
		
		System.out.println("ScheduleRepository의 updateSchedule 실행됨");
		String SQL = "UPDATE schedule SET schedule_date=?, schedule_record=? where schedule_id=?";
		template.update(SQL, schedule.getSchedule_date(), schedule.getSchedule_record(), schedule.getSchedule_id());
	}
	public void deleteSchedule(long schedule_id) {
		System.out.println("ScheduleRepository의 deleteSchedule 실행됨");
		String SQL = "DELETE from schedule where schedule_id=?";
		this.template.update(SQL,schedule_id);
	}
}
