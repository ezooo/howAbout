package com.springproject.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.springproject.domain.Diary;
import com.springproject.domain.Member;
import com.springproject.domain.Recommendation;
import com.springproject.service.RecommendationService;

@Controller
@RequestMapping("/recommend")
public class RecommendationController 
{
	@Autowired
	RecommendationService recommendationService;

	@RequestMapping
	public String getAllRecommend(Model model)
	{
		System.out.println("RecommendationController getAllRecommend in");
		List<Recommendation> recommendationList = recommendationService.getAllRecommend();
		
		model.addAttribute("recommendationList", recommendationList);
		
		return "recommendation/recommendations";	//2. 이동할 뷰까지 작성해놓기
	}
	
	@GetMapping("/my")
	public String getMyRecommend(Model model, HttpServletRequest request)
	{
		System.out.println("RecommendationController getMyRecommend in");
		String sessionid;
		if(request.getSession(false) != null)
		{
			sessionid = request.getSession(false).getId();
			if(sessionid != null)
			{
				Member mb = (Member) request.getSession(false).getAttribute("userStatus");
				if(mb !=  null)
				{
					String userId = mb.getUserId();
					System.out.println("로그인 한 유저 아이디는 : "+userId);
					List<Recommendation> recommendationList = recommendationService.getMyRecommend(userId);
					
					model.addAttribute("recommendationList", recommendationList);
					return "recommendation/myRecommend";
				}
				System.out.println("세션은 있는데 로그인 안됐음");
				return "redirect:/user/login";
			}
		}
		System.out.println("로그인 안되어있다 : 다이어리 구조만 보여주기");
		return "redirect:/user/login";
	}
	
	// CREATE
	@GetMapping("/addRecommend")
	public String addRecommendation(Model model, HttpServletRequest request)
	{
		System.out.println("RecommendationController addRecommendation in");
		String sessionid;
		if(request.getSession(false) != null)
		{
			sessionid = request.getSession(false).getId();
			if(sessionid != null)
			{
				Member mb = (Member) request.getSession(false).getAttribute("userStatus");
				if(mb !=  null)
				{
					model.addAttribute("recommendation", new Recommendation());
					return "recommendation/addRecommendation";
				}
				System.out.println("세션은 있는데 로그인 안됐음");
				return "redirect:/user/login";
			}
		}
		System.out.println("로그인 안되어있다 : 다이어리 구조만 보여주기");
		return "redirect:/user/login";
	}
	@PostMapping("/addRecommend")
	public String addSubmitRecommendation(@ModelAttribute Recommendation recommendation, HttpServletRequest req)
	{
		System.out.println("RecommendationController addSubmitRecommendation in");
		Member mb = (Member)req.getSession().getAttribute("userStatus");
		recommendation.setUserId(mb.getUserId());
		recommendation.setRecommendId(System.currentTimeMillis());
		recommendation.setStatus("미확인");
		recommendationService.addRecommend(recommendation);
		
		return "redirect:/recommend";
	}
	
	// READ ONE : 제목만 보여주고 내용은 들어가야 볼 수 있음
	@GetMapping("/recommendation/{recommendId}")
	public String getRecommend(@PathVariable long recommendId, Model model)	//변수 받아온다 
	{
		System.out.println("RecommendationController getRecommend in");
		
		try
		{
			Recommendation recommendation = recommendationService.getRecommend(recommendId);
			// 근데 게시글 받아온게 null 이면 에러남
			if(recommendation != null)
			{
				System.out.println(" 추천 게시글 잘 찾아서 컨트롤러로 돌아옴");
				model.addAttribute("recommendation",recommendation);	//뷰에 가서 꺼내려면 담아야 함
				return "recommendation/recommendation";
			}
		}
		catch(Exception e)
		{
			System.out.println("RecommendationController getRecommend 에러에러");
			e.getStackTrace();
		}
		
		System.out.println(" 추천 게시글 못찾음. 목록으로 가라");
		System.out.println("recommendId : "+recommendId);
		return "redirect:/recommend";
	}

	@GetMapping("/update/{recommendId}")
	public String updateRecommend(@PathVariable long recommendId, Model model)
	{	
		System.out.println("RecommendationController updateRecommend get in");
		Recommendation recommendation = recommendationService.getRecommend(recommendId);
		model.addAttribute("recommendation",recommendation);
		System.out.println("수정할 게시글 찾ㅇ아옴. 수정페이지로 감");
		return "recommendation/updateRecommendation";
	}
	
	@PostMapping("/update/{recommendId}")
	public String updateSubmitRecommend(@ModelAttribute Recommendation recommendation)
	{
		System.out.println("RecommendationController updateRecommend post in");
		recommendationService.updateRecommend(recommendation);
		
		return "redirect:/recommend/recommendation/{recommendId}";
	}
	
	@GetMapping("/delete/{recommendId}")
	public String deleteRecommend(@PathVariable long recommendId)
	{
		System.out.println("RecommendationController deleteRecommend  in");
		recommendationService.deleteRecommend(recommendId);
		
		return "redirect:/recommend";
	}
	
	@PostMapping("/setStatus")
	public ResponseEntity<String> setStatus(@RequestBody String jsonString) throws Exception
	{
		System.out.println("RecommendationController setStatus  in");
        // JSON 파싱
        JSONObject jsonObject = new JSONObject(jsonString);
        String recommendId = jsonObject.getString("recommendId"); // recommendId 추출
        String status = jsonObject.getString("status"); // status 추출
        recommendationService.setStatus(recommendId, status);
        System.out.println("컨트롤러 setStatus 완료");
        // 성공 응답 반환
        return ResponseEntity.ok("{\"message\": \"상태 업데이트 성공\"}");
	}
}
