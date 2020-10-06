package kr.go.alExam.web.sv.controller;

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
import kr.go.alExam.common.util.StringUtil;
import kr.go.alExam.web.sv.service.ReqExamMngtService;
import kr.go.alExam.web.tg.service.TrgterInfoMngtService;

/**
 * @Class Name : ReqExamMngtController.java
 * @Description : 검사의뢰관리
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ ---------- ---- --------------------------- @ 2020.05.12
 *   정준호 최초생성
 *
 * @author Thejoin
 * @since 2020.05.12
 * @version 1.0
 * @see
 *
 */

@Controller
@RequestMapping(value = "/sv")
public class ReqExamMngtController extends DMultiActionController {
	@ModelAttribute
	public Map initData(HttpServletRequest req) throws Exception {
		return super.initData(req);
	}

	@Resource(name = "web.sv.ReqExamMngtService")
	private ReqExamMngtService reqExamMngtService;

	/**
	 * 검사의뢰 페이지 호출
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/reqExamPage.do", method = RequestMethod.GET)
	public String reqExam(@ModelAttribute Map param, ModelMap model) throws Exception {

		return "web/sv/reqExam";
	}

	/**
	 * 검사의뢰리스트 검색
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/reqExamList.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> trgterList(@ModelAttribute Map<String, Object> param, ModelMap model)
			throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();

		List<Map<String, String>> rsList = reqExamMngtService.reqExamList(param);
		rsMap.put("rsList", rsList);

		return rsMap;
	}

	/**
	 * 검사의뢰 상세 페이지 호출
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/reqExamDetailPage.do", method = RequestMethod.POST)
	public String reqExamDetailPage(@ModelAttribute Map param, ModelMap model) throws Exception {
		model.addAttribute("R_NUMBER", param.get("R_NUMBER"));

		return "web/sv/reqExamDetail";
	}

	/**
	 * 검사의뢰 상세 내역 (대상자정보/검사의뢰내역/대상자검사이력) 호출
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/reqExamSet.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reqExamSet(@ModelAttribute Map<String, Object> param, ModelMap model)
			throws Exception {
		Map<String, Object> rsMap = new HashMap<String, Object>();

		// 대상자정보
		Map<String, String> rsInfo = reqExamMngtService.trgterInfo(param);
		// 검사의뢰내역
		List<Map<String, String>> rsVal = reqExamMngtService.reqExamInfo(param);
		// 검사 횟수
		Map<String, String> rsCnt = reqExamMngtService.cntExam(param);
		// 대상자검사이력
		List<Map<String, String>> rsList = reqExamMngtService.ExamRecList(param);

		rsMap.put("rsInfo", rsInfo);
		rsMap.put("rsVal", rsVal);
		rsMap.put("rsCnt", rsCnt);
		rsMap.put("rsList", rsList);

		return rsMap;
	}

	/**
	 * 검사의뢰 취소 (데이터 삭제)
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteExam.do", method = RequestMethod.POST)
	public @ResponseBody int deleteExam(@ModelAttribute Map<String, Object> param, ModelMap model) throws Exception {
		int rsInt = 0;
		rsInt = reqExamMngtService.deleteExam(param);
		return rsInt;
	}

}