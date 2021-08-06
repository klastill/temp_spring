package com.myweb.domain.subscribe;

import java.util.List;

import com.myweb.domain.FilesVO;
import com.myweb.domain.MemberVO;

//구독DTD by 동현, 2021/07/06
public class SubscribeDTO {
	private int subNo;
	// sequence로 연결해서 자동으로 1추가( 총 갯수 관련) , 2021/07/08 얘 안쓰는듯,,
	private int sendNo;
	// 구독을 신청하는 사람 번호
	private String sendId;
	// 구독을 신청하는 사람 ID
	private String sendNickname;
	// 구독을 신청하는 사람 nickname
	private int sendFollowingNum;
	// 구독을 얼마나하는지
	private int sendFollowerNum;
	// 구독을 신청하는 사람의 구독자 수
	private int receiveNo;
	// 구독 받는 사람 번호
	private String receiveId;
	// 구독 받는 사람 ID
	private String receiveNickname;
	// 구독 받는 사람 nickname
	private int receiveFollowingNum;
	// 구독을 얼마나하는지
	private int receiveFollowerNum;
	// 구독 받는 사람의 구독자 수
	private int status;
	// 구독 상태
	

	private FilesVO fvo;
	//프로필 하나만 가져오기
	private MemberVO mvo;
	
	//구독 랭킹용
	private int followerNum;
	private int followingNum;
	private int reviewNum;
	private int rankingNum;

	// 기본생성자
	public SubscribeDTO() {
	}

	

	// 전체 리스트 관리자용
	
	public SubscribeDTO(int subNo, int sendNo, String sendId, String sendNickname, int sendFollowingNum,
			int sendFollowerNum, int receiveNo, String receiveId, String receiveNickname, int receiveFollowingNum,
			int receiveFollowerNum, int status) {
		this.subNo = subNo;
		this.sendNo = sendNo;
		this.sendId = sendId;
		this.sendNickname = sendNickname;
		this.sendFollowingNum = sendFollowingNum;
		this.sendFollowerNum = sendFollowerNum;
		this.receiveNo = receiveNo;
		this.receiveId = receiveId;
		this.receiveNickname = receiveNickname;
		this.receiveFollowingNum = receiveFollowingNum;
		this.receiveFollowerNum = receiveFollowerNum;
		this.status = status;
	}

	// 구독받은 리스트 , 구독한 리스트

	public SubscribeDTO(int sendNo, String sendId, String sendNickname, int sendFollowingNum, int sendFollowerNum,
			int receiveNo, int status) {
		this.sendNo = sendNo;
		this.sendId = sendId;
		this.sendNickname = sendNickname;
		this.sendFollowingNum = sendFollowingNum;
		this.sendFollowerNum = sendFollowerNum;
		this.receiveNo = receiveNo;
		this.status = status;
	}



	// 구독 랭킹?
	
	public SubscribeDTO(int receiveNo, int followerNum) {
		this.receiveNo = receiveNo;
		this.followerNum = followerNum;
	}
	
	
	public int getReviewNum() {
		return reviewNum;
	}



	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}



	public int getRankingNum() {
		return rankingNum;
	}



	public void setRankingNum(int rankingNum) {
		this.rankingNum = rankingNum;
	}



	public int getFollowingNum() {
		return followingNum;
	}

	public void setFollowingNum(int followingNum) {
		this.followingNum = followingNum;
	}

	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	public FilesVO getFvo() {
		return fvo;
	}

	public void setFvo(FilesVO fvo) {
		this.fvo = fvo;
	}

	
	
	public int getSendFollowingNum() {
		return sendFollowingNum;
	}



	public void setSendFollowingNum(int sendFollowingNum) {
		this.sendFollowingNum = sendFollowingNum;
	}



	public int getReceiveFollowingNum() {
		return receiveFollowingNum;
	}



	public void setReceiveFollowingNum(int receiveFollowingNum) {
		this.receiveFollowingNum = receiveFollowingNum;
	}



	public int getFollowerNum() {
		return followerNum;
	}

	public void setFollowerNum(int followerNum) {
		this.followerNum = followerNum;
	}

	public int getSendFollowerNum() {
		return sendFollowerNum;
	}


	public void setSendFollowerNum(int sendFollowerNum) {
		this.sendFollowerNum = sendFollowerNum;
	}

	public int getReceiveFollowerNum() {
		return receiveFollowerNum;
	}

	public void setReceiveFollowerNum(int receiveFollowerNum) {
		this.receiveFollowerNum = receiveFollowerNum;
	}



	public int getSubNo() {
		return subNo;
	}

	public void setSubNo(int subNo) {
		this.subNo = subNo;
	}

	public int getSendNo() {
		return sendNo;
	}

	public void setSendNo(int sendNo) {
		this.sendNo = sendNo;
	}

	public String getSendId() {
		return sendId;
	}

	public void setSendId(String sendId) {
		this.sendId = sendId;
	}

	public String getSendNickname() {
		return sendNickname;
	}

	public void setSendNickname(String sendNickname) {
		this.sendNickname = sendNickname;
	}

	public int getReceiveNo() {
		return receiveNo;
	}

	public void setReceiveNo(int receiveNo) {
		this.receiveNo = receiveNo;
	}

	public String getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(String receiveId) {
		this.receiveId = receiveId;
	}

	public String getReceiveNickname() {
		return receiveNickname;
	}

	public void setReceiveNickname(String receiveNickname) {
		this.receiveNickname = receiveNickname;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
