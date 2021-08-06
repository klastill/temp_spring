package com.myweb.service.review;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.domain.PageVO;
import com.myweb.domain.review.ReviewVO;
import com.myweb.persistence.CommentDAORule;
import com.myweb.persistence.review.ReviewDAORule;

//리뷰 서비스 by 동현 ,2021/07/07
@Service
public class ReviewService implements ReviewServiceRule {
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);
	
	@Inject
	private ReviewDAORule rdao;
	
	@Inject
	private CommentDAORule cdao;
	
	@Override
	public int register(ReviewVO rvo) {
		return rdao.insert(rvo);
	}

	@Override
	public List<ReviewVO> getList(PageVO pgvo) {
		return rdao.selectList(pgvo);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public ReviewVO detail(int rno) {
		rdao.updateRC(rno, 1);
		return rdao.selectOne(rno);
	}

	@Override
	public int modify(ReviewVO rvo) {
		rdao.updateRC(rvo.getRno(), -2);
		return rdao.update(rvo);
	}

	@Override
	public int remove(int rno) {
		cdao.deleteAll(rno);
		return rdao.delete(rno);
	}

	

	@Override
	public List<ReviewVO> getBestLikeList() {
		return rdao.selectBestLikeList();
	}

	@Override
	public List<ReviewVO> getBestRecommendList() {
		return rdao.selectRecommendList();
	}
	
	//by 고영빈 d:0712
	@Override
	public List<ReviewVO> getBnameRecommendList(String isbn) {
		return rdao.selectBnameRecommendList(isbn);
	}
	@Override
	public List<ReviewVO> getSearchedList(String isbn,PageVO pgvo) {
		return rdao.selectSearchedList(isbn,pgvo);
	}
	@Override
	public int getTotalSearchedCount(String isbn,PageVO pgvo) {
		return rdao.selectSearchedOne(isbn,pgvo);
	}
	

	@Override
	public int getTotalCount(PageVO pgvo) {
		return rdao.selectOne(pgvo);
	}

	@Override
	public List<ReviewVO> getMyList(int mno,PageVO pgvo) {
		return rdao.selectMyList(mno,pgvo);
	}

	@Override
	public int getTotalMyCount(int mno,PageVO pgvo) {
		return rdao.selectMyOne(mno,pgvo);
	}

	@Override
	public List<ReviewVO> getFavorList(PageVO pgvo) {
		return rdao.selectFavorList(pgvo);
	}

	@Override
	public List<ReviewVO> getSearchedkeywordList(PageVO pgvo) {
		return rdao.selectKeywordSearchedList(pgvo);
	}

	@Override
	public int getTotalSearchedCount(PageVO pgvo) {
		return rdao.selectReviewCount(pgvo);
	}

	@Override
	public List<ReviewVO> getRelatedList(int rno, int mno) {
		return rdao.selectRelatedList(rno,mno);
	}
}
