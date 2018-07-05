package com.kitri.daily.board;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.kitri.daily.member.Member;
import com.kitri.daily.search.Hashtag;

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
		String originPath = basePath + "\\board\\"; // ¿øº»ÆÄÀÏ °æ·Î
		String upfolder = basePath + "\\thumbnail\\"; // ½æ³×ÀÏ Ã³¸®ÇÑ ÆÄÀÏ °æ·Î
		MultipartFile file = b.getFile(); // form.jsp¿¡¼­ ¼±ÅÃÇÑ ÆÄÀÏ °¡Á®¿À±â
		if (file != null && !file.equals("")) {
			File dir = new File(originPath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			// ÆÄÀÏ Áßº¹¹æÁö Ã³¸®
			String[] extension = file.getOriginalFilename().split("\\.");
			String FileType = extension[extension.length - 1];
			String img = b.getWriter() + "_" + System.currentTimeMillis() + "." + FileType;
			b.setImg(img); // img °æ·Î set
			File f = new File(originPath + "\\" + img);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			// ½æ³×ÀÏ Ã³¸®
			int thumbnail_width = 375;
			int thumbnail_height = 350;
			File dir2 = new File(upfolder);
			if (!dir2.exists()) {
				dir2.mkdirs();
			}
			try {
				BufferedImage srcImg = ImageIO.read(f); // ¿øº»ÆÄÀÏ ÀÐ¾î¿À±â
				BufferedImage thumbImg;
				thumbImg = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
				java.awt.Graphics2D g = thumbImg.createGraphics();
				g.drawImage(srcImg, 0, 0, thumbnail_width, thumbnail_height, null);
				File outFile = new File(upfolder + "\\" + img);
				ImageIO.write(thumbImg, "PNG", outFile); // ½æ³×ÀÏ ÆÄÀÏ ÀúÀå

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		service.uploadBoard(b); //boardÅ×ÀÌºí¿¡ insert
		/*return "forward:/board/tagInsert.do";*/
		return "redirect:/board/tagInsert.do";
		/*return "redirect:/board/myList.do";*/
	}
	
	@RequestMapping(value = "/board/tagInsert.do")
	public String tagInsert(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		System.out.println("id?"+id);
		Board board = service.selectByid(id);
		// ÇØ½ÃÅÂ±× Ã³¸®
		if (board.getContent().contains("#")) {
			String block_yn = "N";
			String content = board.getContent(); // ±âÁ¸¿¡ board¿¡ ÀÖ´Â ³»¿ëÀ» °¡Á®¿Â´Ù.
			System.out.println("±Û³»¿ë: " + content);
			// Á¤±ÔÇ¥Çö½ÄÀ» ÀÌ¿ëÇÑ ÇØ½ÃÅÂ±× ÃßÃâ
			Pattern p = Pattern.compile("\\#([0-9a-zA-Z°¡-ÆR]*)");
			Matcher m = p.matcher(content);
			String extTag = null;
			// #ÀÌ ºÙÀº ¹®ÀÚ¿­À» Ã£¾Æ¼­ insert
			while (m.find()) {
				extTag = ch_replace(m.group());
				if (extTag != null) {
					Hashtag h = new Hashtag(board.getBoard_seq(), extTag, block_yn);
					service.insertHashtag(h);
					System.out.println("ÇØ½ÃÅÂ±× : " + extTag);
				}
			}
		}
		return "redirect:/board/myList.do";
	}

	public String ch_replace(String str) {
		str = StringUtils.replace(str, "-_+=!@#$%^&*()[]{}|\\;:'\"<>,.?/~`£© ", "");
		if (str.length() < 1) {
			return null;
		}
		return str;
	}

	@RequestMapping(value = "/board/updateBoard.do")
	public ModelAndView editBoard(Board b, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/editForm");
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		Board update = service.detailBoard(b.getBoard_seq());
		mav.addObject("update", update);
		return mav;
	}

	@RequestMapping(value = "/board/edit.do")
	public String edit(Board b) {
		String originPath = basePath + "\\board\\"; // ¿øº»ÆÄÀÏ °æ·Î
		String upfolder = basePath + "\\thumbnail\\"; // ½æ³×ÀÏ Ã³¸®ÇÑ ÆÄÀÏ °æ·Î
		MultipartFile file = b.getFile(); // form.jsp¿¡¼­ ¼±ÅÃÇÑ ÆÄÀÏ °¡Á®¿À±â
		if (file != null && !file.equals("")) {
			File dir = new File(originPath);
			Board d = service.detailBoard(b.getBoard_seq());
			String del = originPath + d.getImg(); // ¿øº»ÆÄÀÏ °æ·Î¿Í ÆÄÀÏ¸í
			System.out.println("ÆÄÀÏ" + del);
			File delete = new File(del);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			// ÆÄÀÏ Áßº¹¹æÁö Ã³¸®
			String[] extension = file.getOriginalFilename().split("\\.");
			String FileType = extension[extension.length - 1];
			String img = b.getWriter() + "_" + System.currentTimeMillis() + "." + FileType;
			b.setImg(img); // img °æ·Î set
			File f = new File(originPath + "\\" + img);

			try {
				file.transferTo(f); // »õ·Î¿î ÆÄÀÏÀ» ³ÖÀ½
				delete.delete();
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			// ½æ³×ÀÏ Ã³¸®
			int thumbnail_width = 375;
			int thumbnail_height = 350;
			File dir2 = new File(upfolder);
			if (!dir2.exists()) {
				dir2.mkdirs();
			}
			try {
				BufferedImage srcImg = ImageIO.read(f); // ¿øº»ÆÄÀÏ ÀÐ¾î¿À±â
				BufferedImage thumbImg;
				thumbImg = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
				java.awt.Graphics2D g = thumbImg.createGraphics();
				g.drawImage(srcImg, 0, 0, thumbnail_width, thumbnail_height, null);
				File outFile = new File(upfolder + "\\" + img);
				ImageIO.write(thumbImg, "PNG", outFile); // ½æ³×ÀÏ ÆÄÀÏ ÀúÀå

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
		String upfolder = basePath + "\\thumbnail\\"; // img °¡Á®¿Ã ÆÄÀÏ °æ·Î
		System.out.println("ÀÌ¹ÌÁö~~~~~~!! " + b.getImg());
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

	@RequestMapping(value = "/board/newsfeed.do", method = RequestMethod.GET)
	public void newsfeed(Model model, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/newsfeed");
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		List<Board> feedList = (ArrayList<Board>) service.getNewsfeed(id);
		model.addAttribute("feed", feedList);
	}
}