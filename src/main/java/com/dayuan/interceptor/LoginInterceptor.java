package com.dayuan.interceptor;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	private List<String> exceptUrls;
	
	public List<String> getExceptUrls() {
		return exceptUrls;
	}

	public void setExceptUrls(List<String> exceptUrls) {
		this.exceptUrls = exceptUrls;
	}

	/**
	 * 在Controller类调用之前执行
	 */
	@Override//重写父类的方法
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath();
		if("/".equals(path)){
			return true;
		}
		for (String url : exceptUrls) {
			if(path.startsWith(url)){
				return true;
			}
		}
			
		//获取Session
		HttpSession session = request.getSession();
		//获取Session中存储的登录用户数据
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
//		InspectionUnitUser csUser=(InspectionUnitUser)session.getAttribute("session_user_terminal");
		//add by xiaoyl 2022/07/14 start 同一个用户不同浏览器或者异地重复登录，登录时让前一个用户session会话失效，重定向到登录页面
		ServletContext application = session.getServletContext();
		String sessionId = session.getId();
		if(tsUser!=null && !sessionId.equals(application.getAttribute(tsUser.getId()))){//用户被踢出系统
			response.sendRedirect(request.getContextPath()+"/toLogin.do");
			return false;
		}
		//add by xiaoyl 2022/07/14 end
		//判断用户数据是否存在
		if(tsUser==null && path.contains("/system") ) {//后台操作：用户会话失效 add by xiaoyl 2019-11-14
			response.sendRedirect(request.getContextPath()+"/toLogin.do");
			return false;
		}else if(tsUser != null){
			return true;
//		}else if(csUser==null && (path.contains("/terminal")
//				|| path.contains("/pay")|| path.contains("/reportPrint"))) {
//			response.sendRedirect(request.getContextPath()+"/terminal/index.do");
//			return false;
		}else{
//			throw new MissSessionExceprtion();
			//return false;
			response.sendRedirect(request.getContextPath()+"/toLogin.do");
			return false;
		}
	}

}
