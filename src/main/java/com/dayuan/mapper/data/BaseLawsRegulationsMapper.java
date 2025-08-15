package com.dayuan.mapper.data;

import com.dayuan.bean.data.BaseLawsRegulations;
import com.dayuan.mapper.BaseMapper;

/**
 * 
 * Description:法律法规 Mapper
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public interface BaseLawsRegulationsMapper extends BaseMapper<BaseLawsRegulations, String> {

	BaseLawsRegulations queryByLawName(String lawName);

}