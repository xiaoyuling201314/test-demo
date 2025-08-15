package com.dayuan.service.DataCheck;


import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.foodTypeStatistics;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.system.TSUser;
import com.dayuan.model.BaseModel;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.model.dataCheck.DataCheckRecordingModel;
import com.dayuan.model.monitor.DataCheckQueryModel;
import com.dayuan.model.regulatory.RegulatoryCoverageModel;
import com.dayuan3.api.vo.check.SaveCheckDataDTO;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author Dz
 * @description 针对表【data_check_recording(检测数据表)】的数据库操作Service
 * @createDate 2025-06-21 16:03:31
 */
public interface DataCheckRecordingService extends IService<DataCheckRecording> {
	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
     Page loadDatagrid(Page page, BaseModel t) throws Exception;
	
//	/**
//	 * 已处理分页
//	 * @param page
//	 * @param dataCheckRecording
//	 * @return
//	 */
//	public Page loadDatagrid1(Page page, DataCheckRecording dataCheckRecording);
	
	/**
	 * 数据列表分页方法
	 * @param page 分页参数
	 * @return 列表
	 */
     Page loadDatagrids(Page page, DataCheckRecordingModel t);
	
	/**
	 * 检测点数据统计
	 * @return
	 */
     List<DataCheckRecordingModel> selectDataGroup(Integer did,String typeObj,String start,String end,String pointType,Integer systemFlag,Integer pointId,Integer pageSize);

//	/**
//	* @Description 快检车数据统计
//	* @Date 2021/03/04 16:55
//	* @Author xiaoyl
//	* @Param
//	* @return
//	*/
//	public List<DataCheckRecordingModel> selectCarDataGroup(Integer did,String start,String end,Integer pointType);
	/**
	 * 机构数据统计
	 * @return
	 */
     DataCheckRecordingModel selectDepartDataGroup(List<Integer> did,Integer departId,String departName,String typeObj,List<Integer> departIds,String start,String end,String pointType,Integer systemFlag);

	/**
	 * 单位统计
	 * @return
	 */
     List<DataCheckRecordingModel> selectDepartDataGroup2(Integer departId, String start, String end) throws Exception;
	
	/**
	 * 检测项目数据统计
	 * @return
	 */
     List<DataCheckRecordingModel> selectItemGroup(Integer did,String typeObj,String start,String end,String pointType,Integer pointId,Integer systemFlag);

	/**
	 * 食品种类统计
	 * @return
	 */
     List<DataCheckRecordingModel> selectFoodGroup(Integer did,List<Integer> subIds,String typeObj,String start,String end,String pointType,Integer systemFlag,Integer pointId);
	
//	public String selectArryByFid(String fid);
	
	/**
	 * 食品类别统计
	 * @param did
	 * @param start
	 * @param end
	 * @return
	 */
     foodTypeStatistics selectFoodTypeGroup(Integer did,List<Integer> subIds,String typeObj,String start,String end,String name,Integer id,String pointType,Integer systemFlag,Integer pointId);
	
	/**
	 * 食品安全预警
	 * @return
	 */
     List<DataCheckRecordingModel> selectFoodGroup2(Integer did,String start,String end,String pointType,Integer systemFlag,Integer pointId,Integer pageSize);
	
	/**
	 * 被检单位统计
	 * @return
	 */
     List<DataCheckRecordingModel> selectRegGroup(Integer did,String typeObj,String start,String end,String pointType,Integer systemFlag,Integer pointId,Integer taskType,Integer pageSize);
	
//	public List<DataCheckRecordingModel> selectDataItem(Integer did,String start,String end,List<Integer> foodArray,String[] itemArray);
//
//	/**
//	 * 数据报表 检测趋势查询
//	 * @param did
//	 * @param start
//	 * @param end
//	 * @return
//	 * @author wtt
//	 * @date 2018年11月13日
//	 */
//	public List<DataCheckRecordingModel> selectTrend(Integer did,String datatype,String start,String end);
//
//	/**
//	 * 数据报表 检测数据分析
//	 * @param did
//	 * @param start
//	 * @param end
//	 * @return
//	 * @author wtt
//	 * @date 2018年11月13日
//	 */
//	public DataCheckRecordingModel selectTrendNum(Integer did,String start,String end);
//
//	public DataCheckRecordingModel selectTreatment(Integer did,String start,String end);
	
