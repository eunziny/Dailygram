package com.kitri.daily.admin;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
/*	//금지 해시태그 낱개 활성화하기(눈 클릭했을 때)
	@RequestMapping(value = "/admin/eyeclick.do")
	public String blockcancle(@RequestParam(value="tagcancle") String tagcancle ) {
		System.out.println("tagcancle : " + tagcancle);
		service.cancleblock(tagcancle);
		return "forward:/admin/deleteHashtag.do";
	}*/
	
	
	//금지한 해시태그 활성화하기(눈, 버튼 클릭 모두)
	@RequestMapping(value = "/admin/allclick.do")
	void blockcancle(@RequestParam(value="valueArrTest[]") List<String> checkArr ) {
		System.out.println("checkArr : " + checkArr);
		service.cancleblock(checkArr);
	}
	
}