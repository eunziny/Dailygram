package com.kitri.daily.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemController {
	@RequestMapping(value = "/container/header.do")
	void test() {
		
	}
	
	@RequestMapping(value = "/friend/knownfriend.do")
	void test2() {
		
	}
}
