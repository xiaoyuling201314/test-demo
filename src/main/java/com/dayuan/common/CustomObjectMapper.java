package com.dayuan.common;

import java.io.IOException;

import com.dayuan.util.DateUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月6日
 */
public class CustomObjectMapper extends ObjectMapper {

	private static final long serialVersionUID = 1L;
	
	public CustomObjectMapper(){
		setDateFormat(DateUtil.datetimeFormat);
		this.getSerializerProvider().setNullValueSerializer(new com.fasterxml.jackson.databind.JsonSerializer<Object>() {
			@Override
			public void serialize(Object obj, com.fasterxml.jackson.core.JsonGenerator jsonGenerator, com.fasterxml.jackson.databind.SerializerProvider provider) throws IOException {
				jsonGenerator.writeString("");
			}
		});
		// 禁用 FAIL_ON_EMPTY_BEANS 特性
		configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		// 配置Jackson将字符串"null"视为null值
		configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
	}
}
