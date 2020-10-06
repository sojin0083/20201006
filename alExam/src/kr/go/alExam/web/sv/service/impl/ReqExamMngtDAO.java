package kr.go.alExam.web.sv.service.impl;

import java.util.List;
import java.util.Map;

import kr.go.alExam.common.DMultiEgovAbstractMapper;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : ReqExamMngtDAO.java
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

@Repository("web.sv.ReqExamMngtDAO")
public class ReqExamMngtDAO extends DMultiEgovAbstractMapper {

	public List<Map<String, String>> reqExamList(Map<String, Object> param) throws Exception{
		List<Map<String,String>> rsList = selectList("alExam.web.sv.ReqExamMngt.reqExamList", param);		
		return rsList;
	}

	public Map<String, String> trgterInfo(Map<String, Object> param) throws Exception{		
		Map<String,String> rsInfo = selectOne("alExam.web.sv.ReqExamMngt.trgterInfo", param);		
		return rsInfo;
	}

	public List<Map<String, String>> reqExamInfo(Map<String, Object> param) throws Exception{		
		List<Map<String,String>> rsVal = selectList("alExam.web.sv.ReqExamMngt.reqExamInfo", param);		
		return rsVal;
	}

	public List<Map<String, String>> ExamRecList(Map<String, Object> param) throws Exception{
		List<Map<String,String>> rsList = selectList("alExam.web.sv.ReqExamMngt.ExamRecList", param);		
		return rsList;
	}

	public Map<String, String> cntExam(Map<String, Object> param) throws Exception{
		Map<String,String> rsCnt = selectOne("alExam.web.sv.ReqExamMngt.cntExam", param);
		return rsCnt;
	}

	public int deleteExam(Map<String, Object> param) throws Exception{
		int rsInt = delete("alExam.web.sv.ReqExamMngt.deleteExam", param);
		return rsInt;
	}
}