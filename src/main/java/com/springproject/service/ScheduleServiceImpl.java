package com.springproject.service;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Schedule;
import com.springproject.repository.ScheduleRepositoryImpl;
@Service
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	private ScheduleRepositoryImpl scheduleRepository;
	@Override
	public List<Schedule> getAllSchedule() {
		// TODO Auto-generated method stub
		return scheduleRepository.getAllSchedule();
	}

	@Override
	public Schedule getScheduleById(long schedule_id) throws Exception {
		// TODO Auto-generated method stub
		return scheduleRepository.getScheduleById(schedule_id);
	}

	@Override
	public List<Schedule> getScheduleByMonth(Date date) {
		// TODO Auto-generated method stub
		return scheduleRepository.getScheduleByMonth(date);
	}

	@Override
	public List<Schedule> getScheduleByWeek(Date date) {
		// TODO Auto-generated method stub
		return scheduleRepository.getScheduleByWeek(date);
	}

	@Override
	public void addSchedule(Schedule schedule, HttpSession session) {
		System.out.println("ScheduleService의 addSchedule실행");
		scheduleRepository.addSchedule(schedule, session);
	}

	@Override
	public void updateSchedule(Schedule schedule) {
		scheduleRepository.updateSchedule(schedule);

	}

	@Override
	public void deleteSchedule(long schedule_id) {
		scheduleRepository.deleteSchedule(schedule_id);

	}


}
