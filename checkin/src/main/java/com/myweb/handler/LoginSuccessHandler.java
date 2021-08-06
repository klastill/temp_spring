package com.myweb.handler;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.myweb.service.member.MemberServiceRule;

public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	private static Logger logger = LoggerFactory.getLogger(LoginSuccessHandler.class);
	private String authMemberID;
	private String authUrl;
	private RequestCache reqCache = new HttpSessionRequestCache(); //내가 어떤 리퀘스트를 썼는가 기억저장소
	private RedirectStrategy rdStg = new DefaultRedirectStrategy(); //어디로 보낼것인가 어떻게 보낼것인가에 대한 방법론이 들어있는 인터페이스
	
	@Inject
	MemberServiceRule msv;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		String memberID =request.getParameter(authMemberID);
		String referer = (String)request.getHeader("REFERER");
		boolean isUp = msv.resetFailureCount(memberID);
		
		HttpSession ses = request.getSession(false); // 새로 생선된 세션 아니고 기존에 사용되어져 있는 세션값을 사용하겠다라는뜻
		

		if(!isUp || ses == null) { //세션없고 실패아닐때 (요청리퀘없고 로그인성공)
			return;
		}else {
			//로그인 실패후 다시 성공했을시 전 세션(실패세션)으로 갈수있으니 실패세션 지워야함
			ses.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		}
		// 이제 내가 인증이 필요한 페이지로 로긴했냐 직접로긴했냐 판단해서
		// 그쪽으로 넘길것이냐 아니면 인덱스(홈)로 넘길것이냐 결정
		SavedRequest savedReq = reqCache.getRequest(request, response);
		// 현재 존재하는 (기록정보(어떻게넘어왔는지)) 가져와서 savedreq형식으로 갖고있는거임
		if(savedReq != null) {
			//로그인 이전에 리퀘스트값이 있으면 (ex. 비로그인에서 리뷰등록 누르고 로그인페이지로 가면 리뷰등록 리퀘스트 값이있는거 그걸 저장함)
			String destPage = savedReq.getRedirectUrl();
			rdStg.sendRedirect(request, response, destPage); //destpage 가려고했던페이지로 보내는거
		}else { //직접 로그인 했을경우
			rdStg.sendRedirect(request, response, referer); //authUrl 우리가 로그인하면 가는 페이지
		}
	}

	public String getAuthMemberID() {
		return authMemberID;
	}

	public void setAuthMemberID(String authMemberID) {
		this.authMemberID = authMemberID;
	}

	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}

}


