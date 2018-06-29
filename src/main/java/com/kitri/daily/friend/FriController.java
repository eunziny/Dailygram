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
		Friend friend = new Friend();
		String user_id = (String) session.getAttribute("id");
		friend.setId(user_id);
		System.out.println("로그인 한 아이디 : " + user_id);
		
		//로그인한 사람의 친구 수 구하기
		List<HashMap<String, Object>> count = service.getFriendRelationshipCount(user_id);
		
		//System.out.println("count의 크기 : " + count.size() + ", 0번째 : " + count.get(0).get("cnt"));
		if(count.size()==1) {//친구 수가 0이고 좋아요 한 글이 없다면 최신글순으로 좋아요 많이 받은 회원 추천하기
			System.out.println("친구 0명");
			ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommend();
			mav.addObject("list", list);
			return mav;
		}else{//친구 수가 1명 이상 있으면
			System.out.println("친구 여러명");
			//로그인한 회원의 intro 가져오기
			String user_intro = service.getUserIntro(user_id);
			System.out.println("로그인한 회원의 소개글 : " + user_intro);
			//-> 해시태그 단위로 잘라서 배열로 만들기
			String[] introArray = user_intro.split(" ");
			System.out.println("해시태그 갯수 : " + introArray.length);
			for(int i=0;i<introArray.length;i++) System.out.println(introArray[i]);
			
			// intro 해시태그 기준으로 회원 추천해주기
			if(introArray.length == 0) {//소개글이 null 일경우 || 해시태그로 이루어져있지 않은 경우(좋아요 기준으로 회원 추천)
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommend();
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 1) {//해시태그가 1개 있을 경우
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT1(introArray[0]);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 2) {//해시태그가 2개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT2(friend);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 3){//해시태그가 3개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT3(friend);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 4) {//해시태그가 4개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				friend.setTag3(introArray[3]);
				
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT4(friend);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 5) {//해시태그가 5개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				friend.setTag3(introArray[3]);
				friend.setTag3(introArray[4]);
				
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT5(friend);
				mav.addObject("list", list);
				return mav;
			}			
		}
		return null;
	}
}
