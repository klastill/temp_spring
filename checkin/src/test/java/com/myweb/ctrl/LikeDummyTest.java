package com.myweb.ctrl;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myweb.domain.like.LikeDTO;
import com.myweb.domain.like.LikeVO;
import com.myweb.persistence.like.LikeDAORule;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class LikeDummyTest {
	
	@Inject
	private LikeDAORule ldao;
	
//	좋아요 토글
	@Test
	public void changeLikeTest() throws Exception{
		LikeVO lvo = new LikeVO();
		lvo.setRno(10);
		lvo.setMno(6);
		int status = 1;
		ldao.updateLike(lvo, status);
	}
	
//	좋아요 체크
//	@Test
//	public void selectCheckOneLikeTest() throws Exception{
//		LikeVO lvo = new LikeVO();
//		lvo.setRno(5);
//		lvo.setMno(6);
//		ldao.selectOneCheck(lvo);
//	}
	

	
//	좋아요 리스트
// 	@Test
//	public void listlikeTest()throws Exception{
//		LikeDTO ldto = new LikeDTO();
//		int rno=4;
//		ldao.selectList(rno);
//	}
	
//  좋아요신청
//	@Test
//	public void insertLikeTest() throws Exception {
//		LikeVO lvo = new LikeVO();
//		lvo.setRno(10);
//		lvo.setMno(6);
//		ldao.insert(lvo);
//	}
	

}
