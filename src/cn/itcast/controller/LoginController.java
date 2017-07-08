package cn.itcast.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	@RequestMapping("/login")
	public String login(HttpSession session, String username, String password)
			throws Exception {
		session.setAttribute("username", username);
		return "redirect:/Items/queryItems.do";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session)
			throws Exception {
		session.invalidate();
		return "redirect:/Items/queryItems.do";
	}
}
