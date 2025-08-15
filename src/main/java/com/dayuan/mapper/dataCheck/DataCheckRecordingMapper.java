package com.dayuan.mapper.dataCheck;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.foodTypeStatistics;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.model.dataCheck.DataCheckRecordingModel;
import com.dayuan.model.monitor.DataCheckQueryModel;
import com.dayuan.model.regulatory.RegulatoryCoverageModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * @author Dz
 * @description 针对表【data_check_recording(检测数据表)】的数据库操作Mapper
 * @createDate 2025-06-21 16:03:31
 * @Entity DataCheckRecording
 */
public interface DataCheckRecordingMapper extends BaseMapper<DataCheckRecording> {

    /**
     * 查询分页数据列表
     * @param page
     * @return
     */
    List<BaseDetectItem> loadDatagrid(Page page);

    /**
     * 查询记录总数量
     * @param page
     * @return
     */
    int getRowTotal(Page page);

    /**
     * 已处理分页
     *
     * @param page 分页参数
     * @return 抽样列表
     */
    List<DataCheckRecording> loadDatagrid1(Page page);

    /**
     * 已处理查询记录总数量
     *
     * @param page
     * @return
     */
    int getRowTotal1(Page page);

    int getRowTotals(Page page);

    List<DataCheckRecordingModel> loadDatagrids(Page page);

    List<DataCheckRecording> queryByIds(@Param("ids") List<Integer> ids);

    List<DataCheckRecording> queryByList(CheckResultModel model);

    CheckResultModel getRecording(Integer rid);

    DataCheckRecording queryBySamplingDetailId(Integer samplingDetailId);

    /**
     * 根据ID查询检测结果
     * 返回结果 rid 代替 id
     */
    DataCheckRecording queryById(String id);

    /**
     * 检测点数据统计
     *
     * @return
     */
    List<DataCheckRecordingModel> selectDataGroup(@Param("did") Integer did, @Param("typeObj") String typeObj, @Param("start") String start, @Param("end") String end, @Param("pointType") String pointType, @Param("systemFlag") Integer systemFlag, @Param("pointId") Integer pointId,@Param("pageSize") Integer pageSize);

    /**
     * 检测车数据统计
     *
     * @return
     */
    List<DataCheckRecordingModel> selectCarDataGroup(@Param("did") Integer did, @Param("checkDateStart") String start, @Param("checkDateEnd") String end, @Param("pointType") Integer pointType);

    /**
     * 机构数据统计
     *
     * @return
     */
    DataCheckRecordingModel selectDepartDataGroup(@Param("did") List<Integer> did, @Param("departId") Integer departId, @Param("departName") String departName, @Param("typeObj") String typeObj, @Param("departIds") List<Integer> departIds,
                                                  @Param("start") String start, @Param("end") String end, @Param("pointType") String pointType, @Param("systemFlag") Integer systemFlag);

    /**
     * 单位统计
     *
     * @return
     */
    List<DataCheckRecordingModel> selectDepartDataGroup2(@Param("departCode") String departCode, @Param("start") String start, @Param("end") String end);

    /**
     * 检测项目数据统计
     *
     * @return
     */
    List<DataCheckRecordingModel> selectItemGroup(@Param("did") Integer did, @Param("typeObj") String typeObj, @Param("start") String start, @Param("end") String end, @Param("pointType") String pointType, @Param("pointId") Integer pointId, @Param("systemFlag") Integer systemFlag);

    /**
     * 食品种类统计
     *
     * @return
     */
    List<DataCheckRecordingModel> selectFoodGroup(@Param("did") Integer did, @Param("fid") List<Integer> fid, @Param("typeObj") String typeObj, @Param("start") String start, @Param("end") String end, @Param("pointType") String pointType, @Param("systemFlag") Integer systemFlag, @Param("pointId") Integer pointId);

    String selectArryByFid(String fid);

