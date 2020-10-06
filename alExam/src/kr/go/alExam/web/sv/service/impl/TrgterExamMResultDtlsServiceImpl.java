package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.springframework.stereotype.Service;

import kr.go.alExam.web.sv.service.TrgterExamMResultDtlsService;
import kr.go.alExam.web.sv.service.impl.TrgterExamMResultDtlsDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : TrgterInfoMngtServiceImpl.java
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

@Service("web.sv.TrgterExamMResultDtlsService")
public class TrgterExamMResultDtlsServiceImpl extends EgovAbstractServiceImpl implements TrgterExamMResultDtlsService{
	@Resource(name="web.sv.TrgterExamMResultDtlsDAO")
	private TrgterExamMResultDtlsDAO trgterExamMResultDtlsDAO;

	@Override
	public List<Map<String, String>> examMResultDtls(Map<String, Object> param) throws Exception {
		return trgterExamMResultDtlsDAO.examMResultDtls(param);
	}

	@Override
	public int updateMmsePoint(Map<String, Object> param, JSONArray jarr) throws Exception {
		return trgterExamMResultDtlsDAO.updateMmsePoint(param, jarr);
	}

	@Override
	public int insertMmsePoint(Map<String, Object> param, JSONArray jarr) throws Exception {
		return trgterExamMResultDtlsDAO.insertMmsePoint(param, jarr);
	}

	@Override
	public int MSttsChange(Map<String, Object> param) throws Exception {
		return trgterExamMResultDtlsDAO.MSttsChange(param);
	}
	
}
