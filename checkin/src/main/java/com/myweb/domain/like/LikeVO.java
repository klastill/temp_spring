package com.myweb.domain.like;


//좋아요VO by 동현, 2021/07/08
public class LikeVO {
	//자동 증가 넘버
	private int likeNo;
	//좋아요 누른 멤버 번호
	private int mno;
	//좋아요 누른 리뷰 번호
	private int rno;
	//좋아요 체크해서 0이면 1로 바꾸면서 like +1 , 1이면 0으로 바꾸고 like -1
	private int status;
	
	//기본 생성자
	public LikeVO() {}
	
	//좋아요 누르기
	public LikeVO(int mno, int rno) {
		this.mno = mno;
		this.rno = rno;
	}
	//좋아요 상태 체크하기
	public LikeVO(int mno, int rno, int status) {
		this.mno = mno;
		this.rno = rno;
		this.status = status;
	}

	public int getLikeNo() {
		return likeNo;
	}

	public void setLikeNo(int likeNo) {
		this.likeNo = likeNo;
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
	
	
}
