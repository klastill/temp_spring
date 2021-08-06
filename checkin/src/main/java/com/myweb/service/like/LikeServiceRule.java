package com.myweb.service.like;

import java.util.List;

import com.myweb.domain.like.LikeDTO;
import com.myweb.domain.like.LikeVO;

//좋아요 서비스 by 동현, 2021/07/08
public interface LikeServiceRule {
	//좋아요 등록
	public int register(LikeVO lvo);
	//좋아요 리스트
	public List<LikeVO> getList(int rno);
	//좋아요 체크
	public LikeVO checkLike(LikeVO lvo);
	//좋아요 상태 바꾸기
	public int changeLike(LikeVO lvo, int status);

}
