package kr.go.alExam.web.sv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.web.sv.service.TrgterExamLReportService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * @Class Name : TrgterExamLReportController.java
 * @Description : LICA 검사 결과지 업무를 관리하는 컨트롤러 Class
 * @Modification Information
 * @
 * @	수정일			    수정자			수정내용
 * @	----------		-----		---------------------------
 * @	2020.05.20		오샘이			최초생성
 *
 * @author TheJoin
 * @since 2020.05.20
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Controller
@RequestMapping(value = "/sv") 
public class TrgterExamLReportController extends DMultiActionController{
	
	@Resource(name = "web.sv.TrgterExamLReportService")
	private TrgterExamLReportService trgterExamLReportService;
	
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception {
		return super.initData(req);
	}
	
	/**
	 * LICA  검사 결과지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamLReport.do")
	public String trgterExamResultList(@ModelAttribute Map param, ModelMap model) throws Exception{
		
		model.addAttribute("P_R_NUMBER", param.get("R_NUMBER").toString());
		model.addAttribute("P_EXAM_NO", param.get("EXAM_NO").toString());	
		model.addAttribute("P_EXAM_SN", param.get("EXAM_SN").toString());			
		
		

		return "web/sv/trgterExamLReport";
	}
	
	/**
	 * LICA  검사 결과지 내용 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamLReportContentsList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectTrgterExamLReportResultList(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		
		//대상자 정보, 평가종합소견
		Map<String, Object> rsTrgt             = trgterExamLReportService.selectTrgterInfo(param);
		//비문해 판정
		Map<String, Object> rsIll                = trgterExamLReportService.selectIllJudgeInfo(param);		
		//인지영역 그래프
		List<Map<String, Object>> rsGrp1    = trgterExamLReportService.selectCogAreaGrp(param);			
		//기억력 그래프
		List<Map<String, Object>> rsGrp2    = trgterExamLReportService.selectMemoryAreaGrp(param);		
		//인지영역결과표
		List<Map<String, Object>> rsTb1     = trgterExamLReportService.selectCogAreaRsltTable(param);		
		//세부검사결과표
		List<Map<String, Object>> rsTb2     = trgterExamLReportService.selectExamDtlsRsltTable(param);			
		//누적검사결과표
		List<Map<String, Object>> rsTb3     = trgterExamLReportService.selectExamAccuRsltTable(param);						
		
		rsMap.put("rsTrgt",  rsTrgt);
		rsMap.put("rsIll",     rsIll);
		rsMap.put("rsGrp1", rsGrp1);
		rsMap.put("rsGrp2", rsGrp2);
		rsMap.put("rsTb1",  rsTb1);		
		rsMap.put("rsTb2",  rsTb2);	
		rsMap.put("rsTb3",  rsTb3);	
		
		return rsMap;		
	}	
	
	/**
	 * LICA  검사 결과지 평가 결과 내용 저장
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value ="/updateTrgterExamLReportComment.do")
	public @ResponseBody int updateTrgterExamLReportComment(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		int rsInt = 0;
		rsInt = trgterExamLReportService.updateTrgterExamLReportComment(param);
		return rsInt;
	}	
	
	/**
	 * LICA 검사 결과지 프린트
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterExamLReportPrint.do")
	public String trgterExamLReportPrint(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		model.addAllAttributes(param);
		return "web/sv/trgterExamLReportPopPrint";
		
	}		

	
}
