package com.springproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springproject.repository.WeatherRepository;

@Service
public class WeatherServiceImpl implements WeatherService
{
	@Autowired
	WeatherRepository weatherRepository;
	
	@Override
	public String getRegCode(String areaname) 
	{
		return weatherRepository.getRegCode(areaname);
	}

}
