package com.myweb.service.review;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.myweb.domain.PageVO;
import com.myweb.domain.review.ReviewVO;

//리뷰서비스 by 동현, 2021/07/07
public interface ReviewServiceRule {
	public int register(ReviewVO rvo);
	public List<ReviewVO> getList(PageVO pgvo);
	public ReviewVO detail(int rno);
	public int modify(ReviewVO rvo);
	public int remove(int rno);
	public List<ReviewVO> getBestLikeList();
	public List<ReviewVO> getBestRecommendList();
	
	//by 고영빈 d:0712
	public List<ReviewVO> getBnameRecommendList(String isbn);
	public List<ReviewVO> getSearchedList(String isbn,PageVO pgvo);
	public int getTotalSearchedCount(String isbn,PageVO pgvo);
	public int getTotalCount(PageVO pgvo);
	// by 동현,2021/07/14 내가 쓴 리뷰 보기
	public List<ReviewVO> getMyList(int mno,PageVO pgvo);
	// 리뷰 내가쓴거 갯수
	public int getTotalMyCount(int mno,PageVO pgvo);
	//리뷰 인기순,by 동현,2021/07/15
	public List<ReviewVO> getFavorList(PageVO pgvo);
	public List<ReviewVO> getSearchedkeywordList(PageVO pgvo);
	//연관된 리뷰 가져오기
	public List<ReviewVO> getRelatedList(int rno,int mno);
	public int getTotalSearchedCount(PageVO pgvo);
}