    /**
     * 食品类别统计
     *
     * @return
     */
    foodTypeStatistics selectFoodTypeGroup(@Param("did") Integer did, @Param("fid") List<Integer> subIds, @Param("typeObj") String typeObj, @Param("start") String start, @Param("end") String end, @Param("name") String name, @Param("id") Integer id, @Param("pointType") String pointType, @Param("systemFlag") Integer systemFlag, @Param("pointId") Integer pointId);

    /**
     * 食品安全预警
     *
     * @return
     */
    List<DataCheckRecordingModel> selectFoodGroup2(@Param("did") Integer did, @Param("start") String start, @Param("end") String end, @Param("pointType") String pointType, @Param("systemFlag") Integer systemFlag, @Param("pointId") Integer pointId, @Param("pageSize")Integer pageSize);

    /**
     * 被检单位统计
     *
     * @return
     */
    List<DataCheckRecordingModel> selectRegGroup(@Param("did") Integer did, @Param("typeObj") String typeObj, @Param("start") String start, @Param("end") String end, @Param("pointType") String pointType, @Param("systemFlag") Integer systemFlag, @Param("pointId") Integer pointId,@Param("taskType") Integer taskType,@Param("pageSize")Integer pageSize);

    /**
     * 数据报表 检测趋势查询
     *
     * @param did
     * @param start
     * @param end
     * @return
     * @author wtt
     * @date 2018年11月13日
     */
    List<DataCheckRecordingModel> selectTrend(@Param("did") Integer did, @Param("datatype") String datatype, @Param("start") String start, @Param("end") String end);

    /**
     * 查出数据报表中项目总结所需要的临时数据
     *
     * @param did
     * @param start
     * @param end
     * @param foodArray
     * @param itemArray
     * @return
     * @author wtt
     * @date 2018年12月17日
     */
    List<DataCheckRecordingModel> selectDataItem(@Param("did") Integer did, @Param("start") String start, @Param("end") String end, @Param("foodArray") List<Integer> foodArray, @Param("itemArray") String[] itemArray);

    /**
     * 数据报表 检测数据分析
     *
     * @param did
     * @param start
     * @param end
     * @return
     * @author wtt
     * @date 2018年11月13日
     */
    DataCheckRecordingModel selectTrendNum(@Param("did") Integer did, @Param("start") String start, @Param("end") String end);

    DataCheckRecordingModel selectTreatment(@Param("did") Integer did, @Param("start") String start, @Param("end") String end);

    List<DataCheckRecordingModel> selectDataForDate(@Param("pointId") Integer pointId, @Param("regId") Integer regId, @Param("typeObj") String typeObj, @Param("start") String start, @Param("end") String end);

    List<DataCheckRecordingModel> selectDataForDates(@Param("pointId") Integer pointId, @Param("regId") Integer regId, @Param("typeObj") String typeObj, @Param("start") String start, @Param("end") String end);

    /**
     * 按项目统计完成数量
     *
     * @param pId        项目ID
     * @param departCode
     * @return
     * @author LuoYX
     * @date 2018年3月26日
     */
    Integer queryCountByPId(@Param("pId") Integer pId, @Param("departCode") String departCode, @Param("start") String start, @Param("end") String end);

    List<Map<String, Object>> queryCountByPId2(@Param("pId") Integer pId, @Param("departCode") String departCode, @Param("start") String start, @Param("end") String end);

    /**
     * 按机构查询检测数据
     *
     * @param departId	机构ID
     * @param pointId	检测点ID
     * @param regId 监管对象ID
     * @param start   开始时间 格式：yyyy-MM-dd HH:mm:ss
     * @param end     结束时间 格式：yyyy-MM-dd HH:mm:ss
     * @return
     */
    List<DataCheckRecordingModel> queryDailyData(@Param("departId") Integer departId, @Param("pointId") Integer pointId, @Param("regId") Integer regId, @Param("start") String start, @Param("end") String end);


