package com.springproject.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

public class Schedule {
	private long schedule_id;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate schedule_date;
	private String schedule_record;
	private String userId;
	public Schedule() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Schedule(long schedule_id, LocalDate schedule_date, String schedule_record, String userId) {
		super();
		this.schedule_id = schedule_id;
		this.schedule_date = schedule_date;
		this.schedule_record = schedule_record;
		this.userId = userId;
	}


	public long getSchedule_id() {
		return schedule_id;
	}

	public void setSchedule_id(long schedule_id) {
		this.schedule_id = schedule_id;
	}

	public LocalDate getSchedule_date() {
		return schedule_date;
	}

	public void setSchedule_date(LocalDate schedule_date) {
		this.schedule_date = schedule_date;
	}

	public String getSchedule_record() {
		return schedule_record;
	}

	public void setSchedule_record(String schedule_record) {
		this.schedule_record = schedule_record;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}
