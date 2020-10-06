package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;


/**
 * @Class Name : TrgterExamResultService.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과상세를  관리하는 서비스 interface
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

public interface TrgterExamResultService {
	
	public List<Map<String, Object>> trgterResultList(Map<String, Object> param) throws Exception;

}
