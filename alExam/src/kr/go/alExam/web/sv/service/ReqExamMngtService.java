package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : ReqExamMngtService.java
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

public interface ReqExamMngtService {

	List<Map<String, String>> reqExamList(Map<String, Object> param) throws Exception;

	Map<String, String> trgterInfo(Map<String, Object> param) throws Exception;

	List<Map<String, String>> reqExamInfo(Map<String, Object> param) throws Exception;

	List<Map<String, String>> ExamRecList(Map<String, Object> param) throws Exception;

	Map<String, String> cntExam(Map<String, Object> param)throws Exception;

	int deleteExam(Map<String, Object> param)throws Exception;

}