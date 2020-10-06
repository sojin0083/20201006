package kr.go.alExam.common.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.go.alExam.common.DMultiActionController;
import kr.go.alExam.common.LoginManager;
import kr.go.alExam.common.service.LoginService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Class Name : LoginController.java
 * @Description : 사용자 로그인 체크
 * @Modification Information
 * @
 * @	수정일				수정자			수정내용
 * @	----------		----		---------------------------
 * @	2020.05.07		오샘이			최초생성
 *
 * @author TheJoin
 * @since 2020.05.07
 * @version 1.0
 * @see
 *
 *  Copyright (C) by Mobile Health Care All right reserved.
 */

@Controller
@RequestMapping(value="/login")
public class LoginController extends DMultiActionController{ 
	@Resource(name="common.loginService")
	private LoginService loginService;
	
	//login session
	LoginManager loginManager = LoginManager.getInstance();
	
	@ModelAttribute
	public Map<String,Object> initData(HttpServletRequest req) throws Exception{
		return super.initData(req);
	}
	
	/**
	 * 로그인 페이지
	 * @param param 검색 조건
	 * @return 검색된 ROW 
	 * @throws Exception 
	 */
	@RequestMapping( value="/login.do", method = RequestMethod.GET)
	public String login(HttpServletRequest req, @ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		String rtnPage = "web/cm/login";
		
		String userId = req.getSession().getAttribute("SESS_USER_ID")==null?"":(String)req.getSession().getAttribute("SESS_USER_ID");
		String loginIp = loginManager.getUserIp(req.getSession());
		if(!"".equals(userId)){
			loginManager.removeSession(userId, req.getSession());
		}
		//2016-08-24 윤봉훈 - 다시 로그인 시 이전 데이터가 세션에 남아있는 현상 방지를 위한 세션 초기화
		req.getSession().invalidate();
		if(loginIp!=null && !"".equals(loginIp) && !loginIp.isEmpty())req.getSession(true).setAttribute("msg", loginIp+"에서 로그인 되어 해당 세션이 종료되었습니다.");

		return rtnPage;
	}	
	
	/**
	 * 로그인 정보 체크
	 * @param param 검색 조건
	 * @return 검색된 ROW 
	 * @throws Exception 
	 */
	@RequestMapping( value="/loginInfoChk.do", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> selectLoginInfoChk(HttpServletRequest req, @ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		String sessGb = "N";

		Map<String,Object>	rsMap		= loginService.selectLoginInfoChk(param);
		
		if("true".equals(rsMap.get("isLogin"))){		
			sessGb = "Y";
		}else{
			model.addAttribute("msg", getMsg(String.valueOf(rsMap.get("rtnMsgCode"))));
		}

			
		model.addAttribute("msg", getMsg(String.valueOf(rsMap.get("rtnMsgCode"))));
		model.addAttribute("sessGb", sessGb);
		model.addAttribute("rsMap", rsMap);

		
		return model;
	}	
		
	

	/**
	 * 로그아웃
	 * @param param 검색 조건
	 * @return 검색된 ROW 
	 * @throws Exception 
	 */
	@RequestMapping( value="/loginOut.do", method = RequestMethod.GET)
	public String loginOut(HttpServletRequest req, @ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		
//		String viewGbn = (String)param.get("SESS_ISMOBILE");
		String viewGbn = (String)param.get("SESS_USER_ID");
		req.getSession().invalidate();
//		req.getSession(true).setAttribute("SESS_ISMOBILE", viewGbn);
		req.getSession(true).setAttribute("SESS_USER_ID", viewGbn);
//		String rtnPage = ;
		return "redirect:/";
	}	
	
	/**
	 * 로그인 사용자 정보 조회
	 * @param param 검색 조건
	 * @return 검색된 ROW 
	 * @throws Exception 
	 */
	@RequestMapping( value="/loginUserInfo.do", method = RequestMethod.POST)
	public String selectLoginUserInfo(HttpServletRequest req, @ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		Map<String,Object>	rsMap		= loginService.selectLoginUserInfo(param)	;
		Map<String,String> sessMap		= (Map<String, String>) rsMap.get("rsMap");
	
		setSessionInfo(req, req.getSession(), sessMap);
		
		return "redirect:/pageNavi.do";
	}
	
	/**
	 * index.jsp에서 호출하며 메인 대시보드 화면 호출
	 * @param param 검색 조건
	 * @return 검색된 ROW 
	 * @throws Exception 
	 */
	@RequestMapping( value="/loginPage.do", method = RequestMethod.GET)
	public String loginPage(HttpServletRequest req, @ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
		String rtnPage = "web/cm/login";
		String userId = req.getSession().getAttribute("SESS_USER_ID")==null?"":(String)req.getSession().getAttribute("SESS_USER_ID");
		String loginIp = loginManager.getUserIp(req.getSession());
		if(!"".equals(userId)){
			loginManager.removeSession(userId, req.getSession());
		}
		//2016-08-24 윤봉훈 - 다시 로그인 시 이전 데이터가 세션에 남아있는 현상 방지를 위한 세션 초기화
		req.getSession().invalidate();
		if(loginIp!=null && !"".equals(loginIp) && !loginIp.isEmpty())req.getSession(true).setAttribute("msg", loginIp+"에서 로그인 되어 해당 세션이 종료되었습니다.");

		return rtnPage;
	}	

}
