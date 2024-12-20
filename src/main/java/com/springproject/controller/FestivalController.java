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


import com.springproject.domain.Festival;

import com.springproject.repository.FestivalRepositoryImpl;
import com.springproject.service.FestivalService;

@Controller
@RequestMapping("/festival")
public class FestivalController {
	
	@Autowired
	private FestivalService festivalService;
	@GetMapping
	public String requestAllFestival(Model model) {
		System.out.println("requestAllFestival 실행됨");
		List<Festival> list = festivalService.getAllFestival();
		model.addAttribute("listOfFestivals", list);
		System.out.println(list.isEmpty());
		return "Festivals";
	}
	@PostMapping("/month")
	public String requestGetFestivalByMonth(@RequestParam("stringMonth") String stringMonth, Model model) {
		System.out.println("requestGetFestivalByMonth 실행됨");
		System.out.println("stringMonth :"+stringMonth);
		LocalDate localDate = LocalDate.parse(stringMonth + "-01");
		System.out.println("localDate : "+ localDate);
		Date date = Date.valueOf(localDate);
		System.out.println("date : "+date);
		List<Festival> list = festivalService.getFestivalByMonth(date);
		model.addAttribute("listOfFestivals", list);
		System.out.println(list.isEmpty());
		return "Festivals";
	}
	@PostMapping("/week")
	public String requestGetFestivalByWeek(@RequestParam("stringDate") String stringDate, Model model) {
		System.out.println("requestGetFestivalByWeek실행됨");
		Date date = Date.valueOf(stringDate);
		List<Festival> list = festivalService.getFestivalByWeek(date);
		model.addAttribute("listOfFestivals", list);
		return "Festivals";
	}
	@GetMapping("/festivalNo")
	public String requestGetFestivalByNo(@RequestParam("fesNo") long fesNo, Model model) throws Exception {
		System.out.println("requestGetFestivalByNo 실행됨");
		Festival festivalByNo = festivalService.getFestivalByNo(fesNo);
		model.addAttribute("festival", festivalByNo);
		return "Festival";
	}
	@GetMapping("/add")
	public String requestAddFestivalForm(@ModelAttribute("NewFestival") Festival NewFestival) {
		System.out.println("requestAddFestivalform 실행됨");
		return "addFestival";
	}
	@PostMapping("/add")
	public String submitAddFestival(@ModelAttribute("NewFestival") Festival festival) {
//		if(result.hasErrors()) {
//			System.out.println("add Festival error 발생");
//			return "addFestival";
//		}
		System.out.println("submitAddFestival 실행됨");
		festivalService.addFestival(festival);
		return "redirect:/festival";
	}
	
	@GetMapping("/update")
	public String requestUpdateFestival(@ModelAttribute("updateFestival") Festival Festival,
										@RequestParam("fesNo") long fesNo,
										Model model) {
		System.out.println("festival updateform 이동 실행");
		System.out.println("fesNo : "+fesNo);
		try {
			Festival festivalById = festivalService.getFestivalByNo(fesNo);
			model.addAttribute("festival", festivalById);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "updateFestival";
	}
	@PostMapping("/update")
	public String submitUpdateFestival(@ModelAttribute("updateFestival") Festival festival) {
		System.out.println("submitUpdateFestival 실행");
		festivalService.updateFestival(festival);
		return "redirect:/festival";
	}
	@RequestMapping(value="/delete")
	public String getDeleteFestivalForm(Model model, @RequestParam("fesNo") long fesNo) {
		System.out.println("deleteFestivalform 실행됨");
		festivalService.deleteFestival(fesNo);
		return "redirect:/festival";
	}
}
