package com.khbill.service.face;

import java.util.HashMap;
import java.util.List;

import com.khbill.dto.User;

public interface MemberService {

	/**
	 * 로그인 정보와 회원 정보 일치하는지 확인하기
	 * 
	 * @param user - 로그인 정보
	 * @return true - 일치하는 회원 정보 1개 있음, false - 일치하는 회원 정보가 없거나 1개 이상
	 */
	public boolean isLogin(User user);

	/**
	 * 로그인 정보로 세션에 저장할 회원 정보 불러오기
	 * 
	 * @param user - 로그인 정보
	 * @return - User 
	 */
	public User getUserInfo(User user);

	/**
	 * 아이디 중복확인과 닉네임 중복확인을 한 후 회원가입 정보 저장
	 * 
	 * @param user - 회원가입 정보
	 */
	public void join(User user);
	
	/**
	 * 회원 닉네임으로 회원 번호 불러오기
	 * 
	 * @param userNick - 회원 닉네임
	 * @return int userNo
	 */
	public int getUserNo(String userNick);

	/**
	 * 아이디 중복 확인
	 * 
	 * @param userId - 회원가입 시 입력한 아이디
	 * @return int
	 */
	public int checkUserId(String userId);

	/**
	 * 닉네임 중복 확인
	 * 
	 * @param userNick - 회원가입 시 입력한 닉네임
	 * @return int
	 */
	public int checkUserNick(String userNick);

	/**
	 * 유저 번호로 닉네임을 구한다
	 * 
	 * @param msgUserNo
	 * @return 유저 닉네임
	 */
	public String getUserNickByUserNo(int msgUserNo);

	/**
	 * 세션에 있는 유저번호로 유저 가져오기
	 * 
	 * @param userNo
	 * @return 유저 객체
	 */
	public User getUserByUserNo(int userNo);

	/**
	 * 회원정보를 수정한다
	 * 
	 * @param user
	 */
	public void setUserUpdate(User user);
	
	/**
	 * 회원정보를 삭제한다
	 * 
	 * @param userNo
	 */
	public void setUserDelete(int userNo);
	
	/**
	 * 닉네임에 맞는 사용자가 있는지 조회한다
	 * 
	 * @param userNick
	 * @return 존재하면 1 없으면 0
	 */
	public int checkUserExists(String userNick);

	/**
	 * 해당 이메일을 사용하는 회원이 있는지 조회한다
	 * 
	 * @param userMail - 입력한 이메일
	 * @return int
	 */
	public int checkUserMail(String userMail);

	/**
	 * 카카오 메일로 회원 정보 불러오기
	 * 
	 * @param kakaoEmail - 카카오 메일
	 * @return User
	 */
	public User getUserByUserMail(String kakaoEmail);

	/**
	 * 카카오로 회원가입 처리
	 * 
	 * @param user - 유저 정보
	 */
	public void joinKakao(User user);

	/**
	 * 임시 비밀번호로 회원 비번 변경
	 * 
	 * @param User - 임시 비밀번호와 변경하려는 회원 정보가 담겨있는 User 객체
	 */
	public void setUserTempPwUpdate(User tempUser);

	/**
	 * 유저 닉네임으로 유저 정보 조회
	 * 
	 * @param userNick
	 * @return 유저 정보
	 */
	public User getUserByUserNick(String userNick);

	/**
	 * 유저번호로 최근 작성글 5개 리스트르 불러오기
	 * 
	 * @param userNo
	 * @return
	 */
	public List<HashMap<String, Object>> getWriteListByUserNo(int userNo);



}
