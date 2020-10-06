package kr.go.alExam.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;

public class PushMessageUtil {

	
//	public static final String API_KEY = "AIzaSyC8zMf7D-jp8xdAlvbzs6ZG-Ec_eWw66Ro";
	public static final String API_KEY = "AAAA_FNtwJc:APA91bENgMFxE82o4EL3aD0-veKLN_2W-xM7PhqyEJ3vBTZwjexiuBhWROKJ_AXYkKfGsM53MHvxZRSjuBq2e7IbxznHV46LVR_FlCYSiu_dIOeV-HJ3jkEv8XfSXlrs6WGfROnPM9yZF4MJnL_snUBpC3wf9OwwKg";
	public static final String USER_LIST = "userInfoList";
	public static final String LINK_PAGE = "/myhealth.do";
	
	public static final String RCVCLF_A = "A";  /* 전체 */
	public static final String RCVCLF_H = "H";  /*보건소 */
	public static final String RCVCLF_I = "I";  /*개인별 */

	public static final String NOTICECLF_A = "A";  /*전체 */
	public static final String NOTICECLF_N = "N";  /*알림 */
	public static final String NOTICECLF_P = "P";  /*푸시 */
	
	public static final String AUTOMANUCLF_M = "M";  /* 수동 */
	public static final String AUTOMANUCLF_A = "A";  /* 자동 */

	public static final int ERR_PUSH_SETVAL = 0;  //푸쉬 메시지 셋팅값 오류 null
	public static final int ERR_PUSH_EXCEPTION = 1;  //푸쉬 메시지 전송 오류
	
	private String sndSn          ;     /* 전송_순번              */
	private String lstDmlDt       ;     /* 최종_수정_일시         */
	private String lstDmlId       ;     /* 최종_수정_ID           */
	private String noticeClf      ;     /* 알림_구분 (SV021)      */
	private String sndOrgCd       ;     /* 전송_기관_코드         */
	private String sndUserId      ;     /* 전송_사용자_ID         */
	private String sndDt          ;     /* 전송_일시              */
	private String sndSttus       ;     /* 전송_상태 (CM004)      */
	private int    sndCnt         ;     /* 전송_건수              */
	private String msgClf         ;     /* 메시지_구분 (SV012)    */
	private String pushTitle      ;     /* 푸시_제목              */
	private String pushCont       ;     /* 푸시_내용              */
	private String noticeTitle    ;     /* 알림_제목              */
	private String noticeCont     ;     /* 알림_내용              */
	private String noticeEndDe    ;     /* 알림_종료일            */
	private String rcvClf         ;     /* 수신_구분 (SV013)      */
	private String reqClf         ;     /* 요청_구분 (CM019)      */
	private String autoManuClf    ;     /* 자동_수동_구분 (SV014) */
	private String pushLinkPage   ;     /* 링크_페이지            */
	private String noticeLinkPage ;     /* 링크_페이지            */
	private String noticeSetNo    ;     /* 알림_설정_번호         */
	private String resrvtDe    ;    	/* 예약_일자         */
	private String resrvtTm    ;     	/* 알림_시간         */
	private String boardSn;				/* 게시물_순번 */
	////
	

