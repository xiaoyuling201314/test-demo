package com.dayuan.service.DataCheck.impl;

import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.*;
import com.dayuan.bean.dataCheck.DataCheckHistoryRecording;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.dataCheck.DataCheckRecordingMapper;
import com.dayuan.mapper.sampling.TbSamplingDetailRecevieMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.model.dataCheck.DataCheckRecordingModel;
import com.dayuan.model.monitor.DataCheckQueryModel;
import com.dayuan.model.regulatory.RegulatoryCoverageModel;
import com.dayuan.service.DataCheck.DataCheckHistoryRecordingService;
import com.dayuan.service.DataCheck.DataCheckRecordingAddendumService;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.DataCheck.DataUnqualifiedRecordingService;
import com.dayuan.service.data.*;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.sampling.TbSamplingDetailCodeService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.service.system.TSUserService;
import com.dayuan.service.task.TaskDetailService;
import com.dayuan.service.task.TaskService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.HttpClient4Util;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramException;
import com.dayuan3.api.vo.check.SaveCheckDataDTO;
import com.dayuan3.common.util.SystemConfigUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
* @author Dz
* @description 针对表【data_check_recording(检测数据表)】的数据库操作Service实现
* @createDate 2025-06-21 16:03:31
*/
@Slf4j
@Service
@RequiredArgsConstructor
public class DataCheckRecordingServiceImpl extends ServiceImpl<DataCheckRecordingMapper, DataCheckRecording>
    implements DataCheckRecordingService {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private BaseDeviceService baseDeviceService;
    @Autowired
    private BaseDeviceTypeService baseDeviceTypeService;
    @Autowired
    private BaseDeviceParameterService baseDeviceParameterService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private TaskDetailService taskDetailService;
    @Autowired
    private BaseDetectItemService detectItemService;
    @Autowired
    private BaseStandardService standardService;
    @Autowired
    private BaseFoodTypeService foodTypeService;
    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private DataUnqualifiedRecordingService dataUnqualifiedRecordingService;
    @Autowired
    private DataCheckRecordingAddendumService dataCheckRecordingAddendumService;
    @Autowired
    private TbSamplingDetailRecevieMapper recevieMapper;

    private final TbSamplingService tbSamplingService;
    private final TbSamplingDetailService tbSamplingDetailService;
    private final TbSamplingDetailCodeService tbSamplingDetailCodeService;
    private final TSDepartService departService;
    private final BasePointService pointService;
    private final TSUserService userService;
    private final DataCheckHistoryRecordingService dataCheckHistoryRecordingService;

    @Value("${systemUrl}")
    private String systemUrl;

    private Logger iErrLog = Logger.getLogger("iERR");


    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        }

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 已处理分页
     * @param page
     * @param dataCheckRecording
     * @return
     */
    public Page loadDatagrid1(Page page, DataCheckRecording dataCheckRecording){
        //初始化分页参数
        if(null==page){
            page = new Page();
        }

        page.setRowTotal(getBaseMapper().getRowTotal1(page));
        //每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal()/(page.getPageSize()*1.0)));

        page.setObj(dataCheckRecording);
        List<DataCheckRecording> dataCheckRecordingList = getBaseMapper().loadDatagrid1(page);
        page.setResults(dataCheckRecordingList);
        return page;
    }

    /**
     * 数据列表分页方法
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrids(Page page, DataCheckRecordingModel t) {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotals(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if(page.getPageNo() <= 0){
            page.setPageNo(1);
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }else if(page.getPageNo() > page.getPageCount()){
            page.setPageNo(page.getPageCount());
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }

        List<DataCheckRecordingModel> dataList = getBaseMapper().loadDatagrids(page);
        page.setResults(dataList);
        return page;
    }

    public List<DataCheckRecording> queryByIds(List<Integer> ids){
        return getBaseMapper().queryByIds(ids);
    }

    public List<DataCheckRecording> queryByList(CheckResultModel model){
        return getBaseMapper().queryByList(model);
    }

    public DataCheckRecording queryBySamplingDetailId(Integer SamplingDetailId){
        return getBaseMapper().queryBySamplingDetailId(SamplingDetailId);
    }

    /**
     * 检测点数据统计
     * @return
     */
    public List<DataCheckRecordingModel> selectDataGroup(Integer did,String typeObj,String start,String end,String pointType,Integer systemFlag,Integer pointId,Integer pageSize){
        return getBaseMapper().selectDataGroup(did,typeObj,start,end,pointType,systemFlag,pointId,pageSize);
    }
    /**
     * @Description 快检车数据统计
     * @Date 2021/03/04 16:55
     * @Author xiaoyl
     * @Param
     * @return
     */
    public List<DataCheckRecordingModel> selectCarDataGroup(Integer did,String start,String end,Integer pointType){
        return getBaseMapper().selectCarDataGroup(did,start,end,pointType);
    }
    /**
     * 机构数据统计
     * @return
     */
    public DataCheckRecordingModel selectDepartDataGroup(List<Integer> did,Integer departId,String departName,String typeObj,List<Integer> departIds,String start,String end,String pointType,Integer systemFlag){
        return getBaseMapper().selectDepartDataGroup(did,departId,departName,typeObj,departIds,start,end,pointType,systemFlag);
    }
    /**
     * 单位统计
     * @return
     */
    public List<DataCheckRecordingModel> selectDepartDataGroup2(Integer departId, String start, String end) throws Exception {
        TSDepart depart = departService.getById(departId);
        if (depart != null) {
            if (end.length() < 11) {
                end += " 23:59:59";
            }
            return getBaseMapper().selectDepartDataGroup2(depart.getDepartCode(), start, end);

        } else {
            return new ArrayList<DataCheckRecordingModel>();
        }
    }

    /**
     * 检测项目数据统计
     * @return
     */
    public List<DataCheckRecordingModel> selectItemGroup(Integer did,String typeObj,String start,String end,String pointType,Integer pointId,Integer systemFlag){
        return getBaseMapper().selectItemGroup(did,typeObj,start,end,pointType,pointId,systemFlag);
    }
    /**
     * 食品种类统计
     * @return
     */
    public List<DataCheckRecordingModel> selectFoodGroup(Integer did,List<Integer> subIds,String typeObj,String start,String end,String pointType,Integer systemFlag,Integer pointId){
        return getBaseMapper().selectFoodGroup(did,subIds,typeObj,start,end,pointType,systemFlag,pointId);
    }

    public String selectArryByFid(String fid){
        return getBaseMapper().selectArryByFid(fid);
    }

    /**
     * 食品类别统计
     * @param did
     * @param start
     * @param end
     * @return
     */
    public foodTypeStatistics selectFoodTypeGroup(Integer did, List<Integer> subIds, String typeObj, String start, String end, String name, Integer id, String pointType, Integer systemFlag, Integer pointId){
        return getBaseMapper().selectFoodTypeGroup(did,subIds,typeObj,start,end,name,id,pointType,systemFlag,pointId);
    }

    /**
     * 食品安全预警
     * @return
     */
    public List<DataCheckRecordingModel> selectFoodGroup2(Integer did,String start,String end,String pointType,Integer systemFlag,Integer pointId,Integer pageSize){
        return getBaseMapper().selectFoodGroup2(did,start,end,pointType,systemFlag,pointId,pageSize);
    }

    /**
     * 被检单位统计
     * @return
     */
    public List<DataCheckRecordingModel> selectRegGroup(Integer did,String typeObj,String start,String end,String pointType,Integer systemFlag,Integer pointId,Integer taskType,Integer pageSize){
        return getBaseMapper().selectRegGroup(did,typeObj,start,end,pointType,systemFlag,pointId,taskType,pageSize);
    }

    public List<DataCheckRecordingModel> selectDataItem(Integer did,String start,String end,List<Integer> foodArray,String[] itemArray){
        return getBaseMapper().selectDataItem(did, start, end, foodArray, itemArray);
    }

    /**
     * 数据报表 检测趋势查询
     * @param did
     * @param start
     * @param end
     * @return
     * @author wtt
     * @date 2018年11月13日
     */
    public List<DataCheckRecordingModel> selectTrend(Integer did,String datatype,String start,String end){
        return getBaseMapper().selectTrend(did,datatype, start, end);
    }

    /**
     * 数据报表 检测数据分析
     * @param did
     * @param start
     * @param end
     * @return
     * @author wtt
     * @date 2018年11月13日
     */
    public DataCheckRecordingModel selectTrendNum(Integer did,String start,String end){

        return getBaseMapper().selectTrendNum(did, start, end);
    }

    public DataCheckRecordingModel selectTreatment(Integer did,String start,String end){

        return getBaseMapper().selectTreatment(did, start, end);
    }

    public List<DataCheckRecordingModel> selectDataForDate(Integer pointId,Integer regId,String typeObj,String start,String end){
        return getBaseMapper().selectDataForDate(pointId,regId,typeObj, start, end);
    }

    public List<DataCheckRecordingModel> selectDataForDates(Integer pointId,Integer regId,String typeObj,String start,String end){
        return getBaseMapper().selectDataForDates(pointId,regId,typeObj,start, end);
    }
    //	/**
