package com.kitri.daily.board;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommController {
	   @Resource(name = "boardService")
	   private BoardService service;

	   public void setService(BoardService service) {
	      this.service = service;
	   }
	   
}