     List<DataCheckRecordingModel> selectDataForDate(Integer pointId,Integer regId,String typeObj,String start,String end);
	
     List<DataCheckRecordingModel> selectDataForDates(Integer pointId,Integer regId,String typeObj,String start,String end);

     CheckResultModel getRecording(Integer rid);
	
	/**
	 * 新增或更新检测结果
	 * @param bean 检测结果
	 * @param user 上传用户
	 * @return
	 * @throws Exception
	 */
     int saveOrUpdateDataChecking(DataCheckRecording bean, TSUser user) throws Exception;


	/**
	 * 平台批量上传检测数据
	 * @param samplingDetailIds		抽样单ID
	 * @param conclusion    检测结果
	 * @param checkResult   检测值
	 * @param checkDate     检测时间
	 * @param projectPath add by xiaoyl 2020-03-09 项目地址跟路径，用于生成报告相关签名数据
	 * @throws Exception
	 */
     void uploadData2(List<Integer> samplingDetailIds, String conclusion, String checkResult, Date checkDate, String projectPath) throws Exception;
	
	/**
	 * 平台检测数据上传
	 * @param projectPath add by xiaoyl 2020-03-09 项目地址跟路径，用于生成报告相关签名数据
	 * @throws Exception 
	 */
     void uploadData(DataCheckRecording bean,String deviceParameterId,String projectPath) throws Exception;

//	/**
//	 * 按项目统计完成数量
//	 * @param pId 项目ID
//	 * @param departCode 项目的顶级机构code
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年3月26日
//	 */
//	public Integer queryCountByPId(Integer pId,String departCode,String start,String end);
//
//	public List<Map<String, Object>> queryCountByPId2(Integer pId,String departCode,String start,String end);

	/**
	 * 查询当天检测数据
	 * @author Dz
	 * @param departId	机构ID
	 * @param pointId	检测点ID
	 * @param regId 监管对象ID
	 * @param date
	 * @return
	 */
     List<DataCheckRecordingModel> queryDailyData(Integer departId, Integer pointId, Integer regId, Date date);

	/**
	 * 查询检测数据
	 * @author Dz
	 * @param departId	机构ID
	 * @param pointId	检测点ID
	 * @param regId 监管对象ID
	 * @param start	检测时间-开始时间，格式：yyyy-MM-dd HH:mm:ss (必填)
	 * @param end	检测时间-结束时间，格式：yyyy-MM-dd HH:mm:ss (必填)
	 * @return
	 */
     List<DataCheckRecordingModel> queryCheckData(Integer departId, Integer pointId, Integer regId, String start, String end);

     int queryMonitorRowTotal(DataCheckQueryModel model);

     List<DataCheckRecordingModel> queryMonitorCheckData(DataCheckQueryModel model);

//	/**
//	 * 项目进度详情，查询检测数据分析CHAT
//	 * @param departIds 子级机构IDs
//	 * @param start 开始时间
//	 * @param end 结束时间
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年4月19日
//	 */
//	public Map<String, Object> queryCheckChat(List<Integer> departIds, String start, String end);
//
//	/**
//	 * 机构自身检测的数据数量
//	 * @param departId
//	 * @param start 开始时间
//	 * @param end 结束时间
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年4月19日
//	 */
//	public Map<String, Object> queryCountByDepartId(String departId,String start,String end);
//
//	/**
//	 * 机构检测数据总数、合格数、不合格数
//	 * @param departIds 机构Id
//	 * @param start 开始时间
//	 * @param end 结束时间
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年4月19日
//	 */
//	public Map<String, Object> queryCountBySubDepart(List<Integer> departIds,String start,String end);
//
//	/**
//	 * 33大类检测CHAT
//	 * @param departIds
//	 * @param typeIds
//	 * @param start
//	 * @param end
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年4月19日
//	 */
//	public Map<String, Object> queryCountBySubType(List<Integer> departIds, List<Integer> typeIds, String start, String end);
//
//	/**
//	 * 查询不合格排行CHAT
//	 * @param departIds
//	 * @param start
//	 * @param end
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年4月19日
//	 */
//	public List<Map<String, Object>> queryCountByFoodNameAndUnqual(List<Integer> departIds, String start, String end);

