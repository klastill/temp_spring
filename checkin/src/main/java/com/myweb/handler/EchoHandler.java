package com.myweb.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.myweb.domain.AlarmVO;
import com.myweb.domain.MemberVO;
import com.myweb.persistence.alarm.AlarmDAORule;
 
public class EchoHandler extends TextWebSocketHandler{
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Inject
	private AlarmDAORule adao;
	
	
	//서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		
		String senderID = getEmail(session);
		System.out.println(">>>>>>"+senderID);
		userSessionsMap.put(senderID , session);
	}
	
	//소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//protocol : cmd , 댓글작성자, 게시글 작성자 , 게시글 제목, 게시글 번호
		String msg = message.getPayload();
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			
			if (strs != null) {
				String cmd = strs[0];
				String caller = strs[1];
				String receiver = strs[2];
				String title = strs[3];
				String num = strs[4];

				// 작성자가 로그인 해서 있다면
				WebSocketSession boardWriterSession = userSessionsMap.get(receiver);
				
				String textmessage="";
				if ("like".equals(cmd)) {
					textmessage=caller + "님이 '" + title + "' 리뷰에 좋아요를 했습니다.";
				} else if ("follow".equals(cmd)) {
					textmessage=caller + "님이 " + receiver + "님을 팔로우 시작했습니다.";
				}else if("comment".equals(cmd)) {
					textmessage=caller + "님이 '" + title + "' 리뷰에 댓글을 남겼습니다.";
				}
				if(boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(textmessage);
					boardWriterSession.sendMessage(tmpMsg);
					adao.getAlarm(new AlarmVO(textmessage,num,1 ,receiver));
				}else {
					adao.getAlarm(new AlarmVO(textmessage,num,0 ,receiver));
				}
			}
		}
	}
	
	//연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userSessionsMap.remove(session.getId());
		sessions.remove(session);
	}
	
	private String getEmail(WebSocketSession session) {
		Map<String, Object> map = session.getAttributes();
		SecurityContextImpl test = (SecurityContextImpl) map.get("SPRING_SECURITY_CONTEXT");
		MemberVO mvo = (MemberVO)test.getAuthentication().getPrincipal();
		String userId = (String)mvo.getMemberID();
		return userId;
	}
}
