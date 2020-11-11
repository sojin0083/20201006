package kr.go.alExam.web.sv.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.go.alExam.common.controller.DMultiEgovAbstractMapper;

@Repository("web.sv.TrgterExamLResultInsertDAO")
public class TrgterExamLResultInsertDAO extends DMultiEgovAbstractMapper{
	public Map<String, Object> selectUserInfo(Map<String, Object> param) throws Exception{
		Map<String, Object> rsMap = selectOne("alExam.web.sv.trgterexamlresultinsert.selectUserInfo", param);
		return rsMap;
	}
	
	public Map<String, Object> userExamCount(Map<String, Object> param) throws Exception{
		Map<String, Object> rsMap = selectOne("alExam.web.sv.trgterexamlresultinsert.selectExamCount", param);
		return rsMap;
	}
	
	public List<Map<String,Object>> userExamInfo(Map<String, Object> param) throws Exception{
		List<Map<String,Object>> rsList = selectList("alExam.web.sv.trgterexamlresultinsert.selectExamInfo", param);
		return rsList;
	}
	
	public List<Map<String, Object>> examItemNm(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultinsert.selectexamItemNm", param);
		return rsList;
	}
	
	public List<Map<String, Object>> examTotScore(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultinsert.selectexamtotscore",param);
		return rsList;
	}
	
	public List<Map<String, Object>> examItemCdDtlsNm(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultinsert.selectexamitemcddtlsnm", param);
		return rsList;
	}
	
	public List<Map<String, Object>> examItemCdDtlsPoint(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultinsert.selectexamitemcddtlspoint", param);
		return rsList;
	}

	public List<Map<String, Object>> examHistList(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamlresultinsert.selectExamHist", param);
		return rsList;
	}
	
	public int trgterExamResultPointInsert(Map<String, Object> param) throws Exception{
		String[] point = param.get("POINT").toString().split("\\,",-1);
		String[] examitemcd = param.get("EXAM_ITEM_CD").toString().split("\\,");
		String[] examitemcddtls = param.get("EXAM_ITEM_CD_DTLS").toString().split("\\,");
		String[] examitemno = param.get("EXAM_ITEM_NO").toString().split("\\,");
		String[] rmk = param.get("RMK").toString().split("\\,",-1);
		int rsInt = 0;
		for(int i=0; i<examitemcd.length; i++){
			param.put("POINT", point[i]);
			param.put("EXAM_ITEM_CD", examitemcd[i]);
			param.put("EXAM_ITEM_CD_DTLS", examitemcddtls[i]);
			param.put("EXAM_ITEM_NO", examitemno[i]);
			param.put("RMK", rmk[i]);
			insert("alExam.web.sv.trgterexamlresultinsert.insertPoint", param);
			rsInt ++; 
		}
		insert("alExam.web.sv.trgterexamlresultinsert.insertTotPoint", param);
		return rsInt;
	}
	
	public int sttsChange(Map<String, Object> param) throws Exception{
		int rsInt = update("alExam.web.sv.trgterexamlresultinsert.sttsChange", param);
		return rsInt;
		}
	
}
