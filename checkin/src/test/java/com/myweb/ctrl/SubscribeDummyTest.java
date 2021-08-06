package com.myweb.ctrl;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myweb.domain.subscribe.SubscribeVO;
import com.myweb.persistence.subscribe.SubscribeDAORule;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class SubscribeDummyTest {
	
	@Inject
	private SubscribeDAORule sdao;
	
//	구독취소
//	@Test
//	public void deleteSubscribeTest() throws Exception{
//		SubscribeVO svo = new SubscribeVO();
//		svo.setSendNo(2);
//		svo.setReceiveNo(3);
//		sdao.delete(svo);
//	}
	
//	구독가능한지
//	@Test
//	public void selectCheckOneSubscribeTest() throws Exception{
//		SubscribeVO svo = new SubscribeVO();
//		svo.setSendNo(3);
//		svo.setReceiveNo(4);
//		sdao.selectOneCheck(svo);
//	}
	
//	신청 받은 구독
//	@Test
//	public void listReceiveSubscribeTest()throws Exception{
//		SubscribeVO svo = new SubscribeVO();
//		int mno=3;
//		sdao.selectListReceived(mno);
//	}
	
//	내가 신청한 구독
//	@Test
//	public void listSendSubscribeTest()throws Exception{
//		SubscribeVO svo = new SubscribeVO();
//		int mno=3;
//		sdao.selectListSend(mno);
//	}
	
//	관리자용 구독리스트
// 	@Test
//	public void listSubscribeTest()throws Exception{
//		SubscribeVO svo = new SubscribeVO();
//		int mno=3;
//		sdao.selectList(mno);
//	}
	
//  구독신청
	@Test
	public void insertSubscribeTest() throws Exception {
		SubscribeVO svo = new SubscribeVO();
		svo.setSendNo(5);
		svo.setReceiveNo(6);
		sdao.insert(svo);
	}
	

}
