package com.springproject.repository;

import java.time.LocalDate;

import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Festival;


@Repository
public class FestivalRepositoryImpl implements FestivalRepository{
	private JdbcTemplate template;
	
	@Autowired
	public void setJdbcTemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}
	Festival festival = null;
	public void addFestival(Festival festival) {
		System.out.println("FestivalRepository의 addFestival 실행됨");
		festival.setReferenceDate(LocalDate.now());
		System.out.println("add일 : "+festival.getReferenceDate());
		String SQL = "INSERT INTO festival (fstvlNm,opar,fstvlStartDate,fstvlEndDate,fstvlCo,mnnstNm,auspcInsttNm,suprtInsttNm,phoneNumber,homepageUrl,relateInfo,rdnmadr,lnmadr,latitude,longitude,referenceDate)"
				+"VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		template.update(SQL, festival.getFstvlNm(), festival.getOpar(),festival.getFstvlStartDate(),festival.getFstvlEndDate(),festival.getFstvlCo(),festival.getMnnstNm(),festival.getAuspcInsttNm(),festival.getSuprtInsttNm(),festival.getPhoneNumber(),festival.getHomepageUrl(),festival.getRelateInfo(),festival.getRdnmadr(),festival.getLnmadr(), festival.getLatitude(),festival.getLongitude(),festival.getReferenceDate());
	}

	public Festival getFestivalByNo(long fesNo) throws Exception {
		
		System.out.println("FestivalRepository의 getFestivalByNo 실행됨");
		String SQL = "SELECT count(*) FROM festival where fesNo=?";
		int rowCount = template.queryForObject(SQL,Integer.class,fesNo);
		
		if(rowCount != 0) {
			SQL = "SELECT * FROM festival where fesNo=?";
			festival = template.queryForObject(SQL, new FestivalRowMapper(),fesNo);
		}
		if (festival == null)
			throw new Exception();
		System.out.println("getFestivalByNo로 꺼낸 fesNo : "+festival.getFesNo());
		return festival;
	}	
	public List<Festival> getFestivalByMonth(Date selectedMonth) {
		System.out.println("FestivalRepository의 getFestivalByMonth 실행됨");
		String SQL = "SELECT * FROM festival WHERE (YEAR(fstvlStartDate) = YEAR(?) AND MONTH(fstvlStartDate) = MONTH(?)) OR (YEAR(fstvlEndDate) = YEAR(?) AND MONTH(fstvlEndDate) = MONTH(?))";
		List<Festival> festivalsByMonth = template.query(SQL,new FestivalRowMapper(),selectedMonth,selectedMonth,selectedMonth,selectedMonth);
		
		return festivalsByMonth;
	}
	
	public List<Festival> getFestivalByWeek(Date selectedWeek) {
		System.out.println("FestivalRepository의 getFestivalByWeek 실행됨");
		String SQL = "SELECT * FROM festival WHERE (YEAR(fstvlStartDate) = YEAR(?) AND WEEK(fstvlStartDate, 1) = WEEK(?, 1)) OR (YEAR(fstvlEndDate) = YEAR(?) AND WEEK(fstvlEndDate, 1) = WEEK(?, 1))";
		List<Festival> festivalsByWeek = template.query(SQL, new Object[]{selectedWeek,selectedWeek,selectedWeek,selectedWeek}, new FestivalRowMapper());
		return festivalsByWeek;
	}
	public List<Festival> getAllFestival(){
		String SQL = "SELECT * FROM festival";
		List<Festival> listOfFestivals = template.query(SQL, new FestivalRowMapper());
		System.out.println("FestivaleRepository의 getAllFestival 실행 완료. 가져온 리스트 :" + listOfFestivals);
		return listOfFestivals;
	}	
	public void updateFestival(Festival festival) {
		System.out.println("FestivalRepository의 updateFestival 실행됨");
		festival.setReferenceDate(LocalDate.now());
		String SQL = "UPDATE festival SET fstvlNm=?,opar=?,fstvlStartDate=?,fstvlEndDate=?,fstvlCo=?,mnnstNm=?,auspcInsttNm=?,suprtInsttNm=?,phoneNumber=?,homepageUrl=?,relateInfo=?,rdnmadr=?,lnmadr=?,latitude=?,longitude=?,referenceDate=? where fesNo=?";
		template.update(SQL, festival.getFstvlNm(), festival.getOpar(),festival.getFstvlStartDate(),festival.getFstvlEndDate(),festival.getFstvlCo(),festival.getMnnstNm(),festival.getAuspcInsttNm(),festival.getSuprtInsttNm(),festival.getPhoneNumber(),festival.getHomepageUrl(),festival.getRelateInfo(),festival.getRdnmadr(),festival.getLnmadr(), festival.getLatitude(),festival.getLongitude(),festival.getReferenceDate(),festival.getFesNo());
	}
	public void deleteFestival(long fesNo) {
		System.out.println("FestivalRepository의 deleteFestival 실행됨");
		String SQL = "DELETE from festival where fesNo=?";
		this.template.update(SQL,fesNo);
	}
}