	/**
	 * 根据 监管对象 Ids 查询检测总数、合格数、不合格数
	 * @param regIds 监管对象Ids
	 * @param end 开始时间
	 * @param start 结束时间
	 * @return
	 * @author LuoYX
	 * @date 2018年4月27日
	 */
     Map<String, Object> queryCountByRegIds(List<Integer> regIds, String start, String end);

	/**
	 * 获取当月检测数据数量（首页统计）
	 * @param tsUser
	 * @return
	 * @throws Exception 
	 */
     Map<String,Object> queryCheckNumM(TSUser tsUser) throws Exception;

	/**
	 * 获取每天检测数据数量（首页统计）
	 * @param pointId
	 * @param departId
	 * @param startDate	开始
	 * @param endDate	结束
	 * @return
	 * @throws Exception
	 */
     Map<String,Object> queryCheckNumW(Integer pointId, Integer departId, Date startDate, Date endDate) throws Exception;

	/**
	 * 获取当天每小时检测数据数量
	 * @param pointId
	 * @param departId
	 * @param date		统计日期
	 * @return
	 * @throws Exception
	 */
     Map<String,Object> queryCheckNumD(Integer pointId, Integer departId, Date date) throws Exception;

//	/**
//	 * 查询5条 不合格数据
//	 * @param regIds 市场IDs
//	 * @param start  开始
//	 * @param end 结束
//	 * @param conclusion 合格|不合格
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年6月27日
//	 */
//	public List<DataCheckRecording> queryUnqualCheckDataLimit5(List<Integer> regIds, String start, String end,String conclusion);
//
//	/**
//	 * 端州微信首页-检测汇总
//	 * @param departId
//	 * @param start
//	 * @param end
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年6月28日
//	 */
//	public List<Map<String, Object>> queryCountByRegIdsGroupByReg(Integer departId, String start, String end);

//	/**
//	 * 端州微信-查询指定日期不合格数据
//	 * @param regIds
//	 * @param start
//	 * @param end
//	 * @param conclusion
//	 * @return
//	 * @author LuoYX
//	 * @date 2018年6月29日
//	 */
//	public List<DataCheckRecording> queryUnqualDetailByDepartId(List<Integer> regIds, String start, String end, String conclusion);
//
//	/**
//	 * 查询 检测档口数量、检测样品数量 ， 按市场ID分组
//	 * @param regId 市场ID
//	 * @return
//	 * @author LuoYX
//	 * @param begin
//	 * @date 2018年8月24日
//	 */
//	public Map<String, Object> queryCountByRegIdGroupByRegId(Integer regId, String begin);

	/**
	 * 查询市场覆盖率数据
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年8月27日
	 */
     List<Map<String, Object>> queryCoverage(RegulatoryCoverageModel model);

	/**
	 * 查询市场检测过的 样品
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年8月27日
	 */
     List<Map<String, Object>> queryCheckFoodCountGroupByRegId(RegulatoryCoverageModel model);

	/**
	 * 总食品覆盖率
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年8月27日
	 */
     List<Map<String, Object>> queryCheckFoodCount(RegulatoryCoverageModel model);

	
     List<Map<String, Object>> queryCheckFoodCount2(RegulatoryCoverageModel model);

	/**
	 * 查询时间段内 未检测的 样品 明细
	 * @param model
	 * @return
	 * @author LuoYX
	 * @date 2018年9月13日
	 */
     List<String> queryUnCheckFoodName(RegulatoryCoverageModel model);

//	/**
//	 * 获取微信端检测汇总配置文件端map对象
//	 * @return
//	 * @throws Exception
//	 */
//    public Map<String,Short> getConfigMap()throws Exception;

