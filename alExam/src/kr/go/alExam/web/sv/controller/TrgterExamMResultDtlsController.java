package kr.go.alExam.web.sv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.web.sv.service.TrgterExamMResultDtlsService;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * @Class Name : TrgterExamMResultDtlsController.java
 * @Description : S-LICA 검사 결과지
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

@Controller
@RequestMapping(value = "/sv") 
public class TrgterExamMResultDtlsController extends DMultiActionController{
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception {
		return super.initData(req);
	}
	
	@Resource(name = "web.sv.TrgterExamMResultDtlsService")
	private TrgterExamMResultDtlsService trgterExamMResultDtlsService;

	/**
	 * MMSE-DS 결과상세 목록
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/getMmseList.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> getMmseList( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, String>> rsList = trgterExamMResultDtlsService.examMResultDtls(param);
		rsMap.put("rsList", rsList);
		
		return rsMap;
	}
	/**
	 * MMSE-DS 결과상세 목록 수정
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value ="/updateMmsePoint.do")
	public @ResponseBody int updateMmsePoint(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		int rsInt = 0;
		
		String mmseDataList = ((String) param.get("mmseDataList")).replaceAll("&quot;", "\"");
		
		JSONArray jarr = new JSONArray();
		jarr = new JSONArray(mmseDataList);
		
		rsInt = trgterExamMResultDtlsService.updateMmsePoint(param, jarr);
		return rsInt;
	}
	
	/**
	 * MMSE-DS 결과상세 입력
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value ="/insertMmsePoint.do")
	public @ResponseBody int insertMmsePoint(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		int rsInt = 0;
		
		String mmseDataList = ((String) param.get("mmseDataList")).replaceAll("&quot;", "\"");
		
		JSONArray jarr = new JSONArray();
		jarr = new JSONArray(mmseDataList);
		
		rsInt = trgterExamMResultDtlsService.insertMmsePoint(param, jarr);
		return rsInt;
	}
	
	//저장 확인 진행상태 변경
	@RequestMapping(value = "/MSttsChange.do", method = RequestMethod.POST)
	public @ResponseBody int MSttsChange(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		int rsInt = 0;
		rsInt = trgterExamMResultDtlsService.MSttsChange(param);
		return rsInt;
	}
	
}
