package com.kitri.daily.board;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	@Resource(name = "boardService")
	private BoardService service;
	
	public static String basePath = "D:\\Driver\\apache-tomcat-8.5.30\\webapps\\board\\";

	public void setService(BoardService service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/board/form.do")
	void form() {
		
	}
	
	@RequestMapping(value = "/board/upload.do")
	public String upload(Board b) {
		service.uploadBoard(b);
		return "redirect:/board/list.do";
	}
}
