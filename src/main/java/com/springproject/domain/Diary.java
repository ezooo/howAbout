package com.springproject.domain;

public class Diary 
{
	private long diaryId;
	private String userId;
	private String visit_date;
	private String visit_location;
	private String address;
	private String visit_diary;
	private String filename0;
	private String filename1;
	private String filename2;
	private String filename3;
	private String isopen;
	
	public Diary() 
	{
		super();
	}

	public String getVisit_date() {
		return visit_date;
	}
	public void setVisit_date(String visit_date) {
		this.visit_date = visit_date;
	}
	public String getVisit_diary() {
		return visit_diary;
	}
	public void setVisit_diary(String visit_diary) {
		this.visit_diary = visit_diary;
	}
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getDiaryId() {
		return diaryId;
	}

	public void setDiaryId(long diaryId) {
		this.diaryId = diaryId;
	}

	public String getVisit_location() {
		return visit_location;
	}

	public void setVisit_location(String visit_location) {
		this.visit_location = visit_location;
	}
	public String getFilename1() {
		return filename1;
	}
	
	public void setFilename1(String filename1) {
		this.filename1 = filename1;
	}
	
	public String getFilename2() {
		return filename2;
	}
	
	public void setFilename2(String filename2) {
		this.filename2 = filename2;
	}
	
	public String getFilename3() {
		return filename3;
	}
	
	public void setFilename3(String filename3) {
		this.filename3 = filename3;
	}
	
	public String getFilename0() {
		return filename0;
	}
	
	public void setFilename0(String filename0) {
		this.filename0 = filename0;
	}

	public String getIsopen() {
		return isopen;
	}

	public void setIsopen(String isopen) {
		this.isopen = isopen;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}


}
