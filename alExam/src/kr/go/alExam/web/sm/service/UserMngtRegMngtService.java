package kr.go.alExam.web.sm.service;

import java.util.List;
import java.util.Map;


/**
 * @Class Name : UserMngtRegMngtService.java
 * @Description : 관리자 WEB에서 사용하는 기관/사용자  관리하는 서비스 interface
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		------		---------------------------
 * @	2020.05.07		양현우 		최초생성
 * @author theJoin
 * @since 2020.05.07
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */


public interface UserMngtRegMngtService {

	public List<Map<String, Object>> userMngtRegMngtList(Map<String, Object> param) throws Exception;
	
	public int userMngtRegMngtRegUpd(Map<String, Object> param) throws Exception;
	
	public Map<String, String> selectOrgRegChk(Map<String, Object> param) throws Exception;
	
	public int userMngtRegMngtRegInsert(Map<String, Object> param) throws Exception;
	
	public List<Map<String, Object>> orgMngtUserRegList(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> userInfoSelect(Map<String, Object> param) throws Exception;
	
	public int UserRegUpd(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> selectLoginRegChk(Map<String,Object> param) throws Exception;
	
	public Map<String, Object> selectUserRegChk(Map<String,Object> param) throws Exception;
	
}