	public String getPushLinkPage() {
		return pushLinkPage;
	}
	public void setPushLinkPage(String pushLinkPage) {
		this.pushLinkPage = pushLinkPage;
	}
	public String getNoticeLinkPage() {
		return noticeLinkPage;
	}
	public void setNoticeLinkPage(String noticeLinkPage) {
		this.noticeLinkPage = noticeLinkPage;
	}
	public String getSndSn() {
		return sndSn;
	}
	public String getReqClf() {
		return reqClf;
	}
	public void setReqClf(String reqClf) {
		this.reqClf = reqClf;
	}
	public String getNoticeClf() {
		return noticeClf;
	}
	public void setNoticeClf(String noticeClf) {
		this.noticeClf = noticeClf;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeCont() {
		return noticeCont;
	}
	public void setNoticeCont(String noticeCont) {
		this.noticeCont = noticeCont;
	}
	
	public String getNoticeEndDe() {
		return noticeEndDe;
	}
	public void setNoticeEndDe(String noticeEndDe) {
		this.noticeEndDe = noticeEndDe;
	}
		

	public String getNoticeSetNo() {
		return noticeSetNo;
	}
	public void setNoticeSetNo(String noticeSetNo) {
		this.noticeSetNo = noticeSetNo;
	}
	public void setSndSn(String sndSn) {
		this.sndSn = sndSn;
	}
	public String getLstDmlDt() {
		return lstDmlDt;
	}
	public void setLstDmlDt(String lstDmlDt) {
		this.lstDmlDt = lstDmlDt;
	}
	public String getLstDmlId() {
		return lstDmlId;
	}
	public void setLstDmlId(String lstDmlId) {
		this.lstDmlId = lstDmlId;
	}
	public String getSndOrgCd() {
		return sndOrgCd;
	}
	public void setSndOrgCd(String sndOrgCd) {
		this.sndOrgCd = sndOrgCd;
	}
	public String getSndUserId() {
		return sndUserId;
	}
	public void setSndUserId(String sndUserId) {
		this.sndUserId = sndUserId;
	}
	public String getSndDt() {
		return sndDt;
	}
	public void setSndDt(String sndDt) {
		this.sndDt = sndDt;
	}
	public String getSndSttus() {
		return sndSttus;
	}
	public void setSndSttus(String sndSttus) {
		this.sndSttus = sndSttus;
	}
	public String getMsgClf() {
		return msgClf;
	}
	public void setMsgClf(String msgClf) {
		this.msgClf = msgClf;
	}
	public String getPushTitle() {
		return pushTitle;
	}
	public void setPushTitle(String pushTitle) {
		this.pushTitle = pushTitle;
	}
	public String getPushCont() {
		return pushCont;
	}
	public void setPushCont(String pushCont) {
		this.pushCont = pushCont;
	}
	public String getRcvClf() {
		return rcvClf;
	}
	public void setRcvClf(String rcvClf) {
		this.rcvClf = rcvClf;
	}
	public String getAutoManuClf() {
		return autoManuClf;
	}
	public void setAutoManuClf(String autoManuClf) {
		this.autoManuClf = autoManuClf;
	}

//	20170905 푸시 예약 추가(이태석)
	public String getResrvtDe() {
		return resrvtDe;
	}
	public void setResrvtDe(String resrvtDe) {
		this.resrvtDe = resrvtDe;
	}
	
	public String getResrvtTm() {
		return resrvtTm;
	}
	public void setResrvtTm(String resrvtTm) {
		this.resrvtTm = resrvtTm;
	}
	public String getBoardSn(){
		return boardSn;
	}
	public void setBoardSn(String boardSn){
		this.boardSn = boardSn;
	}
	////
	
	private String[] userId;
	private String[] grpSn;
	private String[] tokens;

	private List<Map<String,Object>> pushInfo;	
	private Map<String,Object> resultMap;	
	private String chkYn;
	private String errorMsg;
	private int errorCode;

	public String[] getUserId() {
		return userId;
	}
	public void setUserId(String[] userId) {
		this.userId = userId;
	}
	public String[] getGrpSn() {
		return grpSn;
	}
	public void setGrpSn(String[] grpSn) {
		this.grpSn = grpSn;
	}
	public String[] getTokens() {
		return tokens;
	}
	public void setToken(String[] tokens) {
		this.tokens = tokens;
	}
	
	
	public String getChkYn() {
		return chkYn;
	}
	public void setChkYn(String chkYn) {
		this.chkYn = chkYn;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public int getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}
	public void setTokens(String[] tokens) {
		this.tokens = tokens;
	}	
	public int getSndCnt() {
		return sndCnt;
	}
	public void setSndCnt(int sndCnt) {
		this.sndCnt = sndCnt;
	}
	
	public Map<String,Object> getResultMap() {
		return resultMap;
	}
	public void setResultMap(Map<String,Object> resultMap) {
		this.resultMap = resultMap;
	}
	
	public List<Map<String,Object>> getPushInfo() {
		return pushInfo;
	}
	public void setPushInfo(List<Map<String,Object>> pushInfo) {
		this.pushInfo = pushInfo;
	}
	public PushMessageUtil(){
		resultMap = new HashMap<String,Object>();
	}
	
	public boolean sendPushMessage(String gubun){
		boolean flag = false;
		if(RCVCLF_A.equals(getRcvClf()) || RCVCLF_H.equals(getRcvClf())){			
			resultMap.clear();			
			String pushId = getPushId();
			setSndSn(pushId);
			
			resultMap.put("sndSn", pushId);
			resultMap.put("lstDmlId", getLstDmlId());
			resultMap.put("sndOrgCd", getSndOrgCd());
			resultMap.put("sndUserId", getSndUserId());
			resultMap.put("pushTitle", getPushTitle());
			resultMap.put("pushCont", getPushCont());

			
			resultMap.put("msgClf", getMsgClf());	
			resultMap.put("rcvClf", getRcvClf());		
			resultMap.put("autoManuClf", getAutoManuClf());
			resultMap.put("sndCnt", 0);
			
//			20170905 푸시 예약 추가(이태석)
			resultMap.put("resrvtDe", getResrvtDe());
			resultMap.put("resrvtTm", getResrvtTm());
			resultMap.put("boardSn", getBoardSn());
			if(!valueCheck()){
				resultMap.put("sndSttus", "F");  //실패
				resultMap.put("errorMsg",getErrorMsg());

			}else{	
				
				try{		

					JSONObject jGcmData = new JSONObject();
			        JSONObject jData = new JSONObject(resultMap);
			        
			        jData.put("title", getPushTitle());
			        jData.put("message", getPushCont());
			        
			        // Where to send GCM message.
			        String to = "";
			        if(RCVCLF_A.equals(getRcvClf())){
			        	to = "/topics/news";
			        }else if(RCVCLF_H.equals(getRcvClf())){
			        	to = "/topics/"+getSndOrgCd();
			        }
			        jGcmData.put("to",to);
			
			        // What to send in GCM message.
			        jGcmData.put("data", jData);	 
			        
			        JSONObject result = setHttpRequest(jGcmData);
			        System.out.println("FCM request =="+jGcmData.toString());
			        System.out.println("FCM result =="+result);

		
					resultMap.put("sndSttus", "S"); //성공				
					flag = true;					
				
				
				}catch(Exception e){
					resultMap.put("sndSttus", "F");  //실패
					resultMap.put("errorCd", ERR_PUSH_EXCEPTION);
					resultMap.put("errorMsg", e.getMessage());
					flag = false;
				}	
			
			}		
			
			System.out.println("resultMap==>"+resultMap );
			
			return flag;
		}else if("I".equals(getRcvClf())){
			sendPushMessage();
		}else{
			flag = false;
			System.out.println("rcvClf not available" );
		}
		
		return flag;
	}
	
//	private boolean sendPushMessage(){
	public boolean sendPushMessage(){
		
		boolean flag = false;
		resultMap.clear();
		
		String pushId = getPushId();
		setSndSn(pushId);
		
		resultMap.put("sndSn", pushId);
//		resultMap.put("lstDmlId", getLstDmlId());
		resultMap.put("lstDmlId", getSndUserId());
		resultMap.put("noticeClf", getNoticeClf());
		resultMap.put("sndOrgCd", getSndOrgCd());
		resultMap.put("sndUserId", getSndUserId());
		resultMap.put("pushTitle", getPushTitle());
		resultMap.put("pushCont", getPushCont());		
		resultMap.put("noticeTitle", getNoticeTitle());
		resultMap.put("noticeCont", getNoticeCont());		
		resultMap.put("noticeEndDe", getNoticeEndDe());			
		
		resultMap.put("msgClf", getMsgClf());	
		resultMap.put("rcvClf", getRcvClf());		
		resultMap.put("autoManuClf", getAutoManuClf());
		resultMap.put("pushLinkPage", getPushLinkPage());
		resultMap.put("noticeLinkPage", getNoticeLinkPage());
		resultMap.put("noticeSetNo", getNoticeSetNo());
		resultMap.put("sndCnt", 0);
		
//		20170905 푸시 예약 추가(이태석)
		resultMap.put("resrvtDe", getResrvtDe());
		resultMap.put("resrvtTm", getResrvtTm());
		resultMap.put("boardSn",  getBoardSn());
		
		if(!valueCheck()){
			System.out.println("valueCheck() ======================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 실패");
			resultMap.put("sndSttus", "F");  //실패
			resultMap.put("errorMsg",getErrorMsg());

		}else{	

			setSndCnt(tokens.length);
			List<Map<String,Object>> userInfoList = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> pushInfoList = getPushInfo();
			
			try{
				int cnt = getSndCnt();
				String[] tokens = getTokens();
				String[] userId = getUserId();
				resultMap.put("sndCnt", cnt);
//				int succ = 0;
//				int fail = 0;
				
				for(int i=0; i<cnt; i++){

					Map<String,Object> pushInfoMap = null;
					if(userId[i].equals((pushInfoList.get(i)).get("USER_ID"))){
						pushInfoMap = pushInfoList.get(i);
					}else{
						for (int j = 0; j < pushInfoList.size(); j++) {
							if(userId[i].equals((pushInfoList.get(j)).get("USER_ID"))){
								pushInfoMap = pushInfoList.get(j);
								break;
							}
						}
					}
					
					if(pushInfoMap == null){
						continue;
					}
					
					String setYn = StringUtil.nvl(String.valueOf(pushInfoMap.get("PUSH_NOTICE_SET_YN")));
					String noticeYn = StringUtil.nvl(String.valueOf(pushInfoMap.get("NOTICE_YN")));
					String mobileOs = StringUtil.nvl(String.valueOf(pushInfoMap.get("MOBILE_OS")));
					String badgeCnt = StringUtil.nvl(String.valueOf(pushInfoMap.get("BADGE_CNT")));
					
					Map<String,Object> userInfo = new HashMap<String,Object>();
					Map<String,Object> notification = new HashMap<String,Object>();
					userInfo.put("sndSn", getSndSn());
					userInfo.put("sndUserId", getSndUserId());
					userInfo.put("rcvUserId", userId[i]);
//					userInfo.put("token", tokens[i]);				

//					userInfo.put("title",		URLEncoder.encode(getPushTitle(), "UTF-8"));
//					userInfo.put("message",		URLEncoder.encode(getPushCont(), "UTF-8"));
					userInfo.put("title",		getPushTitle());
					userInfo.put("message",		getPushCont());
					userInfo.put("linkPage",	getPushLinkPage());
					userInfo.put("pushYn", 		setYn = noticeYn=="Y"?"N":setYn );	//공지인 경우 무조건 N으로, 나머지 경우 수신설정여부에 따라 전송
					userInfo.put("badge",		Integer.parseInt(badgeCnt));
					
					if("Y".equals(setYn)){
						notification.put("title",	getPushTitle());
						notification.put("body",	getPushCont());
						notification.put("sound",	"default");
					}
					notification.put("badge",	Integer.parseInt(badgeCnt));
					
					//20161012 윤봉훈 - 알림 전송 시 푸시 내용 누락으로 인한 수정
					if("".equals(getPushTitle()) || "".equals(getPushCont()) ){
			        	userInfo.put("sndSttus", "20"); //대기
			        	userInfoList.add(userInfo);
						continue;
					}
					
					String token = tokens[i];
	
			        JSONObject jGcmData = new JSONObject();
			        JSONObject jData = new JSONObject(userInfo);
			        JSONObject jData_noti = new JSONObject(notification);
			        
			        // Where to send GCM message.
			        String to = "";
			        if(RCVCLF_A.equals(getRcvClf())){
			        	to = "/topics/news";
			        }else if(RCVCLF_H.equals(getRcvClf())){
			        	to = "/topics/"+getSndOrgCd();
			        }else if(RCVCLF_I.equals(getRcvClf())){
			        	to = URLDecoder.decode(token,"UTF-8");
			        }
			        jGcmData.put("to",to);
			
			        // What to send in GCM message.
			        jGcmData.put("data", jData);
			        if("IOS".equals(mobileOs)) {
			        	jGcmData.put("notification", jData_noti);
			        	jGcmData.put("priority","high");
			        }
			        
			        JSONObject result = setHttpRequest(jGcmData);
			        
//			        System.out.println("FCM request =="+jGcmData.toString());
//			        System.out.println("FCM result =="+result);
			        
			        if(result.getInt("success")>0){
			        	userInfo.put("sndSttus", "20"); //대기
			        	userInfoList.add(userInfo);
			        }else{
			        	userInfo.put("sndSttus", "30"); //실패
			        	JSONArray ja = result.getJSONArray("results");
			        	userInfo.put("errorMsg", ja.getJSONObject(0).getString("error")); //실패
			        	userInfoList.add(userInfo);
			        }		        
				}

//				System.out.println("userInfoList() ======================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 성공 :: "+userInfoList);
				resultMap.put("sndSttus", "S"); //성공
				resultMap.put(USER_LIST, userInfoList);
				flag = true;
			
			}catch(Exception e){
				System.out.println("catch(Exception e) ======================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 에러 :: "+e.getMessage());
				resultMap.put("sndSttus", "F");  //실패
				resultMap.put("errorCd", ERR_PUSH_EXCEPTION);
				resultMap.put("errorMsg", e.getMessage());
				flag = false;
			}
		
		}
		
//		System.out.println("resultMap==>"+resultMap );
		
		return flag;
	}

	// 20161020 윤봉훈 - 토큰을 이용한 fcm 전송
	public boolean sendPushList(List<Map<String,Object>>sendList){
		boolean flag = false;
		int nCnt = 0;
		String sndSn = "";
		
		List<Map<String,Object>> userInfoList = new ArrayList<Map<String,Object>>();
		try{
			for(int i = 0; i < sendList.size(); i++){
				
				Map<String,Object> userInfo = new HashMap<String,Object>();
				Map<String,Object> notification = new HashMap<String,Object>();
				Map<String,Object> sendMap = sendList.get(i);
				
				String token = StringUtil.nvl(String.valueOf(sendMap.get("TOKEN")));
				String setYn = StringUtil.nvl(String.valueOf(sendMap.get("PUSH_NOTICE_SET_YN")));
				String noticeYn = StringUtil.nvl(String.valueOf(sendMap.get("NOTICE_YN")));
				String mobileOs = StringUtil.nvl(String.valueOf(sendMap.get("MOBILE_OS")));
				String badgeCnt = StringUtil.nvl(String.valueOf(sendMap.get("BADGE_CNT")));
				
				if("Y".equals(noticeYn)) setYn = "N";
				
				userInfo.put("sndSn",		(String)sendMap.get("SND_SN"));
				userInfo.put("sndUserId",	(String)sendMap.get("SND_USER_ID"));
				userInfo.put("rcvUserId",	(String)sendMap.get("RCV_USER_ID"));
//				userInfo.put("token",		token);

//				userInfo.put("title",		URLEncoder.encode((String)sendMap.get("PUSH_TITLE"), "UTF-8"));
//				userInfo.put("message",		URLEncoder.encode((String)sendMap.get("PUSH_CONT"), "UTF-8"));
//				userInfo.put("linkPage",	(String)sendMap.get("PUSH_LINK_PAGE"));
				userInfo.put("rowNum",		StringUtil.nvl(String.valueOf(sendMap.get("RN"))));
				userInfo.put("pushYn", 		setYn);	//공지인 경우 무조건 N으로, 나머지 경우 수신설정여부에 따라 전송
				userInfo.put("noticeClf", 	StringUtil.nvl(String.valueOf(sendMap.get("NOTICE_CLF"))));	//푸시(P)인 경우 뱃지 카운터 제외
				userInfo.put("click_action",	"kr.go.khealthmhc.MyClickAction");
				userInfo.put("badge",		Integer.parseInt(badgeCnt));
				
//				notification.put("title_loc_key",	(String)sendMap.get("PUSH_TITLE"));
//				notification.put("body_loc_key",	(String)sendMap.get("PUSH_CONT"));
				//notification.put("click_action",	(String)sendMap.get("PUSH_LINK_PAGE"));
				if("Y".equals(setYn)){
//					userInfo.put("title",		URLEncoder.encode((String)sendMap.get("PUSH_TITLE"), "UTF-8"));
//					userInfo.put("message",		URLEncoder.encode((String)sendMap.get("PUSH_CONT"), "UTF-8"));
					userInfo.put("title",		(String)sendMap.get("PUSH_TITLE"));
					userInfo.put("message",		(String)sendMap.get("PUSH_CONT"));
					userInfo.put("linkPage",	(String)sendMap.get("PUSH_LINK_PAGE"));
					
					notification.put("title",	(String)sendMap.get("PUSH_TITLE"));
					notification.put("body",	(String)sendMap.get("PUSH_CONT"));
					notification.put("sound",	"default");
				}
				notification.put("badge",	Integer.parseInt(badgeCnt));
				
				if("".equals(token)){
		        	userInfo.put("sndSttus", "30"); //실패
		        	userInfo.put("errorMsg", "푸시 전송을 위한 대상자 앱 토큰(주소)이 없습니다."); //실패
		        	userInfoList.add(userInfo);
		        	continue;
				}
				if(!"Y".equals(setYn)){	//푸시 미수신 설정 사용자 여부
					if(!"Y".equals(noticeYn)){	//모바일 공지 푸시 여부
						userInfo.put("errorMsg", "대상자가 앱에서 푸시 수신 여부를 미수신으로 설정했습니다."); //실패
					}else{
						//userInfo.put("errorMsg", "푸시 미수신 설정 사용자 모바일 공지 발송."); //실패
						userInfo.put("errorMsg", "수동알림 배찌 카운터 발송");
					}
//					userInfo.put("sndSttus", "30"); //실패
//					userInfoList.add(userInfo);
//					continue;
				}
				
				
		        JSONObject jGcmData = new JSONObject();
		        JSONObject jData = new JSONObject(userInfo);
		        JSONObject jData_noti = new JSONObject(notification);
		        
		        // Where to send GCM message.
		        String to = "";
		        String rcvClf = sendMap.get("RCV_CLF").toString();
		        if(RCVCLF_A.equals(rcvClf)){
		        	to = "/topics/news";
		        }else if(RCVCLF_H.equals(rcvClf)){
		        	to = "/topics/" + sendMap.get("SND_ORG_CD").toString();
		        }else if(RCVCLF_I.equals(rcvClf)){
		        	to = URLDecoder.decode((String)sendMap.get("TOKEN"),"UTF-8");
		        }
		        jGcmData.put("to",to);

		        // What to send in GCM message.
		        jGcmData.put("data", jData);
		        //아이폰인 경우 notification 포함
		        if("IOS".equals(mobileOs)) {
		        	jGcmData.put("notification", jData_noti);
		        	jGcmData.put("priority","high");
		        }
		        
		        JSONObject result = setHttpRequest(jGcmData);
		        
//		        System.out.println("FCM request =="+jGcmData.toString());
//		        System.out.println("FCM result =="+result);//FCM result =={"failure":0,"results":[{"message_id":"0:1476868900683341%0bcf36c0f9fd7ecd"}],"success":1,"multicast_id":8655036516298117529,"canonical_ids":0}
		        
		        if(result.getInt("success")>0){
		        	userInfo.put("sndSttus", "20"); //대기
		        	userInfoList.add(userInfo);
		        	nCnt++;
		        }else{
		        	userInfo.put("sndSttus", "30"); //실패
		        	JSONArray ja = result.getJSONArray("results");
		        	userInfo.put("errorMsg", ja.getJSONObject(0).getString("error")); //실패
		        	userInfoList.add(userInfo);
		        }
			}

//			System.out.println("userInfoList() ======================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 성공 :: "+userInfoList);
			resultMap.put("sndSn", sndSn);
			resultMap.put("sndCnt", nCnt);
			resultMap.put("sndSttus", "S"); //성공
			resultMap.put(USER_LIST, userInfoList);
			flag = true;
		
		}catch(Exception e){
			System.out.println("catch(Exception e) ======================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 에러 :: "+e.getMessage());
			e.printStackTrace();
			resultMap.put("sndSttus", "F");  //실패
			resultMap.put("errorMsg", e.getMessage());
			flag = false;
		}
		
		return flag;
	}
	
	// 20161020 윤봉훈 - 전송할 대상자 리스트를 먼저 테이블에 저장하기 위한 정보 설정.
	public boolean sendNotifition(){

		boolean flag = false;
		List<Map<String,Object>> userInfoList = new ArrayList<Map<String,Object>>();
		
		// 푸시 기본정보 설정
		setPushMap();
		try{

			String[] userId = getUserId();
			resultMap.put("sndCnt", userId.length);		// 푸시 전송 후 전송된 카운트로 다시 측정
			
			for(int i = 0; i < userId.length; i++){
				Map<String,Object> userInfo = new HashMap<String,Object>();
				userInfo.put("sndSn", getSndSn());
				userInfo.put("noticeClf", getNoticeClf());
				userInfo.put("sndUserId", getSndUserId());
				userInfo.put("rcvUserId", userId[i]);
	        	//userInfo.put("sndSttus", NOTICECLF_N.equals(getNoticeClf()) ? "20" : "12"); // 알림만 전송 시 바로 
				userInfo.put("sndSttus", "12");
	        	userInfoList.add(userInfo);
			}
			resultMap.put("sndSttus", "S");  //성공
			resultMap.put(USER_LIST, userInfoList);
			flag = true;

		}catch(Exception e){
			resultMap.put("sndSttus", "F");  //실패
			resultMap.put("errorCd", ERR_PUSH_EXCEPTION);
			resultMap.put("errorMsg", e.getMessage());
			flag = false;
		}
		
		return flag;
		
	}
	
	private JSONObject setHttpRequest(JSONObject jGcmData){

		JSONObject resultObj = null;
		HttpURLConnection conn = null;
		OutputStream outputStream = null;
		try {			
			
			URL url = new URL("https://fcm.googleapis.com/fcm/send");		
	        conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestProperty("Authorization", "key=" + API_KEY);
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	
	        // Send GCM message content.
	        outputStream = conn.getOutputStream();
	        outputStream.write(jGcmData.toString().getBytes());
	
	        // Read GCM response.
	//        InputStream inputStream = conn.getInputStream();
	//        String resp = IOUtils.toString(inputStream);
	//        System.out.println(resp);
	//        System.out.println("Check your device/emulator for notification or logcat for " +
	//                "confirmation of the receipt of the GCM message.");
	        BufferedReader in = new BufferedReader( new InputStreamReader(conn.getInputStream()));
			String inputLine;	
			String result = ""; 
				
			while ((inputLine = in.readLine()) != null) {		
				result = inputLine;
				//System.out.println(result);		
			}
			
			resultObj = new JSONObject(result);			
			
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(conn != null){
				conn.disconnect();
				conn = null;
			}
			if(outputStream != null){
				try {
					outputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				outputStream = null;
			}			
		}
		
		return resultObj;
	}
	
	/**
	 * 필수값 체크
	 * @return
	 */
	private boolean valueCheck(){
		String noticeClf = getNoticeClf();
		String title = getPushTitle();
		String message = getPushCont();
		String noticetitle = getNoticeTitle();
		String noticeCont = getNoticeCont();

		String gubun = getRcvClf();
		String[] tokens = getTokens();
		String[] userId = getUserId();
		String orgCd = getSndOrgCd();
		
		if(NOTICECLF_A.equals(noticeClf) || NOTICECLF_N.equals(noticeClf)){
			if(noticetitle == null || noticetitle.isEmpty()){
				setErrorCode(ERR_PUSH_SETVAL);
				setErrorMsg("noticetitle is null");
				return false;
			}
			if(noticeCont == null || noticeCont.isEmpty()){
				setErrorCode(ERR_PUSH_SETVAL);
				setErrorMsg("noticeCont is null");
				return false;
			}
		}
		if(NOTICECLF_A.equals(noticeClf) || NOTICECLF_P.equals(noticeClf)){
			if(title == null || title.isEmpty()){
				setErrorCode(ERR_PUSH_SETVAL);
				setErrorMsg("title is null");
				return false;
			}
			if(message == null || message.isEmpty()){
				setErrorCode(ERR_PUSH_SETVAL);
				setErrorMsg("message is null");
				return false;
			}
		}
		if(gubun == null || gubun.isEmpty()){
			setErrorCode(ERR_PUSH_SETVAL);
			setErrorMsg("gubun is null");
			return false;
		}else{
			if("I".equals(gubun)){
				if(tokens == null || tokens.length==0){
					setErrorCode(ERR_PUSH_SETVAL);
					setErrorMsg("tokens is null");
					return false;
				}
				if(userId == null || userId.length==0){
					setErrorCode(ERR_PUSH_SETVAL);
					setErrorMsg("userId is null");
					return false;
				}
			}
		}

		if(orgCd == null || orgCd.isEmpty()){
			setErrorCode(ERR_PUSH_SETVAL);
			setErrorMsg("orgCd is null");
			return false;
		}
		
		
		return true;
	}
	
    public String getPushId(){
    	String curDate = SimpleDateUtil.getSysDate("yyyyMMddHHmmss");
    	int rNum = (int)(Math.random()*9999);
    	return curDate.toString()+rNum;
    }
	
	public void setPushMap(){

		resultMap.clear();
		
		String pushId = getPushId();
		setSndSn(pushId);
		
		resultMap.put("sndSn", pushId);
//		resultMap.put("lstDmlId", getLstDmlId());
		resultMap.put("lstDmlId", getSndUserId());
		resultMap.put("noticeClf", getNoticeClf());
		resultMap.put("sndOrgCd", getSndOrgCd());
		resultMap.put("sndUserId", getSndUserId());
		resultMap.put("pushTitle", getPushTitle());
		resultMap.put("pushCont", getPushCont());		
		resultMap.put("noticeTitle", getNoticeTitle());
		resultMap.put("noticeCont", getNoticeCont());
		resultMap.put("noticeEndDe", getNoticeEndDe());		
		
		resultMap.put("msgClf", getMsgClf());	
		resultMap.put("rcvClf", getRcvClf());		
		resultMap.put("reqClf", getReqClf());		
		resultMap.put("autoManuClf", getAutoManuClf());
		resultMap.put("pushLinkPage", getPushLinkPage());
		resultMap.put("noticeLinkPage", getNoticeLinkPage());
		resultMap.put("noticeSetNo", getNoticeSetNo());
		resultMap.put("sndCnt", 0);
//		20170905 푸시 예약 추가(이태석)
		resultMap.put("resrvtDe", getResrvtDe());
		resultMap.put("resrvtTm", getResrvtTm());
		resultMap.put("boardSn", getBoardSn());
		
	}

	public void setReqData(HttpServletRequest req, Map<String,Object> param){

		String noticeClf		= StringUtil.nvl(String.valueOf(param.get("noticeClf")));
		String pushTitle		= StringUtil.nvl(String.valueOf(param.get("pushTitle")));
		String pushCont			= StringUtil.nvl(String.valueOf(param.get("pushCont")));
		String noticeTitle		= StringUtil.nvl(String.valueOf(param.get("noticeTitle")));
		String noticeCont		= StringUtil.nvl(String.valueOf(param.get("noticeCont")));	
		String noticeEndDe      = StringUtil.nvl(String.valueOf(param.get("noticeEndDe")));	
		
		String msgclf			= StringUtil.nvl(String.valueOf(param.get("msgclf")));
		String reqClf			= StringUtil.nvl(String.valueOf(param.get("reqClf")));
		String rcvClf			= StringUtil.nvl(String.valueOf(param.get("rcvClf")),RCVCLF_I);
		String sndOrgCd			= StringUtil.nvl(String.valueOf(param.get("sndOrgCd")),param.get("SESS_ORG_CD").toString());		
		String sndUserId		= StringUtil.nvl(String.valueOf(param.get("sndUserId")),param.get("SESS_USER_ID").toString());	
		String autoManuClf		= StringUtil.nvl(String.valueOf(param.get("autoManuClf")),AUTOMANUCLF_M);
		String pushLinkPage		= StringUtil.nvl(String.valueOf(param.get("pushLinkPage"))).replaceAll("\\&amp;", "&");
		String noticeLinkPage	= StringUtil.nvl(String.valueOf(param.get("noticeLinkPage"))).replaceAll("\\&amp;", "&");
		String noticeSetNo		= StringUtil.nvl(String.valueOf(param.get("noticeSetNo")));
//		20170905 푸시 예약 추가(이태석)
		String resrvtDe		    = StringUtil.nvl(String.valueOf(param.get("resrvtDe")));
		String resrvtTm		    = StringUtil.nvl(String.valueOf(param.get("resrvtTm")));
		String boardSn			= StringUtil.nvl(String.valueOf(param.get("boardSn")));
		
		String[] userId			= req.getParameterValues("userId") != null ? req.getParameterValues("userId") : req.getParameterValues("userId[]");
		String[] grpSn			= req.getParameterValues("grpSn") != null ? req.getParameterValues("grpSn") : req.getParameterValues("grpSn[]");
		String[] tokens			= req.getParameterValues("token") != null ? req.getParameterValues("token") : req.getParameterValues("token[]");
		
		if(!"".equals(noticeClf)){
			setNoticeClf(noticeClf);
		}else{
			if(!"".equals(pushCont) && !"".equals(noticeCont)){
				setNoticeClf(NOTICECLF_A);
			}else if(!"".equals(pushCont) && "".equals(noticeCont)){
				setNoticeClf(NOTICECLF_P);
				if("".equals(pushLinkPage)) pushLinkPage = LINK_PAGE;
			}else if("".equals(pushCont) && !"".equals(noticeCont)){
				setNoticeClf(NOTICECLF_N);
				if("".equals(noticeLinkPage)) noticeLinkPage = LINK_PAGE;
			}
		}
		
		setSndOrgCd(sndOrgCd);
		setSndUserId(sndUserId);
		setMsgClf(msgclf);
		setPushTitle(pushTitle);
		setPushCont(pushCont);
		setNoticeTitle(noticeTitle);
		setNoticeCont(noticeCont);
		setRcvClf(rcvClf);
		setReqClf(reqClf);
		setAutoManuClf(autoManuClf);
		setPushLinkPage(pushLinkPage);
		setNoticeLinkPage(noticeLinkPage);
		setNoticeSetNo(noticeSetNo);
		
		setResrvtDe(resrvtDe);
		setResrvtTm(resrvtTm);
		setBoardSn(boardSn);
		
		setUserId(userId);
		setGrpSn(grpSn);
		setTokens(tokens);
		
		setNoticeEndDe(noticeEndDe);
		
	}

}
