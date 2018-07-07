package com.kitri.daily.board;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kitri.daily.friend.Friend;
import com.kitri.daily.friend.Relationship;
import com.kitri.daily.member.Member;
import com.kitri.daily.search.Hashtag;
import com.kitri.daily.search.Look;

@Controller
public class BoardController {
	String basePath = System.getProperty("catalina.home") + "\\webapps\\dailygram";

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
		String originPath = basePath + "\\Board\\"; // ¿øº»ÆÄÀÏ °æ·Î
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
		service.uploadBoard(b); // boardÅ×ÀÌºí¿¡ insert
		return "redirect:/board/tagInsert.do";
	}

	@RequestMapping(value = "/board/tagInsert.do")
	public String tagInsert(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		System.out.println("id?" + id);
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

	@RequestMapping(value = "/board/newsfeed.do", method = RequestMethod.GET)	
	public ModelAndView newsfeed(@RequestParam String id) {
		ModelAndView mav = new ModelAndView("board/newsfeed");
		Board sendbo = new Board();
		sendbo.setWriter(id);
		sendbo.setRow(0);
		List <Board> boardList= service.getNewsfeed(sendbo);//10°³ + ÇØ´ç±ÛÀÇ type°¡Á®¿Â´Ù L,S,X ¼ÂÁßÇÏ³ª.
		mav.addObject("boardList", boardList);
		//´ñ±ÛÀ» Ã£±âÀ§ÇÑ ±Û¹øÈ£ list ÀÌ´Ù.
		List <Integer> bseqList = new ArrayList<Integer>();
		//ÇÁ·ÎÇÊ »çÁø À» °®°í¿À±â À§ÇÑ ÇØ´ç ±Û¹øÈ£ ±Û¾´ÀÌ writer º¸³»±â.
		List <String> writerList = new ArrayList<String>();
		//´ñ±ÛÀ» °¡Á®¿À±â À§ÇÑ À§¿¡¼­ ¹øÈ£ »Ì±â.
		for(Board b : boardList) {
			bseqList.add(b.getBoard_seq());
			writerList.add(b.getWriter());
		}
		HashMap<String,List<Integer>> hm = new HashMap<String,List<Integer>>();
		HashMap<String,List<String>> hm2 = new HashMap<String, List<String>>();
		hm.put("bseq", bseqList);
		hm2.put("writer",writerList);
		List<Comment> coList = service.getNewsComm(hm); //´ñ±Û °¡Á®¿Í¶ó
		List<Member> proList = service.getProfileImg(hm2);
		mav.addObject("coList",coList);
		mav.addObject("proList",proList);
		return mav;
	}

	@RequestMapping(value = "/board/infiLoad.do" , method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> infiLoad(@RequestParam String id  , @RequestParam int row){
		Map<String , Object> map = new HashMap<String, Object>();
		System.out.println("ÇöÀç row:"+row);
		Board sendbo = new Board();
		sendbo.setWriter(id);
		sendbo.setRow(row);
		List <Board> boardList= service.getNewsfeed(sendbo);//10°³ + ÇØ´ç±ÛÀÇ type°¡Á®¿Â´Ù L,S,X ¼ÂÁßÇÏ³ª.
		map.put("boardList", boardList);
		List <Integer> bseqList = new ArrayList<Integer>();
		List <String> writerList = new ArrayList<String>();
		for(Board b : boardList) {
			bseqList.add(b.getBoard_seq());
			writerList.add(b.getWriter());
		}
		HashMap<String,List<Integer>> hm = new HashMap<String,List<Integer>>();
		HashMap<String,List<String>> hm2 = new HashMap<String, List<String>>();
		hm.put("bseq", bseqList);
		hm2.put("writer",writerList);
		List<Comment> coList = service.getNewsComm(hm); //´ñ±Û °¡Á®¿Í¶ó
		List<Member> proList = service.getProfileImg(hm2);
		map.put("coList", coList);
		map.put("proList", proList);
		return map;
	}
	
	@RequestMapping(value = "/board/del.do")
	public String delete(HttpServletRequest req, @RequestParam(value = "bseq") int bseq) throws Exception {
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		service.deleteBoard(bseq);
		return "redirect:/board/myList.do";
	}

	@RequestMapping(value = "/board/updateBoard.do")
	public ModelAndView editBoard(@RequestParam(value = "bseq") int bseq, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/editForm");
		Board update = service.detailBoard(bseq);
		mav.addObject("update", update);
		return mav;
	}

	@RequestMapping(value = "/board/edit.do")
	public String edit(Board b) {
		String originPath = basePath + "\\board\\"; // ¿øº»ÆÄÀÏ °æ·Î
		String upfolder = basePath + "\\thumbnail\\"; // ½æ³×ÀÏ Ã³¸®ÇÑ ÆÄÀÏ °æ·Î
		MultipartFile file = b.getFile(); // form.jsp¿¡¼­ ¼±ÅÃÇÑ ÆÄÀÏ °¡Á®¿À±â
		if (file != null && !file.equals("")) {
			Board d = service.detailBoard(b.getBoard_seq());
			String del = originPath + d.getImg(); // ¿øº»ÆÄÀÏ °æ·Î¿Í ÆÄÀÏ¸í
			String del2 = upfolder + d.getImg(); // ¿øº»ÆÄÀÏ °æ·Î¿Í ÆÄÀÏ¸í
			File delete = new File(del);
			File delete2 = new File(del2);
			// ÆÄÀÏ Áßº¹¹æÁö Ã³¸®
			String[] extension = file.getOriginalFilename().split("\\.");
			String FileType = extension[extension.length - 1];
			String img = b.getWriter() + "_" + System.currentTimeMillis() + "." + FileType;
			b.setImg(img); // img °æ·Î set
			File f = new File(originPath + "\\" + img);

			try {
				file.transferTo(f); // »õ·Î¿î ÆÄÀÏÀ» ³ÖÀ½
				delete.delete();
				delete2.delete();
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
		return "redirect:/board/post.do?bseq=" + b.getBoard_seq();
	}

	@RequestMapping(value = "/board/post.do")
	public ModelAndView detail(HttpServletRequest req, @RequestParam(value = "bseq") int bseq) {
		ModelAndView mav = new ModelAndView("board/post");
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		Like like = new Like(bseq, id);
		Like l = service.getType(like);
		mav.addObject("l", l);
		Board b = service.detailBoard(bseq);
		List<Comment> coList = service.getComments(bseq);// ÇØ´ç±ÛÀÇ ÄÚ¸àÆ® ¸®½ºÆ®µé °¡Á®¿À±â.
		mav.addObject("b", b);
		mav.addObject("coList", coList);
		String upfolder = basePath + "\\thumbnail\\"; // img °¡Á®¿Ã ÆÄÀÏ °æ·Î
		String path = upfolder + b.getImg();
		mav.addObject("path", path);
		Member fri = service.friend(b.getWriter());
		mav.addObject("fri", fri);

		return mav;
	}

	@RequestMapping(value = "/board/myList.do")
	public ModelAndView list(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		String id = mem.getId();
		List<Board> boardlist = (ArrayList<Board>) service.getMyList(id);
		String cnt = service.cntBoard(id);
		req.setAttribute("cnt", cnt);
		/*
		 * Timer t = new Timer(true); TimerTask m_task = new TimerTask() {
		 * 
		 * @Override public void run() { System.out.println("°ø°³ °Ô½Ã¹°2 : " + boardlist);
		 * for(int i=0; i<boardlist.size(); i++) { System.out.println("°ø°³ °Ô½Ã¹°"+i+" : " +
		 * boardlist.get(i).getPublic_yn());
		 * if(boardlist.get(i).getPublic_yn().trim().equals("yd") ||
		 * boardlist.get(i).getPublic_yn().trim().equals("nd")) {
		 * System.out.println("°ø°³ °Ô½Ã¹° : " + boardlist.get(i).getPublic_yn()); String yn
		 * = boardlist.get(i).getPublic_yn().substring(0, 1);
		 * boardlist.get(i).setPublic_yn(yn); service.updelay(boardlist.get(i)); } } }
		 * };
		 * 
		 * t.schedule(m_task, 10000);
		 */
		ModelAndView mav = new ModelAndView("board/myList");
		mav.addObject("list", boardlist);
		return mav;
	}

   @RequestMapping(value = "/board/delType.do")
   public String delType (HttpServletRequest req ,@RequestParam(value="bseq") int bseq) {
	   HttpSession session = req.getSession(false);
	   Member mem  = (Member) session.getAttribute("memInfo");
	   String id = mem.getId();
	   Like like = new Like(bseq, id);
	   service.delType(like);
	   return "redirect:/board/post.do?bseq="+bseq;
   }
   
   @RequestMapping(value = "/board/like.do")
   public String like (HttpServletRequest req ,@RequestParam(value="bseq") int bseq) {
	   HttpSession session = req.getSession(false);
	   Member mem  = (Member) session.getAttribute("memInfo");
	   String id = mem.getId();
	   Like like = new Like(bseq, id);
	   service.addLike(like);
	   return "redirect:/board/post.do?bseq="+bseq;
   }
   
   @RequestMapping(value = "/board/siren.do")
   public String siren (HttpServletRequest req ,@RequestParam(value="bseq") int bseq) {
	   HttpSession session = req.getSession(false);
	   Member mem  = (Member) session.getAttribute("memInfo");
	   String id = mem.getId();
	   Like like = new Like(bseq, id);
	   service.addSiren(like);
	   return "redirect:/board/post.do?bseq="+bseq;
   }
   
   @RequestMapping(value = "/board/friList.do")
   public ModelAndView friProfile(HttpServletRequest req ,
		   						@RequestParam(value="writer") String writer) {
	   HttpSession session = req.getSession(false);
	   Member mem  = (Member) session.getAttribute("memInfo");
	   String id = mem.getId();
	   System.out.println("ÀÛ°¡ : " + writer + " id : " + id);
	   Board board = new Board(writer, id);
	   List<Board> list = null;
	   String[] statusArr = {};
	   statusArr = service.getStatus(board);
	   if(statusArr.length ==1) {
		   if(statusArr[0].equals("y")) {
			   list = (ArrayList<Board>) service.publicy(board);
		   }else {
			   System.out.println("°ø°³µÈ °Ô½Ã¹°ÀÌ ¾ø½À´Ï´Ù.");
		   }
		   
	   }else {
		   if((statusArr[0].equals("y") || statusArr[0].equals("n")) && statusArr[1].equals("Y")) {
			   list = (ArrayList<Board>) service.publicyn(board);
		   } else if(statusArr[0].equals("y") && 
				   (statusArr[1].equals("N") ||statusArr[1].equals("R"))) {
			   list = (ArrayList<Board>) service.publicy(board);
		   } else {
			   System.out.println("°ø°³µÈ °Ô½Ã¹°ÀÌ ¾ø½À´Ï´Ù.");
		   }
	   }
	   
//	   List<Board> list = (ArrayList<Board>) service.getList(board);
	   Member fri = service.friend(writer);
	   System.out.println("Ä«¿îÆ®~~~~~~~!! " + fri.getCnt());
	   session.setAttribute("friendId", writer);
	   ModelAndView mav = new ModelAndView("board/friList");
	   mav.addObject("list", list);
	   mav.addObject("fri", fri);
	   
	   Relationship relation = new Relationship(id, writer);
	   ArrayList<Integer> count =  service.FriendprofileCount(writer);
	   String check = service.checkRelation(relation);
	   session.setAttribute("check", check);//  ³ª¿Í »ó´ë¹æÀÇ °ü°è
	   session.setAttribute("friendfollowerCount", count.get(0));
	   session.setAttribute("friendfollowingCount",count.get(1));
	   session.setAttribute("friendsubscribeCount", count.get(2));
	   return mav;
  	}
   
   @RequestMapping(value = "/board/repost.do")
   public String repost(HttpServletRequest req ,
		   @RequestParam(value="bseq") int bseq) {
	   HttpSession session = req.getSession(false);
	   Member mem  = (Member) session.getAttribute("memInfo");
	   String id = mem.getId();
	   Board b = service.detailBoard(bseq);
	   b.setContent("@"+ b.getWriter() + "\n" + b.getContent());
	   b.setPublic_yn("y");
	   b.setImg(b.getImg());
	   b.setWriter(id);
	   service.uploadBoard(b);
	   return "redirect:/board/myList.do";
   }
}