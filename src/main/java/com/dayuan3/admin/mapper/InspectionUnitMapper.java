package com.dayuan3.admin.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.api.vo.InspectionUnitRespVo;
import com.dayuan3.terminal.model.InspectionUnitModel;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface InspectionUnitMapper extends BaseMapper<InspectionUnit, Integer> {

	InspectionUnit queryByCreditCode(String creditCode);

	/**
	 * 进行导出数据的查询
	 *
	 * @param model
	 * @return
	 * @author shit
	 */
	List<InspectionUnit> quaryList(InspectionUnitModel model);
	
	
	List<InspectionUnit> queryAll(@Param("lastUpdateTime")String lastUpdateTime);
	
	List<InspectionUnit> getReqInsUtil(InspectionUnitModel model);

    List<InspectionUnitRespVo> queryByColdId(@Param("coldUnitID")Integer coldUnitID,@Param("companyCode")String companyCode);

    InspectionUnit queryByCompanyCode(@Param("coldUnitId")Integer coldUnitId, @Param("companyName")String companyName, @Param("companyCode")String companyCode);

    InspectionUnit queryUnitById(@Param("id")Integer inspectionId);
}