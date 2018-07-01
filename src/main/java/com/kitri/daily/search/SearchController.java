package com.kitri.daily.search;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.swing.JOptionPane;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SearchController {
	@Resource(name = "searchService")
	private SearchService service;
	
	@RequestMapping(value = "/container/search.do")
	public ModelAndView searchList(@RequestParam(value = "searchType") String searchType,
			@RequestParam(value = "searchValue") String searchValue) {
		System.out.println("검색타입 :" + searchType);
		System.out.println("검색내용: " + searchValue);
		ModelAndView mav1 = new ModelAndView("search/userfind");
		ModelAndView mav2 = new ModelAndView("search/tagfind");
		/*ArrayList<Search> list = null;*/
		List<Search> list = new ArrayList<Search>();
		if (searchType.equals("아이디")) {
			list = service.getSearchByUser(searchValue);
			int i=0;
			for(Search s : list) {
				String originpath = s.getProfile_img();
				try {
					int index = originpath.lastIndexOf("\\");
					String path = originpath.substring(index+1);
					s.setProfile_img(path);
					list.set(i, s);
					i++;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			mav1.addObject("list", list);
			System.out.println("userList : " + list);
			return mav1;
		} else if (searchType.equals("해시태그")) {
			list = service.getSearchByTag(searchValue);
			int i=0;
			for(Search s : list) {
				String originpath = s.getImg();
				int index = originpath.lastIndexOf("\\");
				String path = originpath.substring(index+1);
				s.setImg(path);
				list.set(i, s);
				i++;
			}
			mav2.addObject("list", list);
			System.out.println("tagList : " + list);
			return mav2;
		}
		return searchList(searchType, searchValue);
	}
	
}