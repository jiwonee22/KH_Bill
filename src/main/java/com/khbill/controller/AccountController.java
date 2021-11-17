package com.khbill.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.khbill.dto.Item;
import com.khbill.service.face.AccountService;
import com.khbill.util.Paging;

@Controller
public class AccountController {

	private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	
	@Autowired
	AccountService accountService;
	
	@RequestMapping(value = "/account/main", method = RequestMethod.GET)
	public void accountMain(HttpSession session,Model model) {
		logger.info("/account/main [GET]");
		
		int userNo = (int)session.getAttribute("userNo");
		
		List<Item> itemList =  accountService.getItemListByLoginUserNo(userNo);
		logger.info("itemList : {}", itemList);
		
		
		model.addAttribute("itemList",itemList);
	
	}
	
	
	
	
}