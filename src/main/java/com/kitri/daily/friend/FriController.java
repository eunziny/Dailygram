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

import com.kitri.daily.board.BoardService;
import com.kitri.daily.member.Member;

@Controller
public class FriController {
	@Resource(name = "friService")
	private FriService service;
	@Resource(name = "boardService")
	private BoardService service2;

	public void setService(FriService service) {
		this.service = service;
	}
	public void setService(BoardService service) {
		this.service2 = service;
	}

	@RequestMapping(value = "/friend/knownfriend.do")
	public ModelAndView recommend(HttpServletRequest req, @RequestParam(value = "id") String id) {
		ModelAndView mav = new ModelAndView("friend/knownfriend");
		// HttpSession session = req.getSession(false);
		Friend friend = new Friend();
		// String user_id = (String) session.getAttribute("id");
		friend.setId(id);
		System.out.println("�α��� �� ���̵� : " + id);

		// �α����� ����� ģ�� �� ���ϱ�
		List<HashMap<String, Object>> count = service.getFriendRelationshipCount(id);
		ArrayList<Friend> list = null;
		if (count.size() == 1) {// ģ�� ���� 0�̰� ���ƿ� �� ���� ���ٸ� �ֽűۼ����� ���ƿ� ���� ���� ȸ�� ��õ�ϱ�
			System.out.println("ģ�� 0��");
			list = (ArrayList<Friend>) service.getRecommend(id);
			mav.addObject("list", list);
			return mav;
		} else {// ģ�� ���� 1�� �̻� ������
			System.out.println("ģ�� ������");
			// �α����� ȸ���� intro ��������
			String user_intro = service.getUserIntro(id);
			System.out.println("�α����� ȸ���� �Ұ��� : " + user_intro);

			// -> �ؽ��±� ������ �߶� �迭�� �����
			String[] introArray = null;
			if (user_intro != null) {
				introArray = user_intro.split(" ");
				System.out.println("�ؽ��±� ���� : " + introArray.length);
				for (int i = 0; i < introArray.length; i++)
					System.out.println(introArray[i]);
			}

			// intro �ؽ��±� �������� ȸ�� ��õ���ֱ�
			if (user_intro == null) {
				list = (ArrayList<Friend>) service.getRecommend2(id);
				mav.addObject("list", list);
			} else if (introArray.length == 0) {// �Ұ����� null �ϰ�� || �ؽ��±׷� �̷�������� ���� ���(���ƿ� �������� ȸ�� ��õ)
				list = (ArrayList<Friend>) service.getRecommend2(id);
				mav.addObject("list", list);

			} else if (introArray.length == 1) {// �ؽ��±װ� 1�� ���� ���
				friend.setTag1(introArray[0]);
				friend.setId(id);
				list = (ArrayList<Friend>) service.getRecommendHT1(friend);
				mav.addObject("list", list);

			} else if (introArray.length == 2) {// �ؽ��±װ� 2������ ���
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);

				list = (ArrayList<Friend>) service.getRecommendHT2(friend);
				mav.addObject("list", list);

			} else if (introArray.length == 3) {// �ؽ��±װ� 3������ ���
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);

				list = (ArrayList<Friend>) service.getRecommendHT3(friend);
				mav.addObject("list", list);

			} else if (introArray.length == 4) {// �ؽ��±װ� 4������ ���
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				friend.setTag3(introArray[3]);

				list = (ArrayList<Friend>) service.getRecommendHT4(friend);
				mav.addObject("list", list);

			} else if (introArray.length == 5) {// �ؽ��±װ� 5������ ���
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				friend.setTag3(introArray[3]);
				friend.setTag3(introArray[4]);

				list = (ArrayList<Friend>) service.getRecommendHT5(friend);
				mav.addObject("list", list);
			}
		}

		if (list.size() < 15) {
			ArrayList<Friend> list3 = list;
			/*
			 * for(int a=0; a<list.size();a++) { list3.set(a, list.get(a)); }//list3�� list����
			 */

			System.out.print("list : ");
			for (int i = 0; i < list.size(); i++) {
				System.out.print(list.get(i) + ", ");
			}
			System.out.println("");

			System.out.print("list3 : ");
			for (int i = 0; i < list3.size(); i++) {
				System.out.print(list3.get(i) + ", ");
			}
			System.out.println("");

			ArrayList<Friend> list2 = (ArrayList<Friend>) service.getRecommend2(id);

			System.out.print("list2 : ");
			for (int i = 0; i < list2.size(); i++) {
				System.out.print(list2.get(i) + ", ");
			}
			System.out.println("");

			for (int i = 0; i < list2.size(); i++) {
				boolean check = false;
				for (int j = 0; j < list.size(); j++) {
					if (list.get(j).getId().equals(list2.get(i).getId())) {
						check = true;
					}
				}
				if (check == false) {
					list3.add(list2.get(i));
				}
			}
			mav.addObject("list", list3);
		}
		return mav;
	}

	@RequestMapping(value = "/friend/subscribelist.do")
	public ModelAndView subscribeList(HttpServletRequest req, @RequestParam(value = "id") String id) {// ���� �����ϴ� ��� ����Ʈ
		ModelAndView mav = new ModelAndView("friend/subscribelist");
		Friend friend = new Friend();
		friend.setId(id);
		String cnt = service2.cntBoard(id);
		req.setAttribute("cnt", cnt);
		System.out.println("�α��� �� ���̵� : " + id);

		ArrayList<Friend> list = (ArrayList<Friend>) service.getsubscribeList(id);
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping(value = "/friend/followinglist.do")
	public ModelAndView followingList(HttpServletRequest req, @RequestParam(value = "id") String id) {// ���� �����ϴ� ��� ����Ʈ
		ModelAndView mav = new ModelAndView("friend/followinglist");
		Friend friend = new Friend();
		friend.setId(id);
		String cnt = service2.cntBoard(id);
		req.setAttribute("cnt", cnt);
		System.out.println("�α��� �� ���̵� : " + id);

		ArrayList<Friend> list = (ArrayList<Friend>) service.getfollowingList(id);
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping(value = "/friend/followerlist.do")
	public ModelAndView followerList(HttpServletRequest req, @RequestParam(value = "id") String id) {// ���� �����ϴ� ��� ����Ʈ
		ModelAndView mav = new ModelAndView("friend/followerlist");
		Friend friend = new Friend();
		friend.setId(id);
		String cnt = service2.cntBoard(id);
		req.setAttribute("cnt", cnt);
		System.out.println("�α��� �� ���̵� : " + id);

		ArrayList<Friend> list = (ArrayList<Friend>) service.getfollowerList(id);// �ȷο� ����Ʈ �޾ƿ�
		ArrayList<Friend> mylist = (ArrayList<Friend>) service.getfollowingList(id);// ���� �ȷ��� �ϴ»��(y)
		ArrayList<Friend> mywaitlist = (ArrayList<Friend>) service.getfollowwaitList(id);// �ȷο� ��û �� ���(n)

		for (int i = 0; i < list.size(); i++) {
			for (int j = 0; j < mylist.size(); j++) {
				if (list.get(i).getId().equals(mylist.get(j).getId())) {
					list.get(i).setStatus("y");// �� �ȷο� ����Ʈ�� ������ ���°� y�� �ٲ���
				}
			}
			for (int j = 0; j < mywaitlist.size(); j++) {
				if (list.get(i).getId().equals(mywaitlist.get(j).getId())) {
					list.get(i).setStatus("wait");// �� �ȷο� ��û����Ʈ�� ������ ���°� wait�� �ٲ���
				}
			}
			if (list.get(i).getStatus() == null)
				list.get(i).setStatus("no");
		}
		System.out.println("list : ");
		for (int i = 0; i < list.size(); i++)
			System.out.print(list.get(i) + ", ");
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping(value = "/friend/friendfollowerlist.do")
	public ModelAndView friendFollowerList(HttpServletRequest req, @RequestParam(value = "id") String id) {// ���� �����ϴ� ���
																											// ����Ʈ
		ModelAndView mav = new ModelAndView("friend/friendfollowerlist");
		Friend friend = new Friend();
		friend.setId(id);
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String user_id = mem.getId();
		Member fri = service2.friend(id);
		System.out.println("������ �� ���̵�(ģ��) : " + id);
		System.out.println("�α����� ���̵� : " + user_id);

		ArrayList<Friend> list = (ArrayList<Friend>) service.getfollowerList(id);// ģ�����ȷο� ����Ʈ �޾ƿ�
		ArrayList<Friend> mylist = (ArrayList<Friend>) service.getfollowingList(user_id);// ���� �ȷ��� �ϴ»��
		ArrayList<Friend> mywaitlist = (ArrayList<Friend>) service.getfollowwaitList(user_id);// �ȷο� ��û �� ���(n)
		for (int i = 0; i < list.size(); i++) {
			for (int j = 0; j < mylist.size(); j++) {
				if (list.get(i).getId().equals(mylist.get(j).getId())) {
					list.get(i).setStatus("y");// �� �ȷο� ����Ʈ�� ������ ���°� y�� �ٲ���
				}
			}
			for (int j = 0; j < mywaitlist.size(); j++) {
				if (list.get(i).getId().equals(mywaitlist.get(j).getId())) {
					list.get(i).setStatus("wait");// �� �ȷο� ��û����Ʈ�� ������ ���°� wait�� �ٲ���
				}
			}
			if (list.get(i).getStatus() == null)
				list.get(i).setStatus("no");
			if (list.get(i).getId().equals(user_id))
				list.get(i).setStatus("me");
		}
		mav.addObject("fri", fri);
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping(value = "/friend/friendfollowinglist.do")
	public ModelAndView friendFollowingList(HttpServletRequest req, @RequestParam(value = "id") String id) {// ģ���� �����ϴ�
																											// ��� ����Ʈ
		ModelAndView mav = new ModelAndView("friend/friendfollowinglist");
		Friend friend = new Friend();
		friend.setId(id);
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String user_id = mem.getId();
		Member fri = service2.friend(id);
		System.out.println("������ �� ���̵�(ģ��) : " + id);
		System.out.println("�α����� ���̵� : " + user_id);

		ArrayList<Friend> list = (ArrayList<Friend>) service.getfollowingList(id);// ģ���� �ȷ��� ����Ʈ
		ArrayList<Friend> mylist = (ArrayList<Friend>) service.getfollowingList(user_id);// �� �ȷ��� ����Ʈ
		ArrayList<Friend> mywaitlist = (ArrayList<Friend>) service.getfollowwaitList(user_id);// �ȷο� ��û �� ���(n)

		for (int i = 0; i < list.size(); i++) {
			for (int j = 0; j < mylist.size(); j++) {
				if (list.get(i).getId().equals(mylist.get(j).getId())) {
					list.get(i).setStatus("y");// �� �ȷο� ����Ʈ�� ������ ���°� y�� �ٲ���
				}
			}
			for (int j = 0; j < mywaitlist.size(); j++) {
				if (list.get(i).getId().equals(mywaitlist.get(j).getId())) {
					list.get(i).setStatus("wait");// �� �ȷο� ��û����Ʈ�� ������ ���°� wait�� �ٲ���
				}
			}
			if (list.get(i).getStatus() == null)
				list.get(i).setStatus("no");
			if (list.get(i).getId().equals(user_id))
				list.get(i).setStatus("me");
		}
		mav.addObject("fri", fri);
		mav.addObject("list", list);
		return mav;
	}

	
	  @RequestMapping(value = "/friend/subscribe.do") 
	  public String subscribe(HttpServletRequest req ,@RequestParam(value="writer") String id) {
		  HttpSession session = req.getSession(false); 
		  Member mem = (Member) session.getAttribute("memInfo"); 
		  String user_id = mem.getId(); 
		  String friend_id = (String) session.getAttribute("friendId");
		  Relationship subscribe = new Relationship(user_id, id); 
		  service.subscribe(subscribe);
		  
		  ArrayList<Integer> count = service.profileCount(user_id);
		  session.setAttribute("followerCount", count.get(0));
		  session.setAttribute("followingCount", count.get(1));
		  session.setAttribute("subscribeCount", count.get(2)); 
			
		 return "redirect:/board/friList.do?writer="+id; 
	 }
	 

	@RequestMapping(value = "/friend/cancelFollow.do")
	public String cancelFollow(HttpServletRequest req, @RequestParam(value = "writer") String writer,
			@RequestParam(value = "type") int type) {// �ȷο� ���
		HttpSession session = req.getSession(false);
		String url = null;
		Member mem = (Member) session.getAttribute("memInfo");
		String user_id = mem.getId();
		String friend_id = (String) session.getAttribute("friendId");
		Relationship relation = new Relationship(user_id, writer);
		service.cancelfollow(relation);

		ArrayList<Integer> count = service.profileCount(user_id);
		session.setAttribute("followerCount", count.get(0));
		session.setAttribute("followingCount", count.get(1));
		session.setAttribute("subscribeCount", count.get(2));

		if (type == 1) {// �� �ȷ��� ����Ʈ
			url = "redirect:/friend/followinglist.do?id=" + user_id;
		} else if (type == 2) {// �� �ȷο� ����Ʈ
			url = "redirect:/friend/followerlist.do?id=" + user_id;
		} else if (type == 3) {
			url = "redirect:/friend/friendfollowerlist.do?id=" + friend_id;
		} else if (type == 4) {
			url = "redirect:/friend/friendfollowinglist.do?id=" + friend_id;
		} else if (type == 5) {
			url = "redirect:/board/friList.do?writer=" + friend_id;
		}
		return url;
	}

	@RequestMapping(value = "/friend/cancelSubscribe.do")
	public String cancelSubscribe(HttpServletRequest req, @RequestParam(value = "writer") String writer,
			@RequestParam(value = "type") int type) {// �� ���� ����Ʈ����
		// ���� ���
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String user_id = mem.getId();
		String friend_id = (String) session.getAttribute("friendId");
		String url=null;
		Relationship relation = new Relationship(user_id, writer);
		service.cancelsubscribe(relation);

		ArrayList<Integer> count = service.profileCount(user_id);
		session.setAttribute("followerCount", count.get(0));
		session.setAttribute("followingCount", count.get(1));
		session.setAttribute("subscribeCount", count.get(2));

		if(type == 1) {
			url="redirect:/friend/subscribelist.do?id=" + user_id;
		}else if (type == 2){
			url = "redirect:/board/friList.do?writer=" + friend_id;
		}
		return url;
	}

	@RequestMapping(value = "/friend/addFollow.do")
	public String addFollow(HttpServletRequest req, @RequestParam(value = "writer") String writer,
			@RequestParam(value = "type") int type) {// �ȷο�
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String user_id = mem.getId();
		String url = null;
		String friend_id = (String) session.getAttribute("friendId");
		Relationship relation = new Relationship(user_id, writer);
		service.addfollow(relation);

		ArrayList<Integer> count = service.profileCount(user_id);
		session.setAttribute("followerCount", count.get(0));
		session.setAttribute("followingCount", count.get(1));
		session.setAttribute("subscribeCount", count.get(2));
		if (type == 1) {// �� �ȷο� ����Ʈ���� �ȷο� �� ���
			url = "redirect:/friend/followerlist.do?id=" + user_id;
		} else if (type == 2) {
			url = "redirect:/friend/friendfollowerlist.do?id=" + friend_id;
		} else if (type == 3) {
			url = "redirect:/friend/friendfollowinglist.do?id=" + friend_id;
		} else if (type == 4) {
			url = "redirect:/board/friList.do?writer=" + friend_id;
		}
		return url;
	}
}
