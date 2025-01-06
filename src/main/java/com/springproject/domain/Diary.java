package com.springproject.domain;

public class Diary 
{
	//String diaryId;	//이 아이디 가지고 멤버의 다이어리 찾아줘야 함
	private long diaryId;
	private String userId;	//이 아이디 가진 다이어리 찾아줘야 함
	private String visit_date;
	private String visit_location;
	private String address;
	private String visit_diary;
	//private MultipartFile picture1;
	private String filename0;
	private String filename1;
	private String filename2;
	private String filename3;
	private String isopen;
	//private String diaryId;	//다이어리 수정 삭제하려니까 이거 필요함.. 이게 pk 인듯
	//private int number = 0;
	//private LocalDateTime diaryId;	
	
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
//	public MultipartFile getPicture() {
//		return picture;
//	}
//	public void setPicture(MultipartFile picture) {
//		this.picture = picture;
//	}
//	
//	public String getFilename() {
//		return filename;
//	}
//
//	public void setFilename(String filename) {
//		this.filename = filename;
//	}

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

//	public String getDiaryId() {
//		return diaryId;
//	}
//	public void setDiaryId(String diaryId) {
//		this.diaryId = diaryId;
//	}
//	public int getNumber() {
//		return number;
//	}
//
//	public void setNumber(int number) {
//		this.number = number;
//	}
	
	
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
