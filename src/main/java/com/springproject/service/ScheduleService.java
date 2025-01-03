package com.springproject.service;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.springproject.domain.Schedule;

public interface ScheduleService {
	List<Schedule> getAllSchedule();
	Schedule getScheduleById(long schedule_id) throws Exception;
	List<Schedule> getScheduleByMonth(Date date);
	List<Schedule> getScheduleByWeek(Date date);
	void updateSchedule(Schedule schedule);
	void deleteSchedule(long schedule_id);
	void addSchedule(Schedule schedule, HttpSession session);
}
