package com.kitri.daily.board;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
	@Resource(name = "boardService")
	private BoardService service;

	public void setService(BoardService service) {
		this.service = service;
	}

	@RequestMapping(value = "/board/updateBoard.do")
	public ModelAndView editBoard(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/editForm");
		session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		return mav;
	}

	@RequestMapping(value = "/board/update.do")
	public String edit(Board b) {
		service.uploadBoard(b);
		return "redirect:/list.do";
	}

	/*
	 * @RequestMapping(value = "/board/list.do") public ModelAndView list() {
	 * ModelAndView mav = new ModelAndView("board/list"); ArrayList<Board> list =
	 * (ArrayList<Board>) service.getAll(); for (int i = 0; i < list.size(); i++) {
	 * Board b = list.get(i); } mav.addObject("list", list); return mav; }
	 */

	@RequestMapping(value = "/board/post.do")
	public ModelAndView detail(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/post");
		session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		Board b = service.detailBoard(29, id);
		mav.addObject("b", b);
		String originpath = b.getImg1(); // 파일경로를 가져옴
		int index = originpath.lastIndexOf("\\");
		String path = originpath.substring(index + 1); // 파일명만 가져온다.
		System.out.println(path);
		mav.addObject("path",path);
		return mav;
	}
}
