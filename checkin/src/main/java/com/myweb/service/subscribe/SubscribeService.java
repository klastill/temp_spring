package com.myweb.service.subscribe;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.myweb.domain.FilesVO;
import com.myweb.domain.MemberVO;
import com.myweb.domain.subscribe.SubscribeDTO;
import com.myweb.domain.subscribe.SubscribeVO;
import com.myweb.persistence.files.FilesDAORule;
import com.myweb.persistence.member.MemberDAORule;
import com.myweb.persistence.review.ReviewDAORule;
import com.myweb.persistence.subscribe.SubscribeDAORule;

// 구독 서비스 by 동현, 2021/07/08
@Service
public class SubscribeService implements SubscribeServiceRule {
	private static Logger logger = LoggerFactory.getLogger(SubscribeService.class);

	@Inject
	private SubscribeDAORule sdao;
	
	@Inject
	private FilesDAORule fdao;
	
	@Inject
	private MemberDAORule mdao;
	
	@Inject
	private ReviewDAORule rdao;
	
	@Override
	public int register(SubscribeVO svo) {
		return sdao.insert(svo);
	}


	@Override
	public List<SubscribeDTO> getListSend(int mno) {
		List<SubscribeDTO> list = sdao.selectListSend(mno);
		for (int i = 0; i < list.size(); i++) {
			int receiveNo= list.get(i).getReceiveNo();
			FilesVO fvo = fdao.selectOne(receiveNo); 
			 list.get(i).setFvo(fvo);
		}
		return list;
		
	}

	@Override
	public List<SubscribeDTO> getListReceived(int mno) {
		List<SubscribeDTO> list = sdao.selectListReceived(mno);
		for (int i = 0; i < list.size(); i++) {
			int sendNo= list.get(i).getSendNo();
			FilesVO fvo = fdao.selectOne(sendNo); 
			 list.get(i).setFvo(fvo);
		}
		return list;
	}

	@Override
	public SubscribeVO checkSubscribe(SubscribeVO svo) {
		return sdao.selectOneCheck(svo);
	}

	@Override
	public int changeSubscribe(SubscribeVO svo, int status) {
		return sdao.updateSubscribe(svo, status);
	}

	@Override
	public List<SubscribeDTO> getRank4List() {
		List<SubscribeDTO> list = sdao.selectRank4List();
		for (int i = 0; i < list.size(); i++) {
			int rankingNum=i+1;
			list.get(i).setRankingNum(rankingNum);
			int mno=list.get(i).getReceiveNo();
			int followingNum=sdao.selectFollowingOne(mno);
			list.get(i).setFollowingNum(followingNum);
			MemberVO mvo= mdao.selectOneByMno(mno);
			int reviewNum=rdao.selectReviewCountOne(mno);
			list.get(i).setReviewNum(reviewNum);
			list.get(i).setMvo(mvo);
			 FilesVO fvo = fdao.selectOne(mno); 
			 list.get(i).setFvo(fvo);
		}
		return list;
	}
}
