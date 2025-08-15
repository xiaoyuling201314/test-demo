package com.dayuan.service.DataCheck;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.DataUnqualifiedConfig;
import com.dayuan.mapper.dataCheck.DataUnqualifiedConfigMapper;
import com.dayuan.service.BaseService;



/**
 * 不合格处理操作
 * @author Bill
 *
 */
@Service
public class DataUnqualifiedConfigService extends BaseService<DataUnqualifiedConfig, Integer> {
	
	@Autowired
	private DataUnqualifiedConfigMapper mapper;
	public DataUnqualifiedConfigMapper getMapper() {
		return mapper;
	}

		
	/**
	 * 已处理分页
	 * @param page
	 * @param dataUnqualifiedConfig
	 * @return
	 */
	public Page loadDatagrid1(Page page, DataUnqualifiedConfig dataUnqualifiedConfig){
		//初始化分页参数
		if(null==page){
			page = new Page();
		}
		
		page.setRowTotal(mapper.getRowTotal(page));
		//每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
		page.setPageCount((int) Math.ceil(page.getRowTotal()/(page.getPageSize()*1.0)));
		
		page.setObj(dataUnqualifiedConfig);
		List<DataUnqualifiedConfig> dataUnqualifiedConfigList = mapper.loadDatagrid(page);
		page.setResults(dataUnqualifiedConfigList);
		return page;
	}
	
	public List<DataUnqualifiedConfig> getList(){
		return mapper.getList();
	}
}
