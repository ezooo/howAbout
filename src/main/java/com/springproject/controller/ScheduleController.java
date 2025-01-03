package com.springproject.controller;


import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.springproject.domain.Schedule;
import com.springproject.service.CalendarServiceImpl;
import com.springproject.service.ScheduleService;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private CalendarServiceImpl calendarService;
	@GetMapping
	public String requestAllSchedule(@RequestParam(required = false) Integer year,
									@RequestParam(required = false) Integer month,
			  						Model model) {
		List<Schedule> list = scheduleService.getAllSchedule();
		model.addAttribute("listOfSchedules", list);
		System.out.println(list.isEmpty());
		Map<String, Object> response = calendarService.getCalendarYearMonth(year, month);
		year = (Integer) response.get("year");
		month = (Integer) response.get("month");
		System.out.println("getYearMonth 갔다온 year :"+year);
		System.out.println("getYearMonth 갔다온 month :"+month);
		List<Integer> dates = calendarService.getCalendarDates(year, month);
		List<LocalDate> realDates = calendarService.getRealDates(year, month);
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); //date 변환 형식 지정
		
		List<String> realDatesString= new ArrayList();
		for(int i = 0; i<42; i++) {
			LocalDate currentDate = realDates.get(i);
			String date = currentDate.format(formatter); //date 형식 변환한 String
			System.out.println("date 형식 변환한 결과 : "+date);
			
			realDatesString.add(date);
		}
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("preYear",response.get("preYear"));
		model.addAttribute("preMonth",response.get("preMonth"));
		model.addAttribute("nextYear",response.get("nextYear"));
		model.addAttribute("nextMonth",response.get("nextMonth"));
		model.addAttribute("dates",dates);
		model.addAttribute("realDates",realDates);
		model.addAttribute("realDatesString",realDatesString);
		return "schedule/Schedule";
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
		return "schedule/Schedule";
	}
	@PostMapping("/week")
	public String requestGetScheduleByWeek(@RequestParam("stringDate") String stringDate, Model model) {
		Date date = Date.valueOf(stringDate);
		List<Schedule> list = scheduleService.getScheduleByWeek(date);
		model.addAttribute("listOfSchedules", list);
		return "schedule/Schedule";
	}
	@GetMapping("/add")
	public String requestAddScheduleForm(@ModelAttribute("NewSchedule") Schedule NewSchedule) {
		System.out.println("requestAddScheduleForm 실행");
		return "schedule/addSchedule";
	}
	@PostMapping("/add")
	public String submitAddSchedule(@ModelAttribute("NewSchedule") Schedule schedule, HttpSession session) {
//		if(result.hasErrors()) {
//			System.out.println("add Schedule error 발생");
//			return "addSchedule";
//		}
		System.out.println("submitAddSchedule 실행");
		System.out.println("schedule 확인 : "+schedule);
		scheduleService.addSchedule(schedule, session);
		return "redirect:/schedule";
	}
	
	@GetMapping("/update")
	public String requestUpdateSchedule(@ModelAttribute("updateSchedule") Schedule schedule,
										@RequestParam("schedule_id") long schedule_id,
										Model model) {
		System.out.println("updateform 이동 실행");
		System.out.println("schedule_id : "+schedule_id);
		try {
			System.out.println("try문 진입");
			Schedule scheduleById = scheduleService.getScheduleById(schedule_id);
			System.out.println("getScheduleById 갔다옴");
			System.out.println("scheduleById 출력: "+scheduleById);
			model.addAttribute("schedule", scheduleById);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "schedule/updateSchedule";
	}
	@PostMapping("/update")
	public String submitUpdateSchedule(@ModelAttribute("updateSchedule") Schedule schedule) {
		System.out.println("submitUpdateSchedule 실행");
		System.out.println("submitupdate에서 꺼낸 id : "+schedule.getSchedule_id());
		System.out.println("submitupdate에서 꺼낸 date : "+schedule.getSchedule_date());
		System.out.println("submitupdate에서 꺼낸 record : "+schedule.getSchedule_record());
		scheduleService.updateSchedule(schedule);
		return "redirect:/schedule";
	}
	@RequestMapping(value="/delete")
	public String getDeleteScheduleForm(Model model, @RequestParam("schedule_id") long schedule_id) {
		scheduleService.deleteSchedule(schedule_id);
		return "redirect:/schedule";
	}
}
