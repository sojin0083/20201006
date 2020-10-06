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
import kr.go.alExam.web.sv.service.TrgterExamSReportService;
import kr.go.alExam.common.util.StringUtil;


/**
 * @Class Name : TrgterExamSReportController.java
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
public class TrgterExamSReportController extends DMultiActionController{
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception {
		return super.initData(req);
	}
	
	@Resource(name = "web.sv.TrgterExamSReportService")
	private TrgterExamSReportService trgterExamSReportService;
	
	/**
	 * SLICA 검사 결과지 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterExamSReportPage.do") 
	public String trgterExamSReportPage(@ModelAttribute Map param, ModelMap model) throws Exception {
		
		model.addAttribute("EXAM_NO", param.get("EXAM_NO"));
		model.addAttribute("R_NUMBER", param.get("R_NUMBER"));
		model.addAttribute("EXAM_SN", param.get("EXAM_SN"));
		model.addAttribute("EXAM_DIV", param.get("EXAM_DIV"));
		
		return "web/sv/trgterExamSReport";
	}
	
	/**
	 * SLICA 검사 결과지 정보
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/getTrgterExamSReport.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> getTrgterExamSReport( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		//대상자정보
		Map<String, String> rsInfo = trgterExamSReportService.getTrgterSExamInfo(param);
		//인지영역 결과표
		List<Map<String, String>> rsArea = trgterExamSReportService.getTrgterSExamArea(param);
		//인지그래프
		List<Map<String, String>> grpO = trgterExamSReportService.getTrgterSExamGrpO(param);
		//기억그래프
		List<Map<String, String>> grpM = trgterExamSReportService.getTrgterSExamGrpM(param);
		//세부검사결과표
		List<Map<String, String>> rsDtls = trgterExamSReportService.setTrgterSExamReportDtls(param);
		//누적검사결과표
		List<Map<String, String>> rsRec = trgterExamSReportService.setTrgterSExamReportRec(param);
		//비문해 판정
		Map<String, String> rsLiteracy = trgterExamSReportService.getTrgterSExamrsLiteracy(param);
		
		rsMap.put("rsInfo", rsInfo);
		rsMap.put("rsArea", rsArea);
		rsMap.put("grpO", grpO);
		rsMap.put("grpM", grpM);
		rsMap.put("rsDtls", rsDtls);
		rsMap.put("rsRec", rsRec);
		rsMap.put("rsLiteracy", rsLiteracy);
		
		return rsMap;
	}
	
	/**
	 * 평가종합소견 작성
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/examOpin.do", method = RequestMethod.POST) 
	public @ResponseBody int examOpin(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		int rsInt = 0;		
		//평가종합소견작성
		rsInt = trgterExamSReportService.examOpin(param);			
		return rsInt;
	}	
	
	/**
	 * LICA 검사 결과지 프린트
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterExamSReportPrint.do")
	public String trgterExamSReportPrint(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		model.addAllAttributes(param);
		
		return "web/sv/trgterExamSReportPopPrint";
		
	}			
}
