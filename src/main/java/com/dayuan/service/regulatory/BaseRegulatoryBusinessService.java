package com.dayuan.service.regulatory;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.mapper.regulatory.BaseRegulatoryBusinessMapper;
import com.dayuan.model.regulatory.RegulatoryCoverageModel;
import com.dayuan.service.BaseService;

/**
 * 经营者
 * @author Dz
 *
 */
@Service
public class BaseRegulatoryBusinessService extends BaseService<BaseRegulatoryBusiness, Integer> {

	@Autowired
	private BaseRegulatoryBusinessMapper mapper;
	
	public BaseRegulatoryBusinessMapper getMapper() {
		return mapper;
	}
	
	/**
	 * 通过监管对象ID查询经营户
	 * @param regId 监管对象ID
	 * @param checked 经营户审核状态 null全部, 0未审核, 1审核
	 * @return
	 */
	public List<BaseRegulatoryBusiness> queryByRegid(Integer regId, Integer checked) throws Exception{
		return mapper.queryByRegid(regId, checked);
	}

	/**
	 * 根据市场Id ,经营户名称查询 经营户
	 * @param regId 市场ID 
	 * @param opeShopName 经营户档口编号
	 * @return
	 * @author LuoYX
	 * @date 2018年5月14日
	 */
	public List<BaseRegulatoryBusiness> queryByRegIdAndRegUser(Integer regId, String opeShopCode) {
		return mapper.queryByRegIdAndRegUser(regId,opeShopCode);
	}

	/**
	 * 查询机构下的经营户
	 * @param departCode 机构Code
	 * @param subset Y or N
	 * @return
	 * @author LuoYX
	 * @date 2018年5月30日
	 */
	public List<Map<String, Object>> queryBusMapByDepartCode(String departCode, String subset) {
		return mapper.queryBusMapByDepartCode(departCode,subset);
	}
	/**
	 * 根据市场ID查询 经营户档口ID
	 * @param regIds 市场ID
	 * @return
	 * @author LuoYX
	 * @date 2018年6月27日
	 */
	public List<Integer> queryIdsByRegIds(List<Integer> regIds) {
		return mapper.queryIdsByRegIds(regIds);
	}
	
	/**
	 * 根据市场Id ,档口编号查询经营户,包括市场名称
	 * @param regId
	 * @param opeShopName
	 * @return
	 */
	public List<BaseRegulatoryBusiness> queryByRegIdAndRegName(Integer regId, String opeShopName){
		return mapper.queryByRegIdAndRegName(regId, opeShopName);
		
	}
	/**
	 * 查询 时间段内 市场拥有的档口数量
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年8月27日
	 */
	public List<Map<String, Object>> queryBusCountByGroupByRegId(RegulatoryCoverageModel model) {
		return mapper.queryBusCountByGroupByRegId(model);
	}

	/**
	 * 查询 时间段内为检测的具体档口 详情
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年9月13日
	 */
	public List<BaseRegulatoryBusiness> queryUnCheckBusiness(RegulatoryCoverageModel model) {
		return mapper.queryUnCheckBusiness(model);
	}

	/**
	 * 通过监管对象其他编码查询经营户
	 * @param otherCode
	 * @return
	 */
	public List<BaseRegulatoryBusiness> queryByRegOtherCode(String otherCode) {
		return mapper.queryByRegOtherCode(otherCode);
	}
	/**
	 * 根据上一次更新时间查询
	 * @description
	 * @param lastUpdateTimeBusiness
	 * @return
	 * @author xiaoyl
	 * @date   2019年9月24日
	 */
	public List<BaseRegulatoryBusiness> queryByLastUpdateTime(String lastUpdateTimeBusiness) {
		return mapper.queryByLastUpdateTime(lastUpdateTimeBusiness);
	}
	
}
