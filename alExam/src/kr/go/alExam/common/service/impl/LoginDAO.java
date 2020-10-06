package kr.go.alExam.common.service.impl;

import java.util.HashMap;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : CommonUserDAO.java
 * @Description : 치매진단 시스템 업무에서 사용하는 사용자공통모듈  DataBase 연동 관리하는 Class
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

@Repository("common.loginDAO")
public class LoginDAO extends DMultiEgovAbstractMapper{
	
	public Map<String, Object> selectLoginInfoChk(Map<String, Object> param) throws Exception {
		Map<String, Object> rtMap  = new HashMap<String,Object>();
		Map<String,String>	chkMap  = null;
		Map<String,String>	rsMap  = null;
		String				msgCode	   = "";
		boolean			bLogin		= false;		
		
		chkMap = selectOne("common.user.selectLoginfirstChk", param);
		rsMap = selectOne("common.user.selectLoginInfoChk", param);
		
		if(chkMap == null){//아이디없음
			bLogin = false;			
			msgCode = "common.login.chkId";
			rtMap.put("isLogin", String.valueOf(bLogin));
		}else{//아이디있음
			if(chkMap.get("USE_YN").equals("Y") && chkMap.get("ORG_USE_YN").equals("Y") ){//사용ID
				if(rsMap == null){//pw틀림
					bLogin = false;			
					msgCode = "common.login.chkPw";
					rtMap.put("isLogin", String.valueOf(bLogin));
				}else{//pw맞음
					rtMap.put("isLogin", String.valueOf(bLogin));			
				}
			}else{//미사용ID
				bLogin = false;			
				msgCode = "common.login.fail";
				rtMap.put("isLogin", String.valueOf(bLogin));
			}
		}
		
		rtMap.put("rtnMsgCode", msgCode);
		return rtMap;  
	}

	
	public Map<String,Object> selectLoginUserInfo(Map<String, Object> param) {

		Map<String, Object> rtMap		= new HashMap<String,Object>();
		

		String				msgCode		= "";
		boolean			bLogin		= true;
		String				loginGb		= (String)param.get("loginGb");
		
		Map<String,Object> rsMap = selectOne("common.user.selectUserInfo", param);
		
		if(rsMap==null){
			msgCode = "common.login.chkPw";
			bLogin	= false;
		}
		
		rtMap.put("rsMap", rsMap);
		rtMap.put("rtnMsgCode", msgCode);
		rtMap.put("isLogin", String.valueOf(bLogin));	
		
		return rtMap;  
	}
}
