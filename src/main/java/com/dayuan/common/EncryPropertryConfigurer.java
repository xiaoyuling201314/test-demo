package com.dayuan.common;

import java.util.Enumeration;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

import com.dayuan.util.CodecUtils;
import com.dayuan.util.StringUtil;

public class EncryPropertryConfigurer extends PropertyPlaceholderConfigurer {

	@Override
	protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess, Properties props) throws BeansException {
		String key=props.getProperty("jdbc.key");
		
		String url1=props.getProperty("jdbc.url1");
		if(StringUtil.isNotEmpty(url1)){
			props.setProperty("jdbc.url1", CodecUtils.aesDecrypt(url1, key));
		}
	/*	String url2=props.getProperty("jdbc.url2");
		if(StringUtil.isNotEmpty(url2)){
			props.setProperty("jdbc.url2", CodecUtils.aesDecrypt(url2, key));
		}
		*/
		String username1=props.getProperty("jdbc.username1");
		if(StringUtil.isNotEmpty(username1)){
			props.setProperty("jdbc.username1", CodecUtils.aesDecrypt(username1, key));
		}
		/*String username2=props.getProperty("jdbc.username2");
		if(StringUtil.isNotEmpty(username2)){
			props.setProperty("jdbc.username2", CodecUtils.aesDecrypt(username2, key));
		}*/
		
		String password1=props.getProperty("jdbc.password1");
		if(StringUtil.isNotEmpty(password1)){
			props.setProperty("jdbc.password1", CodecUtils.aesDecrypt(password1, key));
		}
		/*String password2=props.getProperty("jdbc.password2");
		if(StringUtil.isNotEmpty(password2)){
			props.setProperty("jdbc.password2", CodecUtils.aesDecrypt(password2, key));
		}*/
		
//		for (Enumeration<Object> e = props.keys(); e.hasMoreElements();) {
//			String ne = (String) e.nextElement();
//			System.out.println(ne+":"+props.getProperty(ne));
//		}
		super.setFileEncoding("UTF-8");
		super.processProperties(beanFactoryToProcess, props);
	}
}
