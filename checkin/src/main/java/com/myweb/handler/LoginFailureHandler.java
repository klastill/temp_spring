package com.myweb.handler;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.myweb.service.member.MemberServiceRule;


public class LoginFailureHandler implements AuthenticationFailureHandler{
	private static Logger logger = LoggerFactory.getLogger(LoginFailureHandler.class);
	private String authMemberID;
	private String authMemberPassword;
	private String errMsg;
	private String failUrl;
	
	@Inject
	MemberServiceRule msv;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String memberID = request.getParameter(authMemberID); //login시 들어온 파라미터값인데 인증절차 걸침 그래서 그냥 memberID를 못씀
		String memberPassword = request.getParameter(authMemberPassword);
		String exeption_msg = exception.getMessage();
		
		if(exception instanceof BadCredentialsException) {
			loginFailureCountUp(memberID);
		}
		
		if(exception instanceof InternalAuthenticationServiceException) {
			exeption_msg = "no id";
		}
		request.setAttribute(authMemberID, memberID); // 시큐리티통해 memberID의토큰값이 가야함 그래서 authMemberID를 써야함
		request.setAttribute(authMemberPassword, memberPassword);
		request.setAttribute(errMsg, exeption_msg+"1");
		request.getRequestDispatcher(failUrl).forward(request, response);
	}

	private void loginFailureCountUp(String memberID) {
		int check = msv.checkID(memberID);
		if(check == 1) {
			int failCnt = msv.failureCountUp(memberID);
			if(failCnt == 5) {
				msv.lockMemberID(memberID, 0);
		}
		}
		
	}

	public String getAuthMemberID() {
		return authMemberID;
	}

	public void setAuthMemberID(String authMemberID) {
		this.authMemberID = authMemberID;
	}

	public String getAuthMemberPassword() {
		return authMemberPassword;
	}

	public void setAuthMemberPassword(String authMemberPassword) {
		this.authMemberPassword = authMemberPassword;
	}

	public String getErrMsg() {
		return errMsg;
	}

	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

	public String getFailUrl() {
		return failUrl;
	}

	public void setFailUrl(String failUrl) {
		this.failUrl = failUrl;
	}

	
}


