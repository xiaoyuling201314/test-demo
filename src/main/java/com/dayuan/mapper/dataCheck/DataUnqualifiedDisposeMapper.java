package com.dayuan.mapper.dataCheck;

import com.dayuan.bean.dataCheck.DataUnqualifiedDispose;
import com.dayuan.mapper.BaseMapper;
/**
 * 不合格处理记录
 * @author wangzhenxiong
 *
 */
public interface DataUnqualifiedDisposeMapper  extends BaseMapper<DataUnqualifiedDispose, Integer> {
	/**
	 * 根据抽检结果id获取不合格处置记录
	 * @param unid
	 * @return
	 */
	int selectByUnid(Integer unid);

	/**
	 * 删除不合格处理明细
	 * @param unid
	 * @return
	 */
	int deleteByUnid(Integer unid);
}