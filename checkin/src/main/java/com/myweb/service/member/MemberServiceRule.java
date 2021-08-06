package com.myweb.service.member;

import java.util.List;

import com.myweb.domain.FilesVO;
import com.myweb.domain.MemberVO;
import com.myweb.domain.PageVO;

public interface MemberServiceRule {
	public int register(MemberVO mvo);
	public int checkID(String memberID);
	public List<MemberVO> getList(PageVO pgvo);
	public MemberVO login(MemberVO mvo);
	public MemberVO detail(String memberID);
	public MemberVO wishDetail(int mno);
	public int modify(MemberVO mvo);
	public int remove(int mno);
	public int getTotalCount(PageVO pgvo);
	public int getCurrMno();
	public int updateMile(String string, int mileage);
	//by 동현
	public List<MemberVO> getSearchedList(PageVO pgvo);
	//by 동현
	public FilesVO getProfile(int mno);
	public int nowMileage(String memberID);
	public int failureCountUp(String memberID);
	public void lockMemberID(String memberID, int value);
	public boolean resetFailureCount(String memberID);
	public int changeEnabeld(int mno);
	
}
