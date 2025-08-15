package com.dayuan3.api.common;

import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class VerifyUtil {

    /**
     * 手机号码正则表达式
     */
    private static final String PHONE_REG = "^(1[3|4|5|7|8|9]\\d{9})$";

    /**
     * 设置接口请求异常错误代码
     *
     * @param json InterfaceJson对象
     * @param code 错误码、提示信息
     * @retu
     */
    public static void setJson(MiniProgramJson json, ErrCode code) {
        setJson(json, code, null);
    }

    /**
     * 设置接口请求异常错误代码
     *
     * @param json InterfaceJson对象
     * @param code 错误码、提示信息
     * @param tips 自定义提示信息
     * @return
     */
    public static void setJson(MiniProgramJson json, ErrCode code, String tips) {
        json.setResultCode(code.getCode());
        if (null != tips && !"".equals(tips)) {
            json.setMsg(tips);
        } else {
            json.setMsg(code.getTips());
        }
    }

    /**
     * 接口参数必填验证
     *
     * @param obj   验证参数
     * @param code  错误代码
     * @param param 参数名
     * @param tips  提示信息
     * @throws MiniProgramException
     */
    public static void isEmpty(Object obj, ErrCode code, String param, String tips) throws MiniProgramException {
        if (obj == null || "".equals(obj)) {
            throw new MiniProgramException(code, param, tips);
        }
    }

    /**
     * 接口参数必填验证
     *
     * @param obj   验证参数
     * @param param 参数名
     * @param tips  提示信息
     * @throws MiniProgramException
     */
    public static void isEmpty(Object obj, String param, String tips) throws MiniProgramException {
        if (obj == null || "".equals(obj)) {
            throw new MiniProgramException(ErrCode.PARAM_REQUIRED, param, tips);
        }
    }

    /**
     * 接口参数必填验证
     *
     * @param obj   验证参数
     * @param param 参数名
     * @param tips  提示信息
     * @throws MiniProgramException
     */
    public static void isEmpty(String obj, String param, String tips) throws MiniProgramException {
        if (StringUtil.isEmpty(obj)) {
            if (obj != null && obj.length() > 0) {
                throw new MiniProgramException(ErrCode.DATA_IS_EMPTY2, param, tips);
            } else {
                throw new MiniProgramException(ErrCode.DATA_IS_EMPTY, param, tips);
            }
        }
    }

    /**
     * 接口参数必填验证，限制参数值范围
     *
     * @param obj    验证参数
     * @param param  参数名
     * @param tips   提示信息
     * @param values 值范围，含null表示非必填
     * @throws MiniProgramException
     */
    public static void isEmpty(Object obj, String param, String tips, Object[] values) throws MiniProgramException {
        List list = Arrays.asList(values);
        if (obj == null && !list.contains(null)) {
            throw new MiniProgramException(ErrCode.PARAM_REQUIRED, param, tips);
        } else if (!list.contains(obj)) {
            throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, param, tips);
        }
    }

    /**
     * 接口时间参数验证（时间参数格式，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss）
     *
     * @param time  验证参数
     * @param param 参数名
     * @param tips  提示信息
     * @throws MiniProgramException
     */
    public static void isErrTime(String time, String param, String tips) throws MiniProgramException {
        if (time == null || "".equals(time.trim())) {
            throw new MiniProgramException(ErrCode.PARAM_REQUIRED, param, tips);
        } else if (!DateUtil.checkDate(time)) {
            throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, param, "错误参数[" + param + "](时间格式:yyyy-MM-dd 或 yyyy-MM-dd HH:mm:ss)");
        }
    }

    //	/**
    //	 * 接口时间参数验证（时间参数格式，支持:yyyy-MM-dd）
    //	 * @param time 验证参数
    //	 * @param param 参数名
    //	 * @param tips 提示信息
    //	 * @throws MiniProgramException
    //	 */
    //	public static void isErrTime2(String time, String param, String tips) throws MiniProgramException {
    //		if (time == null || "".equals(time.trim())) {
    //			throw new MiniProgramException(ErrCode.PARAM_REQUIRED, param, tips);
    //		} else if (!DateUtil.checkDate2(time)) {
    //			throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, param, "错误参数["+param+"](时间格式:yyyy-MM-dd)");
    //		}
    //	}

    /**
     * 接口时间参数验证（时间参数格式，支持:yyyy-MM-dd）
     *
     * @param phone 验证参数
     * @param param 参数名
     * @param tips  提示信息
     * @throws MiniProgramException
     */
    public static void isErrPhone(String phone, String param, String tips) throws MiniProgramException {
        Pattern pattern = Pattern.compile(PHONE_REG);
        Matcher matcher = pattern.matcher(phone);
        if (phone == null || "".equals(phone.trim())) {
            throw new MiniProgramException(ErrCode.PARAM_REQUIRED, param, tips);
        } else if (!matcher.matches()) {
            throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, param, "错误参数[" + param + "]");
        }
    }

    /**
     * @return
     * @Description 校验数字是否合格参数
     * @Date 2020/12/29 14:24
     * @Author xiaoyl
     * @Param
     */
    public static void isRightNumber(Object obj, String param, String tips) throws MiniProgramException {
        if (Integer.parseInt(obj.toString()) <= 0) {
            throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, param, tips);
        }
    }
}
