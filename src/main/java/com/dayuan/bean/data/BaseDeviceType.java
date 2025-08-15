package com.dayuan.bean.data;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableLogic;
import com.dayuan.bean.BaseBean;
import lombok.Data;

/**
 * 
 * Description:仪器类别维护管理
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月16日
 */
@Data
public class BaseDeviceType extends BaseBean {
	
	private String number;

	private String brand;
	
	private Short type;//0仪器,1检测箱

    private String deviceName;      //仪器名称

    private String deviceSeries;	//仪器系列

    private String deviceVersion;	//仪器版本
    
    private String deviceType;//仪器类型
    
    private String deviceMaker;		//生产厂家

    private String description;		//功能描述
    
    private Short checked;			//是否审核： 0未审核，1审核
    
    private String filePath;		// 仪器图片存放路径file_path

    @TableLogic
    private Short deleteFlag;

    private String createBy;

    private Date createDate;
    
    private String updateBy;

    private Date updateDate;

    private String param1;

    private String param2;

    private String param3;

}