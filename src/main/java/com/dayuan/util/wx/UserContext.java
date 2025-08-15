package com.dayuan.util.wx;

import com.dayuan.controller.wx.inspection.VerifyCodeVO;
import com.dayuan.util.ContextHolderUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Created by dy on 2018/8/19.
 */
public class UserContext {

    private static final String VERIFYCODE_IN_SESSION = "verifyCode";

    public static String getIp() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getRemoteAddr();
    }

    //设置验证码对象进session
    public static void setVerifyCodeInSession(VerifyCodeVO verifyCodeInSession) {
        ContextHolderUtils.getSession().setAttribute(VERIFYCODE_IN_SESSION, verifyCodeInSession);
    }

    //从session中获取验证码对象
    public static VerifyCodeVO getVerifyCodeInSession() {
        return (VerifyCodeVO) ContextHolderUtils.getSession().getAttribute(VERIFYCODE_IN_SESSION);
    }
}
