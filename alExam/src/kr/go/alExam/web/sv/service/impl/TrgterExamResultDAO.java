package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.springframework.stereotype.Repository;


/**
 * @Class Name : TrgterExamResultDAO.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과를 관리하는  DAO class
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		------		---------------------------
 * @	2020.05.11		양현우 		최초생성
 * @author theJoin
 * @since 2020.05.11
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Repository("web.sv.TrgterExamResultDAO")
public class TrgterExamResultDAO  extends DMultiEgovAbstractMapper{
	
	public List<Map<String, Object>> trgterResultList(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> rsList = selectList("alExam.web.sv.trgterexamresult.trgterResultList", param);
		return rsList;
	}

}
