package com.myweb.service.like;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.myweb.domain.like.LikeDTO;
import com.myweb.domain.like.LikeVO;
import com.myweb.persistence.like.LikeDAORule;
import com.myweb.persistence.review.ReviewDAORule;

// 좋아요 서비스 by 동현, 2021/07/08
@Service
public class LikeService implements LikeServiceRule {
	private static Logger logger = LoggerFactory.getLogger(LikeService.class);
	
	@Inject
	private LikeDAORule ldao;
	
	@Inject
	private ReviewDAORule rdao;
	
	@Override
	public int register(LikeVO lvo) {
		rdao.updownlike(lvo.getRno(),1);
		return ldao.insert(lvo);
	}

	@Override
	public List<LikeVO> getList(int rno) {
		return ldao.selectList(rno);
	}

	@Override
	public LikeVO checkLike(LikeVO lvo) {
		return ldao.selectOneCheck(lvo);
	}

	@Override
	public int changeLike(LikeVO lvo, int status) {
		if(status==0) {
			rdao.updownlike(lvo.getRno(), -1);
		}else if(status==1){
			rdao.updownlike(lvo.getRno(), 1);
		}
		return ldao.updateLike(lvo, status);
	}
}
