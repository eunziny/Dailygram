package com.kitri.daily.board;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	
	public void saveImg(@RequestParam(value ="img") MultipartFile img) {
		String fileName = img.getOriginalFilename();
		if (fileName != null && !fileName.equals("")) {
			File dir = new File(basePath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			File f = new File(basePath + "\\" + fileName);
			try {
				img.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value = "/board/upload.do")
	public String upload(HttpServletRequest req, Board b) {
		service.uploadBoard(b);
		return "redirect:/board/list.do";
	} 
}
