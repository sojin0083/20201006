package kr.go.alExam.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.alExam.common.util.StringUtil;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	LoginManager loginManager = LoginManager.getInstance();
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		String viewGbn = StringUtil.nvl(String.valueOf(request.getSession().getAttribute("SESS_ISMOBILE")));
		String loginId = (String)request.getSession().getAttribute("SESS_USER_ID");
		String loginIp = (String)loginManager.getUserIp(request.getSession());
		
		//동시 접속 session 처리
		if(loginIp!=null && !"".equals(loginIp) && !loginIp.isEmpty() && !"admin".equals(loginId)){
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
				
		
		if(loginId!=null&&!loginId.isEmpty()){
			return true;
		}
		
		//정상적인 세션정보가 없으면 로그인실패 alert 후 로그인페이지로 이동
		if(viewGbn.indexOf("APP") > 0){
			response.sendRedirect(request.getContextPath()+"/?isMobile=APP");
		}else{
			response.sendRedirect(request.getContextPath()+"/");
		}
//		response.sendRedirect(request.getContextPath()+"/login/loginPage.do");
		return false;
	}
	
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

}
