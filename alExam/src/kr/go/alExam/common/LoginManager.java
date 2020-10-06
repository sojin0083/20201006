package kr.go.alExam.common;

import java.util.*;

import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoginManager implements HttpSessionBindingListener{
    private static final Logger logger = LoggerFactory.getLogger(DMultiActionController.class);
    private static LoginManager loginManager = new LoginManager();
    
    //로그인한 접속자를 담기위한 해시테이블
    private static Hashtable<HttpSession,Object> loginUsers = new Hashtable<HttpSession,Object>();
    private static Hashtable<HttpSession,Object> loginMapping = new Hashtable<HttpSession,Object>();
    
    /*
     * 싱글톤 패턴 사용
     */
    public static LoginManager getInstance(){
        return loginManager;
    }
     
    public void valueBound(HttpSessionBindingEvent event) {
        //session값을 put한다.
        loginUsers.put(event.getSession(), event.getName());        
        //logger.debug(event.getName() + "님이 로그인 하셨습니다.");
        //logger.debug("현재 접속자 수 : " +  getUserCount());
     }
    
     /*
      * 이 메소드는 세션이 끊겼을때 호출된다.(invalidate)
      * Hashtable에 저장된 로그인한 정보를 제거해 준다.
      */
     public void valueUnbound(HttpSessionBindingEvent event) {
    	 removeSession("", event.getSession());
         //session값을 찾아서 없애준다.
         //logger.debug("  " + event.getName() + "님이 로그아웃 하셨습니다.");
         //logger.debug("현재 접속자 수 : " +  getUserCount());
     }
     
     
     /*
      * 입력받은 아이디를 해시테이블에서 삭제. 
      * @param userID 사용자 아이디
      * @return void
      */ 
     public void removeSession(String userId, HttpSession curSession){
    	  //System.out.println("======================removeSession=====================");
    	  
    	  loginMapping.remove(curSession);
          loginUsers.remove(curSession);
          //printloginUsers();
          
          //curSession.invalidate();
          
    	  /*
          Enumeration<HttpSession> e = loginUsers.keys();
          HttpSession session = null;
          while(e.hasMoreElements()){
               session = (HttpSession)e.nextElement();
               if(loginUsers.get(session).equals(userId) && curSession.equals(session)){
                   //세션이 invalidate될때 HttpSessionBindingListener를 
                   //구현하는 클레스의 valueUnbound()함수가 호출된다.
                   loginMapping.remove(loginUsers.get(session));
                   loginUsers.remove(session);
                   session.invalidate();
                   //session.setMaxInactiveInterval(0)를 이용하면 된다는데 제대로 안되어서 invalidate()을 사용했다.
               }
          }
          */
     }
     
     
     /*
        로그아웃시에는 유저테이블의 내용을 변경했다.     
         */
     public void logoutSession(HttpSession session){
        loginUsers.put(session, "L");
        
     }
     
     
     /*
      * 사용자가 입력한 ID, PW가 맞는지 확인하는 메소드
      * @param userID 사용자 아이디
      * @param userPW 사용자 패스워드
      * @return boolean ID/PW가 일치하는 지 여부
      */
     public boolean isValid(String userId, String userPw){
         
         /*
          * 이부분에 Database 로직이 들어간다.
          */
         return true;
     }
 
 
    /*
     * 해당 아이디의 동시 사용을 막기위해서 
     * 이미 사용중인 아이디인지를 확인한다.
     * @param userID 사용자 아이디
     * @return boolean 이미 사용 중인 경우 true, 사용중이 아니면 false
     */
    public boolean isUsing(String userID){
        return loginUsers.containsValue(userID);
    }

    /*
     * 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
     * @param session 세션 객체
     * @param userID 사용자 아이디
     */
    public void setSession(HttpSession session, String userId){
        //이순간에 Session Binding이벤트가 일어나는 시점
        //name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
        session.setAttribute(userId, this);//login에 자기자신을 집어넣는다.
    }
     
     
    /*
      * 입력받은 세션Object로 아이디를 리턴한다.
      * @param session : 접속한 사용자의 session Object
      * @return String : 접속자 아이디
     */
    public String getUserID(HttpSession session){
        return (String)loginUsers.get(session);
    }
    
    //ip값으로 기존 세션정보 조회
    public HttpSession getSessionInfo(String userId){
        return (HttpSession)loginMapping.get(userId);
    }
     
    public String getUserIp(HttpSession session){
    	return (String)loginMapping.get(session);
    }
    
    
    /*
     * 현재 접속한 총 사용자 수
     * @return int  현재 접속자 수
     */
    public int getUserCount(){
        return loginUsers.size();
    }
     
     
    /*
     * 현재 접속중인 모든 사용자 아이디를 출력
     * @return void
     */
    public void printloginUsers(){
        Enumeration<HttpSession> e = loginUsers.keys();
        Enumeration<HttpSession> e2 = loginMapping.keys();
        HttpSession session = null;
        logger.debug("===========================================");
        int i = 0;
        while(e.hasMoreElements()){
            session = (HttpSession)e.nextElement();
            logger.debug((++i) + ". 접속자 : " +  loginUsers.get(session) + ":" + session);
        }
        logger.debug("===========================================");
        int a = 0;
        while(e2.hasMoreElements()){
            session = (HttpSession)e2.nextElement();
            logger.debug((++a) + ". " + session + " : " +  loginMapping.get(session));
        }
        logger.debug("===========================================");
     }
     
    /*
     * 현재 접속중인 모든 사용자리스트를 리턴
     * @return list
     */
    public Collection<Object> getUsers(){
        Collection<Object> collection = loginUsers.values();
        return collection;
    }
    
    public Hashtable<HttpSession,Object> getLoginUsers(){
        return this.loginUsers;
    }
    
    public Hashtable<HttpSession,Object> getLoginIp(){
    	return this.loginMapping;
    }
    
    public boolean setLoginMapping(String userId, HttpServletRequest request, HttpSession curSession){
        try{
        	//System.out.println("======================setLoginMapping=====================");
        	//System.out.println("current session : "+curSession+" / ip : "+request.getRemoteAddr());
            Enumeration<HttpSession> e = loginUsers.keys();
            HttpSession session = null;
            while(e.hasMoreElements()){
                 session = (HttpSession)e.nextElement();
                 if(loginUsers.get(session).equals(userId)){
                	 String ip = loginMapping.get(session) == null ? "" : (String) loginMapping.get(session);
                	 if(!curSession.equals(session) && "".equals(ip)){
                		 loginMapping.put(session, request.getRemoteAddr());
                	 }
                	 //System.out.println("loginUsers session : "+session+" / ip : "+getUserIp(session));
                 }
            }
            return true;
        }
        catch(NullPointerException npe){
            logger.error("detail", npe);
            return false;
        }
    }
}
