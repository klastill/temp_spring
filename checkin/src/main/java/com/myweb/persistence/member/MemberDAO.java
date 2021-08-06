package com.myweb.persistence.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myweb.domain.MemberVO;
import com.myweb.domain.PageVO;

@Repository
public class MemberDAO implements MemberDAORule {
	private static Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	private final String NS = "MemberMapper.";
	
	@Inject
	private SqlSession sql;
	
	
	@Override
	public int insert(MemberVO mvo) {
		return sql.insert(NS+"reg", mvo);
	}

	@Override
	public int selectMemberID(String memberID) {
		return sql.selectOne(NS+"check", memberID);
	}

	@Override
	public List<MemberVO> selectList(PageVO pgvo) {
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10,10);
		return sql.selectList(NS+"list", pgvo,rowbounds);
	}

	@Override
	public MemberVO selectOne(MemberVO mvo) {
		return sql.selectOne(NS+"login", mvo);
	}

	@Override
	public MemberVO selectOne(String memberID) {
		return sql.selectOne(NS+"detail", memberID);
	}

	@Override
	public int update(MemberVO mvo) {
		return sql.update(NS+"mod", mvo);
	}

	@Override
	public int delete(int mno) {
		return sql.delete(NS+"del", mno);
	}

	@Override
	public int selectOne(PageVO pgvo) {
		return sql.selectOne(NS+"tc", pgvo);
	}

	@Override
	public int selectOne() {
		return sql.selectOne(NS+"curr");
	}

	@Override
	public int update(String mid, int mile) {
		MemberVO mvo = new MemberVO(mid,mile);
		return sql.update(NS+"upmile", mvo);
	}
	
	@Override
	public List<MemberVO> selectSearchedList(PageVO pgvo) {
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10,10);
		return sql.selectList(NS+"membersearch", pgvo,rowbounds);
	}

	@Override
	public MemberVO selectOne(int mno) {
		return sql.selectOne(NS+"wishdetail", mno);
	}

	@Override
	public MemberVO selectOneByMno(int mno) {
		return sql.selectOne(NS+"detailbymno", mno);
	}

	@Override
	public int nowMileage(String memberID) {
		return sql.selectOne(NS+"nowMileage", memberID);
		
	}

	@Override
	public int updateFC(String memberID) {
		return sql.delete(NS+"upfc", memberID);
	}

	@Override
	public int selectOneFC(String memberID) {
		return sql.selectOne(NS+"fc", memberID);
	}

	@Override
	public void updateLock(String memberID, int value) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberID", (String)memberID);
		map.put("value", (Integer)value);
		sql.update(NS+"lock", map);
	}

	@Override
	public int updateResetFC(String memberID) {
		return sql.update(NS+"rsfc", memberID);
	}

	@Override
	public int changeEnable(int mno) {
		return sql.update(NS+"cgea", mno);
	}


}


