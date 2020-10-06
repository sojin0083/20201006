package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : TrgterExamSReportService.java
 * @Description : LICA 검사 결과지 업무를 관리하는 서비스 interface
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.20		오샘이			최초생성
 *
 * @author TheJoin
 * @since 2020.05.20
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

public interface TrgterExamLReportService {

	//대상자 정보, 평가종합소견
	public Map<String, Object> selectTrgterInfo(Map<String, Object> param) throws Exception;
	
	//비문해 판정
	public Map<String, Object> selectIllJudgeInfo(Map<String, Object> param) throws Exception;
	
	//인지영역 그래프
	public List<Map<String, Object>> selectCogAreaGrp(Map<String, Object> param) throws Exception;		
	
	//기억력 그래프
	public List<Map<String, Object>> selectMemoryAreaGrp(Map<String, Object> param) throws Exception;			
	
	//인지영역결과표
	public List<Map<String, Object>> selectCogAreaRsltTable(Map<String, Object> param) throws Exception;				
	
	//세부검사결과표
	public List<Map<String, Object>> selectExamDtlsRsltTable(Map<String, Object> param) throws Exception;		
	
	//누적검사결과표
	public List<Map<String, Object>> selectExamAccuRsltTable(Map<String, Object> param) throws Exception;		
	
	//검진 결과 평가내용 업데이트 
	public int updateTrgterExamLReportComment(Map<String, Object> param) throws Exception;			

}