package com.kitri.daily.search;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.kitri.daily.member.Member;


@Controller
public class SearchController {
	@Resource(name="searchService")
	private SearchService service;
	private int i;

	public void setService(SearchService service) {
		this.service = service;
	}
	
/*	@RequestMapping(value = "/container/autocomplete.do")
	public @ResponseBody String autoSearch(@RequestParam(value="term") String term, HttpServletRequest req) {
		List<Search> autoList = new ArrayList<Search>();
		autoList = service.getAutoSearch(term);
		//System.out.println("자동완성 리스트 : " + autoList + "\n사이즈 : " + autoList.size());
		JSONArray array = new JSONArray(autoList);
	    JSONObject json = new JSONObject();
	    json.put("searchlist", array);
	    System.out.println("list :::: " + json.toString());
		return json.toString();
	}*/
	
    @RequestMapping(value = "/container/autocomplete.do")
    public @ResponseBody List<Search> autoSearch(@RequestParam(value="term") String term, HttpServletRequest req) {
       List<Search> autoList = service.getAutoSearch(term);
       System.out.println("autoList >>>>>>> " + autoList);
       return autoList;
    }
	
	@RequestMapping(value = "/container/search.do")
	public ModelAndView searchList(@RequestParam(value = "searchType") String searchType,
			@RequestParam(value = "searchValue") String tagname) {
		System.out.println("검색타입 :" + searchType);
		System.out.println("검색내용: " + tagname);
		ModelAndView mav1 = new ModelAndView("search/userfind");
		ModelAndView mav2 = new ModelAndView("search/tagfind");
		/*ArrayList<Search> list = null;*/
		List<Search> list = new ArrayList<Search>();
		List<Search> list2 = new ArrayList<Search>();
		if (searchType.equals("아이디")) {
			list = service.getSearchByUser(tagname);
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
			Search sc = new Search(0, tagname);
			list = service.getSearchByTag(sc);
			list2 = service.getListSize(tagname);
			mav2.addObject("list", list);
			mav2.addObject("tagname", tagname);
			mav2.addObject("list2", list2);
			System.out.println("tagList : " + list);
			return mav2;
		} else {
			return null;
		}
	}
	
	//검색 결과 무한스크롤
	@RequestMapping(value = "/search/infitag.do")
	public @ResponseBody List<Search> infitag(@RequestParam(value="row") int row , 
			@RequestParam(value="tagname") String tagname) {
		System.out.println("row :" + row );
		List<Search> infiSearchList = new ArrayList<Search>();
		Search sc = new Search(row, tagname);
		infiSearchList = service.getSearchInfiTag(sc);
		System.out.println("무한스크롤 되냐!!" + infiSearchList);
/*		int i=0;
		for(Search s : infiSearchList) {
			String originpath = s.getImg();
			int index = originpath.lastIndexOf("\\");
			String path = originpath.substring(index+1);
			s.setImg(path);
			infiSearchList.set(i, s);
			i++;
		}*/
		return infiSearchList;
		
	}
	
