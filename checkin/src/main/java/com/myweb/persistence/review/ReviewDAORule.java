package com.myweb.persistence.review;

import java.util.List;

import com.myweb.domain.PageVO;
import com.myweb.domain.review.ReviewVO;

//리뷰DAO Rule by 동현 ,2021/07/07
public interface ReviewDAORule {

	//리뷰등록
	public int insert(ReviewVO rvo);
	//전체 리뷰리스트
	public List<ReviewVO> selectList(PageVO pgvo);
	//리뷰 디테일
	public ReviewVO selectOne(int rno);
	//리뷰 업데이트
	public int update(ReviewVO rvo);
	//리뷰 삭제
	public int delete(int rno);
	//리뷰 좋아요 숫자 올리기
	public int updownlike(int rno, int qty);
	//리뷰 좋아요 탑3 리스트
	public List<ReviewVO> selectBestLikeList();
	//리뷰 별점 탑3 리스트
	public List<ReviewVO> selectRecommendList();
	//리뷰 조회수 업데이트
	public void updateRC(int rno, int qty);
	
	//by 고영빈 d:0712
	//도서 별점 탑3 리스트
	public List<ReviewVO> selectBnameRecommendList(String isbn);
	public int selectSearchedOne(String isbn,PageVO pgvo);
	public List<ReviewVO> selectSearchedList(String isbn,PageVO pgvo);
	//리뷰 페이징위해서 총 갯수
	public int selectOne(PageVO pgvo);
	//내가 쓴 리뷰 리스트
	public List<ReviewVO> selectMyList(int mno,PageVO pgvo);
	public int selectMyOne(int mno,PageVO pgvo);
	//인기순 리뷰 리스트
	public List<ReviewVO> selectFavorList(PageVO pgvo);
	//인기순 리뷰 카운트
	public int selectReviewCountOne(int mno);
	
	public List<ReviewVO> selectKeywordSearchedList(PageVO pgvo);
	public int selectReviewCount(PageVO pgvo);
	//관련된 리뷰
	public List<ReviewVO> selectRelatedList(int rno, int mno);
}
