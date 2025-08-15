package com.dayuan3.terminal.service;

import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.DataUnqualifiedPrintlog;
import com.dayuan3.terminal.mapper.DataUnqualifiedPrintlogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 不合格复检单打印记录
 * @author xiaoyl
 * @date   2019年9月23日
 */
@Service
public class DataUnqualifiedPrintlogService extends BaseService<DataUnqualifiedPrintlog, Integer> {
	@Autowired
	private DataUnqualifiedPrintlogMapper mapper;

	public DataUnqualifiedPrintlogMapper getMapper() {
		return mapper;
	}
	public int saveBatch(List<DataUnqualifiedPrintlog> list) {
		return mapper.saveBatch(list);
	}
}
