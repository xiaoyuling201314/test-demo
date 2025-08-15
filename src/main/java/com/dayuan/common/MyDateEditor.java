package com.dayuan.common;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.PropertiesEditor;

import com.dayuan.util.StringUtil;

/**
 * 日期格式转换器
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2017年8月11日
 */
public class MyDateEditor extends PropertiesEditor{
	
    @Override
   public void setAsText(String source) throws IllegalArgumentException {
        
     SimpleDateFormat sdf = getDateFormat(source);
     try {
    	 if(null == sdf){
    		 setValue(null);
    	 }else{
    		 setValue(sdf.parseObject(source));
    	 }
     } catch (ParseException e) {
    	 e.printStackTrace();
     }
        
   }

    /**
     * 日期格式
     * @param source 日期字符串
     * @return
     */
    public SimpleDateFormat getDateFormat(String source) {
    	if(StringUtil.isEmpty(source)){
    		return null;
    	}else if(source.matches("^\\d{4}-\\d{1,2}$")){
            return new SimpleDateFormat("yyyy-MM");
        }else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$")){
            return new SimpleDateFormat("yyyy-MM-dd");
        }else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}$")){
            return new SimpleDateFormat("yyyy-MM-dd hh:mm");
        }else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}:\\d{1,2}$")){
            return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        }else {
        	throw new IllegalArgumentException("时间格式不正确，支持:yyyy-MM、yyyy-MM-dd、yyyy-MM-dd HH:mm和yyyy-MM-dd HH:mm:ss");
        }
    }

}