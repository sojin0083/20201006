package kr.go.alExam.web.sv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.web.sv.service.TrgterExamMReportService;
import kr.go.alExam.common.util.StringUtil;


/**
 * @Class Name : TrgterExamSReportController.java
 * @Description : MMSE-DS 검사 결과지
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
public class TrgterExamMReportController extends DMultiActionController{
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception {
		return super.initData(req);
	}
	
	@Resource(name = "web.sv.TrgterExamMReportService")
	private TrgterExamMReportService trgterExamMReportService;

	
	/**
	 * MMSE-DS 검사 결과지 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterExamMReportPage.do") 
	public String trgterExamMReportPage(@ModelAttribute Map param, ModelMap model) throws Exception {
		
		model.addAttribute("EXAM_NO", param.get("EXAM_NO"));
		model.addAttribute("R_NUMBER", param.get("R_NUMBER"));
		model.addAttribute("EXAM_SN", param.get("EXAM_SN"));
		model.addAttribute("EXAM_DIV", param.get("EXAM_DIV"));
		
		return "web/sv/trgterExamMReport";
	}
	
	/**
	 * MMSE-DS 검사 결과지 정보
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/getTrgterExamMReport.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> getTrgterExamMReport( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		
		Map<String, String> rsInfo = trgterExamMReportService.getTrgterMExamInfo(param);
		List<Map<String, String>> rsList = trgterExamMReportService.getTrgterMExamReport(param);
		rsMap.put("rsInfo", rsInfo);
		rsMap.put("rsList", rsList);
		
		return rsMap;
	}
	
	
	/**
	 * MMSE-DS 검사 결과지 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterExamMReportPrint.do") 
	public String trgterExamMReportPrint(@ModelAttribute Map param, ModelMap model) throws Exception {
		
		model.addAttribute("EXAM_NO", param.get("EXAM_NO"));
		model.addAttribute("R_NUMBER", param.get("R_NUMBER"));
		model.addAttribute("EXAM_SN", param.get("EXAM_SN"));
		model.addAttribute("EXAM_DIV", param.get("EXAM_DIV"));
		
		return "web/sv/trgterExamMReportPopPrint";
	}	

}
