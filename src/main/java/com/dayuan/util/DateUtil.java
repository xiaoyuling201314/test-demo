package com.dayuan.util;

import com.dayuan.exception.MyException;
import com.dayuan3.common.model.TimeModel;
//import com.dayuan3.common.model.TimeModel;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 常用按 开始日期 和 结束日期 查询处理
 *
 * @author Bill
 *         <p>
 *         2017年7月13日
 */
public class DateUtil {

    // 各种时间格式
    public static final SimpleDateFormat date_sdf = new SimpleDateFormat("yyyy-MM-dd");
    public static final SimpleDateFormat date_sdf2 = new SimpleDateFormat("yyyy/MM/dd");
    public static final SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
    public static final SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
    public static final SimpleDateFormat MMdd = new SimpleDateFormat("MMdd");
    public static final SimpleDateFormat date_sdf_wz = new SimpleDateFormat("yyyy年MM月dd日");
    public static final SimpleDateFormat date_sdf_yd = new SimpleDateFormat("yyyy年MM月");
    public static final SimpleDateFormat date_sdf_y = new SimpleDateFormat("yyyy年");
    public static final SimpleDateFormat time_sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    public static final SimpleDateFormat yyyymmddhhmmss = new SimpleDateFormat("yyyyMMddHHmmss");
    public static final SimpleDateFormat yyyymmddhhmmssSSS = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    public static final SimpleDateFormat short_time_sdf = new SimpleDateFormat("HH:mm");
    public static final SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static final SimpleDateFormat datetimeFormat2 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    public static final SimpleDateFormat HHMMSS = new SimpleDateFormat("HH时mm分ss秒");
    public static final SimpleDateFormat MM_dd = new SimpleDateFormat("MM-dd");
    // 以毫秒表示的时间
    private static final long DAY_IN_MILLIS = 24 * 3600 * 1000;
    private static final long HOUR_IN_MILLIS = 3600 * 1000;
    private static final long MINUTE_IN_MILLIS = 60 * 1000;
    private static final long SECOND_IN_MILLIS = 1000;

    // @Test
    public static String SEDate(String start, String end) throws ParseException {

        DateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        DateFormat formatStr = new SimpleDateFormat("yyyy/MM/dd");
        int dayMis = 1000 * 60 * 60 * 24;//
        // CreateTime=2015/01/16&EndTime=2015/01/16 23:59:59
        // 如果日期为空 查询全部
        if ((start == null || "".equals(start)) && (end == null || "".equals(end))) {
            return "";
        }

        // 如果开始日期有 结束日期没有 则查询 开始日期当天的时间
        if ((start != null && !"".equals(start)) && (end == null || "".equals(end))) {
            long endLong = formatStr.parse(start).getTime() + dayMis - 1;
            String endStr = format.format(new Date(endLong));
            System.out.println(endStr);
            return "CreateTime=" + start + "&EndTime=" + endStr;
        }

        // 如果结束日期有 开始日期没有 则查询 结束日期当天的时间
        if ((start == null || "".equals(start)) && (end != null && !"".equals(end))) {
            long endLong = formatStr.parse(end).getTime() + dayMis - 1;
            String endStr = format.format(new Date(endLong));
            System.out.println(endStr);
            return "CreateTime=" + end + "&EndTime=" + endStr;
        }

        // 正常日期查询
        if (start != null && !"".equals(start) && end != null && !"".equals(end)) {
            long endLong = formatStr.parse(end).getTime() + dayMis - 1;
            String endStr = format.format(new Date(endLong));
            System.out.println(endStr);
            return "CreateTime=" + start + "&EndTime=" + endStr;
        }

        return "CreateTime=" + start + "&EndTime=" + end;
    }

    /**
     * 验证日期格式是否为：yyyy-MM-dd 或者 yyyy-MM-dd HH:mm:ss
     *
     * @param date
     * @return
     */
    public static boolean checkDate(String date) {
        String dateReg = "^(\\d{4}-\\d{1,2}-\\d{1,2})|(\\d{4}-\\d{1,2}-\\d{1,2}\\s\\d{1,2}:\\d{1,2}:\\d{1,2})$";
        Pattern pattern = Pattern.compile(dateReg);
        Matcher matcher = pattern.matcher(date);
        return matcher.matches();
    }
    /**
     * 验证日期格式是否为：yyyy-MM-dd
     *
     * @param date
     * @return
     */
    public static boolean checkDate2(String date) {
        String dateReg = "^(\\d{4}-\\d{2}-\\d{2})$";
        Pattern pattern = Pattern.compile(dateReg);
        Matcher matcher = pattern.matcher(date);
        return matcher.matches();
    }

