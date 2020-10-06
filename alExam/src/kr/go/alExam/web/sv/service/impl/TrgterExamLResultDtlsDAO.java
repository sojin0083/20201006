package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : TrgterExamResultDtlsDAO.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과상세를 관리하는 DAO class
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ ---------- ------ --------------------------- @ 2020.05.13
 *   양현우 최초생성
 * @author theJoin
 * @since 2020.05.13
 * @version 1.0
 * @see
 *
 * 		Copyright (C) by Mobile Health Care All right reserved.
 */

@Repository("web.sv.TrgterExamLResultDtlsDAO")
public class TrgterExamLResultDtlsDAO extends DMultiEgovAbstractMapper {

	public Map<String, Object> selectUserInfoDtls(Map<String, Object> param) throws Exception {
		Map<String, Object> rsMap = selectOne("alExam.web.sv.trgterexamlresultdtls.selectUserInfoDtls", param);
		return rsMap;
	}

	public Map<String, Object> userExamCount(Map<String, Object> param) throws Exception {
		Map<String, Object> rsMap = selectOne("alExam.web.sv.trgterexamlresultdtls.selectExamCount", param);
		return rsMap;
	}

	public List<Map<String, Object>> userExamInfo(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultdtls.selectExamInfo", param);
		return rsList;
	}

	public List<Map<String, Object>> examItemNm(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultdtls.selectexamItemNm", param);
		return rsList;
	}

	public List<Map<String, Object>> examTotScore(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultdtls.selectexamtotscore", param);
		return rsList;
	}

	public List<Map<String, Object>> examItemCdDtlsNm(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultdtls.selectexamitemcddtlsnm",
				param);
		return rsList;
	}

	public List<Map<String, Object>> examItemCdDtlsPoint(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultdtls.selectexamitemcddtlspoint",
				param);
		return rsList;
	}

	public List<Map<String, Object>> examHistList(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultdtls.selectExamHist", param);
		return rsList;
	}

	public int trgterExamPointUpd(Map<String, Object> param) throws Exception {
		String[] point = param.get("POINT").toString().split("\\,", -1);
		String[] examitemcd = param.get("EXAM_ITEM_CD").toString().split("\\,");
		String[] examitemcddtls = param.get("EXAM_ITEM_CD_DTLS").toString().split("\\,");
		String[] rmk = param.get("RMK").toString().split("\\,", -1);
		int rsInt = 0;
		for (int i = 0; i < examitemcd.length; i++) {
			param.put("POINT", point[i]);
			param.put("EXAM_ITEM_CD", examitemcd[i]);
			param.put("EXAM_ITEM_CD_DTLS", examitemcddtls[i]);
			param.put("RMK", rmk[i]);
			update("alExam.web.sv.trgterexamlresultdtls.updPoint", param);
			rsInt++;
		}
		update("alExam.web.sv.trgterexamlresultdtls.updTotPoint", param);
		return rsInt;
	}
}
