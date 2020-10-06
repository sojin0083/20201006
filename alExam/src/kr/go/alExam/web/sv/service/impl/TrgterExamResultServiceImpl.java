package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.alExam.web.sv.service.TrgterExamResultService;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;


/**
 * @Class Name : TrgterExamResultServiceImpl.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과를 관리하는  DAO와 연동 관리하는 class
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		------		---------------------------
 * @	2020.05.11		양현우 		최초생성
 * @author theJoin
 * @since 2020.05.11
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Service("web.sv.TrgterExamResultService")
public class TrgterExamResultServiceImpl extends EgovAbstractServiceImpl implements TrgterExamResultService{

	@Resource(name ="web.sv.TrgterExamResultDAO")
	private TrgterExamResultDAO trgterExamResultDAO;
	
	
	@Override
	public List<Map<String, Object>> trgterResultList(Map<String, Object> param) throws Exception {
		return trgterExamResultDAO.trgterResultList(param);
	}


	
}
