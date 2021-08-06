package com.myweb.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.myweb.domain.MemberVO;
import com.myweb.persistence.member.MemberDAORule;

public class MemberAuthDetailService implements UserDetailsService{//UserDetailsService 스프링에서 제공하는 필터 인터페이스
	private static Logger logger = LoggerFactory.getLogger(MemberAuthDetailService.class);

	@Inject
	private MemberDAORule mdao;
	
//MemberAuthDetailService가 작동되기전에 필터에서 loadUserByUsername를 부르고 리턴받는애는 UserDetails(사용자가 던지는 파라미터들을 보안체계로 인증토큰방식으로 가지고 있는 VO개체) 형식으로 받음
	
	//우리가 입력한 id값이 loadUserByUsername(String username)으로 넘어옴 memberID로 바꿔
	@Override
	public UserDetails loadUserByUsername(String memberID) throws UsernameNotFoundException {
		MemberVO mvo = mdao.selectOne(memberID);
		logger.info(">>> mvo : " + mvo.toString()); //얘도 개발완료후 삭제
		return mvo;
	}

}
