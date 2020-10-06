package kr.go.alExam.common.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;
import kr.go.alExam.common.util.StringUtil;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : CommonDAO.java
 * @Description : 치매진단 시스템 업무에서 사용하는 통합공통업무 DataBase 연동 관리하는 Class
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

@Repository("common.cmmnDAO")
public class CommonDAO extends DMultiEgovAbstractMapper{

	public List<Map<String, String>> selectCmmnCd(Map<String, Object> param) throws Exception {
		
		List<Map<String,String>> rsList = null;
		String sCmmnCd = StringUtil.nvl(String.valueOf(param.get("CMMN_CD")));
		
		System.out.println("DAO :::: sCmmnCd :::: " + sCmmnCd);
		System.out.println("DAO :::: sCmmnCd :::: " + param.get("CMMN_DTLS_CD").toString());		
		
		if(!"".equals(sCmmnCd)){
			if("TC_CM_AUTH".equals(sCmmnCd)){
				rsList = selectList("common.cmmn.selectAuthCd", param);
			}else if("TC_CM_ORG".equals(sCmmnCd)){
				rsList = selectList("common.cmmn.selectOrgCd", param);
			}else if("TC_SV_SVC_SCH_CD".equals(sCmmnCd)){
				rsList = selectList("common.cmmn.selectSvcSchCd", param);
			}else if("TC_CM_CMMN_CD_LCLAS".equals(sCmmnCd)){
				rsList = selectList("common.cmmn.selectLclasCd", param);			
			}else if("TC_SV_TRANS_SCORE".equals(sCmmnCd)){
				rsList = selectList("common.cmmn.selectTcSvScore", param);			
		    }else{
				rsList = selectList("common.cmmn.selectCmmnCd", param);
			}
		}
		
		System.out.println("rsList :::: " + rsList);
		
		return rsList;  
	}
	
	public List<Map<String, String>> selectCmmnMenu(Map<String, Object> param)	throws Exception {
		System.out.println(param);
		List<Map<String,String>> rsList = null;
		rsList = selectList("common.cmmn.selectCmmnMenu", param);
		return rsList;
	}
	
	public Map<String, String> selectCmmnMenuInfo(Map<String, Object> param) throws Exception {
		
		Map<String,String> rsMap = selectOne("common.cmmn.selectCmmnMenuInfo", param);
		return rsMap;  
	}
	
	
	
}
