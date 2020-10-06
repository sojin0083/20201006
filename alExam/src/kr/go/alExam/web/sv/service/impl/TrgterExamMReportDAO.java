package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : TrgterInfoMngtDAO.java
 * @Description : 대상자관리
 * @Modification Information
 * @
 * @	수정일			수정자			수정내용
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

@Repository("web.sv.TrgterExamMReportDAO")
public class TrgterExamMReportDAO extends DMultiEgovAbstractMapper {

	public Map<String, String> getTrgterMExamInfo(Map<String, Object> param) throws Exception {
		Map<String, String> rsInfo = selectOne("alExam.web.sv.TrgterExamMReport.getTrgterMExamInfo", param);
		return rsInfo;
	}

	public List<Map<String, String>> getTrgterMExamReport(Map<String, Object> param) throws Exception {
		List<Map<String, String>> rsList = selectList("alExam.web.sv.TrgterExamMReport.getTrgterMExamReport", param);
		return rsList;
	}
	
}