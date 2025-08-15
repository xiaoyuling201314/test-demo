package com.dayuan.service.data;

import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.mapper.data.BaseDeviceTypeMapper;
import com.dayuan.model.data.BaseDeviceTypeModel;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月16日
 */
@Service
public class BaseDeviceTypeService extends BaseService<BaseDeviceType, String>{
	
	@Autowired
	private BaseDeviceTypeMapper mapper;
	
	public BaseDeviceTypeMapper getMapper() {
		return mapper;
	}
	
	/**
	 * 查询所有的检测标准
	 * @author xyl
	 * @return
	 */
	public List<BaseDeviceType> queryAll() {
		return mapper.queryAll();
	}
	/**
	 * 根据类别名称查询数据
	 * @param deviceName 类别名称
	 * @author xyl
	 * @return
	 */
	public BaseDeviceType queryByDeviceName(String deviceName) {
		return mapper.queryByDeviceName(deviceName);
	}
	
	/**
	 * 数据列表分页方法
	 * @param page 分页参数
	 * @return 列表
	 */
	public Page loadDatagrids(Page page, BaseDeviceTypeModel t) throws Exception{
		// 初始化分页参数
		if (null == page) {
			page = new Page();
		}
		// 设置查询条件
		page.setObj(t);

		// 每次查询记录总数量,防止新增或删除记录后总数量错误
		page.setRowTotal(mapper.getRowTotals(page));

		// 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
		page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
		
		//查看页不存在,修改查看页序号
		if(page.getPageNo() <= 0){
			page.setPageNo(1);
			page.setRowOffset(page.getRowOffset());
			page.setRowTail(page.getRowTail());
		}else if(page.getPageNo() > page.getPageCount()){
			page.setPageNo(page.getPageCount());
			page.setRowOffset(page.getRowOffset());
			page.setRowTail(page.getRowTail());
		}
		
		List<BaseDeviceTypeModel> dataList = mapper.loadDatagrids(page);
		page.setResults(dataList);
		return page;
	}
	/**
	 * 根据SAP码查询 仪器、检测箱
	 * @param number
	 * @return
	 * @author LuoYX
	 * @date 2018年1月30日
	 */
	public BaseDeviceType queryDeviceByNumber(String number) {
		return mapper.queryDeviceByNumber(number);
	}

	/**
	 * shit:查询出仪器的所有类型
	 * @return
	 */
	public List<Map<String,Object>> selectAppType() {
		return mapper.selectAppType();
	}

	/**
	 * 查询出类型和图片
	 * @return
	 * @throws Exception
	 */
	public List<BaseDeviceType> selectAppTypeAndImg()throws Exception {
		return mapper.selectAppTypeAndImg();

	}
	/**
	* @Description 根据仪器系列查询仪器类型
	* @Date 2022/12/28 13:21
	* @Author xiaoyl
	* @Param
	* @return
	*/
	public BaseDeviceType queryDeviceBySeries(String series) {
		return mapper.queryDeviceBySeries(series);
	}
}
