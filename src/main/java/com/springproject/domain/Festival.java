package com.springproject.domain;

import java.time.LocalDate;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Festival {
	private long fesNo;
	private String fstvlNm;
	private String opar;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate fstvlStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate fstvlEndDate;
	private String fstvlCo;
	private String mnnstNm;
	private String auspcInsttNm;
	private String suprtInsttNm;
	private String phoneNumber;
	private String homepageUrl;
	private String relateInfo;
	private String rdnmadr;
	private String lnmadr;
	private String latitude;
	private String longitude;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate referenceDate;
	public Festival(long fesNo, String fstvlNm, String opar, LocalDate fstvlStartDate, LocalDate fstvlEndDate,
			String fstvlCo, String mnnstNm, String auspcInsttNm, String suprtInsttNm, String phoneNumber,
			String homepageUrl, String relateInfo, String rdnmadr, String lnmadr, String latitude, String longitude,
			LocalDate referenceDate) {
		super();
		this.fesNo = fesNo;
		this.fstvlNm = fstvlNm;
		this.opar = opar;
		this.fstvlStartDate = fstvlStartDate;
		this.fstvlEndDate = fstvlEndDate;
		this.fstvlCo = fstvlCo;
		this.mnnstNm = mnnstNm;
		this.auspcInsttNm = auspcInsttNm;
		this.suprtInsttNm = suprtInsttNm;
		this.phoneNumber = phoneNumber;
		this.homepageUrl = homepageUrl;
		this.relateInfo = relateInfo;
		this.rdnmadr = rdnmadr;
		this.lnmadr = lnmadr;
		this.latitude = latitude;
		this.longitude = longitude;
		this.referenceDate = referenceDate;
	}
	public Festival() {
		super();
		// TODO Auto-generated constructor stub
	}
	public long getFesNo() {
		return fesNo;
	}
	public void setFesNo(long fesNo) {
		this.fesNo = fesNo;
	}
	public String getFstvlNm() {
		return fstvlNm;
	}
	public void setFstvlNm(String fstvlNm) {
		this.fstvlNm = fstvlNm;
	}
	public String getOpar() {
		return opar;
	}
	public void setOpar(String opar) {
		this.opar = opar;
	}
	public LocalDate getFstvlStartDate() {
		return fstvlStartDate;
	}
	public void setFstvlStartDate(LocalDate fstvlStartDate) {
		this.fstvlStartDate = fstvlStartDate;
	}
	public LocalDate getFstvlEndDate() {
		return fstvlEndDate;
	}
	public void setFstvlEndDate(LocalDate fstvlEndDate) {
		this.fstvlEndDate = fstvlEndDate;
	}
	public String getFstvlCo() {
		return fstvlCo;
	}
	public void setFstvlCo(String fstvlCo) {
		this.fstvlCo = fstvlCo;
	}
	public String getMnnstNm() {
		return mnnstNm;
	}
	public void setMnnstNm(String mnnstNm) {
		this.mnnstNm = mnnstNm;
	}
	public String getAuspcInsttNm() {
		return auspcInsttNm;
	}
	public void setAuspcInsttNm(String auspcInsttNm) {
		this.auspcInsttNm = auspcInsttNm;
	}
	public String getSuprtInsttNm() {
		return suprtInsttNm;
	}
	public void setSuprtInsttNm(String suprtInsttNm) {
		this.suprtInsttNm = suprtInsttNm;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getHomepageUrl() {
		return homepageUrl;
	}
	public void setHomepageUrl(String homepageUrl) {
		this.homepageUrl = homepageUrl;
	}
	public String getRelateInfo() {
		return relateInfo;
	}
	public void setRelateInfo(String relateInfo) {
		this.relateInfo = relateInfo;
	}
	public String getRdnmadr() {
		return rdnmadr;
	}
	public void setRdnmadr(String rdnmadr) {
		this.rdnmadr = rdnmadr;
	}
	public String getLnmadr() {
		return lnmadr;
	}
	public void setLnmadr(String lnmadr) {
		this.lnmadr = lnmadr;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public LocalDate getReferenceDate() {
		return referenceDate;
	}
	public void setReferenceDate(LocalDate referenceDate) {
		this.referenceDate = referenceDate;
	}
	
}