	/**
	 * 数据统计-检测监控-送检详情：查询检测数据明细
	 * @param page
	 * @param model
	 * @param start
	 * @param end
	 */
     Page datagridDetails(Page page, CheckResultModel model,Integer id, String start, String end);

	/**
	 * 重置检测数据同步状态
	 * @param ids 重置检测数据ID
	 * @param updateBy 操作用户ID
	 * @return
	 * @throws Exception
	 */
     int resetUploadStatus(Integer[] ids, String updateBy) throws Exception;


	/**
	 * 删除检测结果
	 * @param rid 检测结果ID
	 * @throws Exception
	 */
     void deleteCheckData(Integer rid) throws Exception;

	/**
	 * 判定数据有效性
	 * @param rid 数据ID
	 * @param param6 数据有效性：0正常，1上传超时，2手工录入无附件，3手工录入超时且无附件，4人工审核无效数据(有效改为无效)，5其他，9造假数据
	 * @param remark 备注说明
	 * @return
	 * @throws Exception
	 */
     int judge(Integer rid, Integer param6, String remark) throws Exception;

//    /**
//     * 微信云服务-查询检测数据
//     *
//     * @param rowStart 页
//     * @param rowEnd   条
//     * @param model    包含开始时间和结束时间
//     * @return
//     */
//    public List<CheckResultModel> wxQueryList(int rowStart, int rowEnd, CheckResultModel model);
//
//	/**
//	* @Description 根据抽样单ID查询检测人员姓名和检测日期
//	* @Date 2021/06/03 16:58
//	* @Author xiaoyl
//	* @Param id 抽样单ID
//	* @return
//	*/
//    public Map<String, Object> queryCheckUserBySamplingId(Integer id);
//
//	public int  bathInsertDataCheck(List<DataCheckRecording> list);
//
//	/**
//	* @Description 企业云微信端：检测室统计
//	* @Date 2021/11/22 15:34
//	* @Author xiaoyl
//	* @Param
//	* @return
//	*/
//	public List<DataCheckRecordingModel> selectPointGroup(Integer departId,String start,String end);
//
//	/**
//	 * 企业云微信端：被检单位统计
//	 * @return
//	 */
//	public List<DataCheckRecordingModel> selectRegGroup2Wx(Integer did,String start,String end,Integer pageSize);

	/**
	* @Description 甘肃项目任务考核：根据监管机构分级查看各个子机构的有效数据统计
	* @Date 2022/05/24 16:49
	* @Author xiaoyl
	* @Param departId 机构ID
	* @Param start 开始时间
	* @Param end 结束时间
	* @return
	*/
     List<Map<String, Object>>  selectEffectiveDataForGS(Integer departId, String start, String end) throws Exception;

     List<Map<String, Object>> selectQualityData(Integer departId, String start, String end) throws Exception;

	/**
	* @Description 修改疑似阳性数据为已审核状态
	* @Date 2022/11/24 11:47
	* @Author xiaoyl
	* @Param
	* @return
	*/
     int updateReviewStatus(Integer[] ids, String userId);



	/******************************************** 快检新模式 20250625 ****************************************/
	Page loadDatagridForOrder(Page page, CheckResultModel t);
	 /**
	* @Description 上传检测数据
	* @Date 2025/06/25 13:47
	* @Author Dz
	* @Param
	* @return
	*/
	void saveCheckData(SaveCheckDataDTO dto) throws Exception;

	/**
	* @Description 根据uid查询检测数据
	* @Date 2025/06/25 13:47
	* @Author Dz
	* @Param
	* @return
	*/
	DataCheckRecording getByUid(String uid);

	/**
	* @Description 根据samplingDetailId查询检测数据
	* @Date 2025/06/25 13:47
	* @Author Dz
	* @Param
	* @return
	*/
	DataCheckRecording getBySamplingDetailId(Integer samplingDetailId);

}
