package com.dayuan3.api.config;


import cn.dev33.satoken.exception.NotLoginException;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramException;
import com.dayuan3.api.common.MiniProgramJson;
import org.springframework.beans.TypeMismatchException;
import org.springframework.core.convert.ConversionFailedException;
import org.springframework.http.converter.HttpMessageConversionException;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

/**
 * GlobalExceptionHandler 全局异常处理器
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/6/18 13:28
 * @description 类的功能描述
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    // 处理未登录异常
    @ExceptionHandler(NotLoginException.class)
    public Object handleNotLoginException(NotLoginException e) {
        // 判断token类型
        String message = "";
        switch (e.getType()) {
            case NotLoginException.NOT_TOKEN:
                message = "未提供token";
                break;
            case NotLoginException.INVALID_TOKEN:
                message = "token无效";
                break;
            case NotLoginException.TOKEN_TIMEOUT:
                message = "token已过期";
                break;
            case NotLoginException.BE_REPLACED:
                message = "token已被顶下线";
                break;
            case NotLoginException.KICK_OUT:
                message = "token已被踢下线";
                break;
            default:
                message = "未登录";
                break;
        }

        // 返回自定义格式
        return MiniProgramJson.error(ErrCode.AUTH_ERROR, message);
    }
    /**
     * 处理必填参数缺失异常
     */
    @ExceptionHandler(MissingServletRequestParameterException.class)
    public MiniProgramJson handleMissingParamException(MissingServletRequestParameterException ex) {
        String message= "缺少必填参数: " + ex.getParameterName();
        return MiniProgramJson.error(ErrCode.PARAM_REQUIRED, message);
    }

    /**
     * 处理JSON参数解析错误
     */
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public MiniProgramJson handleHttpMessageNotReadableException(HttpMessageNotReadableException ex) {
        String message= "请求参数格式错误: " + ex.getMessage();
        return MiniProgramJson.error(ErrCode.PARAM_ILLEGAL, message);
    }

    /**
     * 参数错误
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public MiniProgramJson handleMethodArgumentNotValidException(MethodArgumentNotValidException ex) {
//        String message= "请求参数错误: " + ex.getMessage();
        StringBuffer message= new StringBuffer("请求参数错误: ");
        ex.getBindingResult().getFieldErrors().forEach(fieldError -> {
            message.append(fieldError.getField() + ": " + fieldError.getDefaultMessage() + "; ");
        });
        return MiniProgramJson.error(ErrCode.PARAM_ILLEGAL, message.toString());
    }

    /**
     * 自定义异常
     */
    @ExceptionHandler(MiniProgramException.class)
    public MiniProgramJson handleMiniProgramException(MiniProgramException ex) {
        return MiniProgramJson.error(ex.getErrCode(), ex.getMessage());
    }

    /**
     * 处理参数类型不匹配异常
     */
    @ExceptionHandler({
            TypeMismatchException.class,
            MethodArgumentTypeMismatchException.class,
            ConversionFailedException.class,
            HttpMessageConversionException.class,
            IllegalArgumentException.class,
            BindException.class
    })
    public MiniProgramJson handleHttpTypeMismatchException(Exception  ex) {
        String message = "参数类型错误: ";
        // 针对 BindException 特殊处理（表单绑定错误）
        if (ex instanceof BindException) {
            BindException bindException = (BindException) ex;
            FieldError fieldError = bindException.getFieldError();
            if (fieldError != null) {
                // 提取更详细的类型信息
                String errorDetails = extractTypeMismatchDetails(fieldError);
                message = String.format("参数类型错误: 字段[%s] 需要%s类型, 但收到值: '%s'",
                        fieldError.getField(),
                        errorDetails,
                        fieldError.getRejectedValue());
            }
        }else if (ex instanceof ConversionFailedException) {
            ConversionFailedException cfe = (ConversionFailedException) ex;
            message += "无法将 " + cfe.getValue() + " 转换为 " + cfe.getTargetType().getName();
        } else {
            message += ex.getMessage();
        }
        return MiniProgramJson.error(ErrCode.PARAM_BIND_ERROR, message);
    }
    /**
     * 提取详细的类型不匹配信息
     */
    private String extractTypeMismatchDetails(FieldError fieldError) {
        // 1. 尝试从错误代码中提取期望类型
       /* String[] codes = fieldError.getCodes();
        if (codes != null) {
            for (String code : codes) {
                if (code.startsWith("typeMismatch.")) {
                    // 示例: "typeMismatch.inspectionUnitUserReqVo.coldUnitId"
                    String[] parts = code.split("\\.");
                    if (parts.length > 2) {
                        // 提取字段名后面的部分作为类型提示
                        return parts[parts.length - 1];
                    }
                }
            }
        }*/

        // 2. 备选方案：从默认消息中提取
        String defaultMessage = fieldError.getDefaultMessage();
        if (defaultMessage != null && defaultMessage.contains("required type")) {
            // 示例: "Failed to convert property value of type 'java.lang.String' to required type 'java.lang.Integer'"
            return defaultMessage.substring(
                    defaultMessage.indexOf("required type") + 13,
                    defaultMessage.indexOf("for property")
            ).trim();
        }

        // 3. 使用通用类型描述
        return "正确的";
    }
}
