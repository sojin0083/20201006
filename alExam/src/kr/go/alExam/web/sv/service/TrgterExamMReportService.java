package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : TrgterExamMReportService.java
 * @Description : 대상자관리
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.18		정준호			최초생성
 *
 * @author Thejoin
 * @since 2020.05.18
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

public interface TrgterExamMReportService {

	Map<String, String> getTrgterMExamInfo(Map<String, Object> param) throws Exception ;

	List<Map<String, String>> getTrgterMExamReport(Map<String, Object> param) throws Exception ;
	
}