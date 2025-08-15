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
public @interface QrcodeScanCount {
    /*
     *操作模块
     */
    String module() default "";

    /*
     *扫描类型：0 抽样单，1 监管对象，2 经营户
     */
    int scanType() default 0;
}
