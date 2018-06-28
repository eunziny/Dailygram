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
	
	@RequestMapping(value = "/board/upload.do")
	public String upload(HttpServletRequest req, Board b) {
		MultipartFile file = b.getFile();
		if (file != null && !file.equals("")) {
			File dir = new File(basePath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			int thumbnail_width = 300;
			int thumbnail_height = 300;
			String fileName = file.getOriginalFilename();
			String img = fileName /*+ System.currentTimeMillis() + file.getSize()*/;
			File f = new File(basePath + "\\" + img);
			b.setImg(img);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		service.uploadBoard(b);
		return "redirect:/board/list.do";
	} 
}