	@RequestMapping(value = "/search/look.do")
	public ModelAndView look(HttpServletRequest req) {
		//로그인 한 사람의 id 값 session 에서 가져오기.
		HttpSession session = req.getSession(false);
		Member mem = (Member)session.getAttribute("memInfo");
		String id = mem.getId();
		ModelAndView mav = new ModelAndView("search/look");
		//List <String> cntList = new ArrayList<String>();
		String [] cntArr = {};
		List <Look> lookList = new ArrayList<Look>();
		cntArr = service.getLookCnt(id);
		System.out.println(cntArr.length);
		for(i=0;i<cntArr.length;i++) {
			System.out.println("cntArr[i]"+cntArr[i]);
		}
		/*i = 0; //index용*/
		if(cntArr.length == 1) { //아무 활동도 하지 않은 상태  cnt=0 1줄
			lookList = service.getLook(0);
			/*for(Look b : lookList) {
				String originpath = b.getImg();
				int index = originpath.lastIndexOf("\\");
				String path = originpath.substring(index+1); //파일명만 가져온다.
				b.setImg(path);
				lookList.set(i, b);
				i++;//index용
			}*/
			mav.addObject("lookList",lookList);
			mav.addObject("flag",1);
		}else {
			if(Integer.parseInt(cntArr[0]) > 1 && Integer.parseInt(cntArr[1]) == 0) {//좋아요 1이상 친구 0
				List <Look> likeLookList = new ArrayList<Look>();
				Look lo = new Look(id,0);
				likeLookList = service.getLikeLook(lo);
				/*i = 0; //index용
				for(Look b : likeLookList) {
					String originpath = b.getImg();
					int index = originpath.lastIndexOf("\\");
					String path = originpath.substring(index+1); //파일명만 가져온다.
					b.setImg(path);
					likeLookList.set(i, b);
					i++;//index용
				}*/
				
				mav.addObject("lookList",likeLookList);
				mav.addObject("flag",2);
			}else if(Integer.parseInt(cntArr[0]) == 0 && Integer.parseInt(cntArr[1]) > 1 ) {//좋아요 0 친구 1이상
				String friCnt = service.getFriLookCnt(id);
				List <Look> friLookList = new ArrayList<Look>();
				Look lo = new Look(id,0);
				
				if(Integer.parseInt(friCnt) <= 100) {
					friLookList = service.getFriLookDown(lo);
					mav.addObject("flag",3);
				}else {//100개 이상이라면
					friLookList = service.getFriLookUp(lo);
					mav.addObject("flag",4);
				}
				
				/*i = 0; //index용
				for(Look b : friLookList) {
					String originpath = b.getImg();
					int index = originpath.lastIndexOf("\\");
					String path = originpath.substring(index+1); //파일명만 가져온다.
					b.setImg(path);
					friLookList.set(i, b);
					i++;//index용
				}*/
				mav.addObject("lookList",friLookList);
			}else {
				System.out.println("일로 들어온거니?");
				List <Look> frliLookList = new ArrayList<Look>();
				Look lo = new Look(id,0);
				frliLookList = service.getFrLiLook(lo);
				/*i = 0; //index용
				for(Look b : frliLookList) {
					String originpath = b.getImg();
					int index = originpath.lastIndexOf("\\");
					String path = originpath.substring(index+1); //파일명만 가져온다.
					b.setImg(path);
					frliLookList.set(i, b);
					i++;//index용
				}*/
				mav.addObject("lookList",frliLookList);
				mav.addObject("flag",5);
			}
		}
		return mav;
	}
	
	@RequestMapping(value = "/search/infiLoad.do" , method = RequestMethod.POST)
	public @ResponseBody List<Look> infiLoad(@RequestParam(value="row") int row,
			@RequestParam(value="flag") int flag ,HttpServletRequest req){
		List<Look> lookList = new ArrayList<Look>();
		HttpSession session = req.getSession(false);
		Member mem = (Member)session.getAttribute("memInfo");
		String id = mem.getId();
		Look lo = new Look(id,row);
		switch (flag) {
		case 1:
			lookList= service.getLook(row);
			break;
		case 2:
			lookList = service.getLikeLook(lo);
			break;
		case 3:
			lookList= service.getFriLookDown(lo);
			break;
		case 4:
			lookList= service.getFriLookUp(lo);
			break;
		case 5:
			lookList = service.getFrLiLook(lo);
			break;
		}
		
		/*i = 0; //index용
			for(Look b : lookList) {
				String originpath = b.getImg();
				int index = originpath.lastIndexOf("\\");
				String path = originpath.substring(index+1); //파일명만 가져온다.
				b.setImg(path);
				lookList.set(i, b);
				i++;//index용
			}*/
		return lookList;
	}
}