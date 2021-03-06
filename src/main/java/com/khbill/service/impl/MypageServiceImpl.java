package com.khbill.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.khbill.dao.face.MypageDao;
import com.khbill.dto.Ask;
import com.khbill.dto.Review;
import com.khbill.dto.Trade;
import com.khbill.service.face.MypageService;
import com.khbill.util.Paging;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired MypageDao mypageDao;
	
	@Override
	public Paging getMyAskPaging(Paging paramData, int userNo) {
		
		int totalCount = mypageDao.selectCntMyAskAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
	}
	
	@Override
	public List<Ask> getMyAskList(HashMap<String, Object> map) {
		return mypageDao.selectAskListByUserNo(map);
	}
	
	@Override
	public Paging getMyAskCommentPaging(Paging paramData, int userNo) {
		
		int totalCount = mypageDao.selectCntMyAskCommentAll(userNo);
	
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
	}
	
	@Override
	public List<HashMap<String, Object>> getMyAskCommentList(HashMap<String, Object> map) {
		return mypageDao.selectAskCommentListByUserNo(map);
	}

	@Override
	public Paging getMyAskScrapPaging(Paging paramData, int userNo) {
		
		int totalCount = mypageDao.selectCntMyAskScrapAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
	}
	
	@Override
	public List<HashMap<String, Object>> getMyAskScrapList(HashMap<String, Object> map) {
		return mypageDao.selectAskScrapListByUserNo(map);
	}
	
	@Override
	public void setAskScrapDelete(int askNo) {
		mypageDao.deleteAskScrapByScrapNo(askNo);
	}
	
	@Override
	public Paging getMyReviewPaging(Paging paramData, int userNo) {
		
		int totalCount = mypageDao.selectCntMyReviewAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
	}
	
	@Override
	public void setAskComDelete(int askComNo) {
		mypageDao.deleteAskComByAskComNo(askComNo);
	}
	
	@Override
	public List<Review> getMyReviewList(HashMap<String, Object> map) {
		return mypageDao.selectReviewListByUserNo(map);
	}
	
	@Override
	public Paging getMyReviewCommentPaging(Paging paramData, int userNo) {
		
		int totalCount = mypageDao.selectCntMyReviewCommentAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
	}
	
	@Override
	public List<HashMap<String, Object>> getMyReviewCommentList(HashMap<String, Object> map) {
		return mypageDao.selectReviewCommentListByUserNo(map);
	}
	
	@Override
	public void setReviewComDelete(int reviewComNo) {
		mypageDao.deleteReviewComByReviewComNo(reviewComNo);
	}
	
	@Override
	public Paging getMyReviewScrapPaging(Paging paramData, int userNo) {
		
		int totalCount = mypageDao.selectCntMyReviewScrapAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
	}
	
	@Override
	public List<HashMap<String, Object>> getMyReviewScrapList(HashMap<String, Object> map) {
		return mypageDao.selectReviewScrapListByUserNo(map);
	}
	
	@Override
	public void setReviewScrapDelete(int scrapNo) {
		mypageDao.deleteReviewScrapByScrapNo(scrapNo);
	}
	
	@Override
	public Paging getMyTradePaging(Paging paramData, int userNo) {

		int totalCount = mypageDao.selectCntMyTradeAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
		
	}
	
	@Override
	public List<Trade> getMyTradeList(HashMap<String, Object> map) {
		return mypageDao.selectTradeListByUserNo(map);
	}
	
	@Override
	public Paging getMyTradeCommentPaging(Paging paramData, int userNo) {
		
		int totalCount = mypageDao.selectCntMyTradeCommentAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;
	}
	
	@Override
	public List<HashMap<String, Object>> getMyTradeCommentList(HashMap<String, Object> map) {
		return mypageDao.selectTradeCommentListByUserNo(map);

	}
	
	@Override
	public void setTradeComDelete(int tradeComNo) {
		mypageDao.deleteTradeComByTradeComNo(tradeComNo);
		
	}
	
	@Override
	public Paging getMyTradeScrapPaging(Paging paramData, int userNo) {

		int totalCount = mypageDao.selectCntMyTradeScrapAll(userNo);
		
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		
		return paging;

	}
	
	@Override
	public List<HashMap<String, Object>> getMyTradeScrapList(HashMap<String, Object> map) {
		return mypageDao.selectTradeScrapListByUserNo(map);

	}
	
	@Override
	public void setTradeScrapDelete(int scrapNo) {
		mypageDao.deleteTradeScrapByScrapNo(scrapNo);
	}
	
	

}
