package com.dayuan.mapper.message;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.message.TbTaskMessgae;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.message.TbTaskMessgaeModel;

/**
 * @project 快速服务云平台
 * @author wtt
 * @date 2017年10月25日
 */
public interface TbTaskMessgaeMapper extends BaseMapper<TbTaskMessgae, String>{
	
   /**
    * 根据id查询发送信息详情
	 * @param id
	 * @return
	 */
   TbTaskMessgaeModel selectFromById(int id);
	
   /**
    * 根据id查询接收信息详情
	 * @param id
	 * @return
	 */
   TbTaskMessgaeModel selectToById(int id);
	/**
	 * 删除数据
	 * @param id
	 * @return
	 */
	int deleteByPrimaryKey(int id);
	
	/**
	 *  查询首页列表信息
	 * @param id
	 * @return
	 */
	List<TbTaskMessgaeModel> selectIndex(@Param("id")String id,@Param("departId")Integer departId,@Param("pointId")Integer pointId);
	/**
	* @Description 根据发送类型ID查询接收人或接收机构的名称
	* @Date 2022/07/21 16:56
	* @Author xiaoyl
	* @Param
	* @return
	*/
	String queryReceiveObject(TbTaskMessgaeModel messgaeModel);
}