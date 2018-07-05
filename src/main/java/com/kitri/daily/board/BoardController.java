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
   String basePath = "D:\\apache-tomcat-8.5.30\\webapps";

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
		String originPath = basePath + "\\board\\";		//�������� ���
		String upfolder = basePath + "\\thumbnail\\";	//����� ó���� ���� ���
		MultipartFile file = b.getFile();				//form.jsp���� ������ ���� ��������
		if (file != null && !file.equals("")) {
			File dir = new File(originPath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			//���� �ߺ����� ó��
			String[] extension = file.getOriginalFilename().split("\\.");	
			String FileType = extension[extension.length-1];
			String img = b.getWriter() + "_" + System.currentTimeMillis() + "." + FileType;
			b.setImg(img);		//img ��� set
			File f = new File(originPath + "\\" + img);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			//����� ó��
			int thumbnail_width = 375;
			int thumbnail_height = 350;
			File dir2 = new File(upfolder);
			if (!dir2.exists()) {
				dir2.mkdirs();
			}
			try {
				BufferedImage srcImg = ImageIO.read(f);		//�������� �о����
				BufferedImage thumbImg;
				thumbImg = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
				java.awt.Graphics2D g = thumbImg.createGraphics();
				g.drawImage(srcImg, 0, 0, thumbnail_width, thumbnail_height, null);
				File outFile = new File(upfolder + "\\" + img);
				ImageIO.write(thumbImg, "PNG", outFile);	//����� ���� ����

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
   public ModelAndView editBoard(@RequestParam(value="bseq") int bseq,
		   						HttpServletRequest req) {
      ModelAndView mav = new ModelAndView("board/editForm");
      Board update = service.detailBoard(bseq);
      mav.addObject("update", update);
      return mav;
   }

   @RequestMapping(value = "/board/edit.do")
   public String edit(Board b) {
      String originPath = basePath + "\\board\\"; // �������� ���
      String upfolder = basePath + "\\thumbnail\\"; // ����� ó���� ���� ���
      MultipartFile file = b.getFile(); // form.jsp���� ������ ���� ��������
      if (file != null && !file.equals("")) {
         Board d = service.detailBoard(b.getBoard_seq());
         String del = originPath + d.getImg(); // �������� ��ο� ���ϸ�
         String del2 = upfolder + d.getImg(); // �������� ��ο� ���ϸ�
         File delete = new File(del);
         File delete2 = new File(del2);
         // ���� �ߺ����� ó��
         String[] extension = file.getOriginalFilename().split("\\.");
         String FileType = extension[extension.length - 1];
         String img = b.getWriter() + "_" + System.currentTimeMillis() + "." + FileType;
         b.setImg(img); // img ��� set
         File f = new File(originPath + "\\" + img);

         try {
            file.transferTo(f); // ���ο� ������ ����
            delete.delete();
            delete2.delete();
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
      System.out.println(b);
      return "redirect:/board/post.do?bseq="+b.getBoard_seq();
   }

   @RequestMapping(value = "/board/post.do")
   public ModelAndView detail(HttpServletRequest req ,@RequestParam(value="bseq") int bseq) {
      ModelAndView mav = new ModelAndView("board/post");
      HttpSession session = req.getSession(false);
	  Member mem  = (Member) session.getAttribute("memInfo");
	  String id = mem.getId();
	  Like like = new Like(bseq,id);
	  Like l = service.getType(like);
      mav.addObject("l", l);
	  Board b = service.detailBoard(bseq);
      List<Comment> coList = service.getComments(bseq);//�ش���� �ڸ�Ʈ ����Ʈ�� ��������.
      System.out.println("��� ����:"+coList.size());
      mav.addObject("b", b);
      mav.addObject("coList",coList);
      String upfolder = basePath + "\\thumbnail\\"; // img ������ ���� ���
      System.out.println("�̹���~~~~~~!! "+b.getImg());
      String path = upfolder + b.getImg();
      System.out.println(path);
      mav.addObject("path", path);
      
      return mav;
   }
   
   @RequestMapping(value = "/board/myList.do")
   public ModelAndView list(HttpServletRequest req) {
	   HttpSession session = req.getSession(false);
	   Member mem  = (Member) session.getAttribute("memInfo");
	   String id = mem.getId();
	   List<Board> boardlist = (ArrayList<Board>) service.getMyList(id);
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
	   System.out.println("�۰� : " + writer + " id : " + id);
	   Board board = new Board(writer, id);
	   List<Board> list = (ArrayList<Board>) service.getList(board);
	   Member fri = service.friend(writer);
	   session.setAttribute("friendId", writer);
	   ModelAndView mav = new ModelAndView("board/friList");
	   mav.addObject("list", list);
	   mav.addObject("fri", fri);
	 
	   ArrayList<Integer> count =  service.FriendprofileCount(writer);
		for(int i=0;i<count.size();i++)
			System.out.print(count.get(i) + ", ");
		
		session.setAttribute("friendfollowerCount", count.get(0));
		session.setAttribute("friendfollowingCount",count.get(1));
		session.setAttribute("friendsubscribeCount", count.get(2));
	   return mav;
  	}
}