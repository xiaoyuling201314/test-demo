package com.dayuan3.common.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.terminal.bean.RequesterUnit;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TbSamplingRequesterMapper extends BaseMapper<TbSamplingRequester, Integer> {

    List<TbSamplingRequester> queryBySamplingId(@Param("samplingId") Integer samplingId);
    /**
     * 	批量写入订单与委托单位关联表
     * @description
     * @param sampleRequestList
     * @return
     * @author xiaoyl
     * @date   2020年1月9日
     */
	int saveBatch(List<TbSamplingRequester> sampleRequestList);
	/**
	 * 根据订单ID和关键字查询委托单位信息
	 * @description
	 * @param samplingId
	 * @param keyWords
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月14日
	 */
	List<TbSamplingRequester> queryBySamplingIdAndKeys(@Param("samplingId")Integer samplingId, @Param("keyWords")String keyWords);
	/**
	 * 根据订单号、收样批次查询待打印/已打印委托单位列表
	 * @description
	 * @param id
	 * @param printType
	 * @param collectCode
	 * @param keyWords
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月15日
	 */
	List<TbSamplingRequester> queryUnitsForPrint(@Param("samplingId")Integer id, @Param("printType")int printType, @Param("collectCode")String collectCode, @Param("keyWords")String keyWords);

	/**
	 * 查询委托单位数量
	 * @description
	 * @param samplingId
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月19日
	 */
	int queryCountBySamplingId(@Param("samplingId")Integer samplingId);


	List<RequesterUnit> queryRequestList(@Param("simplingId") Integer simplingId, @Param("requestIds") Integer[] requestIds);
}