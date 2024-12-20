package com.springproject.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Festival;
import com.springproject.repository.FestivalRepositoryImpl;
@Service
public class FestivalServiceImpl implements FestivalService {
	@Autowired
	private FestivalRepositoryImpl festivalRepository;
	@Override
	public List<Festival> getAllFestival() {
		// TODO Auto-generated method stub
		return festivalRepository.getAllFestival();
	}

	@Override
	public List<Festival> getFestivalByMonth(Date date) {
		// TODO Auto-generated method stub
		return festivalRepository.getFestivalByMonth(date);
	}

	@Override
	public List<Festival> getFestivalByWeek(Date date) {
		// TODO Auto-generated method stub
		return festivalRepository.getFestivalByWeek(date);
	}

	@Override
	public Festival getFestivalByNo(long fesNo) throws Exception {
		Festival festivalByNo = festivalRepository.getFestivalByNo(fesNo);
		return festivalByNo;
	}

	@Override
	public void addFestival(Festival festival) {
		festivalRepository.addFestival(festival);

	}

	@Override
	public void updateFestival(Festival festival) {
		festivalRepository.updateFestival(festival);

	}

	@Override
	public void deleteFestival(long fesNo) {
		festivalRepository.deleteFestival(fesNo);

	}

}
