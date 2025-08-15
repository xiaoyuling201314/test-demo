package com.dayuan.mapper.regulatory;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.regulatory.BaseRegulatoryLicense;
import com.dayuan.mapper.BaseMapper;

public interface BaseRegulatoryLicenseMapper extends BaseMapper<BaseRegulatoryLicense, Integer> {
	
	List<BaseRegulatoryLicense> queryBySourceId(Integer sourceId);
	
	BaseRegulatoryLicense queryByBusinessId(Integer businessId);

	BaseRegulatoryLicense queryBySourceIdAndType(@Param("sourceId")Integer sourceId,@Param("licenseType") int licenseType);
	
}