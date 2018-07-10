package com.kitri.daily.member;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;

@Controller
public class MemController {
	String basePath = System.getProperty("catalina.home") + "\\webapps\\dailygram";

	@Resource(name = "memService")
	private MemService service;

	public void setService(MemService service) {
		this.service = service;
	}

	@RequestMapping(value = "/member/mem_editForm.do")
	public void mem_editForm() {
	}

	@RequestMapping(value = "/member/loginForm.do")
	public String loginForm() {
		return "member/login";
	}

	@RequestMapping(value = "/member/login.do")
	public String login(HttpServletRequest req, Member m) {
		Member mem = service.getMember(m.getId());
		System.out.println("�����ȣ ��������~" + mem);
		if (mem == null || !mem.getPwd().equals(m.getPwd())) {
			System.out.println("�α��� ����");
			return "redirect:/member/loginForm.do";
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("memInfo", mem);

			if (!m.getId().equals("admin")) {
				ArrayList<Integer> list = service.profileCount(m.getId());

				session.setAttribute("followerCount", list.get(0));
				session.setAttribute("followingCount", list.get(1));
				session.setAttribute("subscribeCount", list.get(2));
			} else if (m.getId().equals("admin")) { // ������(admin)�� ������ ȭ������ �Ѿ���� ����.
				return "redirect:/admin/chartlist.do";
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

	@RequestMapping(value = "/member/out.do")
	public String out(HttpServletRequest req, @RequestParam(value = "id") String id) {
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
		session.setAttribute("memInfo", m);
		return "redirect:/board/myList.do";
	}

	@RequestMapping(value = "/member/joinForm.do")
	public String joinForm() {
		return "member/join";
	}

	@RequestMapping(value = "/member/join.do")
	public String join(HttpSession session, Member m) {
		String captchaValue = (String) session.getAttribute("captcha");
		if (m.getCaptcha() == null || !captchaValue.equals(m.getCaptcha())) {
			return "redirect:/member/joinForm.do"; // �� �ۼ� �������� �̵�
		}
		service.insertMem(m);
		return "redirect:/member/loginForm.do";
	}

	@RequestMapping(value = "/member/idCheck.do")
	public ModelAndView idCheck(HttpServletRequest req, @RequestParam(value = "id") String id) {
		System.out.println(id);
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("member/idCheck");
		String result = "";
		Member m = service.getMember(id);
		if (m == null) {
			result = "��밡���� ���̵��Դϴ�.";
			session.setAttribute("idCheck", true);
		} else {
			result = "�̹� ������� ���̵��Դϴ�.";
			session.setAttribute("idCheck", false);
		}
		System.out.println(session.getAttribute("idCheck"));
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping(value = "/member/searchID.do")
	public String sId() {
		return "member/searchID";
	}
	
	@RequestMapping(value = "/member/idResult.do")
	public ModelAndView idResult(Member m, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("/member/showId");
		String mail = m.getEmail();
		if(mail!=null) {
			String id = service.getId(mail);
			System.out.println(id);
			mav.addObject("result",id);
		}
		return mav;
	}
	
/*	@RequestMapping(value = "/member/searchID.do")
	public String sId() {
		return "member/searchID";
	}*/

/*	@RequestMapping(value = "/member/idResult.do")
	public ModelAndView idResult(String Email, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8"); // ��½� �ѱ۱��� ����
		ModelAndView mav = new ModelAndView();
		String id = service.getId(Email);
		mav.addObject("id", id);
		System.out.println(id);
		return mav;
	}*/

	@RequestMapping(value = "/member/searchPW.do")
	public void sPW(@RequestParam Map<String, Object> paramMap, ModelMap model) throws Exception {
		model.addAttribute("msg", 0);
	}

	@Autowired
	private EmailSender emailSender;
	@Autowired
	private Email email;

	@RequestMapping(value = "/member/sendPW.do")
	public ModelAndView sendPW(@RequestParam Map<String, Object> paramMap, ModelMap model) throws Exception {
		ModelAndView mav;
		String id = (String) paramMap.get("id");
		String e_mail = (String) paramMap.get("email");
		String pw = service.getPw(paramMap);
		System.out.println(pw);
		if (pw != null) {
			email.setContent("��й�ȣ�� " + pw + "�Դϴ�.");
			email.setReceiver(e_mail);
			email.setSubject(id + "���� ��й�ȣ ã�� �����Դϴ�.");
			emailSender.SendEmail(email);
			mav = new ModelAndView("redirect:/member/loginForm.do");
			return mav;
		} else {
			mav = new ModelAndView("redirect:/member/searchPW.do");
			return mav;
		}
	}

	@RequestMapping(value = "/member/captchaImg.do")
	public void captchaImg(HttpServletRequest req, HttpServletResponse res) throws Exception {
		new CaptchaUtil().captchaImg(req, res);
	}

	@RequestMapping(value = "/member/captchaAudio.do")
	public void captchaAudio(HttpServletRequest req, HttpServletResponse res) throws Exception {
		new CaptchaUtil().captchaAudio(req, res);
	}

	// �����ȣ �˻�
	// ����Ű
	/*
	 * public static final String ZIPCODE_API_KEY =
	 * "ZRp1M9%2FW4tvJTR7kaHLhUGxrkMy1R0rB70aWUBuzc9WQTpIwygSrT%2BnplK2lQb2KqKbAb0K7ta8WPo1b54vkHw%3D%3D";
	 */
	// api�� ���� ���� �ּ�
	public static final String ZIPCODE_API_URL = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll?ServiceKey=ZRp1M9%2FW4tvJTR7kaHLhUGxrkMy1R0rB70aWUBuzc9WQTpIwygSrT%2BnplK2lQb2KqKbAb0K7ta8WPo1b54vkHw%3D%3D&countPerPage=10&currentPage=1&srchwrd=";

	@RequestMapping(value = "/member/zip_search.do")
	public @ResponseBody String zip_codeList(@RequestParam(value = "query") String query) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		StringBuilder queryUrl = new StringBuilder();
		queryUrl.append(ZIPCODE_API_URL);
		queryUrl.append(query.replaceAll(" ", ""));

		// document ����
		Document document = Jsoup.connect(queryUrl.toString()).get();
		// errorCode ����
		String errorCode = document.select("errMsg").text();

		if (errorCode == null || errorCode.equals("")) {
			Elements elements = document.select("newAddressListAreaCdSearchAll");
			List<Member> list = new ArrayList<Member>();
			Member m = null;

			for (Element element : elements) {
				m = new Member();
				// �����ȣ �˻�
				m.setZip_code(element.select("zipNo").text());
				// ���θ��ּ� �˻�
				m.setAddress(element.select("lnmAdres").text());
				list.add(m);
			}
			// list ��� put
			paramMap.put("list", list);
			System.out.println("�����ȣ �˻� ����???" + list);
		} else {
			String errorMessage = document.select("errMsg").text();
			// paramMap.put("errorCode", errorCode);
			paramMap.put("errorMessage", errorMessage);
		}
		// Gson���·� paramMap ����
		return (new Gson()).toJson(paramMap);
	}

}