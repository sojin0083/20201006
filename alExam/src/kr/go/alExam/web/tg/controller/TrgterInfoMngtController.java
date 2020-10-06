package kr.go.alExam.web.tg.controller;

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
import kr.go.alExam.web.tg.service.TrgterInfoMngtService;
import kr.go.alExam.common.util.StringUtil;


/**
 * @Class Name : TargetManagementController.java
 * @Description : 대상자관리
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.07		정준호			최초생성
 *
 * @author Thejoin
 * @since 2020.05.07
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Controller
@RequestMapping(value = "/tg") 
public class TrgterInfoMngtController extends DMultiActionController{
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception {
		return super.initData(req);
	}
	
	@Resource(name = "web.tg.TrgterInfoMngtService")
	private TrgterInfoMngtService trgterInfoMngtService;

	
	/**
	 * 대상자관리 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterMngt.do", method = RequestMethod.GET) 
	public String trgterMngt(@ModelAttribute Map param, ModelMap model) throws Exception {

		return "web/tg/trgterMngt";
	}
	
	/**
	 * 대상자리스트 검색
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterList.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> trgterList( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		
		List<Map<String, String>> rsList = trgterInfoMngtService.trgterList(param);
		rsMap.put("rsList", rsList);
		
		return rsMap;
	}

	/**
	 * 신규대상자 등록 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/regTrgterInfoPage.do", method = RequestMethod.GET) 
	public String regTrgterInfoPage(@ModelAttribute Map param, ModelMap model) throws Exception {

		return "web/tg/regTrgterInfo";
	}
	
	/**
	 * 신규대상자 등록
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/regTrgterInfo.do", method = RequestMethod.POST) 
	public @ResponseBody int regTrgterInfo(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		int rsInt = 0;
		rsInt = trgterInfoMngtService.regTrgterInfo(param);
		return rsInt;
	}
	
	/**
	 * 대상자정보 페이지 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/modTrgterInfoPage.do", method = RequestMethod.GET) 
	public String modTrgterInfoPage(@ModelAttribute Map param, ModelMap model) throws Exception {
		model.addAttribute("R_NUMBER", param.get("R_NUMBER"));
		
		return "web/tg/modTrgterInfo";
	}
	
	/**
	 * 대상자 정보&검사이력조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/trgterInfoSet.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> trgterInfoSet( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		
		//대상자정보
		Map<String, String> rsInfo = trgterInfoMngtService.trgterInfoSet(param);
		
		rsMap.put("rsInfo", rsInfo);
		
		return rsMap;
	}
	
	/**
	 * 대상자정보 수정
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/modTrgterInfo.do", method = RequestMethod.POST) 
	public String modTrgterInfo(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		trgterInfoMngtService.modTrgterInfo(param);
		
		return "redirect:../tg/trgterMngt.do";
	}
	
	/**
	 * 검사의뢰 팝업 호출
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/reqExamPopup.do")
	public String reqExamPopup(@ModelAttribute Map param, ModelMap model) throws Exception {
		
		return "web/tg/reqExamPopup";
	}
	
	/**
	 * 검사의뢰
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/reqExam.do", method = RequestMethod.POST) 
	public String reqExam(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		String trgterInfo = StringUtil.nvl((String)param.get("RNUMS"));
		param.put("trgterInfoList", StringUtil.makeStringToIterator(trgterInfo));
		
		trgterInfoMngtService.reqExam(param);
				
		return "redirect:../sv/reqExamPage.do";
	}
	
	/**
	 * 검사의뢰 검사자정보 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/selectInsExamInfo.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> selectInsExamInfo( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		
		List<Map<String, String>> rsList = trgterInfoMngtService.selectInsExamInfo(param);
		rsMap.put("rsList", rsList);
		
		return rsMap;
	}
	
	/**
	 * 검사의뢰 검사자정보 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/modTrgterNumChk.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> modTrgterNumChk( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		
		Map<String, String> rsChk = trgterInfoMngtService.modTrgterNumChk(param);
		rsMap.put("rsChk", rsChk);
		
		return rsMap;
	}
	
	/**
	 * 신규등록시 차트 기본값 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value = "/getCNum.do", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> getCNum( @ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();
		
		Map<String, String> rsNum = trgterInfoMngtService.getCNum(param);
		rsMap.put("rsNum", rsNum);
		
		return rsMap;
	}
}
