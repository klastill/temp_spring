package com.myweb.persistence.like;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.myweb.domain.like.LikeDTO;
import com.myweb.domain.like.LikeVO;

//좋아요 DAO by 동현,2021/07/08
@Repository
public class LikeDAO implements LikeDAORule {
	
	private final String NS="LikeMapper.";
	
	@Inject
	private SqlSession sql;
	
	//좋아요 신청
	@Override
	public int insert(LikeVO lvo) {
		return sql.insert(NS+"reg", lvo);
	}
	
	//리뷰하나당 좋아요 리스트
	@Override
	public List<LikeVO> selectList(int rno) {
		return sql.selectList(NS+"list", rno);
	}
	
	//좋아요 체크
	@Override
	public LikeVO selectOneCheck(LikeVO lvo) {
		return sql.selectOne(NS+"check",lvo);
	}
	// 좋아요 toggle 
	@Override
	public int updateLike(LikeVO lvo, int status) {
		Map<String,Integer> map = new HashMap<String, Integer>();
		map.put("mno", (Integer)lvo.getMno());
		map.put("rno", (Integer)lvo.getRno());
		map.put("status", (Integer)status);
		return sql.update(NS+"changeLike",map);
	}
	
	//리뷰 좋아요목록 페이지 위해
	@Override
	public int selectLikeOne(int rno) {
		return sql.selectOne(NS+"liketc",rno);
	}
	//리뷰 좋아요 목록
	@Override
	public List<LikeVO> selectList(int rno, int pgIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rno", (Integer)rno);
		map.put("pageIndex", (Integer)pgIdx);
		return sql.selectList(NS+"likelist",map);
	}
}
