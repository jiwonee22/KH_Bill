package com.khbill.dao.face;

import com.khbill.dto.User;

public interface MemberDao {

	/**
	 * 입력된 정보와 정확히 일치하는 행의 수 구하기
	 * 
	 * @param user - 로그인 정보
	 * @return 1 or 0
	 */
	public int countLoginInfo(User user);

	/**
	 * 로그인 정보 확인 후 해당 로그인 정보로 회원 정보 불러오기
	 * 
	 * @param user - 로그인 정보
	 * @return User
	 */
	public User selectUserByUserInfo(User user);

	/**
	 * 임시 임시 아이디랑 닉네임 나눠야함
	 * @param user
	 * @return
	 */
	public int checkInfo(User user);

	/**
	 * 회원가입 정보를 DB에 저장
	 * 
	 * @param user - 회원가입 정보
	 */
	public void insertMember(User user);
	
	/**
	 * 회원 닉네임으로 회원 번호 불러오기
	 * 
	 * @param userNick - 회원 닉네임
	 * @return int userNo
	 */
	public int selectUserNoByUserNick(String userNick);

	/**
	 * 중복되는 아이디 확인
	 * 
	 * @param user - 회원가입 정보
	 * @return 0이어야 정상
	 */
	public int countUserIdDupl(User user);

	/**
	 * 중복되는 닉네임 확인
	 * 
	 * @param user - 회원가입 정보
	 * @return 0이어야 정상
	 */
	public int countUserNickDupl(User user);

}
