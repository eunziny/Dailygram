package com.kitri.daily.alerm;



import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.socket.CloseStatus;

import org.springframework.web.socket.TextMessage;


import org.springframework.web.socket.WebSocketSession;

import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kitri.daily.member.Member;


public class SocketHandler extends TextWebSocketHandler implements InitializingBean {
	@Resource(name="alermService")
	private AlermService service;
	private final Logger logger = LoggerFactory.getLogger(SocketHandler.class);
	 List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	public SocketHandler() {
		this.logger.info("create SocketHandler instance!");
		
	}

	@Override

	public void afterConnectionClosed(WebSocketSession session,

			CloseStatus status) throws Exception {

		this.logger.info("remove session!");

	}

	@Override

	public void afterConnectionEstablished(WebSocketSession session)throws Exception {
		/*Map <String,Object> map = session.getAttributes();
		Member mem = (Member)map.get("memInfo");
		String id = mem.getId();
		String a = Integer.toString(service.getCount(id));
		session.sendMessage(new TextMessage(a));*/
	}

	@Override

	public void handleTextMessage(WebSocketSession session,TextMessage message) throws Exception {
		this.logger.info("client msg>>>>"+message.getPayload());
		if(message.getPayload().contains("like")) {
			StringTokenizer token = new StringTokenizer(message.getPayload(), "|");
			int countTokens =token.countTokens();
			String[] likeArr = new String[4];
			for(int i=0;i<countTokens;i++) {
				likeArr[i] = token.nextToken();
			}
			String board_seq = likeArr[1];
			String sender = likeArr[2];
			String receiver = likeArr[3];
			String msg = sender+"님이"+receiver+"님의글에  좋아요 누름!";
			session.sendMessage(new TextMessage(msg));
		}
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub
		
	}


}
