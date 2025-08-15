package com.dayuan.bean.data;

import java.util.Date;

import com.dayuan.bean.BaseBean;
/**
 * 
 * Description:检测方法
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月17日
 */
public class BaseDetectMethod extends BaseBean {
	 private String id;		
    private String detectModularId;		//关联检测模块ID

    private String detectMethod;		//检测方法

    private String showParameter;		//要设置的参数名集合show_parameter,用于控制仪器检测项目参数设置项
    private short deleteFlag;	
    private String createBy;	
    private Date createDate;	
    private String updateBy;	
    private Date updateDate;	
    private short isCheck;//是否审核0审核1未审核

	public short getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(short isCheck) {
		this.isCheck = isCheck;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getDetectModularId() {
        return detectModularId;
    }

    public void setDetectModularId(String detectModularId) {
        this.detectModularId = detectModularId == null ? null : detectModularId.trim();
    }

    public String getDetectMethod() {
        return detectMethod;
    }

    public void setDetectMethod(String detectMethod) {
        this.detectMethod = detectMethod == null ? null : detectMethod.trim();
    }

	public String getShowParameter() {
		return showParameter;
	}

	public void setShowParameter(String showParameter) {
		this.showParameter = showParameter;
	}

}