package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.go.alExam.web.sv.service.TrgterExamSReportService;
import kr.go.alExam.web.sv.service.impl.TrgterExamSReportDAO;
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

@Service("web.sv.TrgterExamSReportService")
public class TrgterExamSReportServiceImpl extends EgovAbstractServiceImpl implements TrgterExamSReportService{
	@Resource(name="web.sv.TrgterExamSReportDAO")
	private TrgterExamSReportDAO trgterExamSReportDAO;

	@Override
	public Map<String, String> getTrgterSExamInfo(Map<String, Object> param) throws Exception {
		return trgterExamSReportDAO.getTrgterSExamInfo(param);
	}

	@Override
	public List<Map<String, String>> getTrgterSExamArea(Map<String, Object> param) throws Exception {
		return trgterExamSReportDAO.getTrgterSExamArea(param);
	}

	@Override
	public int examOpin(Map<String, Object> param) {
		return trgterExamSReportDAO.examOpin(param);
	}

	@Override
	public List<Map<String, String>> getTrgterSExamGrpO(Map<String, Object> param) throws Exception {
		return trgterExamSReportDAO.getTrgterSExamGrpO(param);
	}

	@Override
	public List<Map<String, String>> getTrgterSExamGrpM(Map<String, Object> param) throws Exception {
		return trgterExamSReportDAO.getTrgterSExamGrpM(param);
	}

	@Override
	public List<Map<String, String>> setTrgterSExamReportDtls(Map<String, Object> param) throws Exception {
		return trgterExamSReportDAO.setTrgterSExamReportDtls(param);
	}

	@Override
	public List<Map<String, String>> setTrgterSExamReportRec(Map<String, Object> param) throws Exception {
		return trgterExamSReportDAO.setTrgterSExamReportRec(param);
	}

	@Override
	public Map<String, String> getTrgterSExamrsLiteracy(Map<String, Object> param) throws Exception {
		return trgterExamSReportDAO.getTrgterSExamrsLiteracy(param);
	}

}
