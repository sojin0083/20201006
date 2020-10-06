package kr.go.alExam.common.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.alExam.common.service.CommonService;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : CommonServiceImpl.java
 * @Description :치매진단 시스템 업무에서 사용하는 통합공통업무에서 필요한 DAO와 연동 관리하는 Class
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


@Service("common.cmmnService")
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService{
	
	@Resource(name="common.cmmnDAO")
    private CommonDAO cmmnDAO;

	@Override
	public List<Map<String, String>> selectCmmnCd(Map<String, Object> param)	throws Exception {
		System.out.println("SeverceImpl");
		return cmmnDAO.selectCmmnCd(param);
	}
	
	@Override
	public List<Map<String, String>> selectCmmnMenu(Map<String, Object> param)	throws Exception {
		
		return cmmnDAO.selectCmmnMenu(param);
	}
	
	@Override
	public Map<String, String> selectCmmnMenuInfo(Map<String, Object> param) throws Exception {
		
		return cmmnDAO.selectCmmnMenuInfo(param);
	}	
}
