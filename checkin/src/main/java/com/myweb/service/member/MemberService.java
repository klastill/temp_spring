package com.myweb.service.member;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.domain.FilesVO;
import com.myweb.domain.MemberVO;
import com.myweb.domain.PageVO;
import com.myweb.persistence.files.FilesDAORule;
import com.myweb.persistence.member.MemberDAORule;

@Service
public class MemberService implements MemberServiceRule {
	private static Logger logger = LoggerFactory.getLogger(MemberService.class);

	@Inject
	private MemberDAORule mdao;
	@Inject
	private FilesDAORule fdao;
	
	@Override
	public int register(MemberVO mvo) {
		return mdao.insert(mvo);
	}

	@Override
	public int checkID(String memberID) {
		return mdao.selectMemberID(memberID);
	}

	@Override
	public List<MemberVO> getList(PageVO pgvo) {
		return mdao.selectList(pgvo);
	}

	@Override
	public MemberVO login(MemberVO mvo) {
		return mdao.selectOne(mvo);
	}

	@Override
	public MemberVO detail(String memberID) {
		return mdao.selectOne(memberID);
	}

	@Override
	public int modify(MemberVO mvo) {
		return mdao.update(mvo);
	}

	@Override
	public int remove(int mno) {
		return mdao.delete(mno);
	}

	@Override
	public int getTotalCount(PageVO pgvo) {
		return mdao.selectOne(pgvo);
	}

	@Override
	public int getCurrMno() {
		return mdao.selectOne();
	}

	@Override
	public int updateMile(String mid, int mile) {
		return mdao.update(mid,mile);
	}
	
	@Override
	public List<MemberVO> getSearchedList(PageVO pgvo) {
		List<MemberVO> list = mdao.selectSearchedList(pgvo);
		for (int i = 0; i < list.size(); i++) {
			int mno= list.get(i).getMno();
			FilesVO fvo = fdao.selectOne(mno); 
			 list.get(i).setFvo(fvo);
		}
		return list;
	}

	@Override
	public MemberVO wishDetail(int mno) {
		return mdao.selectOne(mno);
	}

	@Override
	public FilesVO getProfile(int mno) {
		FilesVO fvo = fdao.selectOne(mno);
		return fvo;
	}

	@Override
	public int nowMileage(String memberID) {
		return mdao.nowMileage(memberID);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public int failureCountUp(String memberID) {
		mdao.updateFC(memberID);
		return mdao.selectOneFC(memberID);
	}

	@Override
	public void lockMemberID(String memberID, int value) {
		mdao.updateLock(memberID, value);
	}

	@Override
	public boolean resetFailureCount(String memberID) {
		return mdao.updateResetFC(memberID) > 0 ? true : false;
	}

	@Override
	public int changeEnabeld(int mno) {
		return mdao.changeEnable(mno);
	}

}


