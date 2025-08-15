package com.dayuan3.common.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan3.common.bean.TerminalBaseFood;
import com.dayuan3.common.bean.TerminalBaseRegObj;
import com.dayuan3.common.bean.TerminalRequestUnit;
import com.dayuan3.common.bean.baseFood;
import com.dayuan3.common.bean.baseInspectionUnit;
import com.dayuan3.common.bean.baseObj;
import com.dayuan3.common.bean.baseUnit;
import com.dayuan3.common.mapper.CommonDataMapper;

@Service
public class CommonDataService {
	@Autowired
	private CommonDataMapper mapper;
	
	/**'
	 * 微信端获取全部样品为食品的数据
	 * @return
	 */
	public	List<baseFood>  queryAllFood2(){
		return mapper.queryAllFood2();
	};
	
	/**
	 * 查询送检单位、个人
	 * @return
	 */
		public	List<baseInspectionUnit>  queryInspection(){
			return mapper.queryInspection();
		};
	
		
		/**
		 * 便于数据查询 2019-7-22 huht   只要id  和regName 字段
		 * @param departId
		 * @param checked
		 * @return
		 */
		public List<baseObj> queryByDepartId2(Integer departId, String checked) {
			return mapper.queryByDepartId2(departId, checked);
		}
		
		
		
		/**
		 *   获取所有委托单位,只加载有效字段 
		 *   2019-7-22 huht  
		 * @return
		 */
		public List<baseUnit> queryAll2() {
			return mapper.queryAll2();
		}
		/**
		 * 自助终端--查询样品信息
		 * @description
		 * @return
		 * @author xiaoyl
		 * @date   2019年7月23日
		 */
		public List<TerminalBaseFood> queryCommonFood(){
			return mapper.queryCommonFood();
		}

		/**
		 * 自助终端--查询委托单位
		 * @description
		 * @return
		 * @author xiaoyl
		 * @date   2019年7月23日
		 */
		public List<TerminalRequestUnit> queryRequestForTerminal() {
			return mapper.queryRequestForTerminal();
		}

		/**
		 * 自助终端--样品来源
		 * @description
		 * @return
		 * @author xiaoyl
		 * @date   2019年7月23日
		 */
		public List<TerminalBaseRegObj> queryRegByDepartId(Integer departId, String checked) {
			return mapper.queryRegByDepartId(departId,checked);
		}
		
		/**
		 * 修改personal=2 订单的状态
		 * @param orderStatus
		 * @param id
		 */
		public	void updateSamplingStatus(short orderStatus,Integer id,Date payDate){
			mapper.updateSamplingStatus(orderStatus, id, payDate);
		};
		
		

		/**
		 * 样品是否更新 huht 2019-7-25
		 * @param date
		 * @return
		 */
		public int   queryFoodSatus(Date date){
			
			return mapper.queryFoodSatus(date);
			
		};
		/**
		 * 委托是否更新
		 * @param date
		 * @return
		 */
		public int   queryUnitSatus(Date date) {
			
			return mapper.queryUnitSatus(date);
		}
		/**
		 * 来源是否更新
		 * @param date
		 * @return
		 */
		public	int   queryObjSatus(Date date) {
			
			return mapper.queryObjSatus(date);
		}
}
