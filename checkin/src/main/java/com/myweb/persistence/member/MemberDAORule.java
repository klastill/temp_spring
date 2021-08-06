package com.myweb.persistence.member;

import java.util.List;

import com.myweb.domain.MemberVO;
import com.myweb.domain.PageVO;

public interface MemberDAORule {
	public int insert(MemberVO mvo);
	public int selectMemberID(String memberID);
	public List<MemberVO> selectList(PageVO pgvo);
	public MemberVO selectOne(MemberVO mvo);
	public MemberVO selectOne(String memberID);
	public int update(MemberVO mvo);
	public int delete(int mno);
	public int selectOne(PageVO pgvo);
	public int selectOne();
	public int update(String mid, int mile);
	public List<MemberVO> selectSearchedList(PageVO pgvo);
	public MemberVO selectOne(int mno);
	//by 동현,2021/07/18
	public MemberVO selectOneByMno(int mno);
	public int nowMileage(String memberID);
	public int updateFC(String memberID);
	public int selectOneFC(String memberID);
	public void updateLock(String memberID, int value);
	public int updateResetFC(String memberID);
	public int changeEnable(int mno);
}
