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
		Captcha captcha = new Captcha.Builder(200, 60) //�̹��� ũ�� 200 * 60
				.addText(new NumbersAnswerProducer(6)) //6�ڸ� ����
				.addNoise().addNoise().addNoise() //���ؼ�
				.addBackground(new GradiatedBackgroundProducer()) //����
				.addBorder() //�׵θ�
				.build();
		
		res.setHeader("Cache-Control", "no-cache");
		res.setDateHeader("Expires", 0);
		res.setHeader("Pragma", "no-cache");
		res.setDateHeader("Max-Age", 0);
		res.setContentType("image/png");
		
		CaptchaServletUtil.writeImage(res, captcha.getImage()); //�̹��� �׸���
		req.getSession().setAttribute("captcha", captcha.getAnswer()); //�� ����
	}

	public void captchaAudio(HttpServletRequest req, HttpServletResponse res) {
		String getAnswer = (String) req.getSession().getAttribute("captcha");
		
		AudioCaptcha ac = new AudioCaptcha.Builder()
				.addAnswer(new SetTextProducer(getAnswer)) //���ڿ� ����
				.addVoice()
				.addNoise()
				.build();
		
		res.setHeader("Cache-Control", "no-cache");
		res.setDateHeader("Expires", 0);
		res.setHeader("Pragma", "no-cache");
		res.setDateHeader("Max-Age", 0);
		
		CaptchaServletUtil.writeAudio(res, ac.getChallenge()); // ������� write�Ѵ�.
		
		req.getSession().setAttribute("captcha", ac.getAnswer()); //�� ����
	}

}
