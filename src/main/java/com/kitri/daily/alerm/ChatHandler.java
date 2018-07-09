package com.kitri.daily.alerm;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.web.socket.CloseStatus;

import org.springframework.web.socket.TextMessage;


import org.springframework.web.socket.WebSocketSession;

import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kitri.daily.member.Member;


public class ChatHandler extends TextWebSocketHandler{
	@Resource(name="alermService")
	private AlermService service;
	
	private final Logger logger = LoggerFactory.getLogger(ChatHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();	 
	 
	public ChatHandler() {
		this.logger.info("create SocketHandler instance!");
	}
	
	private Map<String, String> users = new HashMap<String, String>();
	List<String> idList = new ArrayList<String>();

	@Override

	public void afterConnectionEstablished(WebSocketSession session)throws Exception {
		logger.info("{} :�����!",session.getId());
		Map <String,Object> map = session.getAttributes();
		Member mem = (Member)map.get("memInfo");
		String id = mem.getId();
		users.put(session.getId(), id);  //session.getId()�� id�� �ִ´�.
		sessionList.add(session);
		System.out.println("ä�ù� ������ :"+id);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session,
			CloseStatus status) throws Exception {
		Map <String,Object> map = session.getAttributes();
		Member mem = (Member)map.get("memInfo");
		String id = mem.getId();
		sessionList.remove(session);
		users.remove(session.getId());
		this.logger.info("{} : ���������",session.getId());
		System.out.println("ä�ù� ������:"+id);
	}
	@Override
	public void handleTextMessage(WebSocketSession session,TextMessage message) throws Exception {
		this.logger.info("{}�κ��� {}����",session.getId(),message.getPayload());
		Map <String,Object> map = session.getAttributes();
		Member mem = (Member)map.get("memInfo");
		String id = mem.getId();
		
		if(message.getPayload().contains("joinList")) {
			ObjectMapper mapper = new ObjectMapper();
			String json ="";
			json = mapper.writeValueAsString(users);
			session.sendMessage(new TextMessage(json));
			System.out.println(json);
		}else {
			//����� ��� ��������� ��������..
			for(WebSocketSession sess: sessionList) {
				sess.sendMessage(new TextMessage(id+"|"+message.getPayload()));
			}	
		}
	}

	

}
