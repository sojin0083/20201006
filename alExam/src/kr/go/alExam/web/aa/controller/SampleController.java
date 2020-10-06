package kr.go.alExam.web.aa.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @Class Name : SampleController.java
 * @Description : 치매진단 시스템 업무에서 사용하는 통합공통업무를 관리하는 컨트롤러 Class
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.07		오샘이		최초생성
 *
 * @author TheJoin
 * @since 2020.05.07
 * @version 1.0
 * @see
 *
 *  Copyright (C) by TheJoin All right reserved.
 *  
 */

@Controller
@RequestMapping(value="/aa")
public class SampleController extends DMultiActionController{
	
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception{
		return super.initData(req);
	}
	
	/**
	 * 기관/사용자관리 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/sample.do") 
	public String sample(@ModelAttribute Map param, ModelMap model) throws Exception {
		return "web/sample/test";
	}
	
	/**
	 * 기관/사용자관리 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/sampleDtls.do") 
	public String sampleDtls(@ModelAttribute Map param, ModelMap model) throws Exception {
		return "web/sample/testDtls";
	}	
	
	/**
	 * 기관/사용자관리 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/samplePopup.do") 
	public String samplePopup(@ModelAttribute Map param, ModelMap model) throws Exception {
		return "web/sample/testPopup";
	}		
}
