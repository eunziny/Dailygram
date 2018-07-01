package com.kitri.daily.member;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemController {
	@Resource(name="memService")
	private MemService service;

	public void setService(MemService service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/member/loginForm.do")
	public String loginForm() {
		return "member/login";
	}
	
	@RequestMapping(value = "/member/login.do")
	public String login(HttpServletRequest req, Member m) {
		Member mem = service.getMember(m.getId());
	
		if (mem == null || !mem.getPwd().equals(m.getPwd())) {
			System.out.println("로그인 실패");
			return "redirect:/member/loginForm.do";
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("memInfo",mem);
			return "board/list";
		}
	}
	
	@RequestMapping(value = "/member/logout.do")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		session.removeAttribute("id");
		session.invalidate();
		return "redirect:/member/loginForm.do";
	}
	
	@RequestMapping(value="/member/out.do")
	  public String out(HttpServletRequest req, 
			  			@RequestParam(value="id") String id) {
		HttpSession session = req.getSession(false);
		service.delete(id);
		session.removeAttribute("id");
		session.invalidate();
		return "redirect:/member/loginForm.do";
	}
	
	@RequestMapping(value = "/container/header.do")
	void test() {
		
	}
	
	@RequestMapping(value = "/admin/chargelist.do")
	void test6() {
		
	}
	
	@RequestMapping(value = "/admin/chargeMemList.do")
	void test7() {
		
	}
	

	
/*	@RequestMapping(value = "/board/post.do")
	void test9() {
		
	}*/
	
	@RequestMapping(value = "/board/look.do")
	void test10() {
		
	}
	
	@RequestMapping(value = "/member/join.do")
	void test11() {
		
	}
	
	@RequestMapping(value = "/member/mem_editForm.do")
	void test12() {
		
	}
	
	/*@RequestMapping(value = "/board/list.do")
	void test13() {
		
	}*/
	
	@RequestMapping(value = "/board/editForm.do")
	void test15() {
		
	}
	
	@RequestMapping(value = "/admin/deleteHashtag.do")
	void test17() {
		
	}
	
	@RequestMapping(value = "/admin/admin_header.do")
	void test18() {
		
	}
}