    /**
     * 项目进度详情，查询检测数据分析CHAT
     *
     * @param departIds 子级机构IDs
     * @param start     开始时间
     * @param end       结束时间
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    Map<String, Object> queryCheckChat(@Param("departIds") List<Integer> departIds, @Param("start") String start, @Param("end") String end);

    /**
     * 机构自身检测的数据数量
     *
     * @param departId
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    Map<String, Object> queryCountByDepartId(@Param("departId") String departId, @Param("start") String start, @Param("end") String end);

    /**
     * 机构检测数据总数、合格数、不合格数
     *
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
//    Map<String, Object> queryCountBySubDepart(@Param("departId") String departId, @Param("departIds") String[] departIds, @Param("start") String start, @Param("end") String end);
    Map<String, Object> queryCountBySubDepart(@Param("departIds") List<Integer> departIds, @Param("start") String start, @Param("end") String end);

    /**
     * 33大类检测CHAT
     *
     * @param departIds
     * @param typeIds
     * @param start
     * @param end
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    Map<String, Object> queryCountBySubType(@Param("departIds") List<Integer> departIds, @Param("typeIds") List<Integer> typeIds, @Param("start") String start, @Param("end") String end);

    /**
     * 查询不合格排行CHAT
     *
     * @param departIds
     * @param start
     * @param end
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    List<Map<String, Object>> queryCountByFoodNameAndUnqual(@Param("departIds") List<Integer> departIds, @Param("start") String start, @Param("end") String end);

    /**
     * 根据 监管对象 Ids 查询检测总数、合格数、不合格数
     *
     * @param regIds 监管对象Ids
     * @param end    开始时间
     * @param start  结束时间
     * @return
     * @author LuoYX
     * @date 2018年4月27日
     */
    Map<String, Object> queryCountByRegIds(@Param("regIds") List<Integer> regIds, @Param("start") String start, @Param("end") String end);

    /**
     * 端州微信首页-查询5条 不合格数据
     *
     * @param regIds     市场IDs
     * @param start      开始
     * @param end        结束
     * @param conclusion 合格|不合格
     * @return
     * @author LuoYX
     * @date 2018年6月27日
     */
    List<DataCheckRecording> queryUnqualCheckDataLimit5(@Param("regIds") List<Integer> regIds, @Param("start") String start, @Param("end") String end, @Param("conclusion") String conclusion);

    /**
     * 端州微信首页-检测汇总
     *
     * @param departId
     * @param start
     * @param end
     * @return
     * @author LuoYX
     * @date 2018年6月28日
     */
    List<Map<String, Object>> queryCountByRegIdsGroupByReg(@Param("departId") Integer departId, @Param("start") String start, @Param("end") String end);

    /**
     * 端州微信-查询指定日期不合格数据
     *
     * @param regIds
     * @param start
     * @param end
     * @param conclusion
     * @return
     * @author LuoYX
     * @date 2018年6月29日
     */
    List<DataCheckRecording> queryUnqualDetailByDepartId(@Param("regIds") List<Integer> regIds, @Param("start") String start, @Param("end") String end, @Param("conclusion") String conclusion);

    /**
     * 查询 检测档口数量、检测样品数量 ， 按市场ID分组
     *
     * @param regId 市场ID
     * @param begin
     * @return
     * @author LuoYX
     * @date 2018年8月24日
     */
    Map<String, Object> queryCountByRegIdGroupByRegId(@Param("regId") Integer regId, @Param("begin") String begin);

    /**
     * 查询市场覆盖率数据
     *
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年8月27日
     */
    List<Map<String, Object>> queryCoverage(RegulatoryCoverageModel model);

    /**
     * 查询市场检测过的 样品
     *
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年8月27日
     */
    List<Map<String, Object>> queryCheckFoodCountGroupByRegId(RegulatoryCoverageModel model);

    /**
     * 总食品覆盖率
     *
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年8月27日
     */
    List<Map<String, Object>> queryCheckFoodCount(RegulatoryCoverageModel model);

    List<Map<String, Object>> queryCheckFoodCount2(RegulatoryCoverageModel model);

    /**
     * 查询时间段内 未检测的 样品 明细
     *
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年9月13日
     */
    List<String> queryUnCheckFoodName(RegulatoryCoverageModel model);

    /**
     * 获取微信端检测汇总配置文件端map对象
     *
     * @return
     * @throws Exception
     */
    Map<String, Short> getConfigMap();

