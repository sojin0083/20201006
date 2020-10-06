package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.go.alExam.web.sv.service.TrgterExamLReportService;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : TrgterExamLReportServiceImpl.java
 * @Description : LICA 검사 결과지 업무에 필요한 DAO와 연동 관리하는 Class
 * @Modification Information
 * @
 * @	수정일			    수정자			수정내용
 * @	----------		-----		---------------------------
 * @	2020.05.20		오샘이			최초생성
 *
 * @author TheJoin
 * @since 2020.05.20
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Service("web.sv.TrgterExamLReportService")
public class TrgterExamLReportServiceImpl extends EgovAbstractServiceImpl implements TrgterExamLReportService{
	@Resource(name="web.sv.TrgterExamLReportDAO")
	private TrgterExamLReportDAO trgterExamLReportDAO;

	//대상자 정보, 평가종합소견	
	@Override
	public Map<String, Object> selectTrgterInfo(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.selectTrgterInfo(param);
	}

	//비문해 판정	
	@Override
	public Map<String, Object> selectIllJudgeInfo(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.selectIllJudgeInfo(param);
	}

	//인지영역 그래프	
	@Override
	public List<Map<String, Object>> selectCogAreaGrp(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.selectCogAreaGrp(param);
	}

	//기억력 그래프	
	@Override
	public List<Map<String, Object>> selectMemoryAreaGrp(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.selectMemoryAreaGrp(param);
	}

	//인지영역결과표	
	@Override
	public List<Map<String, Object>> selectCogAreaRsltTable(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.selectCogAreaRsltTable(param);
	}

	//세부검사결과표	
	@Override
	public List<Map<String, Object>> selectExamDtlsRsltTable(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.selectExamDtlsRsltTable(param);
	}

	//누적검사결과표	
	@Override
	public List<Map<String, Object>> selectExamAccuRsltTable(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.selectExamAccuRsltTable(param);
	}

	// LICA  검사 결과지 평가 결과 내용 저장
	@Override
	public int updateTrgterExamLReportComment(Map<String, Object> param) throws Exception {
		return trgterExamLReportDAO.updateTrgterExamLReportComment(param);
	}

	
	
}
