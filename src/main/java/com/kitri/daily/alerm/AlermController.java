package com.kitri.daily.alerm;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.friend.FriService;
import com.kitri.daily.member.Member;
import com.kitri.daily.search.Search;

@Controller
public class AlermController {
	@Resource(name = "alermService")
	private AlermService service;
	
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
	
	@RequestMapping(value = "/container/searchalerm.do")
	public @ResponseBody List<Alerm> getMyAlerm(HttpServletRequest req, @RequestParam(value="id") String id) {
		List<Alerm> alermList = new ArrayList<Alerm>();
		alermList = service.getMyAlerm(id);
		HttpSession session = req.getSession();
		session.setAttribute("alermSize", alermList.size());
		return alermList;
	}
}
