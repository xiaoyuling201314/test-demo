package com.dayuan.logs.aop;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 可以用于class、method 或 param
 * 如果在method和class都有，则以method的为准
 *
 * @Date 2021/05/25 14:12
 * @Author xiaoyl
 * @Param
 * @return
 */
@Target(value = {ElementType.METHOD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface SystemLog {
    /*
     *模块名称
     */
    String module() default "";

    /*
     *方法名称
     */
    String methods() default "";

    /**
     * 查询的bean名称
     */
    String serviceClass() default "";

    /*
    *查询单个详情的bean的方法
     */
    String queryMethod() default "queryById";

    /**
     * 从页面参数中解析出要查询的id，
     * 如域名修改中要从参数中获取customerDomainId的值进行查询
     */
    String parameterKey() default "";

    String parameterType() default "String";

    /*
     *操作类型： 0普通操作，1新建或编辑 ，3删除
     */
    int type() default 0;

    /*
     *数据来源： 1_平台,2_APP,3_仪器
     */
    String source() default "";
}
