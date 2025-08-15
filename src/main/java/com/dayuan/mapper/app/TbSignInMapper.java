package com.dayuan.mapper.app;

import com.dayuan.bean.app.TbSignIn;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.app.TbSignInModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TbSignInMapper extends BaseMapper<TbSignIn, String> {

	List<TbSignInModel> queryByDepartIds(@Param("departArr")String[] departArr, @Param("signDate")String signDate,@Param("realname")String realname );
	
	List<TbSignInModel> queryByUserId(@Param("userId")String userId, @Param("dateStr")String dateStr);

	List<String> querySignDate(@Param("departId")int departId);

	List<String> querySignDate(@Param("departId")int departId, @Param("signDate")String signDate, @Param("userId")String userId);

	TbSignInModel queryLastSignByUserId(@Param("userId")String userId);

	List<TbSignInModel> querySignByDepartIds(@Param("departArr")String[] departIds,@Param("realname")String realname);

}