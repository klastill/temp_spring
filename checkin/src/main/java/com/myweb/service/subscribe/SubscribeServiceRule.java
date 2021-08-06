package com.myweb.service.subscribe;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.myweb.domain.like.LikeVO;
import com.myweb.domain.subscribe.SubscribeDTO;
import com.myweb.domain.subscribe.SubscribeVO;

//구독 서비스 by 동현, 2021/07/08
public interface SubscribeServiceRule {
	//구독신청
	public int register(SubscribeVO svo);
	//신청한 구독 리스트
	public List<SubscribeDTO> getListSend(int mno);
	//신청받은 리스트
	public List<SubscribeDTO> getListReceived(int mno);
	//구독 여부 확인
	public SubscribeVO checkSubscribe(SubscribeVO svo);
	//구독 상태 바꾸기
	public int changeSubscribe(SubscribeVO svo, int status);
	//구독자 랭킹 4 보기
	public List<SubscribeDTO> getRank4List();

}
