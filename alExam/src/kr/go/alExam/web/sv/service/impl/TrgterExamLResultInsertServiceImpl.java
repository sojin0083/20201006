package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.go.alExam.web.sv.service.TrgterExamLResultInsertService;

@Service("web.sv.TrgterExamLResultInsertService")
public class TrgterExamLResultInsertServiceImpl extends EgovAbstractServiceImpl implements TrgterExamLResultInsertService {

	@Resource(name = "web.sv.TrgterExamLResultInsertDAO")
	private TrgterExamLResultInsertDAO TrgterExamLResultInsertDAO;

	@Override
	public Map<String, Object> selectUserInfo(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.selectUserInfo(param);
	}

	@Override
	public Map<String, Object> userExamCount(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.userExamCount(param);
	}

	@Override
	public List<Map<String, Object>> userExamInfo(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.userExamInfo(param);
	}

	@Override
	public List<Map<String, Object>> examItemNm(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.examItemNm(param);
	}

	@Override
	public List<Map<String, Object>> examTotScore(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.examTotScore(param);
	}

	@Override
	public List<Map<String, Object>> examItemCdDtlsNm(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.examItemCdDtlsNm(param);
	}

	@Override
	public List<Map<String, Object>> examItemCdDtlsPoint(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.examItemCdDtlsPoint(param);
	}

	@Override
	public List<Map<String, Object>> examHistList(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.examHistList(param);
	}

	@Override
	public int trgterExamResultPointInsert(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.trgterExamResultPointInsert(param);
	}
	
	@Override
	public int sttsChange(Map<String, Object> param) throws Exception {
		return TrgterExamLResultInsertDAO.sttsChange(param);
	}
}