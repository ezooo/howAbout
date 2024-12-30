package com.springproject.domain;

public class WeatherNow {
	private String baseDate; //발표일자 00000000
	private String baseTime; //발표시각 0000
	private String category; //자료구분문자
	private String fcstDate; //예측 일자
	private String fcstTime;//예보 시각
	private String fcstValue;//예보 값
	private String nx; //예보지점 X좌표
	private String ny; //예보지점 Y좌표
	public WeatherNow(String baseDate, String baseTime, String category, String fcstDate, String fcstTime,
			String fcstValue, String nx, String ny) {
		super();
		this.baseDate = baseDate;
		this.baseTime = baseTime;
		this.category = category;
		this.fcstDate = fcstDate;
		this.fcstTime = fcstTime;
		this.fcstValue = fcstValue;
		this.nx = nx;
		this.ny = ny;
	}
	public WeatherNow() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}
	public String getBaseTime() {
		return baseTime;
	}
	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getFcstDate() {
		return fcstDate;
	}
	public void setFcstDate(String fcstDate) {
		this.fcstDate = fcstDate;
	}
	public String getFcstTime() {
		return fcstTime;
	}
	public void setFcstTime(String fcstTime) {
		this.fcstTime = fcstTime;
	}
	public String getFcstValue() {
		return fcstValue;
	}
	public void setFcstValue(String fcstValue) {
		this.fcstValue = fcstValue;
	}
	public String getNx() {
		return nx;
	}
	public void setNx(String nx) {
		this.nx = nx;
	}
	public String getNy() {
		return ny;
	}
	public void setNy(String ny) {
		this.ny = ny;
	}
	
}
