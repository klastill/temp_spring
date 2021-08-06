package com.myweb.persistence.like;

import java.util.List;

import com.myweb.domain.like.LikeDTO;
import com.myweb.domain.like.LikeVO;

//좋아요 DAORule by 동현 ,2021/07/08
public interface LikeDAORule {

	//좋아요 신청
	public int insert(LikeVO lvo);
	//좋아요 리스트(rno,mno 받아오기)
	public List<LikeVO> selectList(int rno);
	//좋아요 상태확인
	public LikeVO selectOneCheck(LikeVO lvo);
	//좋아요 상태 바꾸기
	public int updateLike(LikeVO lvo, int status);
	//리뷰 좋아요목록 페이징 갯수
	public int selectLikeOne(int rno);
	//리뷰 좋아요 목록
	public List<LikeVO> selectList(int rno, int pgIdx);
}
