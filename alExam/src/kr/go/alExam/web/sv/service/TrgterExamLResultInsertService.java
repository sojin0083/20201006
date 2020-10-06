package kr.go.alExam.web.sv.service;

import java.util.List;
import java.util.Map;

public interface TrgterExamLResultInsertService {
	
	public List<Map<String,Object>> userExamInfo(Map<String, Object> param) throws Exception;
	
	public List<Map<String,Object>> examItemNm(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examTotScore(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examItemCdDtlsNm(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examItemCdDtlsPoint(Map<String, Object> param ) throws Exception;
	
	public List<Map<String, Object>> examHistList(Map<String, Object> param ) throws Exception;
	
	public Map<String, Object> selectUserInfo(Map<String, Object> param) throws Exception; 
	
	public Map<String, Object> userExamCount(Map<String, Object> param) throws Exception;
	
	public int trgterExamResultPointInsert(Map<String, Object> param) throws Exception;

	int sttsChange(Map<String, Object> param) throws Exception;
}
