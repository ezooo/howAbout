package com.springproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class homeController {
	
    @GetMapping("/")
    public String home() {
        return "index"; // 기본 페이지로 리다이렉트
    }
    
}
