package com.dayuan3.terminal.service;

import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import com.dayuan.service.BaseService;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.sampleDetail;
import com.dayuan3.terminal.mapper.RequesterUnitMapper;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 
 * @author xiaoyl
 * @date   2019年7月1日
 */
@Service
public class RequesterUnitService extends BaseService<RequesterUnit, Integer> {
	@Autowired
	private RequesterUnitMapper mapper;

	public RequesterUnitMapper getMapper() {
		return mapper;
	}

	/**
	 * 获取所有委托单位
	 * @return
	 */
	public List<RequesterUnit> queryAll(String lastUpdateTime) {
		return mapper.queryAll(lastUpdateTime);
	}
	
	/**2019-8-14 huht
	 * 委托单位查询检测数据
	 * @param id
	 * @param end 结束时间
	 * @param start 开始时间
	 * @param rowStart 分页第几条开始
	 * @param rowEnd 第几条结束
	 * @return
	 */
	public List<sampleDetail> queryDataCheckById(Integer id, int rowStart, int rowEnd,String start,String end) {
		int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
		return mapper.queryDataCheckById(id, rowStart, rowEnd, start, end, recheckNumber);
	}
	
		
	/**
	 * 判断名称、统一编码是否已存在
	 * @param requesterName
	 * @param creditCode
	 * @return
	 */
	public int queryIsExist(String requesterName, String creditCode ) {
		return mapper.queryIsExist(requesterName, creditCode);
	}

	/**
	 * 根据委托单位名称去查询校验其唯一性
	 * @param requesterName
	 * @param id
	 * @return
	 */
	public RequesterUnit selectByName(String requesterName, Integer id) {
		return mapper.selectByName(requesterName,id);
	}
	
	public Page loadDatagrid2(Page page, BaseModel t) throws Exception{
		// 初始化分页参数
		if (null == page) {
			page = new Page();
		}
		// 设置查询条件
		page.setObj(t);

		// 每次查询记录总数量,防止新增或删除记录后总数量错误
		page.setRowTotal(getMapper().getRowTotal2(page));

		// 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
		page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

		//查看页不存在,修改查看页序号
		if(page.getPageNo() <= 0){
			page.setPageNo(1);
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
		}else if(page.getPageNo() > page.getPageCount()){
			page.setPageNo(page.getPageCount());
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
		}

		List<T> dataList = mapper.loadDatagrid2(page);
		page.setResults(dataList);
		return page;
	}


	/**2020-03-04 shit
	 * 委托单位查询检测数据
	 * @param id
	 * @param end 结束时间
	 * @param start 开始时间
	 * @param rowStart 分页第几条开始
	 * @param rowEnd 第几条结束
	 * @return
	 */
	public List<sampleDetail> queryDataCheckById2(Integer id, int rowStart, int rowEnd, String start, String end) {
		int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
		return mapper.queryDataCheckById2(id, rowStart, rowEnd, start, end, recheckNumber);
	}
}
