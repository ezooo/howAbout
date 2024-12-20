package com.springproject.service;

import java.sql.Date;
import java.util.List;

import com.springproject.domain.Festival;

public interface FestivalService {
	List<Festival> getAllFestival();
	List<Festival> getFestivalByMonth(Date date);
	List<Festival> getFestivalByWeek(Date date);
	Festival getFestivalByNo(long fesNo) throws Exception;
	void addFestival(Festival festival);
	void updateFestival(Festival festival);
	void deleteFestival(long fesNo);
}
