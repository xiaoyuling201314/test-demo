package com.dayuan.mapper.sampling;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Dz
 * @description 针对表【tb_sampling_detail_code(样品明细条形码/二维码)】的数据库操作Mapper
 * @createDate 2025-06-24 17:07:00
 * @Entity TbSamplingDetailCode
 */
public interface TbSamplingDetailCodeMapper extends BaseMapper<TbSamplingDetailCode> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BaseFoodType> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);

	List<TbSamplingDetailCode> queryByBagCode(String bagCode);

	List<TbSamplingDetailCode> queryByTubeCode(@Param("tubecode")String tubecode, @Param("validityTime")String validityTime);
    
    /**
     * 根据抽样单详情id 查询 2019-7-15 huht
     * @param Id
     * @return
     */
    TbSamplingDetailCode  queryBySamplingDetailId(Integer Id);

	int bulkUpdateTubeCode(@Param("samplingDetailCodes")List<TbSamplingDetailCode> samplingDetailCodes);

	List<TbSamplingDetailCode> loadDatagridCodeInfo(Page page);

	int getRowTotalCodeInfo(Page page);

}