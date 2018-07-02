package com.kitri.daily.board;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.member.Member;
import com.sun.media.jfxmedia.logging.Logger;

@Controller
public class BoardController {
	String basePath = "D:\\apache-tomcat-8.5.30-windows-x64\\apache-tomcat-8.5.30\\webapps";

	@Resource(name = "boardService")
	private BoardService service;

	public void setService(BoardService service) {
		this.service = service;
	}

	@RequestMapping(value = "/board/form.do")
	void form() {

	}

	@RequestMapping(value = "/board/upload.do")
	public String upload(HttpServletRequest req, Board b) {
		String originPath = basePath + "\\board\\"; // �������� ���
		String upfolder = basePath + "\\thumbnail\\"; // ����� ó���� ���� ���
		MultipartFile file = b.getFile(); // form.jsp���� ������ ���� ��������
		if (file != null && !file.equals("")) {
			File dir = new File(originPath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			// ���� �ߺ����� ó��
			String[] extension = file.getOriginalFilename().split("\\.");
			String FileType = extension[extension.length - 1];
			String img = b.getWriter() + "_" + System.currentTimeMillis() + "." + FileType;
			b.setImg(img); // img ��� set
			File f = new File(originPath + "\\" + img);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			// ����� ó��
			int thumbnail_width = 375;
			int thumbnail_height = 350;
			File dir2 = new File(upfolder);
			if (!dir2.exists()) {
				dir2.mkdirs();
			}
			try {
				BufferedImage srcImg = ImageIO.read(f); // �������� �о����
				BufferedImage thumbImg;
				thumbImg = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
				java.awt.Graphics2D g = thumbImg.createGraphics();
				g.drawImage(srcImg, 0, 0, thumbnail_width, thumbnail_height, null);
				File outFile = new File(upfolder + "\\" + img);
				ImageIO.write(thumbImg, "PNG", outFile); // ����� ���� ����

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		service.uploadBoard(b);
		return "redirect:/board/myList.do";
	}

	@RequestMapping(value = "/board/updateBoard.do")
	public ModelAndView editBoard(Board b, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/editForm");
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		Board update = service.detailBoard(b.getBoard_seq());
		mav.addObject("update", update);
		/*
		 * String originpath = update.getImg(); // ���ϰ�θ� ������ int index =
		 * originpath.lastIndexOf("\\"); String path = originpath.substring(index + 1);
		 * System.out.println(path); mav.addObject("path", path);
		 */
		return mav;
	}

	@RequestMapping(value = "/board/edit.do")
	public String edit(Board b) {
		String originPath = basePath + "\\board\\"; // �������� ���
		String upfolder = basePath + "\\thumbnail\\"; // ����� ó���� ���� ���
		MultipartFile file = b.getFile(); // form.jsp���� ������ ���� ��������
		if (file != null && !file.equals("")) {
			File dir = new File(originPath);
			Board d = service.detailBoard(b.getBoard_seq());
			String del = originPath + d.getImg(); // �������� ��ο� ���ϸ�
			System.out.println("����" + del);
			File delete = new File(del);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			// ���� �ߺ����� ó��
			String[] extension = file.getOriginalFilename().split("\\.");
			String FileType = extension[extension.length - 1];
			String img = b.getWriter() + "_" + System.currentTimeMillis() + "." + FileType;
			b.setImg(img); // img ��� set
			File f = new File(originPath + "\\" + img);

			try {
				file.transferTo(f); // ���ο� ������ ����
				delete.delete();
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			// ����� ó��
			int thumbnail_width = 375;
			int thumbnail_height = 350;
			File dir2 = new File(upfolder);
			if (!dir2.exists()) {
				dir2.mkdirs();
			}
			try {
				BufferedImage srcImg = ImageIO.read(f); // �������� �о����
				BufferedImage thumbImg;
				thumbImg = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
				java.awt.Graphics2D g = thumbImg.createGraphics();
				g.drawImage(srcImg, 0, 0, thumbnail_width, thumbnail_height, null);
				File outFile = new File(upfolder + "\\" + img);
				ImageIO.write(thumbImg, "PNG", outFile); // ����� ���� ����

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		service.editBoard(b);
		return "redirect:/board/post.do";
	}

	@RequestMapping(value = "/board/post.do")
	public ModelAndView detail(HttpSession session, HttpServletRequest req, @RequestParam(value = "bseq") int bseq) {
		ModelAndView mav = new ModelAndView("board/post");
		Board b = service.detailBoard(bseq);
		mav.addObject("b", b);
		String upfolder = basePath + "\\thumbnail\\"; // img ������ ���� ���
		System.out.println("�̹���~~~~~~!! " + b.getImg());
		String path = upfolder + b.getImg();
		System.out.println(path);
		mav.addObject("path", path);
		return mav;
	}

	@RequestMapping(value = "/board/myList.do")
	public ModelAndView list(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		List<Board> boardlist = (ArrayList<Board>) service.getMyList(id);
		ModelAndView mav = new ModelAndView("board/myList");
		mav.addObject("list", boardlist);
		return mav;
	}

	@RequestMapping(value = "/board/newsfeed.do")
	public ModelAndView newsfeed(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/newsfeed");
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		List<Board> feedList = new ArrayList<Board>();
		feedList = service.getNewsfeed(id, 0);
		mav.addObject("feed", feedList);
		return mav;
	}
	
	@RequestMapping(value = "/board/infnScrollDown.do", method = RequestMethod.POST)
	public @ResponseBody List<Board> infiniteScrollDown(@RequestParam("row") int row, HttpServletRequest req) {
		List<Board> flist = new ArrayList<Board>();
		HttpSession session = req.getSession(false);
		Member mem = (Member)session.getAttribute("memInfo");
		String id = mem.getId();
		flist = service.getNewsfeed(id, row-1);
		return flist;
	}
}