package com.khbill.controller;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.khbill.dto.Ask;
import com.khbill.dto.AskComment;
import com.khbill.dto.AskReport;
import com.khbill.dto.AskScrap;
import com.khbill.dto.File;
import com.khbill.dto.Item;
import com.khbill.dto.User;
import com.khbill.dto.Vote;
import com.khbill.service.face.AskService;
import com.khbill.util.Paging;

@Controller
@RequestMapping(value = "/ask")
public class AskController {

	private static final Logger logger = LoggerFactory.getLogger(AskController.class);

	@Autowired
	AskService askService;

	@RequestMapping(value = "/list")
	public void getAskList(Paging paramData, Model model) {
		logger.info("/ask/list [GET]");

	}// list
	
	
	@RequestMapping(value = "/list/hit")
	public String askHitList( Model model, Paging paramData ) {
		logger.info("/ask/list/hit");
		logger.info("param {}", paramData);
		
		
		Paging paging = askService.getPaging(paramData);
		logger.info("paging.target : {}",paging.getTarget());
		List<Ask> list = askService.getAskList(paging);
		List<HashMap<String, Object>> comCnt = askService.getAskComCntList();
		
		model.addAttribute("comCnt", comCnt);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);

		if(paging.getTarget() != null) {
			if(paging.getTarget().equals("3")) {
				return "ask/itemlist";
			}
		}
		return "ask/ajaxlist";
		
	}// list


	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void setAskWrite(HttpServletRequest req, Model model) {
		logger.info("/ask/write [GET]");
		HttpSession session = req.getSession();

		String userNick = (String) session.getAttribute("userNick");

		model.addAttribute("userNick", userNick);

	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String setAskWriteProcess(Ask ask, Item item, MultipartFile file, String voteEnd, HttpServletRequest req) {
		logger.info("/ask/write [POST]");

		HttpSession session = req.getSession();
		int userNo = (Integer) session.getAttribute("userNo");

		ask.setUserNo(userNo);

		int askNo = askService.setAskWrite(ask, item, file, voteEnd);
		
		
		logger.info("askNo : {}", askNo);

		return "redirect:/ask/detail?askNo=" + askNo;

	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public void detail(Paging paramData, int askNo, Model model, HttpSession session) {
		logger.info("/ask/detail [GET]");

		Ask ask = askService.getAskDetail(askNo);
		
		int detailUserNo = ask.getUserNo();
		
		//??????????????????
		String grade = askService.getGradeUrlByUserNo(detailUserNo);
		
		int userNo = 0;
        if(session.getAttribute("userNo") != null ){
            userNo = (Integer) session.getAttribute("userNo");
        }

        //??????
        String loginUserGrade = askService.getGradeUrlByUserNo(userNo);
        model.addAttribute("loginUserGrade", loginUserGrade);
		
		Vote status = askService.getLoginUserVoteState(userNo, askNo);
		boolean result = askService.getVoteState(askNo, userNo);

		Vote voteSet = new Vote();
		voteSet.setUserNo(ask.getUserNo());
		voteSet.setAskNo(askNo);

		Vote vote = askService.getVote(voteSet);
		Item item = askService.getItem(ask.getProductNo());
		File file = askService.getFile(item.getFileNo());

		User user = askService.getUserInfoByUserNo(ask.getUserNo());

		model.addAttribute("grade", grade);
		model.addAttribute("user", user);
		model.addAttribute("status", status);
		model.addAttribute("result", result);

		model.addAttribute("ask", ask);
		model.addAttribute("vote", vote);
		model.addAttribute("item", item);
		model.addAttribute("file", file);
		logger.info("file : {} " ,file);

		String check = askService.voteCheck(vote);

		model.addAttribute("check", check);

		String voteStateY = "n"; // ???????????? Y
		int cntN = askService.getVoteStatusTotalCnt(askNo, voteStateY);
		model.addAttribute("cntN", cntN);

		String voteStateN = "y"; // ???????????? N
		int cntY = askService.getVoteStatusTotalCnt(askNo, voteStateN);
		model.addAttribute("cntY", cntY);

		// ??????????????? ??????
		List<HashMap<String, String>> askComment = askService.getAskComList(askNo);
		model.addAttribute("askComment", askComment);
		
		logger.info("askComment: {}", askComment);

		// ????????? ?????? ??????
		AskScrap askScrap = new AskScrap();
		askScrap.setAskNo(askNo);
		askScrap.setUserNo(userNo);

		// ????????? ?????? ??????
		boolean isScrap = askService.isScrap(askScrap);
		model.addAttribute("isScrap", isScrap);
		
		int cntCom = askService.getAskComCnt(askNo);
		
		model.addAttribute("cntCom", cntCom);
		
		

	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void setAskUpdate(int askNo, Model model) {
		logger.info("/ask/update [GET]");

		Ask ask = askService.getAskDetail(askNo);
		Vote voteSet = new Vote();
		voteSet.setUserNo(ask.getUserNo());
		voteSet.setAskNo(askNo);

		Vote vote = askService.getVote(voteSet);
		Item item = askService.getItem(ask.getProductNo());
		File file = askService.getFile(item.getFileNo());
		User user = askService.getUserInfoByUserNo(ask.getUserNo());

		model.addAttribute("user", user);
		model.addAttribute("ask", ask);
		model.addAttribute("vote", vote);
		model.addAttribute("item", item);
		model.addAttribute("file", file);

	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String setAskUpdateProcess(Ask ask, HttpServletRequest req) {
		logger.info("/ask/update [POST]");

		HttpSession session = req.getSession();
		int userNo = (Integer) session.getAttribute("userNo");

		ask.setUserNo(userNo);

		askService.setAskUpdate(ask);

		return "redirect:/ask/detail?askNo=" + ask.getAskNo();

	}

	@RequestMapping(value = "/delete")
	public String delete(int askNo) {
		logger.info("/ask/delete []");

		askService.setAskComDelete(askNo);
		askService.setAskDelete(askNo);

		return "redirect:/ask/list";
	}


	@RequestMapping(value = "/comment/write", method = RequestMethod.POST)
	public ModelAndView askCommentWrite(HttpSession session, AskComment askComment, ModelAndView mav) {
		logger.info("/ask/comment/write [POST]");

		int userNo = (Integer) session.getAttribute("userNo");
		askComment.setUserNo(userNo);
		logger.info("askComment : {} " , askComment);
		askService.setAskCommentWrite(askComment);
		
		AskComment addComment = askService.getAskCommentWriteByUserNo(userNo);
		String userNick = askService.getUserNickByUserNo(addComment.getUserNo());
		String gradeUrl = askService.getGradeUrlByUserNo(addComment.getUserNo());

		logger.info("userNo {}", userNo);
		logger.info("userNick - {}", userNick);
		logger.info("addComment {}", addComment);

		boolean success = false;

		if (addComment != null) {
			success = true;
		}

		mav.addObject("userNick", userNick);
		mav.addObject("success", success);
		mav.addObject("addComment", addComment);
		mav.addObject("gradeUrl", gradeUrl);
		mav.setViewName("jsonView");
		
		int cntCom = askService.getAskComCnt(askComment.getAskNo());
		mav.addObject("cntCom", cntCom);

		return mav;
	}

	

	// ?????? ??????
	@RequestMapping(value = "/comment/update", method = RequestMethod.POST)
	public ModelAndView askCommentUpdate(ModelAndView mav, AskComment askComment) {
		logger.info("/ask/comment/update");
		logger.info("askComment - {}", askComment);

		boolean success = false;

		AskComment resultAskComment = askService.setAskCommentUpdate(askComment);

		if (askComment.getAskComNo() == resultAskComment.getAskComNo()) {
			success = true;
		} else {
			success = false;
		}

		mav.addObject("success", success);
		mav.addObject("askComment", resultAskComment);
		
		mav.setViewName("jsonView");

		return mav;
	}
	
	
	@RequestMapping(value = "/comment/delete")
	public void delete(int askComNo, Writer writer, Model model) {
		logger.info("/ask/comment/delete");

		boolean success = askService.deleteAskCom(askComNo);

		try {
			writer.append("{\"success\":" + success + "}");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/votelike")
	public ModelAndView voteLike(int askNo, ModelAndView mav, HttpSession session) {
		logger.info("/ask/votelike");

		int userNo = (Integer) session.getAttribute("userNo");

		Ask ask = askService.getAskVoteDetail(askNo);

		Vote voteSet = new Vote();

		voteSet.setAskNo(askNo);
		voteSet.setUserNo(ask.getUserNo());

		Vote vote = askService.getVote(voteSet); // ????????? vote??????

		String voteState = "y"; // ???????????? Y

		askService.setVoteInsert(userNo, vote, voteState);
		int cntY = askService.getVoteStatusTotalCnt(askNo, voteState);

		Vote status = askService.getLoginUserVoteState(userNo, askNo);// ?????????????????? ??????????????????
		boolean result = askService.getVoteState(askNo, userNo);

		mav.addObject("result", result);
		mav.addObject("status", status);
		mav.addObject("cntY", cntY); // ????????????
		mav.setViewName("jsonView");

		return mav;
	}

	@RequestMapping(value = "/votehate")
	public ModelAndView voteHate(int askNo, ModelAndView mav, HttpSession session) {
		logger.info("/ask/votehate");

		int userNo = (Integer) session.getAttribute("userNo");

		Ask ask = askService.getAskVoteDetail(askNo);

		Vote voteSet = new Vote();

		voteSet.setAskNo(askNo);
		voteSet.setUserNo(ask.getUserNo());

		Vote vote = askService.getVote(voteSet); // ????????? vote??????

		String voteState = "n"; // ???????????? N

		askService.setVoteInsert(userNo, vote, voteState);
		int cntN = askService.getVoteStatusTotalCnt(askNo, voteState);

		Vote status = askService.getLoginUserVoteState(userNo, askNo);// ?????????????????? ??????????????????
		boolean result = askService.getVoteState(askNo, userNo);

		mav.addObject("result", result);
		mav.addObject("status", status);
		mav.addObject("cntN", cntN); // ????????????
		mav.setViewName("jsonView");

		return mav;
	}

	@RequestMapping(value = "/scrap", method = RequestMethod.GET)
	public ModelAndView scrap(int askNo, ModelAndView mav, HttpSession session) {
		logger.info("/ask/scrap [GET]");

		// ????????? ?????? ??????
		AskScrap askScrap = new AskScrap();
		askScrap.setAskNo(askNo);
		askScrap.setUserNo((Integer) session.getAttribute("userNo"));

		boolean resultScrap = askService.scrap(askScrap);

		mav.addObject("resultScrap", resultScrap);
		mav.setViewName("jsonView");

		return mav;
	}


	//?????? ajax??????
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	public ModelAndView askReport(int askNo, AskReport askReport, HttpSession session,ModelAndView mav) {
		logger.info("/ask/report [POST]");
		
		logger.info("askReport: {}", askReport);
		
		int userNo = (Integer) session.getAttribute("userNo");
		
		askReport.setAskNo(askNo);
		askReport.setReporterNo(userNo);
		
		boolean reportCheck = askService.askReportByAskNoLoginUserNo(askReport);
		
		if (reportCheck) {
			
			askService.setAskReport(askReport);
			
		}
		
		mav.addObject("reportCheck", reportCheck);
		mav.setViewName("jsonView");
		
		return mav;
	}

	
}// class
