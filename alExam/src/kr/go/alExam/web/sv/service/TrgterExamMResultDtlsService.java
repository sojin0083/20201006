package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;

/**
 * @Class Name : TrgterExamMResultDtlsService.java
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

public interface TrgterExamMResultDtlsService {

	List<Map<String, String>> examMResultDtls(Map<String, Object> param) throws Exception;

	int updateMmsePoint(Map<String, Object> param, JSONArray jarr) throws Exception;

	int insertMmsePoint(Map<String, Object> param, JSONArray jarr) throws Exception;

	int MSttsChange(Map<String, Object> param) throws Exception;
	
}