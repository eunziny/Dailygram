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
	public ModelAndView editBoard(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/editForm");
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		Board update = service.detailBoard(29, id);
		mav.addObject("update", update);
		String originpath = update.getImg(); // 파일경로를 가져옴
		int index = originpath.lastIndexOf("\\");
		String path = originpath.substring(index + 1); // 파일명만 가져온다.
		System.out.println(path);
		mav.addObject("path",path);
		return mav;
	}

	@RequestMapping(value = "/board/edit.do")
	public String edit(Board b) {
		service.editBoard(b);
		return "redirect:/board/post.do";
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
		String originpath = b.getImg(); // 파일경로를 가져옴
		int index = originpath.lastIndexOf("\\");
		String path = originpath.substring(index + 1); // 파일명만 가져온다.
		System.out.println(path);
		mav.addObject("path",path);
		return mav;
	}
}
