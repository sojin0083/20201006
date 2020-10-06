package kr.go.alExam.web.sv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.web.sv.service.TrgterExamLResultInsertService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Class Name : TrgterExamResultInsertController.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과입력상세를 관리하는 컨트롤러 Class
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		----		---------------------------
 * @	2020.08.14		박소진 		최초생성
 * @author OpenlinkSystem
 * @since 2020.08.14
 * @version 1.0
 * @see
 *
 */

@Controller
@RequestMapping(value="/sv")
public class TrgterExamLResultInsertController extends DMultiActionController{

	@Resource(name ="web.sv.TrgterExamLResultInsertService")
	private TrgterExamLResultInsertService trgterExamLResultInsertService;
	
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
	@RequestMapping(value="/trgterExamLReportResultInsertPage.do")
	public String  trgterExamResultInsert(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> userInfo  	 			  = trgterExamLResultInsertService.selectUserInfo(param);
		Map<String, Object> examCount 	 			  = trgterExamLResultInsertService.userExamCount(param);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("examCount", examCount);
		model.addAttribute("EXAM_NO", param.get("EXAM_NO"));
		model.addAttribute("R_NUMBER", param.get("R_NUMBER"));
		model.addAttribute("EXAM_SN", param.get("EXAM_SN"));
		model.addAttribute("EXAM_DIV", param.get("EXAM_DIV"));
		return "web/sv/trgterExamLReportResultInsert";
	}
	
	/**
	 * 검사 결과 상세 포인트 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */

	@RequestMapping(value="/trgterExamLResultInsertPoint.do")
	public @ResponseBody Map<String, Object> trgterExamLResultInsertPoint(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rsList			  = trgterExamLResultInsertService.examItemCdDtlsPoint(param);
		List<Map<String, Object>> examTotScore  	  = trgterExamLResultInsertService.examTotScore(param);
		List<Map<String, Object>> userExamInfo 		  = trgterExamLResultInsertService.userExamInfo(param);
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
	@RequestMapping(value="/trgterExamResultHistList.do")
	public @ResponseBody Map<String, Object> trgterExamResultHistList(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rsList= trgterExamLResultInsertService.examHistList(param);
		rsMap.put("rsList", rsList);
		return rsMap;		
	}
	
	/**
	 * 검사결과  이름 및 코드 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamDrawKindsListResult.do", method= RequestMethod.POST)
	public @ResponseBody Map<String, Object> trgterExamDrawKindsListResult(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> examItemNM 		  = trgterExamLResultInsertService.examItemNm(param);
		List<Map<String, Object>> examItemCdDtlsNm    = trgterExamLResultInsertService.examItemCdDtlsNm(param);
		rsMap.put("examItemNm", examItemNM);
		rsMap.put("examItemCdDtlsNm", examItemCdDtlsNm);
		return rsMap;		
	}
	
	/**
	 * 검사 결과 상세 입력
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterExamResultPointInsert.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> trgterExamResultPointInsert(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		int rsInt = trgterExamLResultInsertService.trgterExamResultPointInsert(param);
		rsMap.put("rsInt", rsInt);
		return rsMap;
	}
	
	// 진행상태 변경
	@RequestMapping(value = "/sttsChange.do", method = RequestMethod.POST)
	public @ResponseBody int sttsChange(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		int rsInt = 0;
		rsInt = trgterExamLResultInsertService.sttsChange(param);
		return rsInt;
	}
}