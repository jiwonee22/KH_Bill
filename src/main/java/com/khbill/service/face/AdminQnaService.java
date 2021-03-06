package com.khbill.service.face;

import java.util.List;

import com.khbill.dto.Qna;
import com.khbill.dto.QnaComment;
import com.khbill.util.Paging;

public interface AdminQnaService {

	/**
	 * 페이징 처리
	 * 
	 * @param paramData
	 * @return
	 */
	public Paging getPaging(Paging paramData);

	/**
	 * 문의 게시글 목록 조회
	 * 
	 * @param paging - 페이징
	 * @return
	 */
	public List<Qna> getQnaList(Paging paging);

	/**
	 * 문의 게시글 상세 조회
	 * 
	 * @param qnaNo - 문의글 번호
	 * @return Qna
	 */
	public Qna getQnaDetail(int qnaNo);

	/**
	 * 문의 게시글 답변 조회
	 * 
	 * @param qnaNo - 문의글 번호
	 * @return QnaComment
	 */
	public QnaComment getQnaComment(int qnaNo);

	/**
	 * 유저 번호로 닉네임 가져오기
	 * 
	 * @param userNo - 유저 번호
	 * @return String
	 */
	public String getNickByUserNo(int userNo);

	/**
	 * 문의 삭제
	 * 
	 * @param i - 문의글 번호
	 */
	public void setQnaDelete(int i);

	/**
	 * 답변 작성
	 * 
	 * @param qnaComment - 답변 정보
	 */
	public void setQnaCommentWrite(QnaComment qnaComment);

	/**
	 * 답변 수정
	 * 
	 * @param qnaComment - 수정할 답변 정보
	 */
	public void setQnaCommentUpdate(QnaComment qnaComment);

	/**
	 * 답변 삭제
	 * 
	 * @param qnaNo - 문의글 번호
	 */
	public void setQnaCommentDelete(int qnaNo);


}
