package com.dayuan3.common.service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.mapper.TbSamplingRequesterMapper;
import com.dayuan3.terminal.bean.RequesterUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
public class TbSamplingRequesterService extends BaseService<TbSamplingRequester, Integer> {
	@Autowired
	private TbSamplingRequesterMapper mapper;

	public TbSamplingRequesterMapper getMapper() {
		return mapper;
	}


	public List<TbSamplingRequester> queryBySamplingId(Integer samplingId) {
		return mapper.queryBySamplingId(samplingId);
	}

	/**
	 * 	批量写入订单与委托单位关联表
	 * @description
	 * @param sampleRequestList
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月9日
	 */
	public int saveBatch(List<TbSamplingRequester> sampleRequestList) {
		return mapper.saveBatch(sampleRequestList);
	}

	/**
	 * 根据订单ID和关键字查询委托单位信息
	 * @description
	 * @param samplingId
	 * @param keyWords
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月14日
	 */
	public List<TbSamplingRequester> queryBySamplingId(Integer samplingId,String keyWords) {
		return mapper.queryBySamplingIdAndKeys(samplingId,keyWords);
	}

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
    public List<TbSamplingRequester> queryUnitsForPrint(Integer id, int printType, String collectCode, String keyWords) {
        return mapper.queryUnitsForPrint(id,printType,collectCode,keyWords);
    }

    /**
     * 查询订单对应的委托单位列表
     * @param simplingId
     * @param requestIds
     * @return
     * @author shit
     */
    public List<RequesterUnit> queryRequestList(Integer simplingId, Integer[] requestIds) {
        return mapper.queryRequestList(simplingId,requestIds);
    }
	/**
	 *  查询委托单位数量
	 * @description
	 * @param samplingId
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月19日
	 */
	public int queryCountBySamplingId(Integer samplingId) {
		return mapper.queryCountBySamplingId(samplingId);
	}
}
