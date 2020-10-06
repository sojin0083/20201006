package kr.go.alExam.web.sv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.web.sv.service.TrgterExamLResultDtlsService;
import kr.go.alExam.web.sv.service.TrgterExamLResultInsertService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Class Name : TrgterExamResultDtlsController.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과상세를 관리하는 컨트롤러 Class
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		----		---------------------------
 * @	2020.05.13		양현우 		최초생성
 * @author theJoin
 * @since 2020.05.13
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Controller
@RequestMapping(value="/sv")
public class TrgterExamLResultDtlsController extends DMultiActionController{

	@Resource(name ="web.sv.TrgterExamLResultDtlsService")
	private TrgterExamLResultDtlsService trgterExamLResultDtlsService;
	
	@ModelAttribute
	public Map initData(HttpServletRequest req)throws Exception{
		return super.initData(req);
	}
	
	/**
	 * 검사 결과 상세 페이지 호출 및 기본 세팅
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamLResultDtls.do")
	public String  trgterExamResultDtls(@ModelAttribute Map param , ModelMap model) throws Exception{
		Map<String, Object> userInfo  	 			  = trgterExamLResultDtlsService.selectUserInfoDtls(param);
		Map<String, Object> examCount 	 			  = trgterExamLResultDtlsService.userExamCount(param);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("examCount",examCount);
		model.addAttribute("EXAM_NO", param.get("EXAM_NO"));
		model.addAttribute("R_NUMBER", param.get("R_NUMBER"));
		model.addAttribute("EXAM_SN", param.get("EXAM_SN"));
		model.addAttribute("EXAM_DIV", param.get("EXAM_DIV"));
		return "web/sv/trgterExamLResultDtls";
	}
	
	/**
	 * 검사 결과 상세 포인트 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamLResultDtlsPoint.do")
	public @ResponseBody Map<String, Object> trgterExamLResultDtlsPoint(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rsList			  = trgterExamLResultDtlsService.examItemCdDtlsPoint(param);
		List<Map<String, Object>> examTotScore  	  = trgterExamLResultDtlsService.examTotScore(param);
		List<Map<String, Object>> userExamInfo 		  = trgterExamLResultDtlsService.userExamInfo(param);
		rsMap.put("userExamInfo", userExamInfo);
		rsMap.put("rsList", rsList);
		rsMap.put("examTotScore", examTotScore);
		return rsMap;		
	}
	
	/**
	 * 검사이력 정보 리스트
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamHistList.do")
	public @ResponseBody Map<String, Object> trgterExamHistList(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rsList= trgterExamLResultDtlsService.examHistList(param);
		rsMap.put("rsList", rsList);
		return rsMap;		
	}
	
	/**
	 * 검사 정보 업데이트
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value= "/trgterExamPointUpd.do", method= RequestMethod.POST)
	public @ResponseBody Map<String, Object> trgterExamPointUpd(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		int rsInt  = trgterExamLResultDtlsService.trgterExamPointUpd(param);
		rsMap.put("rsInt", rsInt);
		return rsMap;
	}
	
	/**
	 * 검사결과  이름 및 코드 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamDrawKindsList.do", method= RequestMethod.POST)
	public @ResponseBody Map<String, Object> trgterExamDrawKindsList(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> examItemNM 		  = trgterExamLResultDtlsService.examItemNm(param);
		List<Map<String, Object>> examItemCdDtlsNm    = trgterExamLResultDtlsService.examItemCdDtlsNm(param);
		rsMap.put("examItemNm", examItemNM);
		rsMap.put("examItemCdDtlsNm", examItemCdDtlsNm);
		return rsMap;		
	}
	
}
