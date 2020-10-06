package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.go.alExam.web.sv.service.TrgterExamMReportService;
import kr.go.alExam.web.sv.service.impl.TrgterExamMReportDAO;
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

@Service("web.sv.TrgterExamMReportService")
public class TrgterExamMReportServiceImpl extends EgovAbstractServiceImpl implements TrgterExamMReportService{
	@Resource(name="web.sv.TrgterExamMReportDAO")
	private TrgterExamMReportDAO trgterExamMReportDAO;

	@Override
	public Map<String, String> getTrgterMExamInfo(Map<String, Object> param) throws Exception {
		return trgterExamMReportDAO.getTrgterMExamInfo(param);
	}

	@Override
	public List<Map<String, String>> getTrgterMExamReport (Map<String, Object> param) throws Exception {
		return trgterExamMReportDAO.getTrgterMExamReport(param);
	}
	
}
