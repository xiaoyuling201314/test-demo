package com.dayuan.util.wx;

import com.dayuan.util.DateUtil;

/**
 * 微信常量类
 * Created by shit on 2018/8/19.
 */
public class WxConst {
    //短信验证码的有效时间为(60秒)
    public static int STIPULATE_TIME = 60;
    //产品名称:云通信短信API产品,开发者无需替换
    public static final String product = "Dysmsapi";
    //产品域名,开发者无需替换
    public static final String domain = "dysmsapi.aliyuncs.com";

    //下午下班14:30:01后就把下午未打卡的人设置为缺勤
    public static final String endTime = " 14:30:01";
    //上下班时间常量
    public static final String punchCardStartTime1 = "08:30";//上午上班
    public static final String punchCardEndTime1 = "12:00";//上午下班
    public static final String punchCardStartTime2 = "14:30";//下午上班
    public static final String punchCardEndTime2 = "17:30";//下午下班
    //迟到5分钟不算迟到 允许迟到时间
    public static final Integer allowLateTime = 10;

    public static Double dutyAttendance;//每天应该出勤时长


    //计算迟到分钟数测试
    public static void main(String[] args) throws Exception {
       /* Long timestamp1 = DateUtil.getTimestamp("HH:mm", "08:30");
        Long timestamp2 = DateUtil.getTimestamp("HH:mm", "12:00");
        Long timestamp3 = DateUtil.getTimestamp("HH:mm", "14:30");
        Long timestamp4 = DateUtil.getTimestamp("HH:mm", "17:30");
        System.out.println(timestamp1 + "---1");
        System.out.println(timestamp2 + "---2");
        System.out.println(timestamp3 + "---3");
        System.out.println(timestamp4 + "---4");
        System.out.println(((double) ((timestamp2 - timestamp1) + (timestamp4 - timestamp3)) / 1000) / 60 / 60);*/
       /*Double v;
        v = (double) Math.round(12.23693274932 * 100);
        System.out.println(v/100);*/
        /*Long timestamp1 = DateUtil.getTimestamp("yyyy-MM-dd HH:mm", "2018-10-18 08:30:00");
        Long timestamp2 = DateUtil.getTimestamp("yyyy-MM-dd HH:mm", "2018-10-18 08:30:56");
        System.out.println(timestamp1);
        System.out.println(timestamp2);
        long lateTime = (timestamp2 - timestamp1) / 60000;
        System.out.println("2018-10-18 08:30:00".equals("2018-10-18 08:30:00"));*/

        //时间戳转字符串测试
        /*Long timestamp1 = DateUtil.getTimestamp("yyyy-MM-dd HH:mm", "2018-10-18 08:30:00");
        Long timestamp2 = DateUtil.getTimestamp("yyyy-MM-dd HH:mm", "2018-10-18 08:30:56");
        System.out.println(timestamp1);
        System.out.println(timestamp2);
        long i = WxConst.allowLateTime * 60000;
        Date date = new Date(timestamp1 + i);
        String format = DateUtil.time_sdf.format(date);
        System.out.println(format);*/
    }

    //计算一天内应出勤时间
    static {
        try {
            Long timestamp1 = DateUtil.getTimestamp("HH:mm", punchCardStartTime1);
            Long timestamp2 = DateUtil.getTimestamp("HH:mm", punchCardEndTime1);
            Long timestamp3 = DateUtil.getTimestamp("HH:mm", punchCardStartTime2);
            Long timestamp4 = DateUtil.getTimestamp("HH:mm", punchCardEndTime2);
            Double v = ((double) ((timestamp2 - timestamp1) + (timestamp4 - timestamp3)) / 1000) / 60 / 60;
            dutyAttendance = v;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
