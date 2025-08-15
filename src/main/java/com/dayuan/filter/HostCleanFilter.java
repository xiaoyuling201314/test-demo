package com.dayuan.filter;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

/**
 * host校验
 * @author Dz
 * @date 2020/07/14
 */
public class HostCleanFilter implements Filter{

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

        SafeHttpServletRequestWrapper request = null;
        HttpServletResponse response = (HttpServletResponse) res;

        //防Xss
        HttpServletRequest request0 = (HttpServletRequest) req;
        String enctype = request0.getContentType();
//        if(StringUtils.isNotBlank(enctype) && enctype.contains("multipart/form-data")){
//            // 上传文件
//            CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(request0.getSession().getServletContext());
//            MultipartHttpServletRequest multipartRequest = commonsMultipartResolver.resolveMultipart(request0);
//            request = new SafeHttpServletRequestWrapper(multipartRequest);
//        }else{
//            // 普通表单和Ajax
//            request = new SafeHttpServletRequestWrapper(request0);
//        }
        request = new SafeHttpServletRequestWrapper(request0);

        // 头攻击检测
        String requestHost = request.getHeader("host");
        if (requestHost != null && !isWhite(requestHost)) {
            response.setStatus(403);
            response.sendError(403, "访问地址不在白名单中，无法访问！");
            return;
        }

        // 添加响应头
        response.setHeader("Content-Security-Policy","frame-ancestors 'self'");
        response.setHeader("X-Permitted-Cross-Domain-Policies","master-only");
        response.setHeader("X-Download-Options","noopen");
        response.setHeader("Strict-Transport-Security","max-age=31536000; includeSubDomains");
        response.setHeader("Referrer-Policy","no-referrer");

        //此配置需要https
//        response.setHeader("SET-COOKIE", "JSESSIONID=" + request.getSession().getId() + "; secure ; HttpOnly; SameSite=Lax");

        HttpSession session = request.getSession(false);
        response.setHeader("SET-COOKIE",  "HttpOnly; SameSite=Lax" + (session != null ? "; JSESSIONID=" + session.getId() : ""));

        chain.doFilter(request, res);
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub

    }

    /**
     * 白名单
     */
    private static List<String> whiteList = null;
    static {
        try {
//            System.out.println(HostCleanFilter.class.getClassLoader().getResource("").getPath().replace("%20"," ") + "serverWhiteList.json");
            // 读取白名单列表
            whiteList = new Gson().fromJson(
//                    new InputStreamReader(HostCleanFilter.class.getResourceAsStream("/serverWhiteList.json")),
                    new InputStreamReader(new FileInputStream(HostCleanFilter.class.getClassLoader().getResource("").getPath().replace("%20"," ")+"serverWhiteList.json")),
                    new TypeToken<List<String>>() {
                    }.getType());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * 判断当前host是否在白名单内
     * @param host 待查host
     * @return boolean 是否在白名单内
     */
    private boolean isWhite(String host) {
        if (whiteList == null || whiteList.size() == 0) {
            return true;
        }
        for (String str : whiteList) {
            if (str != null && (str.equals(host) || str.equals("*")) ) {
                return true;
            }
        }
        return false;
    }

}