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
		service.addBlocktag(tagname);
		return "forward:/admin/deleteHashtag.do";
	}
	
}
