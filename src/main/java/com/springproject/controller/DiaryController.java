package com.springproject.controller;

import java.io.File;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springproject.domain.Diary;
import com.springproject.domain.Member;
import com.springproject.service.DiaryService;

@Controller	//저는 컨트롤러에요
@RequestMapping(value="/diaries")
public class DiaryController 
{
	@Autowired	//객체 생성하기
	private DiaryService diaryService;

	@RequestMapping
	public String showDiary(Model model, HttpServletRequest request)
	{
		List<Diary> list = diaryService.getAllDiary();
		model.addAttribute("diaryList", list);

		return "diary/diaries";
	}
	
	@GetMapping("/my")
	public String showMyDiary(Model model, HttpServletRequest request)
	{
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
					List<Diary> list = diaryService.getMyDiary(userId);
					
					model.addAttribute("diaryList", list);
					return "diary/mydiaries";
				}
				System.out.println("세션은 있는데 로그인 안됐음");
				return "redirect:/user/login";
			}
		}
		return "redirect:/user/login";
	}

	@GetMapping("/diary/{diaryId}")
	public String getOnediary(@PathVariable Long diaryId, Model model)
	{
		System.out.println("DiaryController getOnediary in");
		Diary diary = diaryService.getOnediary(diaryId);
		model.addAttribute("diary", diary);
		return "diary/diary";
	}
	
	@GetMapping("/addDiary")
	public String addDiaryForm(@ModelAttribute Diary diary, HttpSession session)
	{
		Member member = (Member)session.getAttribute("userStatus");
		System.out.println(member);
		
		if(member == null)
		{
			return "redirect:/user/login";
		}
		return "diary/addDiary";
	}
	
	@PostMapping("/addDiary")
	public String submitDiaryForm(@ModelAttribute Diary diary,
			@RequestParam("uploadFile") MultipartFile[] multifiles, 
			HttpServletRequest req)
	{	//addDiary 에서 제출한 내용 처리할 메서드
		System.out.println("DiaryController - submitDiaryForm in");
		//다이어리 아이디 주기
		Member mb = (Member)req.getSession().getAttribute("userStatus");
		diary.setUserId(mb.getUserId());
		diary.setDiaryId(System.currentTimeMillis());
		
		diary.setVisit_date(req.getParameter("visit_date"));
		diary.setVisit_location(req.getParameter("visit_location"));
		diary.setAddress(req.getParameter("address"));
		diary.setVisit_diary(req.getParameter("visit_diary"));
		diary.setIsopen(req.getParameter("isopen"));

		String[] files = new String[4];
		String path = "/resources/images";
		String savepath = req.getServletContext().getRealPath(path);
		System.out.println(savepath);
		File savefile;
		
		for(int i = 0; i<multifiles.length; i++)
		{
			if(multifiles[i] != null && !(multifiles[i].isEmpty()) )
			{
				String file_name = multifiles[i].getOriginalFilename();
				String[] namearr = file_name.split("\\.");
				String filename = namearr[0];

				String savename = diary.getDiaryId()+filename+".png" ;
				System.out.println("savename : "+savename);
				
				// 파일 작성하기
				savefile = new File(savepath, savename);
				try 
				{
					multifiles[i].transferTo(savefile);
					System.out.println("addDiary 에서 이미지 저장완료");
				} 
				catch (Exception e) 
				{
					System.out.println("addDiary 에서 이미지 저장 에러에러");
					e.printStackTrace();
				}
				files[i] = savename ;
				System.out.println("새로운 이미지 이름 덮어쓰기 완료 : "+i);
			}
			else
			{
				String savename = "00000000diary.png";
				files[i] = savename ;
			}
		}
		diary.setFilename0(files[0]);
		diary.setFilename1(files[1]);
		diary.setFilename2(files[2]);
		diary.setFilename3(files[3]);
		
		diaryService.setNewDiary(diary);
		return "redirect:/diaries/diary/"+diary.getDiaryId() ;
	}
	
	@GetMapping("/updateDiary")
	public String updateDiary(@ModelAttribute Diary diary, @RequestParam("id") long diaryId, Model model)
	{
		System.out.println("DiaryController - updateDiary in");
		System.out.println("수정할 다이어리 아이디 받아옴 : "+diaryId);
		Diary diaryById = diaryService.getDiaryById(diaryId);
		System.out.println("다이어리 찾아옴 수정페이지로 이동.. 하기전에 다이어리 정보 모델에 넣기");
		model.addAttribute("diaryById",diaryById);
		return "diary/updateDiary";
	}
	
	@PostMapping("/updateDiary")
	public String submitUpdateDiary(@ModelAttribute Diary diary, 
			@RequestParam("uploadFile") MultipartFile[] multifiles, HttpServletRequest req)
	{
		System.out.println("DiaryController - submitUpdateDiary in");
		String[] files = new String[4];

		String path = "/resources/images";
		String savepath = req.getServletContext().getRealPath(path);
		File savefile;
		
		for(int i = 0; i<multifiles.length; i++)
		{
			if(multifiles[i] != null && !(multifiles[i].isEmpty()) )
			{
				String file_name = multifiles[i].getOriginalFilename();
				String[] namearr = file_name.split("\\.");
				System.out.println(namearr);
				String filename = namearr[0];

				String savename = diary.getDiaryId()+filename+".png" ;
				System.out.println("savename : "+savename);

				savefile = new File(savepath, savename);
				try 
				{
					multifiles[i].transferTo(savefile);
					System.out.println("updateDiary 에서 이미지 저장완료");
				} 
				catch (Exception e) 
				{
					System.out.println("updateDiary 에서 이미지 저장 에러에러");
					e.printStackTrace();
				}
				files[i] = savename ;
			}
			else
			{
				String savename = "00000000diary.png";
				files[i] = savename ;
			}
		}
		diary.setFilename0(files[0]);
		diary.setFilename1(files[1]);
		diary.setFilename2(files[2]);
		diary.setFilename3(files[3]);
		
		diaryService.setUpdateDiary(diary);
		return "redirect:/diaries/diary/"+diary.getDiaryId();
	}
	
	@GetMapping("/deleteDiary")
	public String deleteDiary(@ModelAttribute Diary diary, @RequestParam("id") long diaryId)
	{
		diaryService.deleteDiary(diaryId);
		return "redirect:/diaries";
	}
}
