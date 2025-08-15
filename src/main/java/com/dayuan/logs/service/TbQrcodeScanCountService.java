package com.dayuan.logs.service;

import com.dayuan.logs.bean.TbQrcodeScanCount;
import com.dayuan.logs.mapper.TbQrcodeScanCountMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Description 统计各二维码扫描次数
* @Date 2021/07/20 16:29
* @Author xiaoyl
* @Param
* @return
*/
@Service
public class TbQrcodeScanCountService extends BaseService<TbQrcodeScanCount, Integer> {

	@Autowired
	private TbQrcodeScanCountMapper mapper;

	public TbQrcodeScanCountMapper getMapper() {
		return mapper;
	}
	/**
	* @Description 根据对象ID或者抽样单号查询扫描计数对象
	* @Date 2021/07/20 16:43
	* @Author xiaoyl
	 * @Param scanParam 扫描对象ID或抽样单号
	* @Param scanType 类型：0 抽样单，1 监管对象，2 经营户
	* @return
	*/
	public TbQrcodeScanCount queryByScanParams(String scanParam,Integer scanType) {
		return mapper.queryByScanParams(scanParam,scanType);
	}
}
