package kr.go.alExam.common.service;

import java.util.Map;

/**
 * @Class Name : CommonUserService.java
 * @Description : 치매진단 시스템 업무에서 사용하는 로그인 모듈 service Class
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.07		오샘이		최초생성
 *
 * @author TheJoin
 * @since 2020.05.07
 * @version 1.0
 * @see
 *
 *  Copyright (C) by TheJoin All right reserved.
 *  
 */

public interface LoginService {
	
	/**
	 * 사용자 로그인 정보 체크
	 * @param codeId
	 * @return rtnUrl
	 * @throws Exception 
	 */
	public Map<String, Object> selectLoginInfoChk(Map<String, Object> param) throws Exception;
	
	/**
	 * 사용자 정보 확인
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectLoginUserInfo(Map<String,Object> param) throws Exception;	
	
	
}
