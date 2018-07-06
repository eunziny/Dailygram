package com.kitri.daily.admin;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.search.Hashtag;

@Controller
public class AdminController {
	@Resource(name="adminService")
	private AdminService service;
	
	public void setService(AdminService service) {
		this.service = service;
	}
	
	//금지된 해시태그 리스트
	@RequestMapping(value = "/admin/deleteHashtag.do")
	public ModelAndView blockList() {
		ModelAndView mav = new ModelAndView("admin/deleteHashtag");
		List<Hashtag> blocklist = new ArrayList<Hashtag>();
		blocklist = service.getBlockList();
		
		mav.addObject("blocklist", blocklist);
		System.out.println("blocklist : " + blocklist);
		return mav;
	}
	
	//금지할 해시태그 추가하기
	@RequestMapping(value = "/admin/tagblock.do")
	public String tagblock(@RequestParam(value="tagname") String tagname) {
		service.addBlocktag(tagname);
		return "forward:/admin/deleteHashtag.do";
	}
	
	//금지한 해시태그 활성화하기(눈, 버튼 클릭 둘다)
	@RequestMapping(value = "/admin/allclick.do")
	public @ResponseBody List<Hashtag> blockcancle(@RequestParam(value="valueArrTest[]") List<String> checkArr ) {
		System.out.println("checkArr >>>>>>> " + checkArr);
		service.cancleblock(checkArr);
		List<Hashtag> canList = service.getBlockList();
		return canList;
	}
	
	//신고 게시물 리스트
	@RequestMapping(value = "/admin/chargelist.do")
	public ModelAndView chargelist() {
		ModelAndView mav = new ModelAndView("admin/chargelist");
		List<Like_Siren> chargeList = new ArrayList<Like_Siren>();
		chargeList = service.getChargeList();
		
		mav.addObject("chargeList", chargeList);
		System.out.println("chargeList : " + chargeList);
		return mav;
	}
	
	//해당 신고 게시물 보기
	@RequestMapping(value = "/admin/chargepost.do")
	public ModelAndView chargedetail(@RequestParam(value="bseq") int bseq) {
		ModelAndView mav = new ModelAndView("board/post");
		
		return mav;
	}
	
	//해당 게시물 신고자 리스트
	@RequestMapping(value = "/admin/chargeperson.do")
	public ModelAndView personlist(@RequestParam(value="bseq") int bseq) {
		ModelAndView mav = new ModelAndView("admin/chargeMemList");
		List<Like_Siren> personList = new ArrayList<Like_Siren>();
		personList = service.getPersonList(bseq);
		
		mav.addObject("personList", personList);
		System.out.println("personList : " + personList);
		return mav;
	}
	
	
}