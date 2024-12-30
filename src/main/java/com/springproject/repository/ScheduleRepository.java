package com.springproject.repository;

import java.sql.Date;
import java.util.List;

import com.springproject.domain.Schedule;

public interface ScheduleRepository {
	void addSchedule(Schedule schedule);
	Schedule getScheduleById(long schedule_id) throws Exception;
	List<Schedule> getScheduleByMonth(Date selectedMonth);
	List<Schedule> getScheduleByWeek(Date selectedDate);
	List<Schedule> getAllSchedule();
	void updateSchedule(Schedule schedule);
	void deleteSchedule(long schedule_id);
}
