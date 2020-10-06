package kr.go.alExam.web.tg.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : TrgterInfoMngtService.java
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

public interface TrgterInfoMngtService {

	List<Map<String, String>> trgterList(Map<String, Object> param) throws Exception;

	int regTrgterInfo(Map<String, Object> param)throws Exception;
	
	Map<String, String> trgterInfoSet(Map<String, Object> param)throws Exception;

	void modTrgterInfo(Map<String, Object> param)throws Exception;

	void reqExam(Map<String, Object> param)throws Exception;

	List<Map<String, String>> selectInsExamInfo(Map<String, Object> param)throws Exception;

	Map<String, String> modTrgterNumChk(Map<String, Object> param)throws Exception;

	Map<String, String> getCNum(Map<String, Object> param)throws Exception;
	
}