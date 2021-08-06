package com.myweb.ctrl;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myweb.domain.review.ReviewVO;
import com.myweb.persistence.review.ReviewDAORule;

//리뷰 더미테스트 by 동현 (좋아요는 아직 다 확인안해봄) ,2021/07/07
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReviewDummyTest {
	
	@Inject
	private ReviewDAORule rdao;
	
	//리뷰삭제
	@Test
	public void likeTest() throws Exception{
		int rno=10;
		rdao.delete(rno);
	}
	//좋아요 
//	@Test
//	public void likeTest() throws Exception{
//		int rno=10;
//		rdao.like(rno);
//	}
	//댓글 수정
//	@Test
//	public void updateReviewTest() throws Exception{
//		ReviewVO rvo = new ReviewVO();
//		rvo.setRno(10);
//		rvo.setTitle("test댓글0000");
//		rvo.setContent("testContent00000");
//		rvo.setRecommend(2);
//		rdao.update(rvo);
//	}
	//리뷰 디테일
//	@Test
//	public void listOneReviewTest() throws Exception{
//		int rno = 5;
//		rdao.selectOne(rno);
//	}
	//리뷰 리스트(페이징)
//	@Test
//	public void listReviewTest() throws Exception{
//		PageVO pgvo= new PageVO();
//		pgvo.setCountPerPage(10);
//		pgvo.setPageIndex(2);
//		rdao.selectList(pgvo);
//		
//	}
	//리뷰 등록 테스트
//	@Test
//	public void insertReviewTest() throws Exception{
//		for (int i = 0; i < 10; i++) {
//			
//			ReviewVO rvo = new ReviewVO();
//			rvo.setMno(i+6);
//			rvo.setMemberID("kdong702"+i);
//			rvo.setTitle("test댓글"+i);
//			rvo.setContent("testContent"+i);
//			rvo.setRecommend(5);
//			rvo.setBname("test책이름"+i);
//			rvo.setLink("link"+i);
//			rvo.setCover("testCover"+i);
//			rvo.setIsbn("isbn"+i);
//			rdao.insert(rvo);
//		}
//	}
	
}
