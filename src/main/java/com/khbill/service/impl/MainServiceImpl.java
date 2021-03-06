package com.khbill.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.khbill.dao.face.MainDao;
import com.khbill.dto.Ask;
import com.khbill.dto.Notice;
import com.khbill.dto.User;
import com.khbill.service.face.MainService;

@Service
public class MainServiceImpl implements MainService {
	
	private static final Logger logger = LoggerFactory.getLogger(MainServiceImpl.class);
	
	@Autowired MainDao mainDao;

	@Override
	public List<HashMap<String, String>> getUserPointListTen() {
		return mainDao.selectUserInfoOrderByPoint();
	}

	@Override
	public List<Notice> getNoticeListSix() {
		return mainDao.selectNoticeListSix();
	}

	@Override
	public Map<String, Integer> getAvailableAmountAndPercent(HttpSession session) {
		
		//조회 결과
		Map<String, Integer> resultMap = new HashMap<>();
		
		//유저 번호
		int userNo = (int) session.getAttribute("userNo");
		
		//지출 가능 금액, //결제 여부가 y인 상품 가격의 총합
		int extraMoney = mainDao.selectExtraMoneyByUserNo(userNo);
		int totalPrice = mainDao.selectItemListCheckStatusByUserNo(userNo);
		
		logger.info("extraMoney - {}", extraMoney);
		logger.info("totalPrice - {}", totalPrice);
		
		//아낀 돈, //지출 퍼센트
		int saveMoney = 0;
		double percent = -1; //지출 가능 금액을 설정해주세요 출력
		
		//지출 가능 금액을 설정했을 경우, 아낀 돈 계산
		if( extraMoney != 0 ) {
			saveMoney = extraMoney - totalPrice;
		}
		
		//지출 가능 금액, 결제 여부가 y인 상품 가격의 총합이 0이 아닐 경우, 지출 퍼센트 계산
		if( extraMoney != 0 && totalPrice != 0 ) {
			percent = ((double)totalPrice / extraMoney) * 100;
			
			logger.info("(totalPrice / extraMoney) - {}", (totalPrice / extraMoney));
			logger.info("(totalPrice / extraMoney) * 100 - {}", (totalPrice / extraMoney) * 100);
			
			logger.info("percent - {}", percent);
			logger.info("extraMoney - {}", extraMoney);
			logger.info("totalPrice - {}", totalPrice);
			
			//지출 가능 금액보다 결제를 많이 했을 경우
			if( percent > 100) {
				percent = 100;
			}
		}
		
		//지출 가능 금액을 설정했지만, 결제 여부가 없을 때
		if( extraMoney != 0 && totalPrice == 0 ) {
			percent = -2;
		}
		
		logger.info("percent - {}", percent);
		
		resultMap.put("saveMoney", saveMoney);
		resultMap.put("percent", (int) percent);
		
		return resultMap;
	}

	@Override
	public String getMainment(Integer persent) {
		
		List<String> mainment = mainDao.selectMainment(persent);
		
		Random random = new Random();
		
		logger.info("Random Number - {}", random.nextInt(mainment.size()));
		logger.info("mainment - {}", mainment.get(random.nextInt(mainment.size())));
		
		return mainment.get(random.nextInt(mainment.size()));
	}

	@Override
    public List<Object> getPopularBoard() {
        return mainDao.selectAskListOrderByVotes();
    }

    @Override
    public List<Object> getBuyItemList(HttpSession session) {
        
        //유저 번호
        int userNo = (int) session.getAttribute("userNo");
        
        return mainDao.selectBuyItemList(userNo);
    }
}
