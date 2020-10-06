package kr.go.alExam.common.util;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieUtil {

	protected Map cookieMap = new java.util.HashMap();
	protected Cookie[] cookies = null; 
    
    public CookieUtil(){
    	
    }

    public void setCookies(HttpServletRequest request) { 
		cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0 ; i < cookies.length ; i++) {
				cookieMap.put(cookies[i].getName(), cookies[i]);  
			}
		}
	}     
        
    public Cookie createCookie(String name, String value) throws IOException {
		return new Cookie(name, value);
	}
	
	public Cookie createCookie(String name, String value, int maxAge) throws IOException {
		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(maxAge);
		return cookie;
    }
	
	public Cookie createCookie(String name, String value, String path, int maxAge) throws IOException {
		Cookie cookie = new Cookie(name, value);
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		return cookie;
    }
	
    public Cookie createCookie(String name, String value, String domain, String path, int maxAge) throws IOException {
    	Cookie cookie = new Cookie(name, value);
    	cookie.setDomain(domain);
    	cookie.setPath(path);
    	cookie.setMaxAge(maxAge);
    	return cookie;
	}

    public Cookie createCookie(String name, String value, String domain, String path) throws IOException {
    	Cookie cookie = new Cookie(name, value);
    	cookie.setDomain(domain);
    	cookie.setPath(path);
    	return cookie;
	}
    
	public Cookie getCookie(String name) {
		return (Cookie)cookieMap.get(name); 
	}
    
	public String getValue(String name) throws IOException {
		Cookie cookie = (Cookie)cookieMap.get(name);
		if (cookie == null) {return null;}
        return cookie.getValue();
	}
    
	public boolean exists(String name) {
		return cookieMap.get(name) != null;
	}
	
	public int length(){
		return cookies.length;
	}
	
	public Map getCookieMap(){
		return cookieMap; 
	}
}
