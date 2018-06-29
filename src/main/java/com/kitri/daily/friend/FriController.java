package com.kitri.daily.friend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FriController {
	@Resource(name="friService")
	private FriService service;
	
	public void setService(FriService service) {
		this.service = service;
	}
	
	@RequestMapping(value="/friend/knownfriend.do")
	public ModelAndView recommend(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("friend/knownfriend");
		HttpSession session = req.getSession(false);
		String user_id = (String) session.getAttribute("id");
		System.out.println("로그인 한 아이디 : " + user_id);
		//로그인한 사람의 친구 수 구하기
		//ArrayList<Integer> count = (ArrayList<Integer>) service.getFriendRelationshipCount(user_id);
		List<HashMap<String, Object>> count = service.getFriendRelationshipCount(user_id);
		//System.out.println("count의 크기 : " + count.size() + ", 0번째 : " + count.get(0).get("cnt")+ ", " + count.get(1).get("cnt"));
		System.out.println("count의 크기 : " + count.size() + ", 0번째 : " + count.get(0).get("cnt"));
		if(count.size()==1) {//친구 수가 0이고 좋아요 한 글이 없다면 최신글순으로 좋아요 많이 받은 회원 추천하기
			System.out.println("친구 0명");
			ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommend();
			mav.addObject("list", list);
			return mav;
		}else{//친구 수가 1명 이상 있으면
			System.out.println("친구 여러명");
			// intro 해시태그 기준으로 회원 추천해주기
			
			System.out.println("조건 만족X");	
			
			return null;
		}
		
	}
}
