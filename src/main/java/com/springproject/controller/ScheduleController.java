package com.springproject.controller;


import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.springproject.domain.Schedule;
import com.springproject.repository.ScheduleRepositoryImpl;
import com.springproject.service.ScheduleService;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	@GetMapping
	public String requestAllSchedule(Model model) {
		List<Schedule> list = scheduleService.getAllSchedule();
		model.addAttribute("listOfSchedules", list);
		System.out.println(list.isEmpty());
		return "Schedule";
	}
	@PostMapping("/month")
	public String requestGetScheduleByMonth(@RequestParam("stringMonth") String stringMonth, Model model) {
		System.out.println("stringMonth :"+stringMonth);
		LocalDate localDate = LocalDate.parse(stringMonth + "-01");
		System.out.println("localDate : "+ localDate);
		Date date = Date.valueOf(localDate);
		System.out.println("date : "+date);
		List<Schedule> list = scheduleService.getScheduleByMonth(date);
		model.addAttribute("listOfSchedules", list);
		System.out.println(list.isEmpty());
		return "Schedule";
	}
	@PostMapping("/week")
	public String requestGetScheduleByWeek(@RequestParam("stringDate") String stringDate, Model model) {
		Date date = Date.valueOf(stringDate);
		List<Schedule> list = scheduleService.getScheduleByWeek(date);
		model.addAttribute("listOfSchedules", list);
		return "Schedule";
	}
	@GetMapping("/add")
	public String requestAddScheduleForm(@ModelAttribute("NewSchedule") Schedule NewSchedule) {
		return "addSchedule";
	}
	@PostMapping("/add")
	public String submitAddSchedule(@ModelAttribute("NewSchedule") Schedule schedule) {
//		if(result.hasErrors()) {
//			System.out.println("add Schedule error 발생");
//			return "addSchedule";
//		}
		scheduleService.addSchedule(schedule);
		return "redirect:/schedule";
	}
	
	@GetMapping("/update")
	public String requestUpdateSchedule(@ModelAttribute("updateSchedule") Schedule schedule,
										@RequestParam("schedule_id") long schedule_id,
										Model model) {
		System.out.println("updateform 이동 실행");
		System.out.println("schedule_id : "+schedule_id);
		try {
			Schedule scheduleById = scheduleService.getScheduleById(schedule_id);
			model.addAttribute("schedule", scheduleById);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "updateSchedule";
	}
	@PostMapping("/update")
	public String submitUpdateSchedule(@ModelAttribute("updateSchedule") Schedule schedule) {
		System.out.println("submitUpdateSchedule 실행");
		System.out.println("submitupdate에서 꺼낸 id : "+schedule.getSchedule_id());
		System.out.println("submitupdate에서 꺼낸 date : "+schedule.getSchedule_date());
		System.out.println("submitupdate에서 꺼낸 record : "+schedule.getSchedule_record());
		System.out.println("submitupdate에서 꺼낸 weather : "+schedule.getWeather());
		scheduleService.updateSchedule(schedule);
		return "redirect:/schedule";
	}
	@RequestMapping(value="/delete")
	public String getDeleteScheduleForm(Model model, @RequestParam("schedule_id") long schedule_id) {
		scheduleService.deleteSchedule(schedule_id);
		return "redirect:/schedule";
	}
}
