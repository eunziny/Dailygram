package com.kitri.daily.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.board.BoardService;
import com.kitri.daily.member.Member;
import com.kitri.daily.search.Hashtag;

@Controller
public class AdminController {
	@Resource(name="adminService")
	private AdminService service;
	
	@Resource(name="boardService")
	private BoardService service2;
	
	public void setService(AdminService service) {
		this.service = service;
	}
	
	public void setService(BoardService service2) {
		this.service2 = service2;
	}
	
	//������ �ؽ��±� ����Ʈ
	@RequestMapping(value = "/admin/deleteHashtag.do")
	public ModelAndView blockList() {
		ModelAndView mav = new ModelAndView("admin/deleteHashtag");
		List<Hashtag> blocklist = new ArrayList<Hashtag>();
		blocklist = service.getBlockList();
		
		mav.addObject("blocklist", blocklist);
		System.out.println("blocklist : " + blocklist);
		return mav;
	}
	
	//������ �ؽ��±� �߰��ϱ�
	@RequestMapping(value = "/admin/tagblock.do")
	public String tagblock(@RequestParam(value="tagname") String tagname) {
		System.out.println("���"+tagname);
		service.addBlocktag(tagname);
		return "forward:/admin/deleteHashtag.do";
	}
	
	//������ �ؽ��±� Ȱ��ȭ�ϱ�(��, ��ư Ŭ�� �Ѵ�)
	@RequestMapping(value = "/admin/allclick.do")
	public @ResponseBody List<Hashtag> blockcancle(@RequestParam(value="valueArrTest[]") List<String> checkArr ) {
		System.out.println("checkArr >>>>>>> " + checkArr);
		service.cancleblock(checkArr);
		List<Hashtag> canList = service.getBlockList();
		return canList;
	}
	//���� ������ ��, ���ɴ�, ���� ��� 
	@RequestMapping(value = "/admin/chartlist.do")
	public @ResponseBody ModelAndView chartList() {
		ModelAndView mav = new ModelAndView("admin/chartlist");
		List<Member> join; 
		join = service.selectJoin();
		mav.addObject("join", join);
		System.out.println("join"+join);
		
		List<Member> age;
		age = service.selectAge();
		mav.addObject("age", age);
		System.out.println("age"+age);
		
		List<Member> gender; 
		gender = service.selectGender();
		mav.addObject("gender", gender);
		System.out.println("gender"+gender);
		return mav;
	}
	//�Ű� �Խù� ����Ʈ
	@RequestMapping(value = "/admin/chargelist.do")
	public ModelAndView chargelist() {
		ModelAndView mav = new ModelAndView("admin/chargelist");
		List<Like_Siren> chargeList = new ArrayList<Like_Siren>();
		chargeList = service.getChargeList();
		
		mav.addObject("chargeList", chargeList);
		System.out.println("chargeList : " + chargeList);
		return mav;
	}
	
	//�ش� �Ű� �Խù� ����
	@RequestMapping(value = "/admin/chargepost.do")
	public ModelAndView chargedetail(@RequestParam(value="bseq") int bseq) {
		ModelAndView mav = new ModelAndView("board/post");
		
		return mav;
	}
	
	//�ش� �Խù� �Ű��� ����Ʈ
	@RequestMapping(value = "/admin/chargeperson.do")
	public ModelAndView personlist(@RequestParam(value="bseq") int bseq) {
		ModelAndView mav = new ModelAndView("admin/chargeMemList");
		List<Like_Siren> personList = new ArrayList<Like_Siren>();
		personList = service.getPersonList(bseq);
		
		mav.addObject("personList", personList);
		System.out.println("personList : " + personList);
		return mav;
	}
	//�Ű� �Խù� ����
	@RequestMapping(value = "/admin/postdel.do")
	public String postdel(@RequestParam(value="valueArrTest[]") List<Integer> checkArr) {
		System.out.println("������? : " + checkArr);
		for(int i=0; i<checkArr.size(); i++) {
			try {
				service2.deleteBoard(checkArr.get(i));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:/admin/chargelist.do";
	}
}