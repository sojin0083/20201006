package kr.go.alExam.web.tg.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.go.alExam.web.tg.service.TrgterInfoMngtService;
import kr.go.alExam.web.tg.service.impl.TrgterInfoMngtDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : TrgterInfoMngtServiceImpl.java
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

@Service("web.tg.TrgterInfoMngtService")
public class TrgterInfoMngtServiceImpl extends EgovAbstractServiceImpl implements TrgterInfoMngtService{
	@Resource(name="web.tg.TargetManagementDAO")
	private TrgterInfoMngtDAO trgterInfoMngtDAO;
	
	@Override
	public List<Map<String, String>> trgterList(Map<String, Object> param) throws Exception {
		return trgterInfoMngtDAO.trgterList(param);
	}

	@Override	
	public int regTrgterInfo(Map<String, Object> param) throws Exception{
		return trgterInfoMngtDAO.regTrgterInfo(param);
	}

	@Override
	public Map<String, String> trgterInfoSet(Map<String, Object> param) throws Exception{		
		return trgterInfoMngtDAO.trgterInfoSet(param);
	}
	
	@Override
	public void modTrgterInfo(Map<String, Object> param) throws Exception{		
		trgterInfoMngtDAO.modTrgterInfo(param);
	}

	@Override
	public void reqExam(Map<String, Object> param) throws Exception{		
		trgterInfoMngtDAO.reqExam(param);
	}

	@Override
	public List<Map<String, String>> selectInsExamInfo(Map<String, Object> param) throws Exception{	
		return trgterInfoMngtDAO.selectInsExamInfo(param);
	}

	@Override
	public Map<String, String> modTrgterNumChk(Map<String, Object> param) throws Exception {
		return trgterInfoMngtDAO.modTrgterNumChk(param);
	}

	@Override
	public Map<String, String> getCNum(Map<String, Object> param) throws Exception {
		return trgterInfoMngtDAO.getCNum(param);
	}
	
}
