package com.myweb.persistence.subscribe;

import java.util.List;

import com.myweb.domain.like.LikeVO;
import com.myweb.domain.subscribe.SubscribeDTO;
import com.myweb.domain.subscribe.SubscribeVO;

//구독DAORule by 동현 ,2021/07/06
public interface SubscribeDAORule {
	//구독 신청
	public int insert(SubscribeVO svo);

	//신청한 구독 리스트
	public List<SubscribeDTO> selectListSend(int mno);
	//구독자 수 
	
	//신청받은 리스트
	public List<SubscribeDTO> selectListReceived(int mno);
	//구독 여부 확인
	public SubscribeVO selectOneCheck(SubscribeVO svo);
	//구독 상태 바꾸기
	public int updateSubscribe(SubscribeVO svo, int status);
	//구독 랭크4리스트
	public List<SubscribeDTO> selectRank4List();
	//팔로워 수 받아오기
	public int selectFollowerOne(int sendNo);
	//팔로잉 수 받아오기
	public int selectFollowingOne(int mno);
	
}
