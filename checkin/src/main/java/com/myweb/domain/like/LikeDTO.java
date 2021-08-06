package com.myweb.domain.like;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

//좋아요 DTO by 동현 , 2021/07/08

public class LikeDTO {
	//리뷰 넘버
	private int reviewNo;
	//멤버 넘버
	private int memberNo;
	//멤버 이름 (닉넴)
	private String memberNickname;
	//멤버 사진(프로필)
	private String memberProfile;
	private int totalLikeCount;
	private List<LikeVO> likelist;
	private String memberId;
	private int status;
	
	
	
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getReviewNo() {
		return reviewNo;
	}
	
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	
	public int getMemberNo() {
		return memberNo;
	}
	
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	
	public String getMemberNickname() {
		return memberNickname;
	}
	
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	
	public String getMemberProfile() {
		return memberProfile;
	}
	
	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}
	
	public int getTotalLikeCount() {
		return totalLikeCount;
	}
	
	public void setTotalLikeCount(int totalLikeCount) {
		this.totalLikeCount = totalLikeCount;
	}
	
	public List<LikeVO> getLikelist() {
		return likelist;
	}
	
	public void setLikelist(List<LikeVO> likelist) {
		this.likelist = likelist;
	}
	// 기본생성자
	public LikeDTO() {}
	
	//좋아요 누른사람 리스트
	public LikeDTO(int reviewNo, int memberNo, String memberNickname, String memberProfile) {
		this.reviewNo = reviewNo;
		this.memberNo = memberNo;
		this.memberNickname = memberNickname;
		this.memberProfile = memberProfile;
	}
	//좋아요 누른사람 리스트 최신
	public LikeDTO(int totalLikeCount, List<LikeVO> likelist) {
		this.totalLikeCount = totalLikeCount;
		this.likelist = likelist;
	}
	
	
	
	
}
