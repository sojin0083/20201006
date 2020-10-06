package kr.go.alExam.common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.go.alExam.common.service.CommonService;
import kr.go.alExam.common.util.AddTag;
import kr.go.alExam.common.util.FileUtil;
import kr.go.alExam.common.util.PaginationUtil;
import kr.go.alExam.common.util.PushMessageUtil;
import kr.go.alExam.common.util.StringUtil;

import org.apache.log4j.Logger;

public abstract class DMultiActionController{
	
	protected final  Logger LOG = Logger.getLogger(this.getClass()); 
	protected String MESSAGE_NAME = "cmmnMsg";

	@Resource(name="common.cmmnService")
	protected CommonService cmmnService;

	@Resource(name = "msg") 
	private DMessage msg;   
	
	@Resource(name = "pagination")
	protected PaginationUtil pagination;
	
	@Resource(name = "pagination2")
	protected PaginationUtil pagination2;   
	
	@Resource(name = "cookieUtil")
	protected DCookieUtil cookieUtil;    


	protected AddTag addTag;
	
	LoginManager loginManager = LoginManager.getInstance();
	
	public Map<String,Object> initData(HttpServletRequest req) throws Exception{
		addTag = new AddTag(req.getParameterMap());  
		cookieUtil.setCookies(req); 
		String name = "";
	    Map<String,Object> result = new HashMap<String,Object>(); 
		for(Enumeration names = req.getParameterNames(); names.hasMoreElements(); ){          
    		name = (String)names.nextElement();
    		if(req.getParameterValues(name).length>1 || name.indexOf("arr_")>-1){ 
    			result.put(name,req.getParameterValues(name));  
    		}else{
    			result.put(name,req.getParameter(name));       
    		} 	          		 
 	    } 
		result.putAll(getSessionInfo(req));
		LOG.info("requestMap::"+result);

		return result;  
	}
	
	
	
	public String getMsg(String code){
		return msg.getMsg(code);
	}
	
	public String getMsg(String code, Object[] args){ 
		return msg.getMsg(code, args);    
	}
	
	public String getLogMsg(String code){
		return msg.getLogMsg(code);    
	}
	
	public void setSessionInfo(HttpServletRequest req, HttpSession session, Map<String,String> param){
		
		if(!"".equals(param.get("USER_ID"))){
			//현재 세션 저장
			session.setAttribute(param.get("USER_ID"), loginManager);
			String sessGb = req.getParameter("sessGb").toString();
			if("DY".equals(sessGb)){//기존 세션 삭제
				loginManager.setLoginMapping(param.get("USER_ID"), req, session);
			}
			
			for(String name: param.keySet()){
				session.setAttribute("SESS_"+name, param.get(name));
			}
		}
	}
	
	public Map<String,Object> getSessionInfo(HttpServletRequest req){
		Map<String,Object> sessMap = new HashMap<String,Object>();
		HttpSession session = req.getSession();		
		String userId = StringUtil.nvl(String.valueOf(session.getAttribute("SESS_USER_ID")));
		if(!"".equals(userId)){
			sessMap.put("SESS_USER_ID",			StringUtil.nvl(String.valueOf(session.getAttribute("SESS_USER_ID"))));
			sessMap.put("SESS_USER_NM",			StringUtil.nvl(String.valueOf(session.getAttribute("SESS_USER_NM"))));
			sessMap.put("SESS_GENDER",				StringUtil.nvl(String.valueOf(session.getAttribute("SESS_GENDER"))));
			sessMap.put("SESS_ORG_CD",			StringUtil.nvl(String.valueOf(session.getAttribute("SESS_ORG_CD"))));
			sessMap.put("SESS_ORG_NM",			StringUtil.nvl(String.valueOf(session.getAttribute("SESS_ORG_NM"))));		
			
			sessMap.put("SESS_AUTH_CD",			StringUtil.nvl(String.valueOf(session.getAttribute("SESS_AUTH_CD"))));
			sessMap.put("SESS_ORG_PART",			StringUtil.nvl(String.valueOf(session.getAttribute("SESS_ORG_PART"))));
			sessMap.put("SESS_ORG_PART_NM",	StringUtil.nvl(String.valueOf(session.getAttribute("SESS_ORG_PART_NM"))));
			sessMap.put("SESS_JOB_CLF",			StringUtil.nvl(String.valueOf(session.getAttribute("SESS_JOB_CLF"))));
			sessMap.put("SESS_JOB_CLF_NM",		StringUtil.nvl(String.valueOf(session.getAttribute("SESS_JOB_CLF_NM"))));	
			
		}
		return sessMap;
	}
	
	
	public List getArrayParamToList(Map param){
		
		Map<String, Object> rtMap = new HashMap<String, Object>();
		Iterator<String> keySet = param.keySet().iterator();
		String key = "";
		int rowCnt = param.get("rowCnt")!=null?Integer.parseInt(param.get("rowCnt").toString()):0;
		List dataList = new ArrayList();
		
		List<String> keyArr = new ArrayList();
		for(; keySet.hasNext();){
			keyArr.add(keySet.next());
		}
		
		for(int i=0; i<rowCnt; i++){
			Map data = new HashMap();
			for(int j=0; j<keyArr.size(); j++){
				key = keyArr.get(j);
				if (param.get(key) instanceof String[]){
					data.put(key, ((String[])param.get(key))[i]);
				}else{
					data.put(key, param.get(key));
				}
			}
			dataList.add(data);
		}
		
		return dataList;
	}	
}
