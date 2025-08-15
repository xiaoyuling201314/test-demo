package com.dayuan.service.sampling;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.model.BaseModel;
import com.dayuan.util.ContextHolderUtils;

import java.lang.reflect.Method;
import java.util.List;

/**
 * @author Dz
 * @description 针对表【tb_sampling_detail_code(样品明细条形码/二维码)】的数据库操作Service
 * @createDate 2025-06-24 17:07:00
 */
public interface TbSamplingDetailCodeService extends IService<TbSamplingDetailCode> {

	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
	public Page loadDatagrid(Page page, BaseModel t) throws Exception;



	/**
	 * 数据列表分页方法
	 *
	 * @param page               分页
	 * @param t                  条件参数
	 * @param c                  查询方法的类
	 * @param loadDatagridMethod 查询列表数据方法
	 * @param getRowTotalMethod  查询记录总数方法
	 * @return
	 * @throws Exception
	 */
	public Page loadDatagrid(Page page, BaseModel t, Class c, String loadDatagridMethod, String getRowTotalMethod) throws Exception;
	
    /**
     * 前处理批量更新试管码,清除检测任务被接收仪器信息
     * @param samplingDetailCodes
     * @throws Exception
     */
    public int bulkUpdateTubeCode(List<TbSamplingDetailCode> samplingDetailCodes) throws Exception;
    
	/**
	 * 根据样品码查询
	 * @param bagCode 样品码
	 * @return
	 */
	public List<TbSamplingDetailCode> queryByBagCode(String bagCode);
    
//	/**
//	 * 根据有效试管码查询
//	 * 试管码有效期：扫描后30天内
//	 * @param tubecode 试管码
//	 * @return
//	 */
//    public List<TbSamplingDetailCode> queryByTubeCode(String tubecode);

    /**
     * 根据抽样单详情id 查询 2019-7-15 huht
     * @param Id
     * @return
     */
    public TbSamplingDetailCode queryBySamplingDetailId(Integer Id);

	/**
	 * 根据有效试管码查询
	 * 试管码有效期：扫描后30天内
	 * @param tubecode 试管码
	 * @return
	 */
	public List<TbSamplingDetailCode> queryByTubeCode(String tubecode);

}
