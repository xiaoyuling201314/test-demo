package com.dayuan.service.data;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseStandard;
import com.dayuan.mapper.data.BaseStandardMapper;
import com.dayuan.service.BaseService;

/**
 * @author Dz
 * @description 针对表【base_standard(检测标准)】的数据库操作Service
 * @createDate 2025-06-24 00:46:54
 */
public interface BaseStandardService extends IService<BaseStandard> {

	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
	public Page loadDatagrid(Page page, BaseModel t) throws Exception;

	/**
	 * 查询最后一个标准编号
	 * @author xyl
	 * @return
	 */
	public String queryLastCode();

	/**
	 * 根据标准名称查询是否存在重复的数据
	 * @param standardName 标准名称
	 * @return
	 */
	public BaseStandard queryByStandardName(String standardName);

	/**
	 * 查询所有的检测标准
	 * @author xyl
	 * @return
	 */
	public List<BaseStandard> queryAll();

}