    public static boolean checkDates(String date) {
        String dateReg = "^(\\d{4}/\\d{1,2}/\\d{1,2})|(\\d{4}/\\d{1,2}/\\d{1,2}\\s\\d{1,2}:\\d{1,2}:\\d{1,2})$";
        Pattern pattern = Pattern.compile(dateReg);
        Matcher matcher = pattern.matcher(date);
        return matcher.matches();
    }

    /**
     * 将时间转换为指定格式字符串
     *
     * @param date
     * @param pattern
     * @return
     * @author xyl 2017-09-13
     */
    public static String formatDate(Date date, String pattern) {
        if (pattern == null || pattern.equals("") || pattern.equals("null")) {
            pattern = "yyyy-MM-dd";
        }
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(pattern);
        return sdf.format(date);
    }

    /**
     * 将指定格式字符串转换为时间
     *
     * @param date
     * @param pattern
     * @return
     * @throws ParseException
     * @author Dz
     * 2019年6月25日 下午3:40:07
     */
    public static Date parseDate(String date, String pattern) throws ParseException {
        if (pattern == null || pattern.equals("") || pattern.equals("null")) {
            pattern = "yyyy-MM-dd";
        }
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(pattern);
        return sdf.parse(date);
    }

    /**
     * 获取当前月第一天
     *
     * @return
     * @author Dz
     */
    public static String firstDayOfMonth() {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, 1);//设置为1号,当前日期既为本月第一天
        return date_sdf.format(c.getTime());
    }

    /**
     * 获取当前月最后一天
     *
     * @return
     * @author Dz
     */
    public static String lastDayOfMonth() {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
        return date_sdf.format(c.getTime());
    }

    /**
     * 获取指定天数前或指定天数后日期
     *
     * @param x(负数为指定天数前日期，正数为指定天数后日期)
     * @return
     * @author Dz
     */
    public static String xDayAgo(int x) {
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DATE, x);
        return date_sdf.format(c.getTime());
    }

    /**
     * 获取某个月的最后一天
     *
     * @param month 传入月份数
     * @return
     */
    public static int lastDayOfMonth(int month) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.MONTH, month);
        c.set(Calendar.DATE, 1);//设置日期为当前月的第一天
        c.set(Calendar.DATE, -1);//日期回滚一天则为最后一天
        return c.get(Calendar.DATE) + 1;
    }

    /**
     * 获取某年某月的最后一天 因为有平年二月和闰年二月不一样
     *
     * @param year  传入年份数
     * @param month 传入月份数
     * @return
     */
    public static int lastDayOfMonth(int year, int month) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.MONTH, month);
        c.set(Calendar.YEAR, year);
        c.set(Calendar.DATE, 1);//设置日期为当前月的第一天
        c.set(Calendar.DATE, -1);//日期回滚一天则为最后一天
        return c.get(Calendar.DATE) + 1;
    }

    public static void main(String[] args) {
        String code = String.format("%0" + 2 + "d", 1);
        System.out.println(code);
        System.out.println(lastDayOfMonth(2));
        //获取润年2月最后一天，方式1，方式2
        System.out.println(lastDayOfMonth(2008, 2));
        Date date = new Date(2008, 2, 0);
        System.out.println(date.getDate());
    }


    /**
     * 得到某一天的最后一秒钟
     */
    public static Date getEndDate(Date now) {
        if (now == null) {
            return null;
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        calendar.add(Calendar.DATE, 1);
        calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
                calendar.get(Calendar.DATE), 0, 0, 0);
        calendar.add(Calendar.SECOND, -1);
        now = calendar.getTime();
        return now;
    }

    /**
     * 两个时间时差 - 毫秒
     */
    public static int getTimeDifferenceMs(Date one, Date other) {
        return (int) (Math.abs(one.getTime() - other.getTime()));
    }

    /**
     * 两个时间的间隔秒
     */
    public static int getBetweenTime(Date one, Date other) {
        return (int) (Math.abs(one.getTime() - other.getTime()) / 1000);
    }

    /**
     * 两个日期相隔天数
     *
     * @param dateStart
     * @param dateEnd
     * @return
     * @author Dz
     * 2019年5月27日 下午5:27:30
     */
    public static int getBetweenDays(Date dateStart, Date dateEnd) {
        return (int) ((dateEnd.getTime() - dateStart.getTime()) / 1000 / 60 / 60 / 24);
    }

   /**
   * @Description 获取两个日期相差的天数，保留小数位
   * @Date 2022/06/29 15:05
   * @Author xiaoyl
   * @Param
   * @return
   */
  /*  public static float getBetweenDays2Float(Date dateStart, Date dateEnd) {
        Calendar start = Calendar.getInstance();
        start.setTime(dateStart);
        int hours=(int) ((dateEnd.getTime() - dateStart.getTime()) / 1000 / 60 / 60);
        float days=(float)hours/24;
        return days;
    }*/
    /**
    * @Description 判断起始日期dateStart加上HandledTime天是否超过结束日期dateEnd；
     * 举例：2022-06-23 15:28:26与2022-06-27 10:09:10之间是否超过3天
    * @Date 2022/06/29 16:46
    * @Author xiaoyl
    * @Param dateStart 开始日期
    * @Param dateEnd 结束日期
    * @Param HandledTime 间隔天数
    * @return true，已超时，false，未超时
    */
    public static Boolean checkIsTimeOut(Date dateStart, Date dateEnd,int handledTime) {
        Calendar start = Calendar.getInstance();
        start.setTime(dateStart);
        start.add(Calendar.DATE, handledTime);
        if(start.getTime().getTime()<dateEnd.getTime()){
            return true;
        }
        return false;
    }
    /**
     * 计算两个日期相差月份
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public static Integer getDifMonth(Date startDate, Date endDate) {
        Calendar start = Calendar.getInstance();
        Calendar end = Calendar.getInstance();
        if (startDate.getTime() < endDate.getTime()) {
            start.setTime(startDate);
            end.setTime(endDate);
        } else {
            start.setTime(endDate);
            end.setTime(startDate);
        }

        //同年
        if (start.get(Calendar.YEAR) == end.get(Calendar.YEAR)) {
            //同月
            if (start.get(Calendar.MONTH) == end.get(Calendar.MONTH)) {
                return 1;

            //不同月，开始日 < 结束日
            } else if (start.get(Calendar.DAY_OF_MONTH) < end.get(Calendar.DAY_OF_MONTH)){
                return Math.abs(end.get(Calendar.MONTH) - start.get(Calendar.MONTH) + 1);

            //不同月，开始日 >= 结束日
            } else{
                return Math.abs(end.get(Calendar.MONTH) - start.get(Calendar.MONTH));
            }

        //不同年
        } else {
            int month0 = Math.abs(end.get(Calendar.YEAR) - start.get(Calendar.YEAR) + 1) * 12
                    - (start.get(Calendar.MONTH) + 1) - (11 - end.get(Calendar.MONTH));

            //开始日 < 结束日
            if (start.get(Calendar.DAY_OF_MONTH) < end.get(Calendar.DAY_OF_MONTH)) {
                return month0 +1;

            //开始日 >= 结束日
            } else{
                return month0;
            }
        }
    }


    /**
     * 获取指定时间的时间戳
     *
     * @param pattern 指定格式
     * @param Strdate 对应格式的时间字符串
     * @return
     */
    public static Long getTimestamp(String pattern, String Strdate) throws Exception {
        DateFormat df = new SimpleDateFormat(pattern);
        Date date = df.parse(Strdate);
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.getTimeInMillis();
    }


    /**
     * 获取 获取某年某月 所有日期（yyyy-mm-dd格式字符串）
     *
     * @param year
     * @param month
     * @return
     * @author wtt
     * @date 2018年11月22日
     */
    public static List<String> getMonthFullDay(int year, int month) {
        SimpleDateFormat dateFormatYYYYMMDD = new SimpleDateFormat("yyyy-MM-dd");
        List<String> fullDayList = new ArrayList<>(32);
        // 获得当前日期对象
        Calendar cal = Calendar.getInstance();
        cal.clear();// 清除信息
        cal.set(Calendar.YEAR, year);
        // 1月从0开始
        cal.set(Calendar.MONTH, month - 1);
        // 当月1号
        cal.set(Calendar.DAY_OF_MONTH, 1);
        int count = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        for (int j = 1; j <= count; j++) {
            fullDayList.add(dateFormatYYYYMMDD.format(cal.getTime()));
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }
        return fullDayList;
    }

    /**
     * 获取当前时间的前多少个月的起止时间
     *
     * @return
     * @author wtt
     */
    public static StringDate getFristThreeMonth(Integer monthCount) {
        Date dNow = new Date();   //当前时间
        Date dBefore = new Date();
        Calendar calendar = Calendar.getInstance(); //得到日历
        calendar.set(Calendar.DAY_OF_MONTH, 1);//设置为1号,当前日期既为本月第一天
        dNow = calendar.getTime();
        calendar.setTime(calendar.getTime());//把当前时间赋给日历
        calendar.add(Calendar.MONTH, -monthCount);  //设置为前monthCount月
        dBefore = calendar.getTime();   //得到前monthCount月的时间

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //设置时间格式
        String defaultStartDate = sdf.format(dBefore);    //格式化前3月的时间
        String defaultEndDate = sdf.format(dNow); //格式化当前时间
        StringDate dateFormat = new StringDate();
        dateFormat.setStartDate(defaultStartDate);
        dateFormat.setEndDate(defaultEndDate);

        return dateFormat;
    }

    /**
     * 获取传入日期的1号
     *
     * @param d
     * @return
     * @author xiaoyl
     * @date : 2019年6月6日 上午9:46:34
     */
    public static Date firstDayOfMonth(Date d) {
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        c.set(Calendar.DAY_OF_MONTH, 1);//设置为1号,当前日期既为本月第一天
        return c.getTime();
    }

    public static class StringDate {
        private String StartDate;//开始时间

        private String EndDate;//结束时间

        public String getStartDate() {
            return StartDate;
        }

        public void setStartDate(String startDate) {
            StartDate = startDate;
        }

        public String getEndDate() {
            return EndDate;
        }

        public void setEndDate(String endDate) {
            EndDate = endDate;
        }
    }


