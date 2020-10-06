package kr.go.alExam.common.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : CommonService.java
 * @Description : 치매진단 시스템 업무에서 사용하는 통합공통업무를 관리하는 서비스 Class
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
 */

public interface CommonService {

	/**
	 * 공통코드 조회
	 * @param codeId
	 * @return rtnUrl
	 * @throws Exception 
	 */
	public List<Map<String, String>> selectCmmnCd(Map<String, Object> param) throws Exception;
	
	/**
	 * 메뉴 조회
	 * @param codeId
	 * @return rtnUrl
	 * @throws Exception 
	 */
	public List<Map<String, String>> selectCmmnMenu(Map<String, Object> param) throws Exception;
	
	/**
	 * 메뉴 조회
	 * @param codeId
	 * @return rtnUrl
	 * @throws Exception 
	 */
	public Map<String, String> selectCmmnMenuInfo(Map<String, Object> param) throws Exception;
	
}
