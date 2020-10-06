package kr.go.alExam.common;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.go.alExam.common.util.CookieUtil;
import kr.go.alExam.common.util.StringUtil;

public class DCookieUtil extends CookieUtil{  

	public List<Map<String,Object>> getMySearchList() throws Exception{ 
		
		StringUtil sUtil = new StringUtil();
		List<Map<String,Object>> rsList = new ArrayList<Map<String,Object>>();

		if (cookies != null) {
			for (int i = cookies.length-1 ; i >= 0 ; i--) {               
				if(cookies[i].getValue().indexOf("SEARCHKIND") != -1 && cookies[i].getValue().indexOf("SEARCHWORD") != -1){       
					Map rsMap = new HashMap<String,Object>();
					rsMap.put("keyNm", URLDecoder.decode(cookies[i].getName(), "UTF-8"));             
					rsMap.put("keyVal", URLDecoder.decode(cookies[i].getValue(), "UTF-8"));                               
					
					rsList.add(rsMap);
				}				
			}
		}
		return rsList;  
	}

}
