package com.dayuan3.terminal.mapper;

import java.util.List;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.DataUnqualifiedPrintlog;
/**
 * 	不合格复检单打印记录
 * @author xiaoyl
 * @date   2019年9月23日
 */
public interface DataUnqualifiedPrintlogMapper extends BaseMapper<DataUnqualifiedPrintlog, Integer> {
	/**
	 * 	批量写入不合格检测复检单打印记录
	 * @description
	 * @param list
	 * @return
	 * @author xiaoyl
	 * @date   2019年9月23日
	 */
	public int saveBatch(List<DataUnqualifiedPrintlog> list);
}