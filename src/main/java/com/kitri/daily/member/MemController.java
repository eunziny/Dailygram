package com.kitri.daily.member;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;


import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class MemController {
	String basePath = System.getProperty("catalina.home") + "\\webapps\\dailygram";
	
	@Resource(name="memService")
	private MemService service;

	public void setService(MemService service) {
		this.service = service;
	}
	
	@RequestMapping(value = "/member/loginForm.do")
	public String loginForm() {
		return "member/login";
	}
	
	@RequestMapping(value = "/member/login.do")
	public String login(HttpServletRequest req, Member m) {
		Member mem = service.getMember(m.getId());
	
		if (mem == null || !mem.getPwd().equals(m.getPwd())) {
			System.out.println("�α��� ����");
			return "redirect:/member/loginForm.do";
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("memInfo",mem);
			
			if(!m.getId().equals("admin")) {//������(admin)�� ������ ȭ������ �Ѿ����  �߷� ���� �ؾ���.
				ArrayList<Integer> list =  service.profileCount(m.getId());			
				
				session.setAttribute("followerCount", list.get(0));
				session.setAttribute("followingCount",list.get(1));
				session.setAttribute("subscribeCount", list.get(2));
			}
			return "redirect:/board/myList.do";
		}
	}
	
	@RequestMapping(value = "/member/logout.do")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		session.removeAttribute("memInfo");
		session.invalidate();
		return "redirect:/member/loginForm.do";
	}
	
	@RequestMapping(value="/member/out.do")
	public String out(HttpServletRequest req, 
		  			@RequestParam(value="id") String id) {
		HttpSession session = req.getSession(false);
		service.delete(id);
		session.removeAttribute("memInfo");
		session.invalidate();
		return "redirect:/member/loginForm.do";
	}
	
	
	@RequestMapping(value = "/member/memEdit.do")
	public String memEdit(HttpServletRequest req, Member m) {
		String originPath = basePath + "\\Member\\"; // �������� ���
		String upfolder = basePath + "\\thumbnail_mem\\"; // ����� ó���� ���� ���
		MultipartFile file = m.getFile(); // mem_editForm.jsp���� ������ ���� ��������
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");
		if (file != null && !file.equals("")) {
			File dir = new File(originPath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			String del = originPath + mem.getProfile_img(); // �������� ��ο� ���ϸ�
			String del2 = upfolder + mem.getProfile_img(); // �������� ��ο� ���ϸ�
			File delete = new File(del);
			File delete2 = new File(del2);
			// ���� �ߺ����� ó��
			String[] extension = file.getOriginalFilename().split("\\.");
			String FileType = extension[extension.length - 1];
			String img = m.getId() + "_" + System.currentTimeMillis() + "." + FileType;
			m.setProfile_img(img); // img ��� set
			File f = new File(originPath + "\\" + img);
			try {
				file.transferTo(f);
				delete.delete();
				delete2.delete();
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			// ����� ó��
			int thumbnail_width = 150;
			int thumbnail_height = 150;
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
		service.editMem(m);
		session.setAttribute("memInfo",m);
		return "redirect:/board/myList.do";
	}
	
	@RequestMapping(value = "/admin/chargelist.do")
	void test6() {
		
	}
	
	@RequestMapping(value = "/admin/chargeMemList.do")
	void test7() {
		
	}
	
	
	@RequestMapping(value = "/member/join.do")
	void test11() {
		
	}
	
	@RequestMapping(value = "/member/mem_editForm.do")
	void test12() {
		
	}

}
