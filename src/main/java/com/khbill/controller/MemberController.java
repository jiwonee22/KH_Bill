package com.khbill.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khbill.dto.User;
import com.khbill.service.face.MemberService;
import com.khbill.service.face.MessageService;


@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired MemberService memberService;
	@Autowired JavaMailSender mailSender;
	@Autowired MessageService messageService;
	
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public void login(HttpServletRequest req, HttpSession session) {
				
		if( req.getHeader("Referer") != null ) {
			String add = "";
			if(req.getHeader("Referer").contains("localhost:8888")) {
				add = req.getHeader("Referer").substring(req.getHeader("Referer").lastIndexOf("88/")+2); //localhost:8888 referer			
			} else {
				add = req.getHeader("Referer").substring(req.getHeader("Referer").lastIndexOf("kr/")+2);
			}
			logger.info("[GET] member add : {}", add);
			session.setAttribute("referer", add);
			if( session.getAttribute("referer").equals("/member/login") || session.getAttribute("referer").equals("/member/joinSuccess") 
					|| session.getAttribute("referer").equals("/member/findId") || session.getAttribute("referer").equals("/member/findPw")
					|| session.getAttribute("referer").equals("/member/join") || session.getAttribute("referer").equals("/member/kakaojoin")) {
				session.removeAttribute("referer");
				session.setAttribute("referer", "/main");
			}
		} else {
			session.setAttribute("referer", "/main");
		}
		logger.info("[GET] referer : {}", session.getAttribute("referer"));
		logger.info("[GET] personalReferer : {}", session.getAttribute("personalReferer"));
	} 
	
	@RequestMapping(value="/member/login", method=RequestMethod.POST)
	public String loginProc(User user, HttpSession session, 
			@RequestParam(value="kakaoEmail", required=false) String kakaoEmail, 
			@RequestParam(value="kakaoGender", required=false) String kakaoGender, 
			Model model, HttpServletResponse resp, HttpServletRequest req) {
//		logger.info("{}", user);
//		logger.info("kakao email, gender : {}, {}", kakaoEmail, kakaoGender);
		
		if( user.getUserId() != null && !"".equals(user.getUserId())){
			boolean login  = memberService.isLogin(user);
			if( login == true ) {
				logger.info("Login Successed");
				
				User userInfo = memberService.getUserInfo(user);
				Date now = new Date();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				
				String today = format.format(now);
				
				if(userInfo.getUnablePeriod() == null || format.format(userInfo.getUnablePeriod()).compareTo(today) < 0) {
					
//					int unreadMsg = messageService.getUnreadMsgCnt(userInfo.getUserNo());				
//					logger.info("????????? ?????? ?????? : {}", unreadMsg);
					
					session.setAttribute("login", true);
					session.setAttribute("userNick", userInfo.getUserNick());
					session.setAttribute("userNo", userInfo.getUserNo());
//					session.setAttribute("unreadMsg", unreadMsg);
					
					logger.info("[POST] referer : {}", session.getAttribute("referer"));
					if(session.getAttribute("personalReferer") == null) {
						return "redirect:"+session.getAttribute("referer");
					} else {
						return "redirect:"+session.getAttribute("personalReferer");
					}
				} else {
					logger.info("Reported Member - Login Failed until {}", userInfo.getUnablePeriod());
					session.invalidate();

					resp.setHeader("Content-Type", "text/html;charset=UTF-8");
					try {
						PrintWriter out = resp.getWriter();
						out.append("<script>");
						out.append("alert('???????????? ?????? ???????????? ????????? ???????????????. "+format.format(userInfo.getUnablePeriod())+"?????? ??????????????? ??? ????????????.'); location.href='/member/login';");
						out.append("</script>");
					} catch (IOException e) {
						e.printStackTrace();
					}
					return null;
				}
				
			} else {
				logger.info("Login Failed");
				session.invalidate();

				resp.setHeader("Content-Type", "text/html;charset=UTF-8");
				try {
					PrintWriter out = resp.getWriter();
					out.append("<script>");
					out.append("alert('???????????? ?????????????????????. ????????? ????????? ?????? ??????????????????.'); location.href='/member/login';");
					out.append("</script>");
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}

		} else {
			int check = memberService.checkUserMail(kakaoEmail);
			
			if(check == 0) {//?????? ???????????? ??????????????? ????????? ?????? ??????
				model.addAttribute("kakaoEmail", kakaoEmail);
				model.addAttribute("kakaoGender", kakaoGender);
				return "redirect:/member/kakaojoin";
			} else {
				
				User kuser = memberService.getUserByUserMail(kakaoEmail);
				logger.info("kuser.split : {}", kuser.getUserId().split("-")[0]);
				
				if(kuser.getUserId().split("-")[0].equals("kakao")) {
					logger.info("kakao??? ???????????? ???????????? ??????!");
					Date now = new Date();
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					
					String today = format.format(now);
					if(kuser.getUnablePeriod() == null || format.format(kuser.getUnablePeriod()).compareTo(today) < 0) {
						
//						int unreadMsg = messageService.getUnreadMsgCnt(kuser.getUserNo());
						
//						logger.info("????????? ?????? ?????? : {}", unreadMsg);
						
						session.setAttribute("login", true);
						session.setAttribute("userNick", kuser.getUserNick());
						session.setAttribute("userNo", kuser.getUserNo());
//						session.setAttribute("unreadMsg", unreadMsg);
						
						if(session.getAttribute("personalReferer") == null) {
							return "redirect:"+session.getAttribute("referer");
						} else {
							return "redirect:"+session.getAttribute("personalReferer");
						}
					} else {
						logger.info("Reported Member - Login Failed until {}", kuser.getUnablePeriod());
						session.invalidate();

						resp.setHeader("Content-Type", "text/html;charset=UTF-8");
						try {
							PrintWriter out = resp.getWriter();
							out.append("<script>");
							out.append("alert('???????????? ?????? ???????????? ????????? ???????????????. "+format.format(kuser.getUnablePeriod())+"?????? ??????????????? ??? ????????????.'); location.href='/member/login';");
							out.append("</script>");
						} catch (IOException e) {
							e.printStackTrace();
						}
						return null;
					}
				} else {
					logger.info("kakao??? ???????????? ???????????? ??????!");
					resp.setHeader("Content-Type", "text/html;charset=UTF-8");
					try {
						PrintWriter out = resp.getWriter();
						out.append("<script>");
						out.append("alert('???????????? ???????????? ?????? ?????? ????????? ????????????. ?????? ???????????? ??????????????????.'); location.href='/member/login';");
						out.append("</script>");
					} catch (IOException e) {
						e.printStackTrace();
					}
					return null;
				}

			}
		}
	}
	
	
	@RequestMapping(value="/member/logout")
	public String logout(HttpSession session ) {
		logger.info("/member/logout");
		session.invalidate();
		return "redirect:/main";
	}
	
	@RequestMapping(value="/member/join", method=RequestMethod.GET)
	public void join() {	}
	
	@RequestMapping(value="/member/join", method=RequestMethod.POST)
	public String joinProc(User user) {
//		logger.info("/member/join [POST]");
//		logger.info("{}", user);
		
		memberService.join(user);
		return "redirect:/member/joinSuccess";
	
	}
	
	@RequestMapping(value="/member/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public int idCheck( @RequestParam(value="userId") String userId ) {
		logger.info("userIdCheck ??????");
        logger.info("???????????? id:"+userId);
        int cnt = memberService.checkUserId(userId);
        logger.info("?????? ??????:"+cnt);
        return cnt;
	}

	@RequestMapping(value="/member/nickCheck", method=RequestMethod.POST)
	@ResponseBody
	public int nickCheck( @RequestParam(value="userNick") String userNick ) {
		logger.info("userNickCheck ??????");
		logger.info("???????????? Nick:"+userNick);
		int cnt = memberService.checkUserNick(userNick);
		logger.info("?????? ??????:"+cnt);
		return cnt;
	}

	@RequestMapping(value="/member/mailCheck", method=RequestMethod.POST)
	@ResponseBody
	public int mailCheck( @RequestParam(value="userMail") String userMail ) {
		int cnt = memberService.checkUserMail(userMail);
		logger.info("?????? ??????:"+cnt);
		return cnt;
	}
	
	@RequestMapping(value="/member/kakaojoin", method=RequestMethod.GET)
	public void kakaojoin(String kakaoEmail, String kakaoGender, Model model) {
		model.addAttribute("kakaoEmail", kakaoEmail);
		model.addAttribute("kakaoGender", kakaoGender);
	}
	
	@RequestMapping(value="/member/kakaojoin", method=RequestMethod.POST)
	public String kakaojoinProc(User user) {
//		logger.info("user info : {}", user);
		memberService.joinKakao(user);
		return "redirect:/member/joinSuccess";
	}
	
	@RequestMapping(value="/member/joinSuccess")
	public void joinSuccess() {	}
	
	@RequestMapping(value="/member/sendMail", method=RequestMethod.POST)
	public @ResponseBody String sendMail(String userMail, Model model) {
		
		String authkey = UUID.randomUUID().toString().split("-")[2] + UUID.randomUUID().toString().split("-")[4].substring(0, 2);
		model.addAttribute("authkey", authkey);
		
		String subject = "KH ????????? ????????? ?????? ???????????????.";
		String content = "<h3>??????????????? ???????????? ????????? ?????? ??????????????? ????????? ???????????? ???????????? ??????????????? ??????????????????!</h3><br><br>";
		content += "<h2 style='color: red;'><strong>"+ authkey +"</strong></h2>";
		String from = "KH????????? <kh.bill1206@gmail.com>";
		String to = userMail;
		
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true);
			
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return authkey;
	}
	
	@RequestMapping(value="/member/findId", method=RequestMethod.GET)
	public void findId() {	};
	
	@RequestMapping(value="/member/findId", method=RequestMethod.POST)
	public @ResponseBody String findIdProc(String mailAdr) {
		User user = memberService.getUserByUserMail(mailAdr);
		if(user == null) {
			return "noUserId";
		} else if(user.getUserId().split("-")[0].equals("kakao")) {
			return "kakaoMember";
		} else {
			return user.getUserId();
		}
	}

	@RequestMapping(value="/member/findPw", method=RequestMethod.GET)
	public void findPw() {	};
	
	@RequestMapping(value="/member/findPw", method=RequestMethod.POST)
	public @ResponseBody String findPwProc(String mailAdr) {
		User user = memberService.getUserByUserMail(mailAdr);
		if(user == null) {
			return "noUserInfo";
		} else if(user.getUserId().split("-")[0].equals("kakao")) {
			return "kakaoMember";
		} else {
			String tempPw = UUID.randomUUID().toString().split("-")[2] + UUID.randomUUID().toString().split("-")[4].substring(3, 7);
			User tempUser = new User();
			tempUser.setUserNo(user.getUserNo());
			tempUser.setUserPw(tempPw);
			memberService.setUserTempPwUpdate(tempUser);
			
			String subject = "KH ????????? ?????? ?????????????????????.";
			String content = "<h3>?????? ?????? ??????????????? ????????? ??? ???????????? ????????? ?????? ????????? ????????????????????? ??????????????? ??????????????????!</h3><br><br>";
			content += "<h2 style='color: red;'><strong>"+ tempPw +"</strong></h2>";
			String from = "KH????????? <kh.bill1206@gmail.com>";
			String to = mailAdr;
			
			try {
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
				
				mailHelper.setFrom(from);
				mailHelper.setTo(to);
				mailHelper.setSubject(subject);
				mailHelper.setText(content, true);
				
				mailSender.send(mail);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			return "success";
		}
	}
	
	@RequestMapping(value="/member/detail")
	public void memberInfo(@RequestParam(value="userNick") String userNick, Model model) {
		
		User user = memberService.getUserByUserNick(userNick);
		
		List<HashMap<String, Object>> writeList = memberService.getWriteListByUserNo(user.getUserNo());
		
		logger.info("user?????? : {}", user);
		logger.info("writeList ?????? : {}", writeList);
		model.addAttribute("user", user);
		model.addAttribute("list", writeList);
		
	}
	
}
