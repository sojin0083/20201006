package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;

public interface TrgterExamLResultDtlsService {
	
	public Map<String, Object> selectUserInfoDtls(Map<String, Object> param) throws Exception; 
	
	public Map<String, Object> userExamCount(Map<String, Object> param) throws Exception;
	
	public List<Map<String,Object>> userExamInfo(Map<String, Object> param) throws Exception;
	
	public List<Map<String,Object>> examItemNm(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examTotScore(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examItemCdDtlsNm(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examItemCdDtlsPoint(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examHistList(Map<String, Object> param ) throws Exception;
	
	public int trgterExamPointUpd(Map<String, Object> param) throws Exception;
}
