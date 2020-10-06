package kr.go.alExam.common.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import kr.go.alExam.common.service.LoginService;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : CommonUserServiceImpl.java
 * @Description : 모바일 헬스케어에서 사용하는 자용자공통모듈에 필요한 DAO와 연동 관리하는 Class
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

@Service("common.loginService")
public class LoginServiceImpl extends EgovAbstractServiceImpl implements LoginService{
	
	@Resource(name="common.loginDAO")
    private LoginDAO loginDAO;
	
	@Override
	public Map<String, Object> selectLoginInfoChk(Map<String, Object> param) throws Exception {
		return loginDAO.selectLoginInfoChk(param);
	}
	
	@Override
	public Map<String, Object> selectLoginUserInfo(Map<String,Object> param) throws Exception{
		return loginDAO.selectLoginUserInfo(param);
	}
}
