package kr.go.alExam.web.cm.controller;

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

@Controller
@RequestMapping("/")
public class PageNaviController extends DMultiActionController{ 
//	@Resource(name="common.cmmnService")
//	private CommonService cmmnService;

	@ModelAttribute
	public Map<String,Object> initData(HttpServletRequest req) throws Exception{
		return super.initData(req);
	}

	//웹페이지 시작점
	@RequestMapping( value="/pageNavi.do")
	public String pageNavi(HttpServletRequest req, @ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{
//		List<Map<String,Object>> rsList = mainService.getList(param);   
//		model.addAttribute("rsList", rsList);	
		List<Map<String,String>> menuList = cmmnService.selectCmmnMenu(param);
		model.addAttribute("menuList", menuList);
		
		if(param.get("menuCd") == null){//최초 로그인 페이지 처리
			if(param.get("SESS_AUTH_CD").toString().equals("HLTH001")){//슈퍼관리자
				param.put("menuCd", "NSM100");
			}else{
				param.put("menuCd", "NTG100");
			}
		}
		
		Map<String,String> menuInfo = cmmnService.selectCmmnMenuInfo(param);
		String menuUrl = (String) param.get("MENU_URL");
		
		if(menuUrl != null && !"".equals(menuUrl)){
			menuInfo.put("MENU_URL", menuUrl);
		}
		model.addAttribute("menuInfo", menuInfo);


		return "web/pageNavi";   
	}	
	
	//웹페이지 시작점
	@RequestMapping( value="/pageNaviDtls.do", method= RequestMethod.POST)
	public String pageNaviDtls(@ModelAttribute Map<String,Object> param, ModelMap model) throws Exception{

		model.addAllAttributes(param);

		List<Map<String,String>> menuList = cmmnService.selectCmmnMenu(param);
		model.addAttribute("menuList", menuList);
		
		String menuCd = (String) param.get("menuCd");
		model.addAttribute("topMenuCd", getTopMenuCd(menuCd,menuList));
		
		String menuUrl = StringUtil.nvl(String.valueOf(param.get("DTLS_MENU_URL")));
		Map<String,String> menuInfo = cmmnService.selectCmmnMenuInfo(param);
		if(!"".equals(menuUrl)) menuInfo.put("MENU_URL", menuUrl);
		model.addAttribute("menuInfo", menuInfo);
		
		return "web/pageNavi";
	}	
	
	private String getTopMenuCd(String target, List<Map<String,String>> menuList) {
		
		if (menuList == null) return "";
		if (target == null) return "";
		
		String upperMenuCd = "";
		String menuLvl = "";
		for (int i = 0; i < menuList.size(); i++) {
			if (target.equals(menuList.get(i).get("MENU_CD"))) {
				upperMenuCd = menuList.get(i).get("UPPER_MENU_CD");
				menuLvl = String.valueOf(menuList.get(i).get("MENU_LVL"));
				break;
			}
		}
		
		if ("3".equals(menuLvl)) {
			for (int i = 0; i < menuList.size(); i++) {
				if (upperMenuCd.equals(menuList.get(i).get("MENU_CD"))) {
					upperMenuCd = menuList.get(i).get("UPPER_MENU_CD");
					menuLvl = String.valueOf(menuList.get(i).get("MENU_LVL"));
					break;
				}
			}
		} else if ("1".equals(menuLvl)) {
			upperMenuCd = target;
		}
		
		return upperMenuCd;
	}

}
