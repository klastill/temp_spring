package com.myweb.domain.subscribe;

//구독VO by 동현, 2021/07/06
public class SubscribeVO {
private int subNo; 
// sequence로 연결해서 자동으로 1추가( 총 갯수 관련)
private int sendNo;
//구독을 신청하는 사람
private int receiveNo;
//구독을 받는 사람
private int status;
//구독상태 0:기본상태 , 1: 구독중인 상태

//기본생성자
public SubscribeVO() {}

// 구독 신청 기능 by 동현, 2021/07/06
public SubscribeVO(int sendNo, int receiveNo) {
	this.sendNo = sendNo;
	this.receiveNo = receiveNo;
}

// 구독신청 가능여부 확인 by 동현,2021/07/06
public SubscribeVO(int sendNo, int receiveNo, int status) {
	this(sendNo,receiveNo);
	this.status = status;
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

public int getReceiveNo() {
	return receiveNo;
}

public void setReceiveNo(int receiveNo) {
	this.receiveNo = receiveNo;
}

public int getStatus() {
	return status;
}

public void setStatus(int status) {
	this.status = status;
}



}

