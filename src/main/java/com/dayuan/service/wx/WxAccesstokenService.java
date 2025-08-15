package com.dayuan.service.wx;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.wx.WxAccesstoken;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.wx.WxAccesstokenMapper;
import com.dayuan.service.BaseService;
@Service
public class WxAccesstokenService extends BaseService<WxAccesstoken, String> {

	@Autowired
	WxAccesstokenMapper mapper;
	
	@Override
	public BaseMapper<WxAccesstoken, String> getMapper() {
		return mapper;
	}

}
