package com.kitri.daily.search;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class SearchController {
	@Resource(name="searchService")
	private SearchService service;

	public void setService(SearchService service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/search/look.do")
	void look () {
		
	}
}
