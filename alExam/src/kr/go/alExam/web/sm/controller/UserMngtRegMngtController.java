package kr.go.alExam.web.sm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.web.sm.service.UserMngtRegMngtService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Class Name : UserMngtRegMngtController.java
 * @Description : 관리자 WEB에서 사용하는 관리자 정보및 기관을 등록 관리하는 컨트롤러 Class
 * @Modification Information
 * @
 * @	수정일			수정자		수정내용
 * @	----------		----		---------------------------
 * @	2020.05.07		양현우 		최초생성
 * @author theJoin
 * @since 2020.05.07
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */


@Controller
@RequestMapping(value="/sm")
public class UserMngtRegMngtController extends DMultiActionController{

	@Resource(name ="web.sm.UserMngtRegMngtService")
	private UserMngtRegMngtService userMngtRegMngtService;
	
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
	@RequestMapping(value = "/userMngtRegMngt.do") 
	public String userMngtRegMngt(@ModelAttribute Map param, ModelMap model) throws Exception {
		return "web/sm/userMngtRegMngt";
	}
	
	/**
	 * 기관/사용자관리 리스트 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/userMngtRegMngtList.do",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> userMngtRegMngtList(@ModelAttribute Map<String, Object> param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rsList = userMngtRegMngtService.userMngtRegMngtList(param);
		rsMap.put("rsList", rsList);
		return rsMap;
	}
	
	/**
	 * 기관 클릭시 사용자 목록 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/orgMngtUserRegList.do",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> orgMngtUserRegList(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rsList = userMngtRegMngtService.orgMngtUserRegList(param);
		rsMap.put("rsList", rsList);
		return rsMap;
	}
	
	/**
	 * 기관 수정 
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value ="/userMngtRegMngtRegUpd.do")
	public @ResponseBody int userMngtRegMngtRegUpd(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		int rsInt = 0;
		rsInt = userMngtRegMngtService.userMngtRegMngtRegUpd(param);
		return rsInt;
	}
	
	/**
	 * 기관명 중복 체크
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/selectOrgRegChk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectOrgRegChk(@ModelAttribute Map param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		Map<String, String> OrgRegChk = userMngtRegMngtService.selectOrgRegChk(param);
		rsMap.put("OrgRegChk", OrgRegChk);
		return rsMap;
	}
	
	/**
	 * 기관 등록
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value ="/userMngtRegMngtRegInsert.do")
	public @ResponseBody int userMngtRegMngtRegInsert(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		int rsInt = 0;
		rsInt = userMngtRegMngtService.userMngtRegMngtRegInsert(param);
		return rsInt;
	}
	/**
	 *  사용자 신규 등록 및 정보 변경 팝업
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/userRegInfoChgPop.do")
	public String userRegInfoChg(@ModelAttribute Map param, ModelMap model) throws Exception {
		return "web/sm/userRegInfoChgPop";
	}
	
	/**
	 *  사용자 정보  조회 
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/userInfoSelect.do")
	public @ResponseBody Map<String, Object>userInfoSelect(@ModelAttribute Map<String, Object> param,ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		Map<String, Object> rsList = userMngtRegMngtService.userInfoSelect(param);
		rsMap.put("rsList", rsList);
		return rsMap;
	}
	
	/**
	 * 기관 등록
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value ="/UserRegUpd.do")
	public @ResponseBody int UserRegUpd(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception{
		int rsInt = 0;
		rsInt = userMngtRegMngtService.UserRegUpd(param);
		return rsInt;
	}
	
	/**
	 * 로그인 ID 중복 확인
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/selectLoginRegChk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectLoginRegChk(@ModelAttribute Map param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		Map<String, Object> LoginRegChk = userMngtRegMngtService.selectLoginRegChk(param);
		rsMap.put("LoginRegChk", LoginRegChk);
		return rsMap;
	}
	
	/**
	 * 사용자 중복 조회
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/selectUserRegChk.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectUserRegChk(@ModelAttribute Map param , ModelMap model) throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();
		Map<String, Object> rsList = userMngtRegMngtService.selectUserRegChk(param);
		rsMap.put("rsList",rsList);
		return rsMap;
	}
	
}
