package com.dayuan.mapper.app;

import com.dayuan.bean.app.TbSignLast;
import com.dayuan.mapper.BaseMapper;

public interface TbSignLastMapper extends BaseMapper<TbSignLast,String> {
	/**
	 * 根据用户ID查询最后一次签到记录
	 * @description
	 * @param userId
	 * @return
	 * @author xiaoyl
	 * @date   2020年5月14日
	 */
	TbSignLast queryByUserId(String userId);
}