package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : TrgterExamSReportService.java
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

public interface TrgterExamSReportService {

	public Map<String, String> getTrgterSExamInfo(Map<String, Object> param) throws Exception;

	public List<Map<String, String>> getTrgterSExamArea(Map<String, Object> param) throws Exception;

	public int examOpin(Map<String, Object> param);

	public List<Map<String, String>> getTrgterSExamGrpO(Map<String, Object> param) throws Exception;
	
	public List<Map<String, String>> getTrgterSExamGrpM(Map<String, Object> param) throws Exception;

	public List<Map<String, String>> setTrgterSExamReportDtls(Map<String, Object> param) throws Exception;

	public List<Map<String, String>> setTrgterSExamReportRec(Map<String, Object> param) throws Exception;

	public Map<String, String> getTrgterSExamrsLiteracy(Map<String, Object> param) throws Exception;
}