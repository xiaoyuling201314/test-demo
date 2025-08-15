package com.dayuan.common;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.bean.wx.WxUser;
import com.dayuan.controller.wx.WxController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.ReflectHelper;
import com.dayuan3.admin.bean.InspectionUnitUser;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

/**
 * 公共方法
 *
 * @author Dz
 * @Description:
 * @Company:食安科技
 * @date 2017年8月16日
 */
public class PublicUtil {
    /**
     * 数据库表通用字段createDate,createBy,updateDate,updateBy
     *
     * @param obj
     * @param isCreate
     * @throws MissSessionExceprtion
     */
    public static void setCommonForTable(Object obj, boolean isCreate) throws MissSessionExceprtion {
        ReflectHelper reflectHelper = new ReflectHelper(obj);
        TSUser user = getSessionUser();
        Date now = new Date();

        if (isCreate) {
            reflectHelper.setMethodValue("createDate", now);
            if (null != user) {
                reflectHelper.setMethodValue("createBy", user.getId()+"");
            }
        }
        reflectHelper.setMethodValue("updateDate", now);
        if (null != user) {
            reflectHelper.setMethodValue("updateBy", user.getId()+"");
        }
    }

    /**
     * 数据库表通用字段createDate,createBy,updateDate,updateBy（接口专用）
     * 接口用户需要通过token获取用户信息
     *
     * @param obj
     * @param isCreate
     * @param user
     */
    public static void setCommonForTable(Object obj, boolean isCreate, TSUser user) {
        ReflectHelper reflectHelper = new ReflectHelper(obj);
        Date now = new Date();

        if (isCreate) {
            reflectHelper.setMethodValue("createDate", now);
            reflectHelper.setMethodValue("createBy", (user == null ? "" : user.getId()+""));
        }
        reflectHelper.setMethodValue("updateDate", now);
        reflectHelper.setMethodValue("updateBy", (user == null ? "" : user.getId()+""));
    }


    /**
     * 获取登录用户
     *
     * @return
     * @throws MissSessionExceprtion
     */
    public static final TSUser getSessionUser() throws MissSessionExceprtion {
        HttpSession session = ContextHolderUtils.getSession();
        TSUser user = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
        if (null == user) {
            throw new MissSessionExceprtion();
        }
        return user;
    }

    /**
     * 获取登录用户机构
     *
     * @return
     * @throws MissSessionExceprtion
     */
    public static final TSDepart getSessionUserDepart() throws MissSessionExceprtion {
        HttpSession session = ContextHolderUtils.getSession();
        TSDepart depart = (TSDepart) session.getAttribute(WebConstant.ORG);
        if (null == depart) {
            throw new MissSessionExceprtion();
        }
        return depart;
    }

    /**
     * 获取登录用户检测点
     *
     * @return
     * @throws MissSessionExceprtion
     */
    public static final BasePoint getSessionUserPoint() throws MissSessionExceprtion {
        HttpSession session = ContextHolderUtils.getSession();
        BasePoint point = (BasePoint) session.getAttribute(WebConstant.POINT);
        if (null == point) {
            throw new MissSessionExceprtion();
        }
        return point;
    }

    /**
     * 设置接口请求异常错误代码
     *
     * @param ajaxJson   AjaxJson对象
     * @param success    执行结果
     * @param resultCode 错误码
     * @param msg        错误消息
     * @return
     */
    public static final AjaxJson setAjaxJson(AjaxJson ajaxJson, boolean success, String resultCode, String msg) {
        ajaxJson.setSuccess(success);
        ajaxJson.setResultCode(resultCode);
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }


    /**
     * 自定义微信考勤拦截方法
     */
    public static void customWxInterceptor() {
        try {
            HttpSession session = ContextHolderUtils.getSession();
            //HttpServletRequest request = ContextHolderUtils.getRequest();
            WxUser user = (WxUser) session.getAttribute("wxuser");//获取当前登陆的用户
            HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
            if (user == null) {//request.getContextPath()
                response.sendRedirect(WxController.mainUrl);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    /**
     * 数据库表通用字段createDate,createBy,updateDate,updateBy
     *
     * @param obj
     * @param isCreate
     * @throws MissSessionExceprtion
     */
    public static void setCommonForTable2(Object obj, boolean isCreate, TSUser user) {
        ReflectHelper reflectHelper = new ReflectHelper(obj);
        if (isCreate) {
            reflectHelper.setMethodValue("createDate", new Date());
            if (null != user) {
                reflectHelper.setMethodValue("createBy", user.getId());
            }
        }
        reflectHelper.setMethodValue("updateDate", new Date());
        if (null != user) {
            reflectHelper.setMethodValue("updateBy", user.getId());
        }
    }
    /**
     * 数据库表通用字段createDate,createBy,updateDate,updateBy（接口专用）
     * 接口用户需要通过token获取用户信息
     *
     * @param obj
     * @param isCreate
     * @param user
     */
    public static void setCommonForTable1(Object obj, boolean isCreate, InspectionUnitUser user) {
        ReflectHelper reflectHelper = new ReflectHelper(obj);
        Date now = new Date();

        if (isCreate) {
            reflectHelper.setMethodValue("createDate", now);
            if (null != user) {
                reflectHelper.setMethodValue("createBy", user.getId()+"");
            }
        }
        reflectHelper.setMethodValue("updateDate", now);
        if (null != user) {
            reflectHelper.setMethodValue("updateBy", user.getId()+"");
        }
    }
    /**
     * 获取登录用户
     *
     * @return
     * @throws MissSessionExceprtion
     */
    public static final InspectionUnitUser getSessionTerminalUser() throws MissSessionExceprtion {
        HttpSession session = ContextHolderUtils.getSession();
        InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
        if (null == user) {
            throw new MissSessionExceprtion();
        }
        return user;
    }
}
