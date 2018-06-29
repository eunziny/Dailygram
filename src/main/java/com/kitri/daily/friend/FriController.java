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
		System.out.println("�α��� �� ���̵� : " + user_id);
		//�α����� ����� ģ�� �� ���ϱ�
		//ArrayList<Integer> count = (ArrayList<Integer>) service.getFriendRelationshipCount(user_id);
		List<HashMap<String, Object>> count = service.getFriendRelationshipCount(user_id);
		//System.out.println("count�� ũ�� : " + count.size() + ", 0��° : " + count.get(0).get("cnt")+ ", " + count.get(1).get("cnt"));
		System.out.println("count�� ũ�� : " + count.size() + ", 0��° : " + count.get(0).get("cnt"));
		if(count.size()==1) {//ģ�� ���� 0�̰� ���ƿ� �� ���� ���ٸ� �ֽűۼ����� ���ƿ� ���� ���� ȸ�� ��õ�ϱ�
			System.out.println("ģ�� 0��");
			ArrayList<Friend> list = (ArrayList<Friend>) service.getRecommend();
			mav.addObject("list", list);
			return mav;
		}else{//ģ�� ���� 1�� �̻� ������
			System.out.println("ģ�� ������");
			// intro �ؽ��±� �������� ȸ�� ��õ���ֱ�
			
			System.out.println("���� ����X");	
			
			return null;
		}
		
	}
}
