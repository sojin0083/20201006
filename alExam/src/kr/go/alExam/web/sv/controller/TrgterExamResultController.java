package kr.go.alExam.web.sv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.web.sv.service.TrgterExamResultService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



/**
 * @Class Name : TrgterExamResultController.java
 * @Description : 관리자 WEB에서 사용하는 대상자 검사결과를 관리하는 컨트롤러 Class
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		----		---------------------------
 * @	2020.05.11		양현우 		최초생성
 * @author theJoin
 * @since 2020.05.11
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Controller
@RequestMapping(value="/sv")
public class TrgterExamResultController extends DMultiActionController{
	
	@Resource(name="web.sv.TrgterExamResultService")
	private TrgterExamResultService trgterExamResultService;
	
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception{
		return super.initData(req);
	}
	/**
	 * 검사 결과 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterExamResultList.do")
	public String trgterExamResultList(@ModelAttribute Map param, ModelMap model) throws Exception{
		return "web/sv/trgterExamResult";
	}
	
	/**
	 * 검사 결과 대상자 정보 리스트 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/trgterResultList.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> trgterResultList(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rsList = trgterExamResultService.trgterResultList(param);
		rsMap.put("rsList", rsList);
		return rsMap;
	}
}
