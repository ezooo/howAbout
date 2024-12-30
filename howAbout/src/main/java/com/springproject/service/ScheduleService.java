package com.springproject.service;

import java.sql.Date;
import java.util.List;

import com.springproject.domain.Schedule;

public interface ScheduleService {
	List<Schedule> getAllSchedule();
	Schedule getScheduleById(long schedule_id);
	List<Schedule> getScheduleByMonth(Date date);
	List<Schedule> getScheduleByWeek(Date date);
	void addSchedule(Schedule schedule);
	void updateSchedule(Schedule schedule);
	void deleteSchedule(long schedule_id);
}
