package com.dayuan3.api.config;


import cn.dev33.satoken.stp.StpUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * SaInterceptorImpl 类
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/6/18 12:43
 * @description 类的功能描述
 */
public class SaInterceptorImpl implements HandlerInterceptor{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse httpServletResponse, Object o) throws Exception {
//        System.out.println("-------------- SA 路由拦截鉴权，你访问的是：" + request.getRequestURI());
        // 校验登录
        StpUtil.checkLogin();
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
