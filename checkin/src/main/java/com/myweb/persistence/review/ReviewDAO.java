package com.myweb.persistence.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myweb.domain.PageVO;
import com.myweb.domain.review.ReviewVO;

// 리뷰DAO by 동현, 2021/07/07
@Repository
public class ReviewDAO implements ReviewDAORule {

	private final String NS="ReviewMapper.";
	
	@Inject
	private SqlSession sql;
	
	//리뷰 등록
	@Override
	public int insert(ReviewVO rvo) {
		if(rvo.getContent2()!=null && rvo.getContent2()!="") {
			return sql.insert(NS+"reg2",rvo);
		}else {
			return sql.insert(NS+"reg",rvo);
		}
	}
	// 전체 리뷰 
	@Override
	public List<ReviewVO> selectList(PageVO pgvo) {
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10,10);
		return sql.selectList(NS+"list", pgvo,rowbounds);
	}
	//리뷰 디테일
	@Override
	public ReviewVO selectOne(int rno) {
		return sql.selectOne(NS+"detail", rno);
	}
	//리뷰 삭제
	@Override
	public int delete(int rno) {
		return sql.delete(NS+"del", rno);
	}
	//리뷰 수정
	@Override
	public int update(ReviewVO rvo) {
		if(rvo.getContent2()!=null && rvo.getContent2()!="") {
			return sql.update(NS+"mod2", rvo);
		}else {
			return sql.update(NS+"mod", rvo);
		}
		
	}
	//리뷰 좋아요 숫자 올리기
	@Override
	public int updownlike(int rno,int qty) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("rno", (Integer)rno);
		map.put("qty", (Integer)qty);
		return sql.update(NS+"updownlike",map);
	}
	//리뷰 좋아요 탑3 리스트
	@Override
	public List<ReviewVO> selectBestLikeList() {
		return sql.selectList(NS+"getBestLike");
	}
	//리뷰 별점 탑3 리스트
	@Override
	public List<ReviewVO> selectRecommendList() {
		return sql.selectList(NS+"getBestRecommend");
	}
	//조회수 업데이트
		@Override
		public void updateRC(int rno, int qty) {
			Map<String,Integer> map = new HashMap<String, Integer>();
			map.put("rno", (Integer)rno);
			map.put("qty", (Integer)qty);
			sql.update(NS+"uprc",map);
		}
	
	//by 고영빈 d:0712
	//도서별 별점 탑3 리스트
	@Override
	public List<ReviewVO> selectBnameRecommendList(String isbn) {
		return sql.selectList(NS+"getBnameRecommend", isbn);
	}
	@Override
	public int selectSearchedOne(String isbn,PageVO pgvo) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("isbn", isbn);
		map.put("pageIndex",(Integer)pgvo.getPageIndex());
		return sql.selectOne(NS+"stc", map);
	}
	public List<ReviewVO> selectSearchedList(String isbn,PageVO pgvo) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("isbn", isbn);
		map.put("pageIndex",(Integer)pgvo.getPageIndex());
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10,10);
		return sql.selectList(NS+"searchedList", map,rowbounds);
	}
	

	//리뷰 페이지 위해
	@Override
	public int selectOne(PageVO pgvo) {
		return sql.selectOne(NS+"tc", pgvo);
	}
	@Override
	public List<ReviewVO> selectMyList(int mno,PageVO pgvo) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("mno", (Integer)mno);
		map.put("pageIndex",(Integer)pgvo.getPageIndex());
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10,10);
		return sql.selectList(NS+"mylist", map,rowbounds);
	}
	@Override
	public int selectMyOne(int mno,PageVO pgvo) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("mno", (Integer)mno);
		map.put("pageIndex",(Integer)pgvo.getPageIndex());
		return sql.selectOne(NS+"mytc", map);
	}
	@Override
	public List<ReviewVO> selectFavorList(PageVO pgvo) {
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10,10);
		return sql.selectList(NS+"favorlist", pgvo,rowbounds);
	}
	@Override
	public int selectReviewCountOne(int mno) {
		return sql.selectOne(NS+"reviewCount", mno);
	}
	@Override
	public List<ReviewVO> selectKeywordSearchedList(PageVO pgvo) {
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10,10);
		return sql.selectList(NS+"kwList",pgvo,rowbounds);
	}
	@Override
	public int selectReviewCount(PageVO pgvo) {
		return sql.selectOne(NS+"countKw",pgvo);
	}
	@Override
	public List<ReviewVO> selectRelatedList(int rno, int mno) {
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("mno", (Integer)mno);
		map.put("rno",(Integer)rno);
		return sql.selectList(NS+"relatedList", map);
	}
	
}
