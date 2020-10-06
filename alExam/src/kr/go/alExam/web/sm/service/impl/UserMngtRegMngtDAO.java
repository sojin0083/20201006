package kr.go.alExam.web.sm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.go.alExam.common.DMultiEgovAbstractMapper;


/**
 * @Class Name : UserMngtRegMngtDAO.java
 * @Description : 관리자 WEB에서 사용하는 기관/사용자 정보 관리하는  DAO class
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

@Repository("web.sm.UserMngtRegMngtDAO")
public class UserMngtRegMngtDAO extends DMultiEgovAbstractMapper{

	public List<Map<String, Object>> userMngtRegMngtList(Map<String, Object> param) throws Exception{
		List<Map<String,Object>> rsList = selectList("alExam.web.sm.usermngtregmngt.userMngtRegMngtList", param);	
		return rsList;  
	}
	
	public int userMngtRegMngtRegUpd(Map<String, Object> param) throws Exception{
		int rsInt = update("alExam.web.sm.usermngtregmngt.userMngtRegMngtRegUpd",param);
		return rsInt;
	}
	
	public Map<String, String> selectOrgRegChk(Map<String, Object> param) throws Exception {
		Map<String, String> rsMap = selectOne("alExam.web.sm.usermngtregmngt.selectOrgRegChk",param);	
		return rsMap;
	}
	
	public int userMngtRegMngtRegInsert(Map<String, Object> param) throws Exception{
		int rsInt = insert("alExam.web.sm.usermngtregmngt.userMngtRegMngtRegInsert",param);
		return rsInt;
	}
	
	public List<Map<String, Object>> orgMngtUserRegList(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsList = selectList("alExam.web.sm.usermngtregmngt.orgMngtUserRegList", param);
		return rsList;
	}
	
	public Map<String, Object> userInfoSelect(Map<String, Object> param) throws Exception {
		Map<String, Object> rsMap = selectOne("alExam.web.sm.usermngtregmngt.userInfoSelect",param);	
		return rsMap;
	}
	
	public int UserRegUpd(Map<String, Object> param) throws Exception{
		int rsInt = insert("alExam.web.sm.usermngtregmngt.UserRegUpd",param);
		insert("alExam.web.sm.usermngtregmngt.UserManagerAuthUpd",param);
		return rsInt;
	}
	
	public Map<String, Object> selectLoginRegChk(Map<String, Object> param) throws Exception {
		Map<String, Object> rsMap = selectOne("alExam.web.sm.usermngtregmngt.selectLoginRegChk",param);	
		return rsMap;
	}
	
	public Map<String,Object> selectUserRegChk(Map<String,Object> param) throws Exception{
		Map<String,Object> rsMap = selectOne("alExam.web.sm.usermngtregmngt.selectUserRegChk", param);
		return rsMap;
	}
}
