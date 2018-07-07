package com.kitri.daily.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;
import nl.captcha.audio.AudioCaptcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.NumbersAnswerProducer;

public class CaptchaUtil {

	public void captchaImg(HttpServletRequest req, HttpServletResponse res) {
		Captcha captcha = new Captcha.Builder(200, 60) //이미지 크기 200 * 60
				.addText(new NumbersAnswerProducer(6)) //6자리 숫자
				.addNoise().addNoise().addNoise() //방해선
				.addBackground(new GradiatedBackgroundProducer()) //배경색
				.addBorder() //테두리
				.build();
		
		res.setHeader("Cache-Control", "no-cache");
		res.setDateHeader("Expires", 0);
		res.setHeader("Pragma", "no-cache");
		res.setDateHeader("Max-Age", 0);
		res.setContentType("image/png");
		
		CaptchaServletUtil.writeImage(res, captcha.getImage()); //이미지 그리기
		req.getSession().setAttribute("captcha", captcha.getAnswer()); //값 저장
	}

	public void captchaAudio(HttpServletRequest req, HttpServletResponse res) {
		String getAnswer = (String) req.getSession().getAttribute("captcha");
		
		AudioCaptcha ac = new AudioCaptcha.Builder()
				.addAnswer(new SetTextProducer(getAnswer)) //문자열 전달
				.addVoice()
				.addNoise()
				.build();
		
		res.setHeader("Cache-Control", "no-cache");
		res.setDateHeader("Expires", 0);
		res.setHeader("Pragma", "no-cache");
		res.setDateHeader("Max-Age", 0);
		
		CaptchaServletUtil.writeAudio(res, ac.getChallenge()); // 오디오를 write한다.
		
		req.getSession().setAttribute("captcha", ac.getAnswer()); //값 저장
	}

}
