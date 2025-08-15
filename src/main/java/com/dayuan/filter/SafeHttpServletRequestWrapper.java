package com.dayuan.filter;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.Map;

/**
 * 用户请求包装类
 * Created by adonis on 2020/12/12
 */
public class SafeHttpServletRequestWrapper extends HttpServletRequestWrapper{

    public SafeHttpServletRequestWrapper(HttpServletRequest request) {
        super(request);
    }

    @Override
    public String getParameter(String name) {
        String value = super.getParameter(name);
        if (value != null) {
            value = xssEncode(value);
        }
        return value;
    }
    @Override
    public String[] getParameterValues(String name) {
        String[] value = super.getParameterValues(name);
        if(value != null){
            for (int i = 0; i < value.length; i++) {
                value[i] = xssEncode(value[i]);
            }
        }
        return value;
    }
    @Override
    public Map getParameterMap() {
        return super.getParameterMap();
    }

    /**
     * 请求头不过滤
     */
    @Override
    public String getHeader(String name) {
        return super.getHeader(name);
    }

    /**
     * 将容易引起注入的关键字的半角字符直接替换成全角字符
     * @param value 过滤前的值
     * @return 过滤后的值
     */
    private static String xssEncode(String value) {
        if (value == null || value.isEmpty()) {
            return value;
        }
        // 防SQL注入转义
        value = StringEscapeUtils.escapeSql(value);

        // HTML防注入，个人建议使用第三种
        // 1.防HTML注入转义(HtmlUtils工具类，汉字不转义，双引号转义，存在JSON封装需要反转义)
//        value = HtmlUtils.htmlEscape(value);
        //JSON封装，不转义
        try {
            JSONObject jsonVal = JSONObject.parseObject(value);
            if (jsonVal != null) {
                return value;
            }
        } catch (Exception e1) {}
        try {
            JSONArray jsonArr = JSONArray.parseArray(value);
            if (jsonArr != null) {
                return value;
            }
        } catch (Exception e1) {}
        //防HTML注入转义
        value = HtmlUtils.htmlEscape(value);

        /*
        // 2.防HTML注入转义(StringEscapeUtils工具类，汉字也转义，取出时需要反转义)
        // value = StringEscapeUtils.escapeHtml(value);
        // 3.字符串替换法（通过各种循环替换字符串测试，最终还是replace替换效果最佳）
        value = value.replaceAll("<", "＜");
        value = value.replaceAll(">", "＞");
        value = value.replaceAll("'", "＇");
        value = value.replaceAll(";", "﹔");
        value = value.replaceAll("&", "＆");
        value = value.replaceAll("%", "﹪");
        value = value.replaceAll("#", "＃");
        value = value.replaceAll("select", "seleᴄt");// "c"→"ᴄ"
        value = value.replaceAll("truncate", "trunᴄate");// "c"→"ᴄ"
        value = value.replaceAll("exec", "exeᴄ");// "c"→"ᴄ"
        value = value.replaceAll("join", "jᴏin");// "o"→"ᴏ"
        value = value.replaceAll("union", "uniᴏn");// "o"→"ᴏ"
        value = value.replaceAll("drop", "drᴏp");// "o"→"ᴏ"
        value = value.replaceAll("count", "cᴏunt");// "o"→"ᴏ"
        value = value.replaceAll("insert", "ins℮rt");// "e"→"℮"
        value = value.replaceAll("update", "updat℮");// "e"→"℮"
        value = value.replaceAll("delete", "delet℮");// "e"→"℮"

        value = value.replaceAll("script", "sᴄript");// "c"→"ᴄ"
        value = value.replaceAll("cookie", "cᴏᴏkie");// "o"→"ᴏ"
        value = value.replaceAll("iframe", "ifram℮");// "e"→"℮"
        value = value.replaceAll("onmouseover", "onmouseov℮r");// "e"→"℮"
        value = value.replaceAll("onmousemove", "onmousemov℮");// "e"→"℮"*/
        return value;
    }
}