package com.springproject.repository;

import java.util.Date;
import java.util.List;

import com.springproject.domain.Festival;

public interface FestivalRepository {
	void addFestival(Festival festival);
	Festival getFestivalByNo(long fesNo) throws Exception;
	List<Festival> getFestivalByMonth(Date selectedMonth);
	List<Festival> getFestivalByWeek(Date selectedWeek);
	List<Festival> getAllFestival();
	void updateFestival(Festival festival);
	void deleteFestival(long fesNo);
}
