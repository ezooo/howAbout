package com.springproject.controller;


import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.springproject.domain.Festival;
import com.springproject.service.FestivalService;

@Controller
@RequestMapping("/festival")
public class FestivalController {
	
	@Autowired
	private FestivalService festivalService;
	
	private JdbcTemplate template;
	
	@Autowired
	public void setJdbcTemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@GetMapping
	public String requestAllFestival(Model model) throws IOException {
		System.out.println("requestAllFestival 실행됨");

		Resource resource = resourceLoader.getResource("classpath:festivalList.json");
		InputStream is = resource.getInputStream();
		if(is==null) {
			throw new NullPointerException("Cannot find resource file");
		}
		JSONTokener tokener = new JSONTokener(is);
		JSONObject object = new JSONObject(tokener);
		JSONArray records = object.getJSONArray("records");
		
		String SQL = "INSERT IGNORE INTO festival_db (fstvlNm,opar,fstvlStartDate,fstvlEndDate,fstvlCo,mnnstNm,auspcInsttNm,suprtInsttNm,phoneNumber,homepageUrl,relateInfo,rdnmadr,lnmadr,latitude,longitude,referenceDate)"
				+"VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		for(int i=0; i<records.length(); i++) {
			JSONObject fes=(JSONObject)records.get(i);
			String value1 = fes.getString("축제명");
			String value2 = fes.getString("개최장소");
			String value3 = fes.getString("축제시작일자");
			String value4 = fes.getString("축제종료일자");
			String value5 = fes.getString("축제내용");
			String value6 = fes.getString("주관기관명");
			String value7 = fes.getString("주최기관명");
			String value8 = fes.getString("후원기관명");
			String value9 = fes.getString("전화번호");
			String value10 = fes.getString("홈페이지주소");
			String value11 = fes.getString("관련정보");
			String value12 = fes.getString("소재지도로명주소");
			String value13 = fes.getString("소재지지번주소");
			String value14 = fes.getString("위도");
			String value15 = fes.getString("경도");
			String value16 = fes.getString("데이터기준일자");
			
			template.update(SQL, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16);
			System.out.println("update 완료 "+i+"번째 성공");
			
		}
		SQL = "insert IGNORE into festival(fstvlNm,opar,fstvlStartDate,fstvlEndDate,fstvlCo,mnnstNm,auspcInsttNm,suprtInsttNm,phoneNumber,homepageUrl,relateInfo,rdnmadr,lnmadr,latitude,longitude,referenceDate)"
				+ " select fstvlNm,opar,fstvlStartDate,fstvlEndDate,fstvlCo,mnnstNm,auspcInsttNm,suprtInsttNm,phoneNumber,homepageUrl,relateInfo,rdnmadr,lnmadr,latitude,longitude,referenceDate from festival_db"
				+ " where rdnmadr like '경상남도%' or lnmadr like '경상남도%'";
		template.update(SQL);
		System.out.println("festival db 필터링 table 생성 완료");
	

		List<Festival> list = festivalService.getAllFestival();
		model.addAttribute("listOfFestivals", list);
		System.out.println(list.isEmpty());
		return "festival/Festivals";
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
		return "festival/Festivals";
	}
	@PostMapping("/week")
	public String requestGetFestivalByWeek(@RequestParam("stringDate") String stringDate, Model model) {
		System.out.println("requestGetFestivalByWeek실행됨");
		Date date = Date.valueOf(stringDate);
		List<Festival> list = festivalService.getFestivalByWeek(date);
		model.addAttribute("listOfFestivals", list);
		return "festival/Festivals";
	}
	@GetMapping("/festivalNo")
	public String requestGetFestivalByNo(@RequestParam("fesNo") long fesNo, Model model) throws Exception {
		System.out.println("requestGetFestivalByNo 실행됨");
		Festival festivalByNo = festivalService.getFestivalByNo(fesNo);
		model.addAttribute("festival", festivalByNo);
		return "festival/Festival";
	}
	@GetMapping("/add")
	public String requestAddFestivalForm(@ModelAttribute("NewFestival") Festival NewFestival) {
		System.out.println("requestAddFestivalform 실행됨");
		return "festival/addFestival";
	}
	@PostMapping("/add")
	public String submitAddFestival(@ModelAttribute("NewFestival") Festival festival) {
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
		return "festival/updateFestival";
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
