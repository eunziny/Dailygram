package com.kitri.daily.search;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.board.Board;
import com.kitri.daily.member.Member;



@Controller
public class SearchController {
	@Resource(name="searchService")
	private SearchService service;

	public void setService(SearchService service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/search/look.do")
	public ModelAndView look(HttpServletRequest req) {
		//로그인 한 사람의 id 값 session 에서 가져오기.
		//HttpSession session = req.getSession(false);
		//String id = (String)session.getAttribute("id");
		//Member m = new Member();
		//m.setId(id);
		ModelAndView mav = new ModelAndView("search/look");
		List <String> cntList = new ArrayList<String>();
		List <Look> lookList = new ArrayList<Look>();
		cntList = service.getLookCnt("abc");
		int i = 0; //index용
		if(cntList.size() == 1) { //아무 활동도 하지 않은 상태  cnt=0 1줄
			lookList = service.getLook();
			System.out.println("변경 전 리스트:"+lookList.get(0));
			for(Look b : lookList) {
				String originpath = b.getImg();
				int index = originpath.lastIndexOf("\\");
				String path = originpath.substring(index+1); //파일명만 가져온다.
				b.setImg(path);
				lookList.set(i, b);
				System.out.println("파일명:"+path);
				
				i++;//index용
			}
			System.out.println("변경후 리스트:"+lookList.get(0));
			mav.addObject("lookList",lookList);
		}else {
			if(Integer.parseInt(cntList.get(0)) > 1 && Integer.parseInt(cntList.get(1)) == 0) {
				
			}else if(Integer.parseInt(cntList.get(0)) == 0 && Integer.parseInt(cntList.get(1)) > 1 ) {
				
			}else {
				
			}
		}
		return mav;
	}
	
	@RequestMapping(value = "/search/infiLoad.do")
	public 
}