    /**
     * 上传抽样单、送样单检测数据-查询分页数据
     *
     * @param page
     * @return
     */
    List<DataCheckRecording> loadDatagridUpload2(Page page);

    /**
     * 上传抽样单、送样单检测数据-查询记录总数量
     *
     * @param page
     * @return
     */
    int getRowTotalUpload2(Page page);

    /**
     * 上传订单检测数据-查询分页数据
     *
     * @param page
     * @return
     */
    List<DataCheckRecording> loadDatagridUpload3(Page page);

    /**
     * 上传订单检测数据-查询记录总数量
     *
     * @param page
     * @return
     */
    int getRowTotalUpload3(Page page);

    /**
     * 查询订单数据上传列表
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年3月3日
     */
    List<DataCheckRecording> loadDatagridForOrder(Page page);

    /**
     * 查询订单数据上传数量
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年3月3日
     */
    int getRowTotalForOrder(Page page);

    /**
     * 数据统计-检测监控-送检详情：查询检测数据明细
     *
     * @param page
     * @param id
     * @param start
     * @param end
     * @return
     */
    int getRowTotalDetails(@Param("page") Page page, @Param("id") Integer id, @Param("start") String start, @Param("end") String end);

    /**
     * 数据统计-检测监控-送检详情：查询检测数据明细
     *
     * @param page
     * @param id
     * @param start
     * @param end
     * @return
     */
    List<CheckResultModel> loadDatagridDetails(@Param("page") Page page, @Param("id") Integer id, @Param("start") String start, @Param("end") String end);

    /**
     * 重置同步状态
     *
     * @param ids
     * @return
     */
    int resetUploadStatus(@Param("ids") Integer[] ids, @Param("updateBy") String updateBy);

    /**
     * 微信云服务-查询检测数据
     *
     * @param rowStart 页
     * @param rowEnd   条
     * @param obj      包含开始时间和结束时间
     * @return
     */
    List<CheckResultModel> wxQueryList(@Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd, @Param("obj") CheckResultModel obj);
    /**
     * @Description 根据抽样单ID查询检测人员姓名和检测日期
     * @Date 2021/06/03 16:58
     * @Author xiaoyl
     * @Param id 抽样单ID
     * @return
     */
    Map<String, Object> queryCheckUserBySamplingId(@Param("id")Integer id);

    /**
     * 批量插入数据
     * @param list
     */
    int  bathInsertDataCheck(@Param("list")List<DataCheckRecording> list);

    /**
     * 企业云微信端：检测室统计
     * @return
     */
    List<DataCheckRecordingModel> selectPointGroup(@Param("departId") Integer departId, @Param("start") String start, @Param("end") String end);

    /**
     * 企业云微信端：被检单位统计
     *
     * @return
     */
    List<DataCheckRecordingModel> selectRegGroup2Wx(@Param("did") Integer did,@Param("start") String start, @Param("end") String end,@Param("pageSize")Integer pageSize);


    DataCheckRecording queryByUniqualiId(String uniqualId);
    /**
    * @Description甘肃项目：有效数据统计数据查询
    * @Date 2022/05/25 13:18
    * @Author xiaoyl
    * @Param
    * @return
    */
    List<Map<String, Object>>  selectEffectiveDataForGS(@Param("departCode") String departCode, @Param("start") String start, @Param("end") String end);

    int getRowTotalForGS(Page page);

    List<DataCheckRecording> loadDatagridForGS(Page page);

    List<Map<String, Object>> selectQualityData(@Param("departCode") String departCode, @Param("start") String start, @Param("end") String end);

    int queryMonitorRowTotal(DataCheckQueryModel model);

    List<DataCheckRecordingModel> queryMonitorCheckData(DataCheckQueryModel model);
    /**
    * @Description 修改疑似阳性数据为已审核状态
    * @Date 2022/11/24 11:52
    * @Author xiaoyl
    * @Param
    * @return
    */
    int updateReviewStatus(@Param("ids")Integer[] ids, @Param("userId")String userId);
}