//	 * 结果处理
//	 * @param dataCheckModel
//	 */
//
//	public void doHandle(DataUnqualifiedTreatmentModel dataCheckModel) {
//		if(null != dataCheckModel && null != dataCheckModel.getDataCheckRecording()){ //基础数据不为空
//			//获取基础数据
//			DataCheckRecording dataCheckRecording = dataCheckModel.getDataCheckRecording();
//			//获取不合格数据
//			DataUnqualifiedTreatment dataUnqualifiedTreatment = dataCheckModel.getDataUnqualifiedTreatment();
//			//基础数据id不为空
//			if(StringUtil.isNotEmpty(dataCheckRecording.getId())){
//				if(dataCheckRecording.getDealType() == 1){
//					dataCheckRecording.setConclusion("合格");
//				}
//				getBaseMapper().updateByPrimaryKeySelective(dataCheckRecording);
//
//				dataUnqualifiedTreatment.setId(UUIDGenerator.generate());
//
//				dataUnqualifiedTreatmentMapper.insertSelective(dataUnqualifiedTreatment);
//			}
//		}
//	}
    public CheckResultModel getRecording(Integer rid){
        return getBaseMapper().getRecording(rid);
    }

    /**
     * 新增或更新检测结果
     * @param bean 检测结果
     * @param user 上传用户
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public int saveOrUpdateDataChecking(DataCheckRecording bean, TSUser user) throws Exception{

//        if (user != null) {
//            //add by xiaoyl 2020/10/30 检测数据上传时写入用户签名文件
//            if(StringUtil.isNotEmpty(user.getSignatureFile())){
//                bean.setCheckUserSignature(user.getSignatureFile());
//            }
//        }
//
//        //设置样品父类
//        BaseFoodType food = foodTypeService.getById(bean.getFoodId());
//
//        DataCheckRecording olddc = null;
//        DataCheckRecordingAddendum addendum = bean.getAddendum();
//        if(StringUtil.isNotEmpty(bean.getSamplingDetailId())) {
//
//            TbSamplingDetail samplingDetail = samplingDetailService.getById(bean.getSamplingDetailId());
//            if (samplingDetail == null) {
//                throw new MyException("没有找到samplingDetailId为"+bean.getSamplingDetailId()+"的数据", "没有找到samplingDetailId为"+bean.getSamplingDetailId()+"的数据", WebConstant.INTERFACE_CODE5);
//            } else if (samplingDetail.getSamplingId() == null || bean.getSamplingId() == null
//                    || samplingDetail.getSamplingId().intValue() != bean.getSamplingId().intValue()){
//                throw new MyException("无效数据，samplingId和samplingDetailId不关联", "无效数据，samplingId和samplingDetailId不关联", WebConstant.INTERFACE_CODE2);
//            }
//
//            //用抽样明细ID判断数据是否重传
//            olddc = getBaseMapper().queryBySamplingDetailId(bean.getSamplingDetailId());
//
//
//            //保存附加表数据
//            TbSampling ts = samplingService.getById(bean.getSamplingId().intValue());
//            if (bean.getAddendum() == null) {
//
//
//            } else {
//
//                if (addendum.getSamplingNumber() == null) {
//                    addendum.setSamplingNumber((samplingDetail.getSampleNumber() != null ? samplingDetail.getSampleNumber().doubleValue() : null));
//                }
//                if (addendum.getPurchaseDate() == null) {
//                    addendum.setPurchaseDate(samplingDetail.getPurchaseDate());
//                }
//                if (addendum.getPurchaseAmount() == null) {
//                    addendum.setPurchaseAmount((samplingDetail.getPurchaseAmount() != null ? samplingDetail.getPurchaseAmount().doubleValue() : null));
//                }
//                if (StringUtils.isBlank(addendum.getSupplier())) {
//                    addendum.setSupplier(samplingDetail.getSupplier());
//                }
//                if (StringUtils.isBlank(addendum.getSupplierAddress())) {
//                    addendum.setSupplierAddress(samplingDetail.getSupplierAddress());
//                }
//                if (StringUtils.isBlank(addendum.getSupplierPerson())) {
//                    addendum.setSupplierPerson(samplingDetail.getSupplierPerson());
//                }
//                if (StringUtils.isBlank(addendum.getSupplierPhone())) {
//                    addendum.setSupplierPhone(samplingDetail.getSupplierPhone());
//                }
//                if (StringUtils.isBlank(addendum.getBatchNumber())) {
//                    addendum.setBatchNumber(samplingDetail.getBatchNumber());
//                }
//                if (StringUtils.isBlank(addendum.getOrigin())) {
//                    addendum.setOrigin(samplingDetail.getOrigin());
//                }
//            }
//
//            bean.setAddendum(addendum);
//
//        } else if (StringUtil.isNotEmpty(bean.getId())) {
//            //用检测数据id判断数据是否重传，查询结果 rid 代替 id
//            olddc = getBaseMapper().queryById(bean.getId());
//
//        } else if (bean.getRid() != null) {
//            //平台更改检测结果
//            olddc = getBaseMapper().selectByPrimaryKey(bean.getRid());
//
//            //生成平台修改数据的唯一ID
//            String ptid = UUIDGenerator.generate();
//
//            //旧数据是平台上传或导入的
//            if (olddc.getDataSource() == 3 || olddc.getDataSource() == 4) {
//                //使用旧ID，避免因为数据ID不同重复生成历史数据
//                ptid = olddc.getCheckRecordingId();
//            }
//
//            //生成平台修改数据
//            bean.set(ptid, olddc.getFoodTypeId(), olddc.getFoodTypeName(), olddc.getFoodId(), olddc.getFoodName(), olddc.getRegId(), olddc.getRegName(),
//                    olddc.getRegUserId(), olddc.getRegUserName(), olddc.getDepartId(), olddc.getDepartName(), olddc.getPointId(), olddc.getPointName(),
//                    olddc.getItemId(), olddc.getItemName(), olddc.getCheckAccordId(), olddc.getCheckAccord(), olddc.getCheckUnit(),
//                    olddc.getLimitValue(), bean.getCheckResult(), bean.getConclusion(), bean.getCheckDate(), olddc.getCheckUsername(), olddc.getAuditorName(),
//                    olddc.getUploadName(), new Date(), olddc.getDeviceName(), olddc.getDeviceCompany(), olddc.getDeviceModel(), olddc.getDeviceMethod(),
//                    (short)(olddc.getReloadFlag()+1), (short)3, olddc.getStatusFalg(), (short)0, olddc.getCreateBy(), olddc.getUpdateBy(), olddc.getCreateDate(),
//                    olddc.getUploadDate(), olddc.getParam3(), olddc.getDataType(), bean.getModifiedRemark(), olddc.getParam4(), olddc.getParam5(), olddc.getParam6(),
//                    olddc.getParam7(), olddc.getCheckVoucher(), olddc.getParam8(), olddc.getParam9(), olddc.getTime1());
//        }
//
//
//        int recheckModel = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 1, "system_config", "recheck", "model");
//        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
//
//        //首次上传
//        if(olddc == null){
//            //设置上传次数
//            bean.setReloadFlag((short) 1);
//            //设置删除标识0没有删除1删除
//            bean.setDeleteFlag((short)0);
//            PublicUtil.setCommonForTable(bean, true, user);
//
//            //合格数据、平台上传数据和导入数据视为最终结果，状态改为已审核
//            if ("合格".equals(bean.getConclusion()) || bean.getDataSource() == 3 || bean.getDataSource() == 4 || recheckNumber == 1 || bean.getSamplingDetailId() == null) {
//                //已审核
//                bean.setParam7(1);
//
//            } else {
//                //未审核
//                bean.setParam7(0);
//            }
//
//            //保存主表
//            int status = getBaseMapper().insertSelective(bean);
//
//            //保存不合格数据消息记录表
//            dataUnqualifiedRecordingService.save(bean, user);
//
//            //add by xiaoyl 2022/12/30 更新仪器最后使用日期和累计更新次数
//            baseDeviceService.updateDeviceUsage(bean.getDeviceId());
//
//            //保存附加数据
//            if (addendum != null) {
//                addendum.setRid(bean.getRid().intValue());
//                if (StringUtils.isBlank(addendum.getItemVulgo())) {
//                    BaseDetectItem bdi = detectItemService.getById(bean.getItemId());
//                    if (bdi == null) {
//                        throw new MyException("无效数据，itemId不存在", "无效数据，itemId不存在", WebConstant.INTERFACE_CODE2);
//                    }
////					addendum.setItemVulgo(bdi.getDetectItemVulgo());
//                }
//                dataCheckRecordingAddendumService.insertSelective(addendum);
//            }
//
//            //更新任务进度
//            if (bean.getDataType() == 0) {
//                final DataCheckRecording mydcr = bean;
//                threadPoolTaskExecutor.execute(new Runnable() {
//                    @Override
//                    public void run() {
//                        try {
//                            taskService.updateTaskProgress(mydcr.getCheckDate(), mydcr.getPointId(), mydcr.getFoodId(), mydcr.getItemId(), 0);
//                        } catch (Exception e) {
//                            log.error("*****更新抽检任务进度*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//                        }
//                    }
//                });
//            }
//
//            return status;
//
//            //重传检测数据
//        } else {
//
//            bean.setRid(olddc.getRid());
//            //设置删除标识0没有删除1删除
//            bean.setDeleteFlag((short)0);
//            PublicUtil.setCommonForTable(bean, false, user);
//
//            int status = 0;
//
//            //3选2复检模式，3次以内以两次相同结果为准，超出3次以最后上传结果为准
//            if (recheckModel == 2) {
//
//                //1.判读重复上传数据
//                //是否检测数据表数据
//                if (bean.getId().equals(olddc.getCheckRecordingId())
//                        && bean.getCheckDate().getTime() == olddc.getCheckDate().getTime()
//                        && bean.getConclusion() != null && bean.getConclusion().equals(olddc.getConclusion())
//                        && bean.getCheckResult() != null && bean.getCheckResult().equals(olddc.getCheckResult())) {
//                    iErrLog.info("[重传相同数据] [" + user.getUserName() + "] 新数据：" + JSONObject.toJSONString(bean) + "；原数据：" + JSONObject.toJSONString(olddc));
//                    return status;
//                }
//                //是否历史表数据
//                if (olddc.getReloadFlag() > 1) {
//                    DataCheckHistoryRecording dchr = dataCheckHistoryRecordingService.selectCheckHistory(bean.getRid(), bean.getId(), bean.getCheckDate(), bean.getCheckResult(), bean.getConclusion());
//                    if (dchr != null) {
//                        //仪器重传相同数据，不做处理
//                        iErrLog.info("[重传相同数据] [" + user.getUserName() + "] 新数据：" + JSONObject.toJSONString(bean) + "；原数据：" + JSONObject.toJSONString(olddc));
//                        return status;
//                    }
//                }
//
//
//                olddc.setId(olddc.getCheckRecordingId());
//                bean.setRid(olddc.getRid());
//                bean.setCheckRecordingId(bean.getId());
//
//                //2.第二次上传数据，判读检测结果是否相同，取最新检测时间数据
//                if (olddc.getReloadFlag() == 1) {
//
//                    //原数据较新，新数据保存到历史表，bean新数据，olddc原数据
//                    if(bean.getCheckDate().getTime() < olddc.getCheckDate().getTime()) {
//                        //对调数据对象
//                        DataCheckRecording temp = bean;
//                        bean = olddc;
//                        olddc = temp;
//                    }
//
//                    //保存检测结果历史数据
//                    dataCheckHistoryRecordingService.save(olddc);
//
//                    //上传次数+1
//                    bean.setReloadFlag((short) 2);
//
//                    //2次合格或2次不合格
//                    if (bean.getConclusion().equals(olddc.getConclusion())) {
//                        //已审核
//                        bean.setParam7(1);
//
//                        //1次合格1次不合格
//                    } else {
//                        //未审核
//                        bean.setParam7(0);
//                    }
//
//                    //更新重传数据
//                    status = getBaseMapper().updateByPrimaryKeySelective(bean);
//
//                    //保存不合格数据消息记录表
//                    if (StringUtils.isBlank(bean.getFoodName())) {
//                        //平台重传数据没foodName
//                        dataUnqualifiedRecordingService.save(queryById(bean.getRid()), user);
//                    } else {
//                        //仪器重传
//                        dataUnqualifiedRecordingService.save(bean, user);
//                    }
//
//                    //保存附加数据
//                    if (addendum != null) {
//                        addendum.setRid(bean.getRid().intValue());
//                        if (StringUtils.isBlank(addendum.getItemVulgo())) {
//                            BaseDetectItem bdi = detectItemService.getById(bean.getItemId());
//                            if (bdi == null) {
//                                throw new MyException("无效数据，itemId不存在", "无效数据，itemId不存在", WebConstant.INTERFACE_CODE2);
//                            }
////							addendum.setItemVulgo(bdi.getDetectItemVulgo());
//                        }
//                        dataCheckRecordingAddendumService.updateByRid(addendum);
//                    }
//
//                    //3.第三次上传数据，取较多相同结果且检测时间最新的数据
//                } else if (olddc.getReloadFlag() == 2) {
//
//                    //原数据和新数据结果相同，取检测时间最新的数据
//                    if (bean.getConclusion().equals(olddc.getConclusion())) {
//
//                        //原数据较新，新数据保存到历史表，bean新数据，olddc原数据
//                        if(bean.getCheckDate().getTime() < olddc.getCheckDate().getTime()) {
//                            //对调数据对象
//                            DataCheckRecording temp = bean;
//                            bean = olddc;
//                            olddc = temp;
//                        }
//
//                        //保存到历史数据
//                        dataCheckHistoryRecordingService.save(olddc);
//
//                        //原数据和新数据结果不相同，取相同结果较多且检测时间最新的数据
//                    } else {
//                        List<DataCheckHistoryRecording> dchrList = dataCheckHistoryRecordingService.selectCheckHistoryByRid(olddc.getRid());
//                        DataCheckHistoryRecording dchr0 = dchrList.get(0);
//
//                        //新数据和历史表数据结果相同，取检测时间最新的数据
//                        if (bean.getConclusion().equals(dchr0.getConclusion())) {
//
//                            //历史表数据较新，新数据和原数据保存到历史表，bean新数据，olddc原数据，dchr0历史表数据
//                            if(bean.getCheckDate().getTime() < dchr0.getCheckDate().getTime()) {
//
//                                //新数据保存到历史表
//                                DataCheckHistoryRecording dchr = new DataCheckHistoryRecording();
//                                dchr.setId(dchr0.getId());
//                                dchr.setCheckResult(bean.getCheckResult());
//                                dchr.setCheckUnit(bean.getCheckUnit());
//                                dchr.setConclusion(bean.getConclusion());
//                                dchr.setUploadId(bean.getUploadId());
//                                dchr.setUploadName(bean.getUploadName());
//                                dchr.setUploadDate(new Date());
//                                dchr.setCheckDate(bean.getCheckDate());
//                                dchr.setDeviceId(bean.getDeviceId());
//                                dchr.setDeviceName(bean.getDeviceName());
//                                dchr.setDeviceModel(bean.getDeviceModel());
//                                dchr.setDeviceMethod(bean.getDeviceMethod());
//                                dchr.setDeviceCompany(bean.getDeviceCompany());
//                                dchr.setDataSource(bean.getDataSource());
//                                dataCheckHistoryRecordingService.updateBySelective(dchr);
//
//                                //原数据保存到历史表
//                                dataCheckHistoryRecordingService.save(olddc);
//
//                                //取历史表数据为最终数据
//                                bean.setCheckResult(dchr0.getCheckResult());
//                                bean.setCheckUnit(dchr0.getCheckUnit());
//                                bean.setConclusion(dchr0.getConclusion());
//                                bean.setUploadId(dchr0.getUploadId());
//                                bean.setUploadName(dchr0.getUploadName());
//                                bean.setUploadDate(dchr0.getUploadDate());
//                                bean.setCheckDate(dchr0.getCheckDate());
//                                bean.setDeviceId(dchr0.getDeviceId());
//                                bean.setDeviceName(dchr0.getDeviceName());
//                                bean.setDeviceModel(dchr0.getDeviceModel());
//                                bean.setDeviceMethod(dchr0.getDeviceMethod());
//                                bean.setDeviceCompany(dchr0.getDeviceCompany());
//                                bean.setDataSource(dchr0.getDataSource());
//
//                                //原数据保存到历史表
//                            } else {
//                                dataCheckHistoryRecordingService.save(olddc);
//                            }
//
//                            //新数据保存到历史表
//                        } else {
//                            //对调数据对象
//                            DataCheckRecording temp = bean;
//                            bean = olddc;
//                            olddc = temp;
//
//                            dataCheckHistoryRecordingService.save(olddc);
//                        }
//                    }
//
//                    //上传次数+1
//                    bean.setReloadFlag((short) 3);
//                    //已审核
//                    bean.setParam7(1);
//
//                    //更新重传数据
//                    status = getBaseMapper().updateByPrimaryKeySelective(bean);
//
//                    //保存不合格数据消息记录表
//                    if (StringUtils.isBlank(bean.getFoodName())) {
//                        //平台重传数据没foodName
//                        dataUnqualifiedRecordingService.save(queryById(bean.getRid()), user);
//                    } else {
//                        //仪器重传
//                        dataUnqualifiedRecordingService.save(bean, user);
//                    }
//
//                    //保存附加数据
//                    if (addendum != null) {
//                        addendum.setRid(bean.getRid().intValue());
//                        if (StringUtils.isBlank(addendum.getItemVulgo())) {
//                            BaseDetectItem bdi = detectItemService.getById(bean.getItemId());
//                            if (bdi == null) {
//                                throw new MyException("无效数据，itemId不存在", "无效数据，itemId不存在", WebConstant.INTERFACE_CODE2);
//                            }
////							addendum.setItemVulgo(bdi.getDetectItemVulgo());
//                        }
//                        dataCheckRecordingAddendumService.updateByRid(addendum);
//                    }
//
//                    //4.大于三次上传数据，取最新检测时间数据
//                } else {
//
//                    //原数据较新，新数据保存到历史表，bean新数据，olddc原数据
//                    if(bean.getCheckDate().getTime() < olddc.getCheckDate().getTime()) {
//                        //对调数据对象
//                        DataCheckRecording temp = bean;
//                        bean = olddc;
//                        olddc = temp;
//                    }
//
//                    //保存检测结果历史数据
//                    dataCheckHistoryRecordingService.save(olddc);
//
//                    //上传次数+1
//                    bean.setReloadFlag((short) (olddc.getReloadFlag()+1));
//                    //已审核
//                    bean.setParam7(1);
//
//                    //更新重传数据
//                    status = getBaseMapper().updateByPrimaryKeySelective(bean);
//
//                    //保存不合格数据消息记录表
//                    if (StringUtils.isBlank(bean.getFoodName())) {
//                        //平台重传数据没foodName
//                        dataUnqualifiedRecordingService.save(queryById(bean.getRid()), user);
//                    } else {
//                        //仪器重传
//                        dataUnqualifiedRecordingService.save(bean, user);
//                    }
//
//                    //保存附加数据
//                    if (addendum != null) {
//                        addendum.setRid(bean.getRid().intValue());
//                        if (StringUtils.isBlank(addendum.getItemVulgo())) {
//                            BaseDetectItem bdi = detectItemService.getById(bean.getItemId());
//                            if (bdi == null) {
//                                throw new MyException("无效数据，itemId不存在", "无效数据，itemId不存在", WebConstant.INTERFACE_CODE2);
//                            }
////							addendum.setItemVulgo(bdi.getDetectItemVulgo());
//                        }
//                        dataCheckRecordingAddendumService.updateByRid(addendum);
//                    }
//
//                }
//                //add by xiaoyl 2022/12/30 更新仪器最后使用日期和累计更新次数
//                baseDeviceService.updateDeviceUsage(bean.getDeviceId());
//
//                //默认复检模式，以最后上传结果为准
//            } else {
//                //1.重传旧数据
//                if (bean.getCheckDate().getTime() < olddc.getCheckDate().getTime()) {
//                    //1-1.判断数据是否在历史表已存在
//                    DataCheckHistoryRecording dchr = dataCheckHistoryRecordingService.selectCheckHistory(bean.getRid(), bean.getId(), bean.getCheckDate(), bean.getCheckResult(), bean.getConclusion());
//                    if (dchr == null) {
//                        //保存检测结果历史数据
//                        bean.setReloadFlag(olddc.getReloadFlag());
//                        bean.setCheckRecordingId(bean.getId());
//                        dataCheckHistoryRecordingService.save(bean);
//
//                        //设置上传次数+1
//                        DataCheckRecording r = new DataCheckRecording();
//                        r.setRid(olddc.getRid());
//                        r.setReloadFlag((short) (olddc.getReloadFlag()+1));
//                        if ("合格".equals(olddc.getConclusion()) || r.getReloadFlag() >= recheckNumber) {
//                            //已审核
//                            bean.setParam7(1);
//                        } else {
//                            //未审核
//                            bean.setParam7(0);
//                        }
//                        updateBySelective(r);
//                    } else {
//                        //仪器重传相同数据，不做处理
//                        iErrLog.info("[重传相同数据] [" + user.getUserName() + "] 新数据：" + JSONObject.toJSONString(bean) + "；原数据：" + JSONObject.toJSONString(olddc));
//                        return status;
//                    }
//
//                    //2.重传新数据
//                } else {
//                    //2-1.新数据的ID、检测时间、检测值、检测结果和原数据相同，仪器重传相同数据，不做处理
//                    if (bean.getId().equals(olddc.getCheckRecordingId())
//                            && bean.getCheckDate().getTime() == olddc.getCheckDate().getTime()
//                            && bean.getConclusion() != null && bean.getConclusion().equals(olddc.getConclusion())
//                            && bean.getCheckResult() != null && bean.getCheckResult().equals(olddc.getCheckResult())) {
//                        iErrLog.info("[重传相同数据] [" + user.getUserName() + "] 新数据：" + JSONObject.toJSONString(bean) + "；原数据：" + JSONObject.toJSONString(olddc));
//                        return status;
//                    } else {
//                        //2-2.判断数据是否在历史表已存在
//                        DataCheckHistoryRecording dchr = dataCheckHistoryRecordingService.selectCheckHistory(olddc.getRid(), olddc.getCheckRecordingId(), olddc.getCheckDate(), olddc.getCheckResult(), olddc.getConclusion());
//                        if (dchr == null) {
//                            //保存检测结果历史数据
//                            olddc.setId(olddc.getCheckRecordingId());
//                            dataCheckHistoryRecordingService.save(olddc);
//
//                            //设置上传次数+1
//                            bean.setReloadFlag((short) (olddc.getReloadFlag()+1));
//
//                        } else {
//                            //仪器重传相同数据，不做处理
//                            iErrLog.info("[重传相同数据] [" + user.getUserName() + "] 新数据：" + JSONObject.toJSONString(bean) + "；原数据：" + JSONObject.toJSONString(olddc));
//                            return status;
//                        }
//
//                        bean.setCheckRecordingId(bean.getId());
//                        if ("合格".equals(bean.getConclusion()) || bean.getReloadFlag() >= recheckNumber) {
//                            //已审核
//                            bean.setParam7(1);
//                        } else {
//                            //未审核
//                            bean.setParam7(0);
//                        }
//                        //更新重传数据
//                        status = getBaseMapper().updateByPrimaryKeySelective(bean);
//
//                        //保存不合格数据消息记录表
//                        if (StringUtils.isBlank(bean.getFoodName())) {
//                            //平台重传数据没foodName
//                            dataUnqualifiedRecordingService.save(queryById(bean.getRid()), user);
//                        } else {
//                            //仪器重传
//                            dataUnqualifiedRecordingService.save(bean, user);
//                        }
//
//                        //保存附加数据
//                        if (addendum != null) {
//                            addendum.setRid(bean.getRid().intValue());
//                            if (StringUtils.isBlank(addendum.getItemVulgo())) {
//                                BaseDetectItem bdi = detectItemService.getById(bean.getItemId());
//                                if (bdi == null) {
//                                    throw new MyException("无效数据，itemId不存在", "无效数据，itemId不存在", WebConstant.INTERFACE_CODE2);
//                                }
////								addendum.setItemVulgo(bdi.getDetectItemVulgo());
//                            }
//                            dataCheckRecordingAddendumService.updateByRid(addendum);
//                        }
//
//                    }
//                }
//                //add by xiaoyl 2022/12/30 更新仪器最后使用日期和累计更新次数
//                baseDeviceService.updateDeviceUsage(bean.getDeviceId());
//            }
//
//            //更新任务进度
//            if (1 == olddc.getDeleteFlag() && bean.getDataType() == 0) {
//                final DataCheckRecording mydcr = bean;
//                threadPoolTaskExecutor.execute(new Runnable() {
//                    @Override
//                    public void run() {
//                        try {
//                            taskService.updateTaskProgress(mydcr.getCheckDate(), mydcr.getPointId(), mydcr.getFoodId(), mydcr.getItemId(), 0);
//                        } catch (Exception e) {
//                            log.error("*****更新抽检任务进度*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//                        }
//                    }
//                });
//            }
//
//            return status;
//
//        }
        return 0;
    }

//	/**
//	 * 未上传检测结果抽样单
//	 */
//	public Page loadDatagrid2(Page page, CheckResultModel checkResult) throws Exception{
//		return loadDatagrid(page, checkResult, mapper1);
//	}


    /**
     * 平台批量上传检测数据
     * @param samplingDetailIds		抽样单ID
     * @param conclusion    检测结果
     * @param checkResult   检测值
     * @param checkDate     检测时间
     * @param projectPath add by xiaoyl 2020-03-09 项目地址跟路径，用于生成报告相关签名数据
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public void uploadData2(List<Integer> samplingDetailIds, String conclusion, String checkResult, Date checkDate, String projectPath) throws Exception{
        TSUser user = PublicUtil.getSessionUser();
        for (Integer samplingDetailId : samplingDetailIds) {
            DataCheckRecording bean = new DataCheckRecording();
            bean.setUid(UUIDGenerator.generate());
            bean.setSamplingDetailId(samplingDetailId);
            bean.setConclusion(conclusion);
            bean.setCheckResult(checkResult);
            bean.setCheckDate(checkDate);
            bean.setDataSource(3);

            if(user != null){
                bean.setCheckUserid(user.getId());
                bean.setCheckUsername(user.getRealname());
            }

            uploadData(bean, null, projectPath);
        }
    }

    /**
     * 平台检测数据上传
     * @param projectPath add by xiaoyl 2020-03-09 项目地址跟路径，用于生成报告相关签名数据
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public void uploadData(DataCheckRecording bean,String deviceParameterId,String projectPath) throws Exception{
        TSUser user = PublicUtil.getSessionUser();
        TbSamplingDetail detail = tbSamplingDetailService.getById(bean.getSamplingDetailId());
        BaseDevice device=baseDeviceService.getById(bean.getDeviceId());
        TbSampling sampling = null;
        BasePoint point =null;
        BaseStandard standard =null;
        if(detail != null){
            bean.setSamplingId(detail.getSamplingId());
            bean.setFoodId(detail.getFoodId());
            bean.setFoodName(detail.getFoodName());
            bean.setItemId(detail.getItemId());
            bean.setItemName(detail.getItemName());
            bean.setReloadFlag(1);

            sampling = tbSamplingService.getById(detail.getSamplingId());
//			if(sampling != null){
//				bean.setRegId(sampling.getRegId());
//				bean.setRegName(sampling.getRegName());
//				bean.setRegUserId(sampling.getOpeId());
//				bean.setRegUserName(sampling.getOpeShopCode());
//
//				bean.setDataType(sampling.getPersonal());
//
//				//抽样单、送样单 - 获取收样机构、检测点
//				if (sampling.getPersonal()==0 || sampling.getPersonal()==1) {
//					bean.setPointId(sampling.getPointId());
//					point = basePointService.queryById(sampling.getPointId());
//					if(point!=null){
//						bean.setPointName(point.getPointName());
//					}
//					bean.setDepartId(sampling.getDepartId());
//					TSDepart depart = departService.queryById(point.getDepartId());
//					if(depart != null){
//						bean.setDepartName(depart.getDepartName());
//					}
//
//				//订单 - 获取收样机构、检测点
//				} else if (sampling.getPersonal()==2) {
//					//由用户选择检测点
//					point = basePointService.queryById(bean.getPointId());
//					if(point!=null){
//						bean.setPointName(point.getPointName());
//					}
//					bean.setDepartId(detail.getDepartId());
//					TSDepart depart = departService.queryById(detail.getDepartId());
//					if(depart != null){
//						bean.setDepartName(depart.getDepartName());
//					}
//
//					//清空试管码
//					StringBuffer subffer=new StringBuffer();
//					subffer.append("UPDATE tb_sampling_detail_code  " +
//							"	SET tube_code1=NULL, tube_code_time1=NULL, " +
//							"		tube_code2=NULL, tube_code_time2=NULL, " +
//							"		tube_code3=NULL, tube_code_time3=NULL, " +
//							"		tube_code4=NULL, tube_code_time4=NULL,  " +
//							"		delete_flag=0, update_date=NOW() " +
//							"WHERE sampling_detail_id=? " );
//					jdbcTemplate.update(subffer.toString(), new Object[]{detail.getId()});
//				}
//
//			}

            BaseDetectItem detectItem = detectItemService.getById(detail.getItemId());
            if(detectItem != null){
                bean.setCheckAccordId(detectItem.getStandardId());

                standard = standardService.getById(detectItem.getStandardId());
                if(standard != null){
                    bean.setCheckAccord(standard.getStdName());
                }
                bean.setLimitValue(detectItem.getDetectSign() + detectItem.getDetectValue());
                bean.setCheckUnit(detectItem.getDetectValueUnit());
            }

            //不分配到仪器任务中
//			detail.setStatus((short) 1);
            if(device!=null){
                detail.setRecevieDevice(device.getSerialNumber());
            }else {
                detail.setRecevieDevice(null);
            }
            PublicUtil.setCommonForTable(detail, false);
            tbSamplingDetailService.updateById(detail);
            //删除仪器任务
            recevieMapper.deleteBySdId(detail.getId());
        }

        if(StringUtil.isNotEmpty(deviceParameterId)) {
            BaseDeviceParameter deviceParameter = baseDeviceParameterService.getById(deviceParameterId);
            if(deviceParameter != null){
                bean.setDeviceModel(deviceParameter.getProjectType());
                bean.setDeviceMethod(deviceParameter.getDetectMethod());

                BaseDeviceType baseDeviceType = baseDeviceTypeService.queryById(deviceParameter.getDeviceTypeId());
                if(baseDeviceType != null){
                    bean.setDeviceCompany(baseDeviceType.getDeviceMaker());
                }
            }
        }

        if(device!=null){
            bean.setDeviceName(device.getDeviceName());
        }

        bean.setStatusFalg(0);
        this.saveOrUpdateDataChecking(bean,user);

/*		try {
			//上传订单检测结果，推送公众号消息
			if (sampling.getPersonal()==2) {
				//TODO 写入检测报告附加信息至关联表中 check_report_data add by xiaoyl 2020/03/06
				JSONObject reportConfig=SystemConfigUtil.REPORT_CONFIG;
				String reviewImage=projectPath +reportConfig.getString("sign_file");//签名文件
				String approveImage=projectPath +reportConfig.getString("approve_file");//批准文件
				String signatureImage=projectPath +reportConfig.getString("signature_file");//电子签章
				reviewImage=StringUtil.isNotEmpty(reviewImage) ? Xml2Word2Pdf.img2Base64(reviewImage) : "";
				approveImage=StringUtil.isNotEmpty(approveImage) ? Xml2Word2Pdf.img2Base64(approveImage) : "";
				signatureImage=StringUtil.isNotEmpty(signatureImage) ? Xml2Word2Pdf.img2Base64(signatureImage) : "";
				CheckReportData reportData=new CheckReportData(bean.getRid(), standard.getStdCode(), point.getAddress(),point.getPhone(), reviewImage, approveImage, signatureImage);
				reportDataMapper.insertSelective(reportData);

				int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
				//推送微信消息
				StringBuffer sql = new StringBuffer();
				//查询每次送样样品检测情况
				sql.append("SELECT tsd.id, tsd.sampling_id samplingId, tsd.sample_code sampleCode, tsd.sample_tube_time sampleTubeTime, tsd.collect_code collectCode,  " +
						" COUNT(1) totalNum, " +    //此次送样样品数量
						" SUM(  " +
						"  IF ( IF(dcr.conclusion = '' OR (dcr.conclusion = '不合格' AND dcr.reload_flag < " + recheckNumber + "), NULL, dcr.conclusion) IS NULL, 0, 1 ) " +
						" ) checkedNum, " +    //已检测数量
						" MAX(dcr.check_date) checkDate " +    //已检测数量
						"FROM tb_sampling_detail tsd " +
						"INNER JOIN  " +
						"( " +
						" SELECT sampling_id, sample_tube_time " +    //查询上传结果的样品ID和送检时间
						"  FROM tb_sampling_detail  " +
						" WHERE id = " + bean.getSamplingDetailId() + " " +
						" AND sample_tube_time IS NOT NULL " +
						" GROUP BY sampling_id, sample_tube_time " +
						") tb1 ON tb1.sampling_id = tsd.sampling_id AND tb1.sample_tube_time = tsd.sample_tube_time " +
						"LEFT JOIN data_check_recording dcr ON tsd.id = dcr.sampling_detail_id " +
						"GROUP BY tsd.sampling_id, tsd.sample_tube_time ");
				List<Map<String, Object>> result = jdbcTemplate.queryForList(sql.toString());
				for (Map<String, Object> res : result) {
					//送检数量 等于 已检测数量，此次送样已全部检测
					if (res.get("totalNum").toString().equals(res.get("checkedNum").toString())) {
						sql.setLength(0);
						//查询订单号、送检人OPEN_ID
						sql.append("SELECT ts.sampling_no samplingNo, iuu.open_id openId " +
								"FROM tb_sampling ts " +
								" INNER JOIN inspection_unit_user iuu ON ts.sampling_userid = iuu.id " +
								"WHERE ts.delete_flag = 0 AND ts.personal = 2 AND ts.order_status = 2 " +
								" AND ts.id = ? ");
						List<Map<String, Object>> result0 = jdbcTemplate.queryForList(sql.toString(), new Object[]{res.get("samplingId").toString()});
						if (result0.size() > 0 && result0.get(0).get("openId") != null && !"".equals(result0.get(0).get("openId").toString().trim())) {
							wxPayService.sendCheckMsg(result0.get(0).get("openId").toString(),
									systemUrl+"collectSample/detail?samplingId="+res.get("samplingId").toString()+"&collectCode="+res.get("collectCode").toString(),
									result0.get(0).get("samplingNo").toString(),
									(Date) res.get("checkDate"), (Date) res.get("sampleTubeTime"));
						}
					}
				}
			}
		} catch (Exception e) {
			log.error("*************************推送微信消息失败：" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}*/

    }

    /**
     * 按项目统计完成数量
     * @param pId 项目ID
     * @param departCode 项目的顶级机构code
     * @return
     * @author LuoYX
     * @date 2018年3月26日
     */
    public Integer queryCountByPId(Integer pId,String departCode,String start,String end) {
        return getBaseMapper().queryCountByPId(pId,departCode,start,end);
    }

    public List<Map<String, Object>> queryCountByPId2(Integer pId,String departCode,String start,String end) {
        return getBaseMapper().queryCountByPId2(pId,departCode,start,end);
    }

    /**
     * 查询当天检测数据
     * @author Dz
     * @param departId	机构ID
     * @param pointId	检测点ID
     * @param regId 监管对象ID
     * @param date
     * @return
     */
    public List<DataCheckRecordingModel> queryDailyData(Integer departId, Integer pointId, Integer regId, Date date){
        return getBaseMapper().queryDailyData(departId, pointId, regId, DateUtil.formatDate(date, "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(date, "yyyy-MM-dd 23:59:59"));
    }

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
    public List<DataCheckRecordingModel> queryCheckData(Integer departId, Integer pointId, Integer regId, String start, String end){
        return getBaseMapper().queryDailyData(departId, pointId, regId, start, end);
    }

    public int queryMonitorRowTotal(DataCheckQueryModel model){
        return getBaseMapper().queryMonitorRowTotal(model);
    }
    public List<DataCheckRecordingModel> queryMonitorCheckData(DataCheckQueryModel model){
        return getBaseMapper().queryMonitorCheckData(model);
    }
    /**
     * 项目进度详情，查询检测数据分析CHAT
     * @param departIds 子级机构IDs
     * @param start 开始时间
     * @param end 结束时间
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public Map<String, Object> queryCheckChat(List<Integer> departIds, String start, String end) {
        return getBaseMapper().queryCheckChat(departIds,start,end);
    }

    /**
     * 机构自身检测的数据数量
     * @param departId
     * @param start 开始时间
     * @param end 结束时间
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public Map<String, Object> queryCountByDepartId(String departId,String start,String end) {
        return getBaseMapper().queryCountByDepartId(departId,start,end);
    }

    /**
     * 机构检测数据总数、合格数、不合格数
     * @param departIds 机构Id
     * @param start 开始时间
     * @param end 结束时间
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public Map<String, Object> queryCountBySubDepart(List<Integer> departIds,String start,String end) {
        return getBaseMapper().queryCountBySubDepart(departIds,start,end);
    }

    /**
     * 33大类检测CHAT
     * @param departIds
     * @param typeIds
     * @param start
     * @param end
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public Map<String, Object> queryCountBySubType(List<Integer> departIds, List<Integer> typeIds, String start, String end) {
        return getBaseMapper().queryCountBySubType(departIds, typeIds, start,  end);
    }

    /**
     * 查询不合格排行CHAT
     * @param departIds
     * @param start
     * @param end
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public List<Map<String, Object>> queryCountByFoodNameAndUnqual(List<Integer> departIds, String start, String end) {
        return getBaseMapper().queryCountByFoodNameAndUnqual(departIds, start, end);
    }

    /**
     * 根据 监管对象 Ids 查询检测总数、合格数、不合格数
     * @param regIds 监管对象Ids
     * @param end 开始时间
     * @param start 结束时间
     * @return
     * @author LuoYX
     * @date 2018年4月27日
     */
    public Map<String, Object> queryCountByRegIds(List<Integer> regIds, String start, String end) {
        return getBaseMapper().queryCountByRegIds(regIds,start,end);
    }

    /**
     * 获取当月检测数据数量（首页统计）
     * @param tsUser
     * @return
     * @throws Exception
     */
    public Map<String,Object> queryCheckNumM(TSUser tsUser) throws Exception{

        Map<String,Object> map = new HashMap<String,Object>();
        StringBuffer sbuffer = new StringBuffer();
        if(null != tsUser){
            String start = DateUtil.firstDayOfMonth();
            String end = DateUtil.lastDayOfMonth() + " 23:59:59";
            if(StringUtil.isNotEmpty(tsUser.getPointId())){

                //当月检测数据数量
                sbuffer.setLength(0);
                sbuffer.append("SELECT " +
                        "	COUNT(1) aRecording, " +
                        "	SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) qRecording, " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) uRecording " +
                        "	FROM data_check_recording dcr" +
                        "	WHERE dcr.delete_flag = 0 and dcr.param7 = 1 and dcr.point_id = ? and dcr.check_date>=? and dcr.check_date<=?  ");
                Map map2 = jdbcTemplate.queryForMap(sbuffer.toString(), new Object[] {tsUser.getPointId(),start ,end});

                map.put("aRecording", map2.get("aRecording"));	//当月检测数据总数量
                map.put("qRecording", StringUtil.isNotEmpty(map2.get("qRecording")) ? map2.get("qRecording") : 0 );	//当月检测数据合格数量
                map.put("uRecording", StringUtil.isNotEmpty(map2.get("uRecording")) ? map2.get("uRecording") : 0 );	//当月检测数据不合格数量

            }else if(StringUtil.isNotEmpty(tsUser.getDepartId())){
                TSDepart depart = departService.getById(tsUser.getDepartId());
                String departCode = depart.getDepartCode();
//				String departCode = PublicUtil.getSessionUserDepart().getDepartCode();
                //当月检测数据数量
                sbuffer.setLength(0);
                sbuffer.append("SELECT " +
                        "	COUNT(1) aRecording, " +
                        "	SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) qRecording, " +
                        "	SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) uRecording " +
                        "FROM data_check_recording dcr " +
                        "		WHERE dcr.depart_id in (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code like CONCAT(?,'%')) and dcr.delete_flag = 0 and dcr.param7 = 1  and dcr.check_date>=? and dcr.check_date<=? ");
                Map map2 = jdbcTemplate.queryForMap(sbuffer.toString(), new Object[] {departCode,start,end});

                map.put("aRecording", map2.get("aRecording"));	//当月检测数据总数量
                map.put("qRecording", StringUtil.isNotEmpty(map2.get("qRecording")) ? map2.get("qRecording") : 0 );	//当月检测数据合格数量
                map.put("uRecording", StringUtil.isNotEmpty(map2.get("uRecording")) ? map2.get("uRecording") : 0 );	//当月检测数据不合格数量

            }
        }
        return map;
    }

    /**
     * 获取每天检测数据数量（首页统计）
     * @param pointId
     * @param departId
     * @param startDate	开始
     * @param endDate	结束
     * @return
     * @throws Exception
     */
    public Map<String,Object> queryCheckNumW(Integer pointId, Integer departId, Date startDate, Date endDate) throws Exception{

        //开始结束时间对换
        if (startDate.getTime() > endDate.getTime()) {
            Date d = startDate;
            startDate = endDate;
            endDate = d;
        }

        Map<String,Object> map = new HashMap<String,Object>();
        StringBuffer sbuffer = new StringBuffer();
        String start = DateUtil.formatDate(startDate, "yyyy-MM-dd 00:00:00");
        String end = DateUtil.formatDate(endDate, "yyyy-MM-dd 23:59:59");

        List<Map<String, Object>> list8 = null;
        if(pointId != null){
            //最近X天合格/不合格检测量
            sbuffer.setLength(0);
            sbuffer.append("SELECT ");
            sbuffer.append("a.md 'days',");
            sbuffer.append("IFNULL(sum(a.hg), 0) 'qualified',");
            sbuffer.append("IFNULL(sum(a.bhg), 0) 'unqualified',");
            sbuffer.append("IFNULL(sum(a.zs), 0) 'total' ");
            sbuffer.append("FROM ");
            sbuffer.append("( ");
            sbuffer.append("SELECT ");
            sbuffer.append("date_format(check_date, '%Y-%m-%d') AS md, ");
            sbuffer.append("SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) AS 'hg', " );
            sbuffer.append("SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) AS 'bhg', " );
            sbuffer.append("sum(1) AS 'zs' ");
            sbuffer.append("FROM ");
            sbuffer.append("data_check_recording dcr ");
            sbuffer.append("WHERE dcr.delete_flag = 0  AND dcr.param7 = 1 AND dcr.point_id = ?  " );
            sbuffer.append("AND dcr.check_date BETWEEN ? AND ? " );
            sbuffer.append("GROUP BY md, dcr.conclusion " );
            sbuffer.append(") a " );
            sbuffer.append("GROUP BY a.md ORDER BY a.md ASC");

            list8 = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {pointId, start, end});

        } else if (departId != null){
            TSDepart depart = departService.getById(departId);
            String departCode = depart.getDepartCode();
            //最近X天合格/不合格检测量
            sbuffer.setLength(0);
            sbuffer.append("SELECT " +
                    "	a.md 'days', " +
                    "	IFNULL(sum(a.hg), 0) 'qualified', " +
                    "	IFNULL(sum(a.bhg), 0) 'unqualified', " +
                    "	IFNULL(sum(a.zs), 0) 'total' " +
                    "FROM " +
                    "	( " +
                    "		SELECT " +
                    "			date_format(check_date, '%Y-%m-%d') AS md, " +
                    "			SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) AS 'hg', " +
                    "			SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) AS 'bhg', " +
                    "			sum(1) AS 'zs' " +
                    "		FROM " +
                    "			data_check_recording dcr " +
                    "		WHERE dcr.depart_id in (SELECT id FROM t_s_depart WHERE delete_flag=0 and depart_code like CONCAT(?,'%')) " +
                    "		AND dcr.delete_flag = 0 AND dcr.param7 = 1 AND check_date between ? AND ? " +
                    "		GROUP BY date_format(dcr.check_date, '%Y-%m-%d'), dcr.conclusion " +
                    "	) a " +
                    "GROUP BY a.md ORDER BY a.md ASC");

            list8 = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {departCode, start, end});
        }

        Calendar startCal = Calendar.getInstance();
        startCal.clear();
        startCal.setTime(DateUtil.parseDate(start, "yyyy-MM-dd HH:mm:ss"));

        Calendar endCal = Calendar.getInstance();
        endCal.clear();
        endCal.setTime(DateUtil.parseDate(end, "yyyy-MM-dd HH:mm:ss"));

        List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
        //补全每天检测量数据
        do {
            String ymd = DateUtil.formatDate(startCal.getTime(), "yyyy-MM-dd");
            if(list8 == null || list8.size()==0){
                Map m = new HashMap<String, Object>();
                m.put("days", ymd);
                m.put("qualified", 0);
                m.put("unqualified", 0);
                m.put("total", 0);
                list9.add(m);

            } else {
                Iterator iterator = list8.iterator();
                while (iterator.hasNext()) {
                    Map m = (Map) iterator.next();
                    if(m!=null && ymd.equals(m.get("days"))){
                        list9.add(m);
                        iterator.remove();
                        break;

                        //当天无检测记录
                    } else if(!iterator.hasNext()) {
                        m = new HashMap<String, Object>();
                        m.put("days", ymd);
                        m.put("qualified", 0);
                        m.put("unqualified", 0);
                        m.put("total", 0);
                        list9.add(m);
                    }
                }
            }

            startCal.add(Calendar.DAY_OF_MONTH, 1);
        } while (startCal.getTimeInMillis() <= endCal.getTimeInMillis());
        map.put("quantity", list9);

        return map;
    }

    /**
     * 获取当天每小时检测数据数量
     * @param pointId
     * @param departId
     * @param date		统计日期
     * @return
     * @throws Exception
     */
    public Map<String,Object> queryCheckNumD(Integer pointId, Integer departId, Date date) throws Exception{

        Map<String,Object> map = new HashMap<String,Object>();
        StringBuffer sbuffer = new StringBuffer();
        List<Map<String, Object>> list8 = null;
        if(pointId != null){
            sbuffer.append("SELECT  " +
                    " a.md 'hours', " +
                    " IFNULL(sum(a.hg), 0) 'qualified', " +
                    " IFNULL(sum(a.bhg), 0) 'unqualified', " +
                    " IFNULL(sum(a.zs), 0) 'total'  " +
                    "FROM  " +
                    "(  " +
                    " SELECT  " +
                    " date_format(check_date, '%H:00') AS md,  " +
                    " SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) AS 'hg',  " +
                    " SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) AS 'bhg',  " +
                    " sum(1) AS 'zs'  " +
                    " FROM  " +
                    " data_check_recording dcr  " +
                    " WHERE dcr.delete_flag = 0 AND dcr.param7 = 1 AND dcr.point_id = ?  " +
                    " AND dcr.check_date BETWEEN ? AND ?  " +
                    " GROUP BY md, dcr.conclusion  " +
                    ") a  " +
                    "GROUP BY a.md ORDER BY a.md DESC");
            list8 = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {pointId, DateUtil.formatDate(date, "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(date, "yyyy-MM-dd 23:59:59")});

        }else if (departId != null){
            sbuffer.append("SELECT  " +
                    " a.md 'hours', " +
                    " IFNULL(sum(a.hg), 0) 'qualified', " +
                    " IFNULL(sum(a.bhg), 0) 'unqualified', " +
                    " IFNULL(sum(a.zs), 0) 'total'  " +
                    "FROM  " +
                    "(  " +
                    " SELECT  " +
                    " date_format(check_date, '%H:00') AS md,  " +
                    " SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) AS 'hg',  " +
                    " SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) AS 'bhg',  " +
                    " sum(1) AS 'zs'  " +
                    " FROM  " +
                    " data_check_recording dcr  " +
                    " WHERE dcr.delete_flag = 0 AND dcr.depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag=0 AND id = ?),'%'))  " +
                    " AND dcr.check_date BETWEEN ? AND ?  " +
                    " GROUP BY md, dcr.conclusion  " +
                    ") a  " +
                    "GROUP BY a.md ORDER BY a.md DESC");
            list8 = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {departId, DateUtil.formatDate(date, "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(date, "yyyy-MM-dd 23:59:59")});
        }

        List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
        Calendar c0 = Calendar.getInstance();
        for (int i=0; i<24; i++) {
            c0.set(Calendar.HOUR_OF_DAY, i);
            String ct0 = DateUtil.formatDate(c0.getTime(), "HH:00");

            if (list8!=null && list8.size()>0) {
                Iterator iterator = list8.iterator();
                while (iterator.hasNext()) {	//当天无检测记录，合格/不合格数量为0
                    Map m = (Map) iterator.next();
                    if(ct0.equals(m.get("hours"))){
                        list9.add(m);
                        iterator.remove();
                        break;
                    }
                    if(!iterator.hasNext()) {//最后一个元素
                        m = new HashMap<String, Object>();
                        m.put("hours", ct0);
                        m.put("qualified", 0);
                        m.put("unqualified", 0);
                        m.put("total", 0);
                        list9.add(m);
                    }
                }

            } else {
                Map m = new HashMap<String, Object>();
                m.put("hours", ct0);
                m.put("qualified", 0);
                m.put("unqualified", 0);
                m.put("total", 0);
                list9.add(m);
            }
        }
        map.put("quantity", list9);

        return map;
    }

    /**
     * 查询5条 不合格数据
     * @param regIds 市场IDs
     * @param start  开始
     * @param end 结束
     * @param conclusion 合格|不合格
     * @return
     * @author LuoYX
     * @date 2018年6月27日
     */
    public List<DataCheckRecording> queryUnqualCheckDataLimit5(List<Integer> regIds, String start, String end,String conclusion) {
        return getBaseMapper().queryUnqualCheckDataLimit5(regIds,start,end,conclusion);
    }

    /**
     * 端州微信首页-检测汇总
     * @param departId
     * @param start
     * @param end
     * @return
     * @author LuoYX
     * @date 2018年6月28日
     */
    public List<Map<String, Object>> queryCountByRegIdsGroupByReg(Integer departId, String start, String end) {
        return getBaseMapper().queryCountByRegIdsGroupByReg(departId,start,end);
    }

    /**
     * 端州微信-查询指定日期不合格数据
     * @param regIds
     * @param start
     * @param end
     * @param conclusion
     * @return
     * @author LuoYX
     * @date 2018年6月29日
     */
    public List<DataCheckRecording> queryUnqualDetailByDepartId(List<Integer> regIds, String start, String end, String conclusion) {
        return getBaseMapper().queryUnqualDetailByDepartId(regIds,start,end,conclusion);
    }

    /**
     * 查询 检测档口数量、检测样品数量 ， 按市场ID分组
     * @param regId 市场ID
     * @return
     * @author LuoYX
     * @param begin
     * @date 2018年8月24日
     */
    public Map<String, Object> queryCountByRegIdGroupByRegId(Integer regId, String begin) {
        return getBaseMapper().queryCountByRegIdGroupByRegId(regId,begin);
    }

    /**
     * 查询市场覆盖率数据
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年8月27日
     */
    public List<Map<String, Object>> queryCoverage(RegulatoryCoverageModel model) {
        return getBaseMapper().queryCoverage(model);
    }

    /**
     * 查询市场检测过的 样品
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年8月27日
     */
    public List<Map<String, Object>> queryCheckFoodCountGroupByRegId(RegulatoryCoverageModel model) {
        return getBaseMapper().queryCheckFoodCountGroupByRegId(model);
    }

    /**
     * 总食品覆盖率
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年8月27日
     */
    public List<Map<String, Object>> queryCheckFoodCount(RegulatoryCoverageModel model) {
        return getBaseMapper().queryCheckFoodCount(model);
    }


    public List<Map<String, Object>> queryCheckFoodCount2(RegulatoryCoverageModel model) {
        return getBaseMapper().queryCheckFoodCount2(model);
    }
    /**
     * 查询时间段内 未检测的 样品 明细
     * @param model
     * @return
     * @author LuoYX
     * @date 2018年9月13日
     */
    public List<String> queryUnCheckFoodName(RegulatoryCoverageModel model) {
        return getBaseMapper().queryUnCheckFoodName(model);
    }

    /**
     * 获取微信端检测汇总配置文件端map对象
     * @return
     * @throws Exception
     */
    public Map<String,Short> getConfigMap()throws Exception {
        return getBaseMapper().getConfigMap();
    }


    /**
     * 数据统计-检测监控-送检详情：查询检测数据明细
     * @param page
     * @param model
     * @param start
     * @param end
     */
    public Page datagridDetails(Page page, CheckResultModel model,Integer id, String start, String end) {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(model);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotalDetails(page,id,start,end));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if(page.getPageNo() <= 0){
            page.setPageNo(1);
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }else if(page.getPageNo() > page.getPageCount()){
            page.setPageNo(page.getPageCount());
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }
        List<CheckResultModel> dataList = getBaseMapper().loadDatagridDetails(page,id,start,end);
        page.setResults(dataList);
        return page;
    }

    /**
     * 重置检测数据同步状态
     * @param ids 重置检测数据ID
     * @param updateBy 操作用户ID
     * @return
     * @throws Exception
     */
    public int resetUploadStatus(Integer[] ids, String updateBy) throws Exception {
        if (ids == null || ids.length < 1) {
            return 0;
        }
        return getBaseMapper().resetUploadStatus(ids, updateBy);
    }


    /**
     * 删除检测结果
     * @param rid 检测结果ID
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public void deleteCheckData(Integer rid) throws Exception {
        removeById(rid);

//        //更新任务进度(删除)
//        if (checkData.getDataType() == 0) {
//            threadPoolTaskExecutor.execute(new Runnable() {
//                @Override
//                public void run() {
//                    try {
//                        taskService.updateTaskProgress(checkData.getCheckDate(), checkData.getPointId(), checkData.getFoodId(), checkData.getItemId(), 1);
//                    } catch (Exception e) {
//                        log.error("*****更新抽检任务进度(删除)*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//                    }
//                }
//            });
//        }

        //更新不合格数据
        dataUnqualifiedRecordingService.deleteCheckRecording(rid);

    }

    /**
     * 判定数据有效性
     * @param rid 数据ID
     * @param param6 数据有效性：0正常，1上传超时，2手工录入无附件，3手工录入超时且无附件，4人工审核无效数据(有效改为无效)，5其他，9造假数据
     * @param remark 备注说明
     * @return
     * @throws Exception
     */
    public int judge(Integer rid, Integer param6, String remark) throws Exception {
        DataCheckRecording dcr = getById(rid);
        if (dcr == null) {
            //没找到检测数据
            return 0;
        }

        if (param6 == 0) {
            //人工审核检测数据有效的时间限制（小时）
            int validStatusTime = (SystemConfigUtil.GS_ASSESSMENT_CONFIG != null && SystemConfigUtil.GS_ASSESSMENT_CONFIG.containsKey("valid_status_time")
                    ? SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("valid_status_time") : 48);
            Calendar c = Calendar.getInstance();
            c.setTime(dcr.getCheckDate());
            c.add(Calendar.HOUR_OF_DAY, validStatusTime);
            if (c.getTime().getTime() < dcr.getUploadDate().getTime()) {
                //超时，不允许修改为正常数据
                return -1;
            }
        }

        dcr.setRemark(remark);
        PublicUtil.setCommonForTable(dcr, false);

        int us = getBaseMapper().updateById(dcr);

        //判定数据有效性或不合格处理造假，更新检测量统计
        String interfaceUrl= SystemConfigUtil.GS_ASSESSMENT_CONFIG.getString("update_checknum_url");
        interfaceUrl= interfaceUrl.replace("[ID]", ""+dcr.getId());
        String result = HttpClient4Util.doGet(interfaceUrl);

        if (StringUtils.isNotBlank(result)) {
            JSONObject resObj = JSONObject.parseObject(result);
            boolean success = resObj.getBoolean("success");
            String msg = resObj.getString("msg");
            Object obj = resObj.get("obj");

            if (!success) {
                log.error("*****更新检测量统计失败====>interfaceUrl：" + interfaceUrl + ",返回值：" + result);
            }

        } else {
            log.error("*****更新检测量统计失败====>interfaceUrl：" + interfaceUrl + ",返回值：" + result);
        }
        return us;
    }

    /**
     * 微信云服务-查询检测数据
     *
     * @param rowStart 页
     * @param rowEnd   条
     * @param model    包含开始时间和结束时间
     * @return
     */
    public List<CheckResultModel> wxQueryList(int rowStart, int rowEnd, CheckResultModel model) {
        return getBaseMapper().wxQueryList(rowStart, rowEnd, model);
    }
    /**
     * @Description 根据抽样单ID查询检测人员姓名和检测日期
     * @Date 2021/06/03 16:58
     * @Author xiaoyl
     * @Param id 抽样单ID
     * @return
     */
    public Map<String, Object> queryCheckUserBySamplingId(Integer id) {
        return getBaseMapper().queryCheckUserBySamplingId(id);
    }

    public int  bathInsertDataCheck(List<DataCheckRecording> list) {
        return getBaseMapper().bathInsertDataCheck(list);
    }

    /**
     * @Description 企业云微信端：检测室统计
     * @Date 2021/11/22 15:34
     * @Author xiaoyl
     * @Param
     * @return
     */
    public List<DataCheckRecordingModel> selectPointGroup(Integer departId,String start,String end){
        return getBaseMapper().selectPointGroup(departId,start,end);
    }

    /**
     * 企业云微信端：被检单位统计
     * @return
     */
    public List<DataCheckRecordingModel> selectRegGroup2Wx(Integer did,String start,String end,Integer pageSize){
        return getBaseMapper().selectRegGroup2Wx(did,start,end,pageSize);
    }

    /**
     * @Description 甘肃项目任务考核：根据监管机构分级查看各个子机构的有效数据统计
     * @Date 2022/05/24 16:49
     * @Author xiaoyl
     * @Param departId 机构ID
     * @Param start 开始时间
     * @Param end 结束时间
     * @return
     */
    public List<Map<String, Object>>  selectEffectiveDataForGS(Integer departId, String start, String end) throws Exception {
        TSDepart depart = departService.getById(departId);
        if (depart != null) {
            if (end.length() < 11) {
                end += " 23:59:59";
            }
            return getBaseMapper().selectEffectiveDataForGS(depart.getDepartCode(), start, end);

        } else {
            return new ArrayList<Map<String, Object>>();
        }
    }

    public List<Map<String, Object>> selectQualityData(Integer departId, String start, String end) throws Exception {
        TSDepart depart = departService.getById(departId);
        if (depart != null) {
            if (end.length() < 11) {
                end += " 23:59:59";
            }
            return getBaseMapper().selectQualityData(depart.getDepartCode(), start, end);

        } else {
            return new ArrayList<Map<String, Object>>();
        }
    }
    /**
     * @Description 修改疑似阳性数据为已审核状态
     * @Date 2022/11/24 11:47
     * @Author xiaoyl
     * @Param
     * @return
     */
    public int updateReviewStatus(Integer[] ids, String userId) {
        return getBaseMapper().updateReviewStatus(ids,userId);
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveCheckData(SaveCheckDataDTO dto) throws Exception {
        Date now = new Date();
        if (dto.getSamplingDetailId() == null || dto.getUid() == null) {
            throw new MiniProgramException(ErrCode.PARAM_REQUIRED, null, "缺少必填参数");
        }
        if (!Arrays.asList("合格", "不合格").contains(dto.getConclusion())) {
            throw new MiniProgramException(ErrCode.PARAM_ILLEGAL, null, "检测结论错误");
        }

        DataCheckRecording dcr = getBySamplingDetailId(dto.getSamplingDetailId());
        if (dcr == null) {
            // 新增
            dcr = BeanUtil.copyProperties(dto, DataCheckRecording.class);

            DataCheckRecording uidDcr = getByUid(dto.getUid());
            if (uidDcr != null) {
                throw new MiniProgramException(ErrCode.DATA_REPEAT, null, "该检测数据UUID已存在");
            }

            TbSamplingDetail samplingDetail = tbSamplingDetailService.getById(dto.getSamplingDetailId());
            if (samplingDetail == null) {
                throw new MiniProgramException(ErrCode.DATA_NOT_FOUND, null, "找不到该订单明细数据");
            }
            // 样品
            dcr.setFoodId(samplingDetail.getFoodId());
            dcr.setFoodName(samplingDetail.getFoodName());
            // 检测项目
            dcr.setItemId(samplingDetail.getItemId());
            dcr.setItemName(samplingDetail.getItemName());
            // 订单ID
            dcr.setSamplingId(samplingDetail.getSamplingId());

            TbSampling sampling = tbSamplingService.getById(samplingDetail.getSamplingId());
            if (sampling == null) {
                throw new MiniProgramException(ErrCode.DATA_NOT_FOUND, null, "找不到该订单数据");
            }

            TSUser checkUser = userService.getById(dto.getCheckUserid());
            if (checkUser == null) {
                throw new MiniProgramException(ErrCode.DATA_NOT_FOUND, null, "找不到该检测人员数据");
            }
            dcr.setCheckUserSignature(checkUser.getSignatureFile());
            // 机构
            dcr.setDepartId(checkUser.getDepartId());
            try {
                if (checkUser.getDepartId()!=null) {
                    TSDepart depart = departService.getById(checkUser.getDepartId());
                    if (depart!=null) {
                        dcr.setDepartName(depart.getDepartName());
                    }
                }
            } catch (Exception e) {
                log.error("查询机构失败",e);
            }
            // 检测点
            dcr.setPointId(checkUser.getPointId());
            try {
                if (checkUser.getPointId()!=null) {
                    BasePoint point = pointService.queryById(checkUser.getPointId());
                    if (point!=null) {
                        dcr.setPointName(point.getPointName());
                    }
                }
            } catch (Exception e) {
                log.error("查询检测点失败",e);
            }

            // 冷库
            dcr.setRegId(sampling.getCcuId());
            dcr.setRegName(sampling.getCcuName());
            // 仓口
            dcr.setRegUserId(sampling.getIuId());
            dcr.setRegUserName(sampling.getIuName());

            dcr.setReloadFlag(1);

            dcr.setCreateBy(dto.getCheckUserid());
            dcr.setCreateDate(now);
            dcr.setUpdateBy(dto.getCheckUserid());
            dcr.setUpdateDate(now);

        } else {
            // 复检数据处理，保存历史记录
            DataCheckHistoryRecording dataCheckHistoryRecording = BeanUtil.copyProperties(dcr, DataCheckHistoryRecording.class);
            dataCheckHistoryRecording.setId(null);
            dataCheckHistoryRecording.setCheckRecordingId(dcr.getId());
            dataCheckHistoryRecordingService.save(dataCheckHistoryRecording);

            // 重传或复检
            dcr.setUid(dto.getUid());
            dcr.setReloadFlag(dcr.getReloadFlag()+1);
            dcr.setUpdateBy(dto.getCheckUserid());
            dcr.setUpdateDate(now);
        }

        dcr.setUploadDate(now);
        dcr.setDataSource(1);
        dcr.setStatusFalg(1);

        // 1.保存检测数据
        saveOrUpdate(dcr);

        // 2.清空试管码
        LambdaUpdateWrapper<TbSamplingDetailCode> updateWrapper1 = new LambdaUpdateWrapper<TbSamplingDetailCode>()
                .eq(TbSamplingDetailCode::getSamplingDetailId, dto.getSamplingDetailId())
                .set(TbSamplingDetailCode::getTubeCode1, null)
                .set(TbSamplingDetailCode::getTubeCode2, null);
        tbSamplingDetailCodeService.update(updateWrapper1);

        // 3.更新订单明细状态
        LambdaUpdateWrapper<TbSamplingDetail> updateWrapper2 = new LambdaUpdateWrapper<TbSamplingDetail>()
                .eq(TbSamplingDetail::getId, dto.getSamplingDetailId())
                .set(TbSamplingDetail::getRecevieStatus, 2);
        tbSamplingDetailService.update(updateWrapper2);

        // 4.更新订单状态
        // 4.1获取订单明细列表（过滤申请复检记录）
        List<TbSamplingDetail> samplingDetails = tbSamplingDetailService.list(new LambdaQueryWrapper<TbSamplingDetail>()
                .eq(TbSamplingDetail::getSamplingId, dcr.getSamplingId())
                .eq(TbSamplingDetail::getIsRecheck, 0));
        if (samplingDetails.size() == samplingDetails.stream().filter(detail -> detail.getRecevieStatus() == 2).count()) {
            // 全部检测完成,更新订单状态
            LambdaUpdateWrapper<TbSampling> updateWrapper3 = new LambdaUpdateWrapper<TbSampling>()
                    .eq(TbSampling::getId, dcr.getSamplingId())
                    .set(TbSampling::getOrderStatus, 3);
            tbSamplingService.update(updateWrapper3);
        }
    }

    @Override
    public DataCheckRecording getByUid(String uid) {
        LambdaQueryWrapper<DataCheckRecording> queryWrapper = new LambdaQueryWrapper<DataCheckRecording>()
                .eq(DataCheckRecording::getUid, uid);
        return getOne(queryWrapper);
    }

    @Override
    public DataCheckRecording getBySamplingDetailId(Integer samplingDetailId) {
        LambdaQueryWrapper<DataCheckRecording> queryWrapper = new LambdaQueryWrapper<DataCheckRecording>()
                .eq(DataCheckRecording::getSamplingDetailId, samplingDetailId);
        return getOne(queryWrapper);
    }
    @Override
    public Page loadDatagridForOrder(Page page, CheckResultModel t) {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotalForOrder(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if(page.getPageNo() <= 0){
            page.setPageNo(1);
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }else if(page.getPageNo() > page.getPageCount()){
            page.setPageNo(page.getPageCount());
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }

        List<DataCheckRecording> dataList = getBaseMapper().loadDatagridForOrder(page);
        page.setResults(dataList);
        return page;
    }
}




