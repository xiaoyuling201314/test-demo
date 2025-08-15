package com.dayuan.mapper.dataCheck;

import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.dataCheck.DataUnqualifiedTreatment;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.dataCheck.CheckResultModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 
 * Description: 不合格处理Mapper
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public interface DataUnqualifiedTreatmentGSMapper extends BaseMapper<DataUnqualifiedTreatment, Integer> {


	int getRowTotalForGS(Page page);

	List<CheckResultModel> loadDatagridForGS(Page page);

	int getDealRowTotal(Page page);

	List<CheckResultModel> loadDealDatagrid(Page page);

	CheckResultModel queryByRid(Integer rid);

	List<DataCheckRecording> loadAllUnqualifieldData(@Param("start") String start, @Param("end") String end);
	/**
	 * @Description 根据检测数据的rid更新不合格处理状态
	 * @Date 2022/05/18 15:00
	 * @Author xiaoyl
	 * @Param id 检测数据rid
	 * @Param handledAssessment 考核状态
	 * @Param  remark 备注
	 * @return
	 */
	int updateCheckDataAssessment(@Param("rid")Integer rid, @Param("hAssessment")Integer hAssessment,@Param("handledRemark")String handledRemark);

	int deleteByRid(@Param("id")Integer id,@Param("remark")String remark);

	CheckResultModel getRecording(Integer id);
}