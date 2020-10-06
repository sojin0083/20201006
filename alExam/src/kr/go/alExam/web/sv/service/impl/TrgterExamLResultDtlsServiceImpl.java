package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.alExam.web.sv.service.TrgterExamLResultDtlsService;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 * @Class Name : TrgterExamResultDtlsServiceImpl.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과상세를 관리하는  DAO와 연동 관리하는 class
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		------		---------------------------
 * @	2020.05.13		양현우 		최초생성
 * @author theJoin
 * @since 2020.05.13
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Service("web.sv.TrgterExamLResultDtlsService")
public class TrgterExamLResultDtlsServiceImpl extends EgovAbstractServiceImpl implements TrgterExamLResultDtlsService{
	
	@Resource(name="web.sv.TrgterExamLResultDtlsDAO")
	private TrgterExamLResultDtlsDAO trgterExamResultDtlsDAO;

	@Override
	public Map<String, Object> selectUserInfoDtls(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.selectUserInfoDtls(param);
	}

	@Override
	public Map<String, Object> userExamCount(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.userExamCount(param);
	}

	@Override
	public List<Map<String,Object>> userExamInfo(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.userExamInfo(param);
	}

	@Override
	public List<Map<String, Object>> examItemNm(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.examItemNm(param);
	}

	@Override
	public List<Map<String, Object>> examTotScore(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.examTotScore(param);
	}

	@Override
	public List<Map<String, Object>> examItemCdDtlsNm(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.examItemCdDtlsNm(param);
	}

	@Override
	public List<Map<String, Object>> examItemCdDtlsPoint(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.examItemCdDtlsPoint(param);
	}

	@Override
	public List<Map<String, Object>> examHistList(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.examHistList(param);
	}

	@Override
	public int trgterExamPointUpd(Map<String, Object> param) throws Exception {
		return trgterExamResultDtlsDAO.trgterExamPointUpd(param);
	}
}
