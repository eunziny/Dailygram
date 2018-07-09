package com.kitri.daily.alerm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.member.Member;

@Controller
public class AlermController {
	
	@RequestMapping(value ="/chat/chatting.do" ,method=RequestMethod.GET)
	public ModelAndView chat(ModelAndView mv ,HttpServletRequest req) {
		mv.setViewName("alerm/chattingview");
		//사용자 정보 출력 (세션)//
		HttpSession session = req.getSession(false);
		Member mem = (Member)session.getAttribute("memInfo");
		System.out.println("user name:"+mem.getId());
		System.out.println("normal chat page");
		mv.addObject("userid", mem.getId());
		return mv;
	}
}
