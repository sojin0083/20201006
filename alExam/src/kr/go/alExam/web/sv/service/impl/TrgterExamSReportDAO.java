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

@Repository("web.sv.TrgterExamSReportDAO")
public class TrgterExamSReportDAO extends DMultiEgovAbstractMapper {

	public Map<String, String> getTrgterSExamInfo(Map<String, Object> param) throws Exception {
		Map<String, String> rsInfo = selectOne("alExam.web.sv.TrgterExamSReport.getTrgterSExamInfo", param);
		return rsInfo;
	}

	public List<Map<String, String>> getTrgterSExamArea(Map<String, Object> param) throws Exception {
		List<Map<String, String>> rsArea = selectList("alExam.web.sv.TrgterExamSReport.getTrgterSExamArea", param);
		return rsArea;
	}

	public int examOpin(Map<String, Object> param) {
		int rsInt = update("alExam.web.sv.TrgterExamSReport.examOpin", param);
		return rsInt;
	}

	public List<Map<String, String>> getTrgterSExamGrpO(Map<String, Object> param) throws Exception {
		List<Map<String, String>> grfO = selectList("alExam.web.sv.TrgterExamSReport.getTrgterSExamGrpO", param);
		return grfO;
	}

	public List<Map<String, String>> getTrgterSExamGrpM(Map<String, Object> param) throws Exception {
		List<Map<String, String>> grfM = selectList("alExam.web.sv.TrgterExamSReport.getTrgterSExamGrpM", param);
		return grfM;
	}

	public List<Map<String, String>> setTrgterSExamReportDtls(Map<String, Object> param) throws Exception {
		List<Map<String, String>> rsDtls = selectList("alExam.web.sv.TrgterExamSReport.setTrgterSExamReportDtls", param);
		return rsDtls;
	}

	public List<Map<String, String>> setTrgterSExamReportRec(Map<String, Object> param) throws Exception {
		List<Map<String, String>> rsRec = selectList("alExam.web.sv.TrgterExamSReport.setTrgterSExamReportRec", param);
		return rsRec;
	}

	public Map<String, String> getTrgterSExamrsLiteracy(Map<String, Object> param) throws Exception {
		Map<String, String> rsLiteracy = selectOne("alExam.web.sv.TrgterExamSReport.getTrgterSExamrsLiteracy", param);
		return rsLiteracy;
	}
}