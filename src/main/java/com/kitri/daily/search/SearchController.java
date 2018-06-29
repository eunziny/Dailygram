package com.kitri.daily.search;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.board.Board;
import com.kitri.daily.member.Member;



@Controller
public class SearchController {
	@Resource(name="searchService")
	private SearchService service;
	private int i;

	public void setService(SearchService service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/search/look.do")
	public ModelAndView look(HttpServletRequest req) {
		//�α��� �� ����� id �� session ���� ��������.
		HttpSession session = req.getSession(false);
		String id = (String)session.getAttribute("id");
		ModelAndView mav = new ModelAndView("search/look");
		//List <String> cntList = new ArrayList<String>();
		String [] cntArr = {};
		List <Look> lookList = new ArrayList<Look>();
		cntArr = service.getLookCnt(id);
		System.out.println(cntArr.length);
		i = 0; //index��
		if(cntArr.length == 1) { //�ƹ� Ȱ���� ���� ���� ����  cnt=0 1��
			lookList = service.getLook(0);
			for(Look b : lookList) {
				String originpath = b.getImg();
				int index = originpath.lastIndexOf("\\");
				String path = originpath.substring(index+1); //���ϸ� �����´�.
				b.setImg(path);
				lookList.set(i, b);
				i++;//index��
			}
			mav.addObject("lookList",lookList);
			mav.addObject("flag",1);
		}else {
			if(Integer.parseInt(cntArr[0]) > 1 && Integer.parseInt(cntArr[1]) == 0) {//���ƿ� 1�̻� ģ�� 0
				List <Look> likeLookList = new ArrayList<Look>();
				Look lo = new Look(id,0);
				likeLookList = service.getLikeLook(lo);
				i = 0; //index��
				for(Look b : likeLookList) {
					String originpath = b.getImg();
					int index = originpath.lastIndexOf("\\");
					String path = originpath.substring(index+1); //���ϸ� �����´�.
					b.setImg(path);
					likeLookList.set(i, b);
					i++;//index��
				}
				
				mav.addObject("lookList",likeLookList);
				mav.addObject("flag",2);
			}else if(Integer.parseInt(cntArr[0]) == 0 && Integer.parseInt(cntArr[1]) > 1 ) {//���ƿ� 0 ģ�� 1�̻�
				String friCnt = service.getFriLookCnt(id);
				List <Look> friLookList = new ArrayList<Look>();
				Look lo = new Look(id,0);
				
				if(Integer.parseInt(friCnt) <= 100) {
					friLookList = service.getFriLookDown(lo);
					mav.addObject("flag",3);
				}else {//100�� �̻��̶��
					friLookList = service.getFriLookUp(lo);
					mav.addObject("flag",4);
				}
				
				i = 0; //index��
				for(Look b : friLookList) {
					String originpath = b.getImg();
					int index = originpath.lastIndexOf("\\");
					String path = originpath.substring(index+1); //���ϸ� �����´�.
					b.setImg(path);
					friLookList.set(i, b);
					i++;//index��
				}
				mav.addObject("lookList",friLookList);
			}else {
				List <Look> frliLookList = new ArrayList<Look>();
				Look lo = new Look(id,0);
				frliLookList = service.getFrLiLook(lo);
				i = 0; //index��
				for(Look b : frliLookList) {
					String originpath = b.getImg();
					int index = originpath.lastIndexOf("\\");
					String path = originpath.substring(index+1); //���ϸ� �����´�.
					b.setImg(path);
					frliLookList.set(i, b);
					i++;//index��
				}
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
		String id = (String)session.getAttribute("id");
		Look lo = new Look(id,row-1);
		System.out.println("flag�� ���߿;�?:"+flag);
		System.out.println("id���� �� �Դ�?"+id);
		switch (flag) {
		case 1:
			lookList= service.getLook(row-1);
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
		
		i = 0; //index��
			for(Look b : lookList) {
				String originpath = b.getImg();
				int index = originpath.lastIndexOf("\\");
				String path = originpath.substring(index+1); //���ϸ� �����´�.
				b.setImg(path);
				lookList.set(i, b);
				i++;//index��
			}
		return lookList;
	}
}
