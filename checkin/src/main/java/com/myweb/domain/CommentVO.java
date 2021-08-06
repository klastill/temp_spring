package com.myweb.domain;

public class CommentVO {
	private int cno;
	private int rno;
	private String writer;
	private String cmt;
	private String cmtdate;
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getRno() {
		return rno;
	}
	public String getCmt() {
		return cmt;
	}
	public void setCmt(String cmt) {
		this.cmt = cmt;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCmtdate() {
		return cmtdate;
	}
	public void setCmtdate(String regdate) {
		this.cmtdate = regdate;
	}

}