//    /**
//     * 查询条件处理：拼接时间
//     *
//     * @param type   类型 month、season、year、diy（月、季、年、自定义）
//     * @param month  月
//     * @param season 年
//     * @param year   季度
//     * @param start  开始时间
//     * @param end    结束时间
//     * @return
//     */
//    public static TimeModel formatTime(String type, String month, String season, String year, String start, String end) {
//        TimeModel model = new TimeModel();
//        if (type.equals("month")) {
//            if (month.length() < 2) {
//                month = "0" + month;
//            }
//            start = year + "-" + month + "-01";
//            end = year + "-" + month + "-31 23:59:59";
//        } else if (type.equals("season")) {
//            if (season.equals("1")) {
//                start = year + "-01-01";
//                end = year + "-03-31 23:59:59";
//            } else if (season.equals("2")) {
//                start = year + "-04-01";
//                end = year + "-06-30 23:59:59";
//            } else if (season.equals("3")) {
//                start = year + "-07-01";
//                end = year + "-09-30 23:59:59";
//            } else if (season.equals("4")) {
//                start = year + "-10-01";
//                end = year + "-12-31 23:59:59";
//            }
//        } else if (type.equals("year")) {
//            start = year + "-01-01";
//            end = year + "-12-31 23:59:59";
//        } else if (type.equals("diy")) {
//            if (StringUtil.isEmpty(end)) {//如果为空，那么最大查询到当天时间为止
//                end = DateUtil.date_sdf.format(new Date());
//            }
//            end = end + " 23:59:59";
//        }
//
//        model.setStart(start);
//        model.setEnd(end);
//        return model;
//    }


    //

    /**
     * 获取两个时间段之间的周六周日个数之和(前补后砍算法,参考CSDN,不需要考虑跨多年时需要处理闰年的问题)
     *
     * @param start 开始时间
     * @param end   结束时间
     * @param sdf   格式化
     * @return
     */
    public static Integer getWeekendDays(String start, String end, SimpleDateFormat sdf) throws Exception {
        if (StringUtil.isEmpty(start)) {
            throw new MyException("start参数必填！");
        }
        if (StringUtil.isEmpty(end)) {
            throw new MyException("end参数必填！");
        }
        if (sdf == null) {
            throw new MyException("sdf参数必填！");
        }
        Calendar c1 = Calendar.getInstance();//开始时间
        Calendar c2 = Calendar.getInstance();//开始时间
        c1.setTime(sdf.parse(start));
        c2.setTime(sdf.parse(end));
        if (c2.getTime().compareTo(c1.getTime()) >= 0) {//结束时间大于等于开始时间
            int w1 = c1.get(Calendar.DAY_OF_WEEK) - 1;
            int w2 = c2.get(Calendar.DAY_OF_WEEK) - 1;
            w2 = w2 == 0 ? 7 : w2;
            w1 = w1 == 0 ? 7 : w1;
            int reduceNum = w1 == 7 ? 1 : 0;//如果开始日期恰好是周日，那么补上6天的同时，最后的结果需要减去一天（周六）
            int startNum = w1 - 1;//不足一周，如果开始日期是星期6，则补上5天，也就是6-1
            int addEndNum = 0;//将后面多余的不足一周的天数，砍掉，例如，结束日期为星期3，那么就从总天数里减去3天，如果结束日期为星期6或者星期天，那么减去6或7的同时，还要在最后补上1或2
            if (w2 == 6) {
                addEndNum = 1;
            } else if (w2 == 7) {
                addEndNum = 2;
            }

            long beginTime = c1.getTime().getTime();
            long endTime = c2.getTime().getTime();
            int betweenDays = (int) ((endTime - beginTime) / (1000 * 60 * 60 * 24));
            int allDayNum = betweenDays + 1;//间隔天数+1得到总天数

            /*System.out.println("总天数：" + allDayNum);
            System.out.println("前补天数：" + startNum);
            System.out.println("前补多补天数（减去多补的周六）：" + reduceNum);
            System.out.println("后减天数：" + w2);
            System.out.println("后减多减的天数（减多的周六和周日）：" + addEndNum);
            System.out.println("总天数：" + allDayNum);*/
            //时间段内周末天数=(总天数（allDayNum）+前补天数（startNum）-后减天数（w2）)/7*2 -前补多补天数（reduceNum）+后减多减的天数(addEndNum)
            //System.out.println("最后求得周末天数：" + ((allDayNum + startNum - w2) / 7 * 2 - reduceNum + addEndNum));
            return (allDayNum + startNum - w2) / 7 * 2 - reduceNum + addEndNum;
        } else {
            throw new MyException("开始时间不等大于结束时间！");
        }
    }
    /**
     * 查询条件处理：拼接时间
     *
     * @param type   类型 month、season、year、diy（月、季、年、自定义）
     * @param month  月
     * @param season 年
     * @param year   季度
     * @param start  开始时间
     * @param end    结束时间
     * @return
     */
    public static TimeModel formatTime(String type, String month, String season, String year, String start, String end) {
        TimeModel model = new TimeModel();
        if (type.equals("month")) {
            if (month.length() < 2) {
                month = "0" + month;
            }
            start = year + "-" + month + "-01";
            end = year + "-" + month + "-31 23:59:59";
        } else if (type.equals("season")) {
            if (season.equals("1")) {
                start = year + "-01-01";
                end = year + "-03-31 23:59:59";
            } else if (season.equals("2")) {
                start = year + "-04-01";
                end = year + "-06-30 23:59:59";
            } else if (season.equals("3")) {
                start = year + "-07-01";
                end = year + "-09-30 23:59:59";
            } else if (season.equals("4")) {
                start = year + "-10-01";
                end = year + "-12-31 23:59:59";
            }
        } else if (type.equals("year")) {
            start = year + "-01-01";
            end = year + "-12-31 23:59:59";
        } else if (type.equals("diy")) {
            if (StringUtil.isEmpty(end)) {//如果为空，那么最大查询到当天时间为止
                end = DateUtil.date_sdf.format(new Date());
            }
            end = end + " 23:59:59";
        }

        model.setStart(start);
        model.setEnd(end);
        return model;
    }
}