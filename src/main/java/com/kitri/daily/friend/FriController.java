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
		System.out.println("�α��� �� ���̵� : " + user_id);
		
		//�α����� ����� ģ�� �� ���ϱ�
		List<HashMap<String, Object>> count = service.getFriendRelationshipCount(user_id);
		
		//System.out.println("count�� ũ�� : " + count.size() + ", 0��° : " + count.get(0).get("cnt"));
		if(count.size()==1) {//ģ�� ���� 0�̰� ���ƿ� �� ���� ���ٸ� �ֽűۼ����� ���ƿ� ���� ���� ȸ�� ��õ�ϱ�
			System.out.println("ģ�� 0��");
			ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommend();
			mav.addObject("list", list);
			return mav;
		}else{//ģ�� ���� 1�� �̻� ������
			System.out.println("ģ�� ������");
			//�α����� ȸ���� intro ��������
			String user_intro = service.getUserIntro(user_id);
			System.out.println("�α����� ȸ���� �Ұ��� : " + user_intro);
			//-> �ؽ��±� ������ �߶� �迭�� �����
			String[] introArray = user_intro.split(" ");
			System.out.println("�ؽ��±� ���� : " + introArray.length);
			for(int i=0;i<introArray.length;i++) System.out.println(introArray[i]);
			
			// intro �ؽ��±� �������� ȸ�� ��õ���ֱ�
			if(introArray.length == 0) {//�Ұ����� null �ϰ�� || �ؽ��±׷� �̷�������� ���� ���(���ƿ� �������� ȸ�� ��õ)
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommend();
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 1) {//�ؽ��±װ� 1�� ���� ���
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT1(introArray[0]);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 2) {//�ؽ��±װ� 2������ ���
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT2(friend);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 3){//�ؽ��±װ� 3������ ���
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT3(friend);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 4) {//�ؽ��±װ� 4������ ���
				friend.setTag1(introArray[0]);
				friend.setTag2(introArray[1]);
				friend.setTag3(introArray[2]);
				friend.setTag3(introArray[3]);
				
				ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommendHT4(friend);
				mav.addObject("list", list);
				return mav;
			}else if(introArray.length == 5) {//�ؽ��±װ� 5������ ���
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
