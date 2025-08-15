package com.dayuan.service.DataCheck;


import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.dataCheck.DataCheckHistoryRecording;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.model.BaseModel;
import com.dayuan.util.ContextHolderUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpSession;
import java.util.*;


/**
 * @author Dz
 * @description 针对表【data_check_history_recording(检测数据历史表)】的数据库操作Service
 * @createDate 2025-06-30 11:39:52
 */
public interface DataCheckHistoryRecordingService extends IService<DataCheckHistoryRecording> {

	/**
	 * 根据检测数据ID去查询检测历史数据
	 * @param rid
	 * @return
	 */
	public List<DataCheckHistoryRecording> selectCheckHistoryByRid(Integer rid)throws Exception;

	/**
	 * 查询检测历史数据
	 * @param rid
	 * @param checkRecordingId
	 * @param checkDate
	 * @param checkResult
	 * @param conclusion
	 * @return
	 */
	public DataCheckHistoryRecording selectCheckHistory(Integer rid, String checkRecordingId,  Date checkDate, String checkResult, String conclusion)throws Exception;

	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
	Page loadDatagrid(Page page, BaseModel t) throws Exception;



	/**
	 * 通过三级菜单地址，获取当前用户查看数据权限
	 * 机构用户默认查看本部，机构数据权限：
	 * 查看本部：查看当前机构下的数据
	 * 查看直管：查看当前机构和直属检测点的数据
	 * 查看下级：查看当前机构及管辖下的所有机构和检测点的数据
	 * 检测点用户只能查看当前检测点下的数据，无论是否已配置查看下级等相关权限
	 * 监管对象用户只能查看当前监管对象下的数据，无论是否已配置查看下级等相关权限
	 *
	 * @param url 三级菜单地址
	 * @return
	 * @throws Exception
	 */
	public Map dataPermission(String url) throws Exception;

}
