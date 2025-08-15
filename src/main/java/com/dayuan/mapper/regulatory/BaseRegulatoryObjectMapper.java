package com.dayuan.mapper.regulatory;

import java.util.List;
import java.util.Map;

import com.dayuan.bean.Page;
import com.dayuan.model.regulatory.BaseRegObjDeviceModel;
import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.mapper.BaseMapper;

public interface BaseRegulatoryObjectMapper extends BaseMapper<BaseRegulatoryObject, Integer>{
	/**
	 * 删除监管对象
	 * @param userId 操作用户ID
	 * @param ids	删除数据ID
	 */
	int deleteData(@Param("userId")String userId, @Param("ids")Integer[] ids);

	List<BaseRegulatoryObject> loadDatagrid2(Page page);

	int getRowTotal2(Page page);

	List<BaseRegObjDeviceModel> loadDatagridDevice(Page page);

	int getRowTotalDevice(Page page);

	List<BaseRegulatoryObject> queryByDepartId(@Param("departId")Integer departId, @Param("checked")String checked);

	List<BaseRegulatoryObject> queryByDepartId1(@Param("departId")Integer departId, @Param("checked")String checked);

	List<BaseRegulatoryObject> queryRegByDepartId(@Param("departId")Integer departId, @Param("regualtoryTypeId")String regualtoryTypeId);
	
	List<BaseRegulatoryObject> queryRegByDepartIds(@Param("regualtoryTypeId")String regualtoryTypeId, @Param("departArr")String[] departArr);
	
	/**
	 * 根据部门id，与市场名称查监管对象
	 * @param departId
	 * @param regName
	 * @return
	 */
	BaseRegulatoryObject selectByDepartCodeAndRegName(@Param("departCode") String departCode,@Param("departName")String departName,@Param("regName")String regName,@Param("regType")String regType);
	/**
	 * 查询机构 下的所有 监管对象
	 * @param subDepartIds 机构id及子机构id
	 * @return
	 * @author LuoYX
	 * @date 2018年4月27日
	 */
	List<Integer> queryRegIdsByDepartIds(@Param("subDepartIds") List<Integer> subDepartIds);

//	/**
//	 * 查询机构下的市场
//	 * @param departId 部门ID
//	 * @param subset 是否包含子机构
//	 * @param regName 市场名称
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年5月14日
//	 */
//	List<BaseRegulatoryObject> queryRegByDepartIdAndRegName(@Param("departId")Integer departId, @Param("subset")String subset,@Param("regName") String regName);

	/**
	 * 查询机构下的市场
	 * @param departCode 机构编号 
	 * @param subset 是否查询子机构下的
	 * @return
	 * @author LuoYX
	 * @date 2018年5月30日
	 */
	List<Map<String, Object>> queryRegMapByDepartCode(@Param("departCode")String departCode, @Param("subset")String subset);

	/**
	 * 查询全部obj
	 * @param departId 
	 * @return
	 */
	List<BaseRegulatoryObject>	queryAllByDepartId(BaseRegulatoryObject obj);
	
	/**
	 * 根据机构ID、监管对象类型、监管对象名称查询
	 * @param departId
	 * @param regType
	 * @param regName
	 * @return
	 */
	List<BaseRegulatoryObject> queryRegByDIdAndRegName(@Param("departId")Integer departId, @Param("regType")String regType,@Param("regName") String regName);

	/**
	 * 根据机构ID、监管对象类型、监管对象名称查询
	 * @param departId
	 * @param regType
	 * @param regName
	 * @return
	 */
	List<BaseRegulatoryObject> queryRegByDIdAndRegName2New(@Param("departId")Integer departId, @Param("regType")String regType,@Param("regName") String regName);

	/**
	 * 根据departCode查询监管对象
	 * @param regualtoryTypeId
	 * @param departCode
	 * @return
	 */
	List<BaseRegulatoryObject> queryRegByDepartCode(@Param("regualtoryTypeId")String regualtoryTypeId, @Param("departCode")String departCode);

	/**
	 * 根据机构ID和监管对象编码查询监管对象
	 * @param otherCode
	 * @return
	 */
	BaseRegulatoryObject queryByOtherCode(@Param("departId")Integer departId, @Param("otherCode") String otherCode);
	/**
	 * 
	 * @description
	 * @param departId
	 * @param checked
	 * @param lastUpdateTime
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月25日
	 */
	List<BaseRegulatoryObject> queryByLastUpdateTime(@Param("departId")Integer departId, @Param("checked")String checked, @Param("lastUpdateTime")String lastUpdateTime);

	/**
	* @Description 自助终端打印抽样报告
	* @Date 2021/06/03 14:32
	* @Author xiaoyl
	* @Param
	* @return
	*/
    BaseRegulatoryObject queryById2Print(@Param("id")Integer id);

	/**
	 * 被检单位名称校验重复
	 *
	 * @param id
	 * @param name
	 * @param type
	 * @return
	 * @date 2022-03-14
	 * 用于仪器嵌入的网页端新增被检单位时的唯一校验
	 */
    BaseRegulatoryObject reqName(@Param("id") Integer id, @Param("name") String name, @Param("type") String type, @Param("departId") Integer departId);
	/**
	* @Description 根据监管对象ID查找数据，包括经营户数量
	* @Date 2022/04/13 13:33
	* @Author xiaoyl
	* @Param
	* @return
	*/
	BaseRegulatoryObject queryByIdForTemplate4(Integer id);
}