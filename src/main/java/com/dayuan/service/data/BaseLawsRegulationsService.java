package com.dayuan.service.data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseLawsRegulations;
import com.dayuan.mapper.data.BaseLawsRegulationsMapper;
import com.dayuan.service.BaseService;

/**
 * 法律法规Service
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月23日
 */
@Service
public class BaseLawsRegulationsService extends BaseService<BaseLawsRegulations, String>{
	
	@Autowired
	private BaseLawsRegulationsMapper mapper;
	
	public BaseLawsRegulationsMapper getMapper() {
		return mapper;
	}

	public BaseLawsRegulations queryByLawName(String lawName) {
		return mapper.queryByLawName(lawName);
	}

}
