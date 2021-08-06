package com.myweb.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.myweb.domain.MemberVO;
import com.myweb.domain.like.LikeVO;
import com.myweb.service.like.LikeServiceRule;
import com.myweb.service.member.MemberServiceRule;


//좋아요 컨트롤러 by 동현, 2021/07/14
@RequestMapping("/like/*")
@RestController



public class LikeController {
	private static Logger logger = LoggerFactory.getLogger(LikeController.class);
	
	@Inject
	private LikeServiceRule lsv;
	
	@Inject
	private MemberServiceRule msv;
	
	
	@PostMapping("/islike")
	public String islike(@RequestParam("rno") int rno, @RequestParam("memberID") String memberID) {
		MemberVO mvo = msv.detail(memberID);
		int mno = mvo.getMno();
		LikeVO lvo= new LikeVO(mno,rno);
		LikeVO lvo2=lsv.checkLike(lvo);
		if(lvo2 == null || lvo2.equals(null)) {
			 return "1";
		}else if(lvo2.getStatus()==0) {
			return "1";
		}else if(lvo2.getStatus()==1) {
			return "2";
		}else {
			return "0";
		}
	}

	
	@PostMapping("/like")
	public String like(@RequestParam("rno") int rno, @RequestParam("memberID") String memberID) {
		
		MemberVO mvo = msv.detail(memberID);
		int mno = mvo.getMno();
		LikeVO lvo = new LikeVO(mno, rno);
		LikeVO lvo2 = lsv.checkLike(lvo);
		if (lvo2 == null || lvo2.equals(null)) {
			lsv.register(lvo);
			return "1";
		} else if (lvo2.getStatus() == 0) {
			lsv.changeLike(lvo, 1);
			return "1";
		} else if (lvo2.getStatus() == 1) {
			lsv.changeLike(lvo, 0);
			return "2";
		}else {
			return "0";
		}
	}
	
	@GetMapping(value="/rno/{rno}",
			produces= {MediaType.APPLICATION_ATOM_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<LikeVO>> list(@PathVariable("rno")int rno){
		return new ResponseEntity<List<LikeVO>>(lsv.getList(rno),
				HttpStatus.OK);
	}
}