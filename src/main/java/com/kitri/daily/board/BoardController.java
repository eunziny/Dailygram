package com.kitri.daily.board;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.member.Member;

@Controller
public class BoardController {
	String basePath = "D:\\driver\\apache-tomcat-8.5.30\\webapps";

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
		List<Newsfeed> feedList = (ArrayList<Newsfeed>) service.getNewsfeed(id, id);
		mav.addObject("feed",feedList);
		return mav;
	}
}