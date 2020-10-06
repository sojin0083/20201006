package kr.go.alExam.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.common.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * @Class Name : CommonController.java
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
@RequestMapping(value = "/cmmn")
public class CommonController extends DMultiActionController{ 

	@ModelAttribute
	public Map<String,Object> initData(HttpServletRequest req) throws Exception{
		return super.initData(req);
	}

	/**
	 * js, css import 페이지 호출
	 * @param clientMode
	 * @return rtnUrl
	 * @throws Exception 
	 */
	@RequestMapping( value="/importResourceFile.do")
	public String importResourceFile(@ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		String rtnUrl = "web/include/importResource";
		model.addAllAttributes(param);
		return rtnUrl;
	}	

	/**
	 * 공통코드 조회
	 * @param codeId
	 * @return rsList
	 * @throws Exception 
	 */
	@RequestMapping( value="/selectCmmnCd.do")
	public @ResponseBody List<Map<String,String>> selectCmmnCd(@ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		
		System.out.println("controller");
		
		List<Map<String,String>> rsList = cmmnService.selectCmmnCd(param);
		
		return rsList;
	}	

	/**
	 * 메뉴 조회
	 * @param sysMode
	 * @return rsList
	 * @throws Exception 
	 */
	@RequestMapping( value="/selectCmmnMenu.do" ,method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> selectCmmnMenu(@ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		
		Map<String,Object> rsMap = new HashMap<String,Object>();
		List<Map<String,String>> rsList = cmmnService.selectCmmnMenu(param);
		rsMap.put("rsList", rsList);
		return rsMap;
	}
	
	/**
	 * 메뉴 화면 조회
	 * @param sysMode
	 * @return rsList
	 * @throws Exception 
	 */
	@RequestMapping( value="/makeMenuList.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String makeMenuList(@ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		
		List<Map<String,String>> rsList = cmmnService.selectCmmnMenu(param);
		model.addAttribute("menuList", rsList);
		return "web/include/leftMenu";
	}
	
	@RequestMapping( value="/pageViewer.do")
	public String pageViewer(@ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		String url = StringUtil.nvl(String.valueOf(param.get("PAGE_URL")));
		url = url.replaceAll(",", "&");
		param.put("PAGE_URL",url);
		model.addAllAttributes(param);
		return "web/cm/pageViewer";
	}

}
