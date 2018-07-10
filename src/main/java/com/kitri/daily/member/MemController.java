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
		System.out.println("우편번호 가져오냐~" + mem);
		if (mem == null || !mem.getPwd().equals(m.getPwd())) {
			System.out.println("로그인 실패");
			return "redirect:/member/loginForm.do";
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("memInfo", mem);

			if (!m.getId().equals("admin")) {
				ArrayList<Integer> list = service.profileCount(m.getId());

				session.setAttribute("followerCount", list.get(0));
				session.setAttribute("followingCount", list.get(1));
				session.setAttribute("subscribeCount", list.get(2));
			} else if (m.getId().equals("admin")) { // 관리자(admin)는 관리자 화면으로 넘어가도록 구현.
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
		String originPath = basePath + "\\Member\\"; // 원본파일 경로
		String upfolder = basePath + "\\thumbnail_mem\\"; // 썸네일 처리한 파일 경로
		MultipartFile file = m.getFile(); // mem_editForm.jsp에서 선택한 파일 가져오기
		HttpSession session = req.getSession(false);
		Member mem = (Member) session.getAttribute("memInfo");

		if (file != null && !file.equals("")) {
			File dir = new File(originPath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			String del = originPath + mem.getProfile_img(); // 원본파일 경로와 파일명
			String del2 = upfolder + mem.getProfile_img(); // 원본파일 경로와 파일명
			File delete = new File(del);
			File delete2 = new File(del2);
			// 파일 중복방지 처리
			String[] extension = file.getOriginalFilename().split("\\.");
			String FileType = extension[extension.length - 1];
			String img = m.getId() + "_" + System.currentTimeMillis() + "." + FileType;
			m.setProfile_img(img); // img 경로 set
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

			// 썸네일 처리
			int thumbnail_width = 150;
			int thumbnail_height = 150;
			File dir2 = new File(upfolder);
			if (!dir2.exists()) {
				dir2.mkdirs();
			}
			try {
				BufferedImage srcImg = ImageIO.read(f); // 원본파일 읽어오기
				BufferedImage thumbImg;
				thumbImg = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
				java.awt.Graphics2D g = thumbImg.createGraphics();
				g.drawImage(srcImg, 0, 0, thumbnail_width, thumbnail_height, null);
				File outFile = new File(upfolder + "\\" + img);
				ImageIO.write(thumbImg, "PNG", outFile); // 썸네일 파일 저장

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
			return "redirect:/member/joinForm.do"; // 글 작성 페이지로 이동
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
			result = "사용가능한 아이디입니다.";
			session.setAttribute("idCheck", true);
		} else {
			result = "이미 사용중인 아이디입니다.";
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
		response.setCharacterEncoding("UTF-8"); // 출력시 한글깨짐 방지
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
			email.setContent("비밀번호는 " + pw + "입니다.");
			email.setReceiver(e_mail);
			email.setSubject(id + "님의 비밀번호 찾기 메일입니다.");
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

	// 우편번호 검색
	// 인증키
	/*
	 * public static final String ZIPCODE_API_KEY =
	 * "ZRp1M9%2FW4tvJTR7kaHLhUGxrkMy1R0rB70aWUBuzc9WQTpIwygSrT%2BnplK2lQb2KqKbAb0K7ta8WPo1b54vkHw%3D%3D";
	 */
	// api를 쓰기 위한 주소
	public static final String ZIPCODE_API_URL = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll?ServiceKey=ZRp1M9%2FW4tvJTR7kaHLhUGxrkMy1R0rB70aWUBuzc9WQTpIwygSrT%2BnplK2lQb2KqKbAb0K7ta8WPo1b54vkHw%3D%3D&countPerPage=10&currentPage=1&srchwrd=";

	@RequestMapping(value = "/member/zip_search.do")
	public @ResponseBody String zip_codeList(@RequestParam(value = "query") String query) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		StringBuilder queryUrl = new StringBuilder();
		queryUrl.append(ZIPCODE_API_URL);
		queryUrl.append(query.replaceAll(" ", ""));

		// document 선언
		Document document = Jsoup.connect(queryUrl.toString()).get();
		// errorCode 선언
		String errorCode = document.select("errMsg").text();

		if (errorCode == null || errorCode.equals("")) {
			Elements elements = document.select("newAddressListAreaCdSearchAll");
			List<Member> list = new ArrayList<Member>();
			Member m = null;

			for (Element element : elements) {
				m = new Member();
				// 우편번호 검색
				m.setZip_code(element.select("zipNo").text());
				// 도로명주소 검색
				m.setAddress(element.select("lnmAdres").text());
				list.add(m);
			}
			// list 결과 put
			paramMap.put("list", list);
			System.out.println("우편번호 검색 성공???" + list);
		} else {
			String errorMessage = document.select("errMsg").text();
			// paramMap.put("errorCode", errorCode);
			paramMap.put("errorMessage", errorMessage);
		}
		// Gson형태로 paramMap 리턴
		return (new Gson()).toJson(paramMap);
	}

}