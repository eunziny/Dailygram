package com.kitri.daily.friend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FriController {
	@Resource(name="friService")
	private FriService service;
	
	public void setService(FriService service) {
		this.service = service;
	}
	
	@RequestMapping(value="/friend/knownfriend.do")
	public ModelAndView recommend(HttpServletRequest req, @RequestParam(value = "id") String id) {
		ModelAndView mav = new ModelAndView("friend/knownfriend");
		//HttpSession session = req.getSession(false);
		Friend friend = new Friend();
		//String user_id = (String) session.getAttribute("id");
		friend.setId(id);
		System.out.println("로그인 한 아이디 : " + id);
		
		//로그인한 사람의 친구 수 구하기
		List<HashMap<String, Object>> count = service.getFriendRelationshipCount(id);
		ArrayList<Friend> list = null;
		if(count.size()==1) {//친구 수가 0이고 좋아요 한 글이 없다면 최신글순으로 좋아요 많이 받은 회원 추천하기
			System.out.println("친구 0명");
			list = (ArrayList<Friend>) service.getRecommend(id);
			mav.addObject("list", list);
			return mav;
		}else{//친구 수가 1명 이상 있으면
			System.out.println("친구 여러명");
			//로그인한 회원의 intro 가져오기
			String user_intro = service.getUserIntro(id);
			System.out.println("로그인한 회원의 소개글 : " + user_intro);
			//-> 해시태그 단위로 잘라서 배열로 만들기
			String[] introArray = user_intro.split(" ");
			System.out.println("해시태그 갯수 : " + introArray.length);
			for(int i=0;i<introArray.length;i++) System.out.println(introArray[i]);
			
			
			// intro 해시태그 기준으로 회원 추천해주기
			if(introArray.length == 0) {//소개글이 null 일경우 || 해시태그로 이루어져있지 않은 경우(좋아요 기준으로 회원 추천)
				list = (ArrayList<Friend>) service.getRecommend2(id);
				mav.addObject("list", list);

			}else if(introArray.length == 1) {//해시태그가 1개 있을 경우
				list = (ArrayList<Friend>) service.getRecommendHT1(introArray[0]);
				mav.addObject("list", list);

			}else if(introArray.length == 2) {//해시태그가 2개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				
				list = (ArrayList<Friend>) service.getRecommendHT2(friend);
				mav.addObject("list", list);

			}else if(introArray.length == 3){//해시태그가 3개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				
				list = (ArrayList<Friend>) service.getRecommendHT3(friend);
				mav.addObject("list", list);

			}else if(introArray.length == 4) {//해시태그가 4개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				friend.setTag3(introArray[3]);
				
				list = (ArrayList<Friend>) service.getRecommendHT4(friend);
				mav.addObject("list", list);

			}else if(introArray.length == 5) {//해시태그가 5개있을 경우
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				friend.setTag3(introArray[3]);
				friend.setTag3(introArray[4]);
				
				list = (ArrayList<Friend>) service.getRecommendHT5(friend);
				mav.addObject("list", list);
			}			
		}
		
		if(list.size()<15) {
			ArrayList<Friend> list3 =  list;
			/*for(int a=0; a<list.size();a++) {
				list3.set(a, list.get(a));
			}//list3에 list복사*/
			
			System.out.print("list : ");
			for(int i=0;i<list.size();i++) {
				System.out.print(list.get(i) + ", ");
			}
			System.out.println("");
			
			System.out.print("list3 : ");
			for(int i=0;i<list3.size();i++) {
				System.out.print(list3.get(i) + ", ");
			}
			System.out.println("");
			
			
			ArrayList<Friend> list2 = (ArrayList<Friend>) service.getRecommend2(id);
			
			System.out.print("list2 : ");
			for(int i=0;i<list2.size();i++) {
				System.out.print(list2.get(i) + ", ");
			}
			System.out.println("");
			
			for(int i=0;i<list2.size();i++) {
				boolean check = false;
				for(int j=0;j<list.size();j++) {
					if(list.get(j).getId().equals(list2.get(i).getId())) {
						check = true;
					}
				}
				if(check==false) {
					list3.add(list2.get(i));
				}
			}
			mav.addObject("list", list3);
		}
		return mav;
	}
	
	@RequestMapping(value="/friend/subscribelist.do")
	public ModelAndView subscribeList(@RequestParam(value = "id") String id) {//내가 구독하는 사람 리스트
		ModelAndView mav = new ModelAndView("friend/subscribelist");
		Friend friend = new Friend();
		friend.setId(id);
		System.out.println("로그인 한 아이디 : " + id);
		
		ArrayList<Friend> list = (ArrayList<Friend>) service.getsubscribeList(id);
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping(value="/friend/followinglist.do")
	public ModelAndView followingList(@RequestParam(value = "id") String id) {//내가 구독하는 사람 리스트
		ModelAndView mav = new ModelAndView("friend/followinglist");
		Friend friend = new Friend();
		friend.setId(id);
		System.out.println("로그인 한 아이디 : " + id);
		
		ArrayList<Friend> list = (ArrayList<Friend>) service.getfollowingList(id);
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping(value="/friend/followerlist.do")
	public ModelAndView followerList(@RequestParam(value = "id") String id) {//내가 구독하는 사람 리스트
		ModelAndView mav = new ModelAndView("friend/followerlist");
		Friend friend = new Friend();
		friend.setId(id);
		System.out.println("로그인 한 아이디 : " + id);
		
		ArrayList<Friend> list = (ArrayList<Friend>) service.getfollowerList(id);//팔로워 리스트 받아옴
		
		ArrayList<Friend> mylist = (ArrayList<Friend>)service.getfollowingList(id);//내가 팔로잉 하는사람
		
		for(int i=0;i<list.size();i++) {
			for(int j=0;j<mylist.size();j++) {
				if(list.get(i).getId().equals(mylist.get(j).getId())) {
					list.get(i).setStatus("y");//내 팔로우 리스트에 있으면 상태값 y로 바꿔줌
				}		
			}
			if(list.get(i).getStatus()==null)
				list.get(i).setStatus("no");
		}
		System.out.println("list : ");
		for(int i=0;i<list.size();i++)
			System.out.print(list.get(i) + ", ");
		mav.addObject("list", list);
		return mav;
	}
}
