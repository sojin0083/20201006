package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.go.alExam.web.sv.service.ReqExamMngtService;
import kr.go.alExam.web.sv.service.impl.ReqExamMngtDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : ReqExamMngtServiceImpl.java
 * @Description : 검사의뢰관리
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.12		정준호			최초생성
 *
 * @author Thejoin
 * @since 2020.05.12
 * @version 1.0
 * @see
 *
 */

@Service("web.sv.ReqExamMngtService")
public class ReqExamMngtServiceImpl extends EgovAbstractServiceImpl implements ReqExamMngtService{
	@Resource(name="web.sv.ReqExamMngtDAO")
	private ReqExamMngtDAO reqExamMngtDAO;

	@Override
	public List<Map<String, String>> reqExamList(Map<String, Object> param) throws Exception{
		return reqExamMngtDAO.reqExamList(param);
	}

	@Override
	public Map<String, String> trgterInfo(Map<String, Object> param) throws Exception{
		return reqExamMngtDAO.trgterInfo(param);
	}

	@Override
	public List<Map<String, String>> reqExamInfo(Map<String, Object> param) throws Exception{		
		return reqExamMngtDAO.reqExamInfo(param);
	}

	@Override
	public List<Map<String, String>> ExamRecList(Map<String, Object> param) throws Exception{
		return reqExamMngtDAO.ExamRecList(param);
	}

	@Override
	public Map<String, String> cntExam(Map<String, Object> param) throws Exception {
		return reqExamMngtDAO.cntExam(param);
	}

	@Override
	public int deleteExam(Map<String, Object> param) throws Exception {
		return reqExamMngtDAO.deleteExam(param);
	}
}