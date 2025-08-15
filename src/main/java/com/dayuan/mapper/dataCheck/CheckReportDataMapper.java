package com.dayuan.mapper.dataCheck;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.dataCheck.CheckReportData;
import com.dayuan.mapper.BaseMapper;
/**
 * 检测报告扩充表
 * @author xiaoyl
 * @date   2020年3月6日
 */
public interface CheckReportDataMapper extends BaseMapper<CheckReportData, Integer> {

	CheckReportData queryByRecordingId(@Param("rid")Integer rid);

}