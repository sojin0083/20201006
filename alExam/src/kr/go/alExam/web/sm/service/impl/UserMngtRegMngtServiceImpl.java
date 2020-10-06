package kr.go.alExam.web.sm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.alExam.web.sm.service.UserMngtRegMngtService;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : UserMngtRegMngtServiceImpl.java
 * @Description : 관리자 WEB에서 사용하는 기관/사용자 관리하는  DAO와 연동 관리하는 class
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

@Service("web.sm.UserMngtRegMngtService")
public class UserMngtRegMngtServiceImpl extends EgovAbstractServiceImpl implements UserMngtRegMngtService {

	@Resource(name="web.sm.UserMngtRegMngtDAO")
	private UserMngtRegMngtDAO userMngtRegMngtDAO;
	
	@Override
	public List<Map<String, Object>> userMngtRegMngtList(Map<String, Object> param) throws Exception {
		return userMngtRegMngtDAO.userMngtRegMngtList(param);
	}

	@Override
	public int userMngtRegMngtRegUpd(Map<String, Object> param)	throws Exception {
		return userMngtRegMngtDAO.userMngtRegMngtRegUpd(param);	
	}

	@Override
	public Map<String, String> selectOrgRegChk(Map<String, Object> param)	throws Exception {
		return userMngtRegMngtDAO.selectOrgRegChk(param);
	}

	@Override
	public int userMngtRegMngtRegInsert(Map<String, Object> param)	throws Exception {
		return userMngtRegMngtDAO.userMngtRegMngtRegInsert(param);
	}

	@Override
	public List<Map<String, Object>> orgMngtUserRegList(Map<String, Object> param) throws Exception {
		return userMngtRegMngtDAO.orgMngtUserRegList(param);
	}

	@Override
	public Map<String, Object> userInfoSelect(Map<String, Object> param)throws Exception {
		return userMngtRegMngtDAO.userInfoSelect(param);
	}

	@Override
	public int UserRegUpd(Map<String, Object> param) throws Exception {
		return userMngtRegMngtDAO.UserRegUpd(param);
	}

	@Override
	public Map<String, Object> selectLoginRegChk(Map<String, Object> param)throws Exception {
		return userMngtRegMngtDAO.selectLoginRegChk(param);
	}

	@Override
	public Map<String,Object> selectUserRegChk(Map<String, Object> param)throws Exception {
		return userMngtRegMngtDAO.selectUserRegChk(param);
	}
}
