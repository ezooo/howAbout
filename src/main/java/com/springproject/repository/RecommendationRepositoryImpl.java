package com.springproject.repository;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Recommendation;

@Repository	
public class RecommendationRepositoryImpl implements RecommendationRepository
{
	
	private JdbcTemplate template;

	@Autowired
	public void setJdbctemplate(DataSource dataSource)
	{
		this.template = new JdbcTemplate(dataSource);
	}
	String SQL;
	
	public RecommendationRepositoryImpl() 
	{	
		super();
		System.out.println("RecommendationRepositoryImpl 기본생성자 진입");
	}

	@Override
	public List<Recommendation> getAllRecommend() 
	{
		System.out.println("RecommendationRepositoryImpl getAllRecommend in");
		SQL = "select * from recommendation";	//쿼리문 작성
		List<Recommendation> recommendationList = template.query(SQL, new RecommendationRowMapper());
		
		return recommendationList;	
	}

	@Override
	public void addRecommend(Recommendation rd) 
	{
		System.out.println("RecommendationRepositoryImpl addRecommend in");
		LocalDateTime today = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년MM월dd일 HH:mm");
        rd.setRecommendDate(today.format(formatter));
		
		SQL = "insert into recommendation values(?,?,?,?,?,?,?,?)";
		template.update(SQL, rd.getRecommendId(), rd.getUserId(), rd.getRecommendTitle(), rd.getRecommendContent(), rd.getRecommendDate(),
				rd.getCategory(), rd.getArea(), rd.getStatus());
		System.out.println("addRecommend 완료");
	}

	
	@Override
	public Recommendation getRecommend(long recommendId) 
	{//추천글리스트에서 글아이디로 해당 글 찾기
		System.out.println("RecommendationRepositoryImpl getRecommend in");
		
		Recommendation recommendation = null;
		try
		{
			SQL = "select count(*) from recommendation where recommendId=?";
			int rowCount = template.queryForObject(SQL, Integer.class, recommendId);
			//등록된 전체 목록 중 검색 조건과 일치하는 레코드 갯수를 얻어오는 변수 
			// : 검색조건인 recommendId 가 등록 될 때만 db에 접근하여 목록을 조회하도록 하기 위한 것
			if(rowCount != 0)
			{
				System.out.println("찾아올 레코드가 존재합니다.");
				SQL = "select * from recommendation where recommendId=?";
				recommendation = template.queryForObject(SQL, new RecommendationRowMapper(), recommendId);
			}
		}
		catch(Exception e)
		{
			System.out.println("recommendation 비었다 !! getRecommend() 에러에러");
			e.getStackTrace();
		}
		return recommendation;
	}

	
	@Override
	public void updateRecommend(Recommendation rd) 
	{
		System.out.println("RecommendationRepositoryImpl updateRecommend in");
		SQL = "update recommendation set recommendTitle=?, recommendContent=?, category=?, area=? where recommendId=?";
		template.update(SQL, rd.getRecommendTitle(), rd.getRecommendContent(), rd.getCategory(), rd.getArea(), rd.getRecommendId());
	}

	@Override
	public void deleteRecommend(long recommendId) 
	{
		System.out.println("RecommendationRepositoryImpl deleteRecommend in");
		SQL = "delete from recommendation where recommendId=?";
		template.update(SQL, recommendId);
	}

	@Override
	public List<Recommendation> getMyRecommend(String userId) 
	{
		System.out.println("RecommendationRepositoryImpl getMyRecommend in");
		SQL = "select * from recommendation where userId=?";
		List<Recommendation> rdList = template.query(SQL, new RecommendationRowMapper(), userId);
		return rdList;
	}

	@Override
	public void setStatus(String recommendId, String status) 
	{
		System.out.println("RecommendationRepositoryImpl setStatus in");
		SQL = "update recommendation set status=? where recommendId=?";
		template.update(SQL, status, recommendId);
		
	}

}
