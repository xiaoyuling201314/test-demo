package com.dayuan.mapper.dataCheck;

import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.DataUnqualifiedTreatment;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.dataCheck.CheckResultModel;

import java.util.List;
/**
 * 
 * Description: 不合格处理Mapper
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public interface DataUnqualifiedTreatmentMapper extends BaseMapper<DataUnqualifiedTreatment, Integer> {
	CheckResultModel getRecording (Integer id);

	int getDealRowTotal(Page page);

	List<CheckResultModel> loadDealDatagrid(Page page);

	DataUnqualifiedTreatment queryByRid(Integer rid);

	/**
	 * 根据检测数据ID查询溯源信息
	 *
	 * @param id 检测数据ID
	 * @return
	 */
    BaseRegulatoryObject selectSourceByRid(Integer id);
    
    List<TbSamplingDetailCode> loadDatagridForUnqualFied(Page page);

	int getRowTotalUnqualFied(Page page);

	DataUnqualifiedTreatment queryByRid2GS(Integer rid);
}