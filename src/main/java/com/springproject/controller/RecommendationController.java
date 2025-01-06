package com.springproject.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
	//2. 일단 모든 추천글 보기 함수 만들기  READ
	@RequestMapping
	public String getAllRecommend(Model model)
	{								//6.
		System.out.println("RecommendationController getAllRecommend in");
		List<Recommendation> recommendationList = recommendationService.getAllRecommend();
		
		model.addAttribute("recommendationList", recommendationList);
		
		return "recommendation/recommendations";	//2. 이동할 뷰까지 작성해놓기
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
}
