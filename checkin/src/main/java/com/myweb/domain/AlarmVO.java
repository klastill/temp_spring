package com.myweb.domain;


public class AlarmVO {
	private int ano;
	private String alarmdata;
	private String rnolink;
	private int status;
	private String memberID;
	private String regdate;
	
	
	public AlarmVO() {}
	public AlarmVO(String alarmdata, String rnolink, int status, String memberID) {
		this.alarmdata = alarmdata;
		this.rnolink = rnolink;
		this.status = status;
		this.memberID = memberID;
	}
	
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
	}
	public String getAlarmdata() {
		return alarmdata;
	}
	public void setAlarmdata(String alarmdata) {
		this.alarmdata = alarmdata;
	}
	public String getRnolink() {
		return rnolink;
	}
	public void setRnolink(String rnolink) {
		this.rnolink = rnolink;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
