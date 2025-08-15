package com.dayuan.service.regulatory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.regulatory.BaseRegulatoryLicense;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.mapper.regulatory.BaseRegulatoryLicenseMapper;
import com.dayuan.mapper.regulatory.BaseRegulatoryObjectMapper;
import com.dayuan.service.BaseService;

/**
 * 许可证
 * @author Dz
 *
 */
@Service
public class BaseRegulatoryLicenseService extends BaseService<BaseRegulatoryLicense, Integer> {

	@Autowired
	private BaseRegulatoryLicenseMapper mapper;
	
	public BaseRegulatoryLicenseMapper getMapper() {
		return mapper;
	}
	
	/**
	 * 通过监管对象ID查询许可证
	 * @param sourceId
	 * @return
	 */
	public List<BaseRegulatoryLicense> queryBySourceId(Integer sourceId) throws Exception{
		List<BaseRegulatoryLicense> licenses = mapper.queryBySourceId(sourceId);
		return licenses;
	}
	
	/**
	 * 通过经营户ID查询营业执照
	 * @param businessId 经营户ID
	 * @return
	 */
	public BaseRegulatoryLicense queryByBusinessId(Integer businessId) throws Exception{
		return mapper.queryByBusinessId(businessId);
	}

	/**
	 * 根据监管对象和类型查询最近注册的执照信息
	 * @param regId 监管对象
	 * @param type 类型
	 * @return
	 */
	public BaseRegulatoryLicense queryBySourceIdAndType(Integer regId, int type) {
		return mapper.queryBySourceIdAndType(regId,type);
	}
}
