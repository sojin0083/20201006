package kr.go.alExam.web.tg.service.impl;

import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : TrgterInfoMngtDAO.java
 * @Description : 대상자관리
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.07		정준호			최초생성
 *
 * @author Thejoin
 * @since 2020.05.07
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Repository("web.tg.TargetManagementDAO")
public class TrgterInfoMngtDAO extends DMultiEgovAbstractMapper {
	
	public List<Map<String, String>> trgterList(Map<String, Object> param) throws Exception{
		List<Map<String,String>> rsList = selectList("alExam.web.tg.TrgterInfoMngt.trgterList", param);
		return rsList;  
	}

	public int regTrgterInfo(Map<String, Object> param) throws Exception{
		int rsInt = insert("alExam.web.tg.TrgterInfoMngt.regTrgterInfo", param);
		return rsInt;
	}

	public Map<String, String> trgterInfoSet(Map<String, Object> param) throws Exception{
		Map<String,String> rsInfo = selectOne("alExam.web.tg.TrgterInfoMngt.modTrgterInfoSet", param);
		return rsInfo;
	}

	public void modTrgterInfo(Map<String, Object> param) throws Exception{
		update("alExam.web.tg.TrgterInfoMngt.modTrgterInfo", param);
	}

	public void reqExam(Map<String, Object> param) throws Exception{
		insert("alExam.web.tg.TrgterInfoMngt.reqExam", param);
	}

	public List<Map<String, String>> selectInsExamInfo(Map<String, Object> param) throws Exception{
		List<Map<String,String>> rsList = selectList("alExam.web.tg.TrgterInfoMngt.selectInsExamInfo", param);
		return rsList;
	}

	public Map<String, String> modTrgterNumChk(Map<String, Object> param) throws Exception{
		Map<String,String> rsChk = selectOne("alExam.web.tg.TrgterInfoMngt.modTrgterNumChk", param);
		return rsChk;
	}

	public Map<String, String> getCNum(Map<String, Object> param) {
		Map<String,String> rsNum = selectOne("alExam.web.tg.TrgterInfoMngt.getCNum", param);
		return rsNum;
	}
}