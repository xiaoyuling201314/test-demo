package com.dayuan3.common.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan3.common.bean.TerminalBaseFood;
import com.dayuan3.common.bean.TerminalBaseRegObj;
import com.dayuan3.common.bean.TerminalRequestUnit;
import com.dayuan3.common.bean.baseFood;
import com.dayuan3.common.bean.baseInspectionUnit;
import com.dayuan3.common.bean.baseObj;
import com.dayuan3.common.bean.baseUnit;

public interface CommonDataMapper {
	
	List<baseFood>  queryAllFood2();
   
	/**
	 * 便于数据查询 2019-7-22 huht   只要id  和regName 字段
	 * @param departId
	 * @param checked
	 * @return
	 */
	List<baseObj> queryByDepartId2(@Param("departId")Integer departId, @Param("checked")String checked);

   
	
	/**
	 *   便于页面加载数据 只加载有效字段 2019-7-22 huht  
	 * @return
	 */
    List<baseUnit> queryAll2();
   
   
	/**
	 *  自助终端查询所有样品id、名称、别名、拼音等数据，不查询种类
	 * @description
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月19日
	 */
	List<TerminalBaseFood> queryCommonFood();
	/**
	 *  自助终端查询所有委托单位id、名称、别名、拼音等数据
	 * @description
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月19日
	 */
	List<TerminalRequestUnit> queryRequestForTerminal();
	/**
	 * 自助终端查询所有监管对象id、名称、别名、拼音等数据
	 * @description
	 * @param departId 组织机构ID，默认查询所有
	 * @param checked  审核状态
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月23日
	 */
	List<TerminalBaseRegObj> queryRegByDepartId(@Param("departId")Integer departId, @Param("checked")String checked);
	
	/**
	 * 修改personal=2 订单的状态
	 * @param orderStatus
	 * @param id
	 */
	void updateSamplingStatus(@Param("orderStatus")short orderStatus,@Param("id") Integer id,@Param("payDate") Date payDate);

	/**
	 * 样品是否更新
	 * @param date
	 * @return
	 */
	int   queryFoodSatus(Date date);
	/**
	 * 委托是否更新
	 * @param date
	 * @return
	 */
	int   queryUnitSatus(Date date);
	/**
	 * 来源是否更新
	 * @param date
	 * @return
	 */
	int   queryObjSatus(Date date);

	List<baseInspectionUnit> queryInspection();




}