import cn.hutool.core.date.LocalDateTimeUtil;
import org.junit.jupiter.api.Test;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAccessor;
import java.time.temporal.TemporalAdjusters;
import java.util.Locale;

/**
 * TestDate 类
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/8/6 11:27
 * @description 类的功能描述
 */
public class TestDate {
    public static void main(String[] args) {
       /* DateTimeFormatter formart= DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss", Locale.CHINESE);
        LocalDateTime local=LocalDateTime.of(2025,8,6,11,30,20);
        String format = formart.format(local);
        TemporalAccessor parse = formart.parse("2025-08-06");
        System.out.println(format+","+parse.toString());*/
        String format = LocalDateTimeUtil.format(LocalDateTime.now(), "yyyy-MM-dd HH:mm:ss");
        System.out.println(format);
    }
    @Test
    public void testLocalDate() {
        // 获取今天的日期
        LocalDate today = LocalDate.now();
        System.out.println("获取今天的日期 = " + today);
        // 构造日期LocalDate(严格按照yyyy-MM-dd验证，02写成2都不行，当然也有一个重载方法允许自己定义格式 )
        LocalDate localDate = LocalDate.parse("2023-02-01");
        System.out.println("将String类型日期格式化成LocalDate类型 = " + localDate);
        // 将LocalDate格式化成字符串
        DateTimeFormatter formatters = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String text = today.format(formatters);
        System.out.println("将LocalDate格式化成字符串 = " + text);

        // 今天是几号
        int dayUfMonth = today.getDayOfMonth();
        System.out.println("今天是几号 = " + dayUfMonth);
        // 今天是周几（返回的是个枚举类型，需要再getValue()）
        int dayOfWeek = today.getDayOfWeek().getValue();
        System.out.println("今天是周几 = " + dayOfWeek);
        // 今天是今年中的第几天
        int dayOfYear = today.getDayOfYear();
        System.out.println("今天是今年中的第几天 = " + dayOfYear);
        // 获取当前月份
        int value = today.getMonth().getValue();
        System.out.println("今天是第几月 = " + value);
        // 获取当前年份
        int year = today.getYear();
        System.out.println("当前年份 = " + year);
        // 判断当前年份是否是闰年
        boolean leapYear = today.isLeapYear();
        System.out.println("是否是闰年 = " + leapYear);
        // 判断当月有几天
        int length = today.getMonth().length(leapYear);
        System.out.println("当月有几天 = " + length);
        // 获取当天开始时间(获取的是年月日类型的)
        LocalDateTime localDateTime = today.atStartOfDay();
        System.out.println("获取当天开始时间 = " + localDateTime); //2023-02-01T00:00
        // 设置当前月份的指定天数的日期
        LocalDate dayOfMonth = today.withDayOfMonth(3);
        System.out.println("当前月份的指定天数的日期 = " + dayOfMonth);
        // 设置当前年份指定天数的日期
        LocalDate dayOfYear1 = today.withDayOfYear(15);
        System.out.println("当前年份指定天数的日期 = " + dayOfYear1);
        // 当前日期向后推几天
        LocalDate plusDays = today.plusDays(4);
        System.out.println("当前日期向后推4天 = " + plusDays);
        // 当前日期向后推几个时间单位
        LocalDate plusWeeks = today.plus(4, ChronoUnit.WEEKS);
        System.out.println("当前日期向后推4个星期 = " + plusWeeks);

        // 取本月第1天：
        LocalDate firstDayOfThisMonth = today.with(TemporalAdjusters.firstDayOfMonth());
        System.out.println("本月第1天 = " + firstDayOfThisMonth);
        // 取本月第2天：
        LocalDate secondDayOfThisMonth = today.withDayOfMonth(2);
        System.out.println("本月第2天 = " + secondDayOfThisMonth);
        // 取本月最后一天，再也不用计算是28，29，30还是31：
        LocalDate lastDayOfThisMonth = today.with(TemporalAdjusters.lastDayOfMonth());
        System.out.println("本月最后一天 = " + lastDayOfThisMonth);
        // 取下一天：
        LocalDate firstDayOfNextMonth = lastDayOfThisMonth.plusDays(1);
        System.out.println("本月最后一天的下一天 = " + firstDayOfNextMonth);
        // 取2023年2月第一个周一：
        LocalDate firstMondayOf2023= LocalDate.parse("2023-02-01").with(TemporalAdjusters.firstInMonth(DayOfWeek.MONDAY));
        System.out.println("2023年2月第一个周一 = " + firstMondayOf2023);
    }
}
