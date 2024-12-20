package com.springproject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springproject.domain.Course;
import com.springproject.domain.Location;
import com.springproject.domain.Member;
import com.springproject.service.CourseService;
import com.springproject.service.LocationService;

@Controller
@RequestMapping("/course")
public class CourseController {
	@Autowired
	private CourseService courseService;
	@Autowired
	LocationService locationService;
	@GetMapping
	public String requestAllCourse(HttpServletRequest request, Model model) {
		System.out.println("기본 get 도착 requestAllCourse");
		 HttpSession session = request.getSession(false); // 세션이 없으면 null 반환
		    if (session != null) {
		        // 세션이 존재하면 처리
		    	System.out.println("세션 존재");
		    	System.out.println(session);
		        Member member = (Member) session.getAttribute("userStatus");
		        if (member != null) {
		            // 로그인 사용자 정보 사용
		            model.addAttribute("member", member);
		        }
		    } else {
		        // 세션이 없을 경우 처리
		    	System.out.println("로그인 필요");
		        model.addAttribute("error", "로그인이 필요합니다.");
		        return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
		    }
		List<Course> list = courseService.getAllCourse();
		model.addAttribute("listOfCourses", list);
		return "Courses";
	}
	@GetMapping("/add")
	public String requestAddCourseForm(@ModelAttribute("NewCourse") Course NewCourse,
										HttpServletRequest request,
										Model model, HttpSession session) {
		session = request.getSession(false); // 세션이 없으면 null 반환
	    if (session != null) {
	        // 세션이 존재하면 처리
	    	System.out.println("세션 존재");
	    	System.out.println(session);
	        Member member = (Member) session.getAttribute("userStatus");
	        if (member != null) {
	            // 로그인 사용자 정보 사용
	        	System.out.println("member 정보 : " + member.getUserId());
	            model.addAttribute("member", member);
	        }
	    } else {
	        // 세션이 없을 경우 처리
	    	System.out.println("로그인 필요");
	        System.out.println("=================세션 없음. 로그인하세요.===============");
	        model.addAttribute("error", "로그인이 필요합니다.");
	        return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
	    }
		
		Map<String,String> selectedLocations=(Map<String, String>)session.getAttribute("selectedLocations");
		System.out.println("selectedLocations 있는지 : "+selectedLocations);
		if(selectedLocations != null) {
			System.out.println("selectedLocations null아닐 경우");
			System.out.println();
			for(int i = 0; i <selectedLocations.size(); i++) {
				String value = selectedLocations.get("selectedLocation");
				System.out.println("value = " + value);
				if(NewCourse.getLocation_names() == null) {
					System.out.println("NewCourse.getLocation_names 없는 경우");
					NewCourse.setLocation_names(new ArrayList<>());
				}
				while(NewCourse.getLocation_names().size()<=selectedLocations.size()) {
					System.out.println("NewCourse.getLocation_names 반복");
					NewCourse.getLocation_names().add(null);
				}
				
				NewCourse.getLocation_names().set(i, value);
				System.out.println("반복 "+i+"번");
			}
			session.removeAttribute("selectedLocations");
		}
		System.out.println("스킵하고 넘어왔으면 이거 뜸");
		
		model.addAttribute("NewCourse",NewCourse);
		System.out.println("NewCourse : "+NewCourse);
		System.out.println("List 있는지 확인 : " + NewCourse.getLocation_names().isEmpty());
		return "addCourse";
	}
	@GetMapping("/selectLocation")
	@ResponseBody
	public Map<String, List<Location>> requestGetLocation(Model model,
									HttpSession session,
									HttpServletRequest request) {
		System.out.println("requestGetLocation 실행");
		List<Location> locations = locationService.getAllLocation();
		Map<String, List<Location>> locationsMap = new HashMap<>();
		locationsMap.put("locations",locations);
		if( !(locations.isEmpty()) )
		{	System.out.println("locations가 비어있지 않으면 if문 실행");
			model.addAttribute("locations", locations);
			System.out.println("locations 출력"+model.getAttribute("locations"));
			request.setAttribute("locations", locations);
			System.out.println("locatoins 출력 request : "+request.getAttribute("locations"));
			session.setAttribute("locations", locations);
			System.out.println("locations 출력 session : "+session.getAttribute("locations"));
		}

		return locationsMap;
	}
	
	@PostMapping("/add")
	public String submitAddCourse(@ModelAttribute("NewCourse") Course course, HttpSession session) {
		System.out.println("submitAddcourse 실행");
		courseService.addCourse(course,session);
		return "redirect:/course";
	}
	@PostMapping("/selectReturn")
	public String handleSelectLocation(HttpSession session,
										@RequestParam("selectedLocation") String selectedLocation, 
										@ModelAttribute("NewCourse") Course updateCourse,	
										Model model) {
		System.out.println("selectReturn 실행");
		
		Map<String, String> selectedLocations = (Map<String, String>)session.getAttribute("selectedLocations");
		if(selectedLocations == null) {
			selectedLocations = new HashMap<>();
		}
		selectedLocations.put("selectedLocation", selectedLocation);
		session.setAttribute("selectedLocations", selectedLocations);
		return "redirect:/course/add";
	}
	@GetMapping("/courseFindById")
	public String submitGetCourseById(@RequestParam("submitId")String submitId, Model model) throws Exception {
		System.out.println("submitGetCourseById 실행");
		System.out.println("submitId : "+ submitId);
		List<Course> courseFindById = courseService.getCourseFindById(submitId);
		model.addAttribute("courseFindById", courseFindById);
		return "Course";
	}
	@GetMapping("/update")
	public String requestUpdateCourseForm(@ModelAttribute("updateCourse") Course course,
											@RequestParam("course_id") long course_id,
											Model model) throws Exception {
		System.out.println("updateform 이동 실행");
		System.out.println("course_id : "+course_id);
		
		Course courseByCourseId = courseService.getOneCourse(course_id);
		model.addAttribute("course", courseByCourseId);

		return "updateCourse";
	}
	@PostMapping("/update")
	public String submitUpdateCourse(@ModelAttribute("updateCourse") Course course) throws Exception {
		System.out.println("submitUpdateCourse 실행");
		courseService.updateCourse(course);
		return "redirect:/course";
	}
	@RequestMapping(value="/delete")
	public String getDeleteCourseForm(Model model, @RequestParam("course_id") long course_id) {
		courseService.deleteCourse(course_id);
		return "redirect:/course";
	}
	
}
