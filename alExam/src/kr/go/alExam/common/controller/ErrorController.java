package kr.go.alExam.common.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @Class Name : ErrorController.java
 * @Description : 모바일 헬스케어에서 사용하는 통합공통업무를 관리하는 컨트롤러 Class
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2016.06.27		윤봉훈			최초생성
 *
 * @author gst
 * @since 2016.06.27
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Controller
@RequestMapping(value = "/cmmn/error")
public class ErrorController extends DMultiActionController{ 

	
	@ModelAttribute
	public Map<String,Object> initData(HttpServletRequest req) throws Exception{
		return super.initData(req);
	}
	
	@RequestMapping( value="/throwable" )
	public String throwable(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("throwable");
		
		pageErrorLog(request);

		model.addAttribute("err_title", "throwable");
		model.addAttribute("err_msg", "예외가 발생하였습니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/exception" )
	public String exception(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("exception");
		
		pageErrorLog(request);

		model.addAttribute("err_title", "exception");
		model.addAttribute("err_msg", "예외가 발생하였습니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/servletexception" )
	public String servletexception(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("servletexception");
		
		pageErrorLog(request);
		
		model.addAttribute("err_title", "servletexception");
		model.addAttribute("err_msg", "지정된 파일을 찾을 수가 없습니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/400" )
	public String pageError400(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("page error code 400");
		
		pageErrorLog(request);

		model.addAttribute("err_title", "400 에러");
		model.addAttribute("err_msg", "잘못된 요청입니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/403" )
	public String pageError403(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("page error code 403");
		
		pageErrorLog(request);

		model.addAttribute("err_title", "403 에러");
		model.addAttribute("err_msg", "접근이 금지되었습니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/404" )
	public String pageError404(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("page error code 404");
		
		pageErrorLog(request);

		model.addAttribute("err_title", "404 에러");
		model.addAttribute("err_msg", "요청하신 페이지는 존재하지 않습니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/405" )
	public String pageError405(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("page error code 405");
		
		pageErrorLog(request);

		model.addAttribute("err_title", "405 에러");
		model.addAttribute("err_msg", "요청된 메소드가 허용되지 않습니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/500" )
	public String pageError500(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("page error code 500");
		
		pageErrorLog(request);
		
		model.addAttribute("err_title", "500 에러");
		model.addAttribute("err_msg", "서버에 오류가 발생하였습니다.");
		return "common/error";
	}
	
	@RequestMapping( value="/503" )
	public String pageError503(@ModelAttribute Map<String,Object> param, HttpServletRequest request, ModelMap model) throws Exception{
		LOG.info("page error code 503");
		
		pageErrorLog(request);

		model.addAttribute("err_title", "503 에러");
		model.addAttribute("err_msg", "서비스를 사용할 수 없습니다.");
		return "common/error";
	}
	
	private void pageErrorLog(HttpServletRequest request) {
		LOG.info("status_code    :: "+ request.getAttribute("javax.servlet.error.status_code"));
		LOG.info("exception_type :: "+ request.getAttribute("javax.servlet.error.exception_type"));
		LOG.info("message        :: "+ request.getAttribute("javax.servlet.error.message"));
		LOG.info("request_uri    :: "+ request.getAttribute("javax.servlet.error.request_uri"));
		LOG.info("exception      :: "+ request.getAttribute("javax.servlet.error.exception"));
		LOG.info("servlet_name   :: "+ request.getAttribute("javax.servlet.error.servlet_name"));
	}
	
}
