package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : TrgterExamLReportDAO.java
 * @Description : LICA 검사 결과지 업무 DataBase 연동 관리하는 Class
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

@Repository("web.sv.TrgterExamLReportDAO")
public class TrgterExamLReportDAO extends DMultiEgovAbstractMapper {
	
	
	//대상자 정보, 평가종합소견		
	public Map<String, Object> selectTrgterInfo(Map<String, Object> param) throws Exception {
		Map<String,Object> rsMap = selectOne("alExam.web.sv.trgterexamlreport.selectTrgterInfo", param);
		return rsMap;
	}

	//비문해 판정		
	public Map<String, Object> selectIllJudgeInfo(Map<String, Object> param) throws Exception {
		Map<String,Object> rsMap = selectOne("alExam.web.sv.trgterexamlreport.selectIllJudgeInfo", param);
		return rsMap;
	}

	//인지영역 그래프		
	public List<Map<String, Object>> selectCogAreaGrp(Map<String, Object> param) throws Exception {
		List<Map<String,Object>> rsList = selectList("alExam.web.sv.trgterexamlreport.selectCogAreaGrp", param);
		return rsList;
	}

	//기억력 그래프		
	public List<Map<String, Object>> selectMemoryAreaGrp(Map<String, Object> param) throws Exception {
		List<Map<String,Object>> rsList = selectList("alExam.web.sv.trgterexamlreport.selectMemoryAreaGrp", param);
		return rsList;
	}

	//인지영역결과표		
	public List<Map<String, Object>> selectCogAreaRsltTable(Map<String, Object> param) throws Exception {
		List<Map<String,Object>> rsList = selectList("alExam.web.sv.trgterexamlreport.selectCogAreaRsltTable", param);
		return rsList;
	}

	//세부검사결과표		
	public List<Map<String, Object>> selectExamDtlsRsltTable(Map<String, Object> param) throws Exception {
		List<Map<String,Object>> rsList = selectList("alExam.web.sv.trgterexamlreport.selectExamDtlsRsltTable", param);
		return rsList;
	}

	//누적검사결과표		
	public List<Map<String, Object>> selectExamAccuRsltTable(Map<String, Object> param) throws Exception {
		List<Map<String,Object>> rsList = selectList("alExam.web.sv.trgterexamlreport.selectExamAccuRsltTable", param);
		return rsList;
	}

	//검진 결과 평가내용 업데이트 	
	public int updateTrgterExamLReportComment(Map<String, Object> param) throws Exception {
		int rsInt = update("alExam.web.sv.trgterexamlreport.updateTrgterExamLReportComment", param);
		return rsInt;
	}	
	
}