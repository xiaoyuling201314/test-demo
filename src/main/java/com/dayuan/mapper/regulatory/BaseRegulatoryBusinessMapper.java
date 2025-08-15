package com.dayuan.mapper.regulatory;

import java.util.List;
import java.util.Map;

import com.dayuan.bean.Page;
import com.dayuan.model.regulatory.BaseRegBusDeviceModel;
import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.regulatory.RegulatoryCoverageModel;

public interface BaseRegulatoryBusinessMapper extends BaseMapper<BaseRegulatoryBusiness, Integer> {

	List<BaseRegulatoryBusiness> queryByRegid(@Param("regId") Integer regId, @Param("checked") Integer checked);

	/**
	 * 根据市场Id ,经营户名称查询 经营户
	 * @param regId 市场ID
	 * @param regShopName 经营户档口名称
	 * @return
	 * @author LuoYX
	 * @date 2018年5月14日
	 */
	List<BaseRegulatoryBusiness> queryByRegIdAndRegUser(@Param("regId") Integer regId, @Param("opeShopCode") String opeShopCode);

	/**
	 * 查询机构下的经营户
	 * @param departCode 机构Code
	 * @param subset Y or N
	 * @return
	 * @author LuoYX
	 * @date 2018年5月30日
	 */
	List<Map<String, Object>> queryBusMapByDepartCode(@Param("departCode") String departCode,@Param("subset")  String subset);
	
	/**
	 * 根据市场ID查询 经营户档口ID
	 * @param regIds 市场ID
	 * @return
	 * @author LuoYX
	 * @date 2018年6月27日
	 */
	List<Integer> queryIdsByRegIds(@Param("regIds")List<Integer> regIds);
	
	/**
	 * 根据市场Id ,档口编号查询经营户,包括市场名称
	 * @param regId
	 * @param opeShopName
	 * @return
	 */
	List<BaseRegulatoryBusiness> queryByRegIdAndRegName(@Param("regId") Integer regId, @Param("opeShopName") String opeShopName);

	/**
	 * 查询 时间段内 市场拥有的档口数量
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年8月27日
	 */
	List<Map<String, Object>> queryBusCountByGroupByRegId(RegulatoryCoverageModel model);

	/**
	 * 查询 时间段内为检测的具体档口 详情
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年9月13日
	 */
	List<BaseRegulatoryBusiness> queryUnCheckBusiness(RegulatoryCoverageModel model);

	/**
	 * 通过监管对象其他编码查询经营户
	 * @param otherCode
	 * @return
	 */
	List<BaseRegulatoryBusiness> queryByRegOtherCode(String otherCode);

	List<BaseRegulatoryBusiness> queryByLastUpdateTime(@Param("lastUpdateTimeBusiness")String lastUpdateTimeBusiness);

	List<BaseRegBusDeviceModel> loadDatagridDevice(Page page);

	int getRowTotalDevice(Page page);

}