package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.json.JSONArray;
import org.json.JSONObject;
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

@Repository("web.sv.TrgterExamMResultDtlsDAO")
public class TrgterExamMResultDtlsDAO extends DMultiEgovAbstractMapper {

	public List<Map<String, String>> examMResultDtls(Map<String, Object> param) throws Exception{
		List<Map<String,String>> rsList = selectList("alExam.web.sv.TrgterExamMResultDtls.examMResultDtls", param);
		return rsList;
	}

	public int updateMmsePoint(Map<String, Object> param, JSONArray jarr) throws Exception{
		int rsInt = 0;
		for(int i=0;i<jarr.length();i++){
			JSONObject tmp = (JSONObject)jarr.get(i);//인덱스 번호로 접근해서 가져온다.
			
			String EXAM_ITEM_CD = (String)tmp.get("EXAM_ITEM_CD");
			String EXAM_ITEM_CD_DTLS = (String)tmp.get("EXAM_ITEM_CD_DTLS");
			String POINT = (String)tmp.get("POINT");
			
			param.put("EXAM_ITEM_CD", EXAM_ITEM_CD);
			param.put("EXAM_ITEM_CD_DTLS", EXAM_ITEM_CD_DTLS);
			param.put("POINT", POINT);
			
			update("alExam.web.sv.TrgterExamMResultDtls.updateMmsePoint", param);
			
			rsInt ++;
		}
		
		update("alExam.web.sv.TrgterExamMResultDtls.updateMmseTotPoint", param);
		return rsInt;
	}
	
	public int insertMmsePoint(Map<String, Object> param, JSONArray jarr) throws Exception{
		int rsInt = 0;
		for(int i=0;i<jarr.length();i++){
			JSONObject tmp = (JSONObject)jarr.get(i);//인덱스 번호로 접근해서 가져온다.
			
			String EXAM_ITEM_CD = (String)tmp.get("EXAM_ITEM_CD");
			String EXAM_ITEM_CD_DTLS = (String)tmp.get("EXAM_ITEM_CD_DTLS");
			String POINT = (String)tmp.get("POINT");
			
			param.put("EXAM_ITEM_CD", EXAM_ITEM_CD);
			param.put("EXAM_ITEM_CD_DTLS", EXAM_ITEM_CD_DTLS);
			param.put("POINT", POINT);
			
			insert("alExam.web.sv.TrgterExamMResultDtls.insertMmsePoint", param);
			
			rsInt ++;
		}
		
		insert("alExam.web.sv.TrgterExamMResultDtls.insertMmseTotPoint", param);
		return rsInt;
	}
	
	public int MSttsChange(Map<String, Object> param) throws Exception{
		int rsInt = update("alExam.web.sv.TrgterExamMResultDtls.MSttsChange", param);
		return rsInt;
	}
}