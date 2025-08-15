package com.dayuan.filter;

import cn.dev33.satoken.servlet.util.SaTokenContextServletUtil;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * SaTokenContext 上下文初始化过滤器 (基于 Servlet)
 */
public class SaTokenContextFilterForServlet implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
            SaTokenContextServletUtil.setContext((HttpServletRequest) request, (HttpServletResponse) response);
            chain.doFilter(request, response);
        } finally {
            SaTokenContextServletUtil.clearContext();
        }
    }

    @Override
    public void destroy() {

    }

}


