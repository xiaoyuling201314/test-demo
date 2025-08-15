package com.dayuan.service.DataCheck;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.dataCheck.DataUnqualifiedTreatment;
import com.dayuan.mapper.dataCheck.DataCheckRecordingMapper;
import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentGSMapper;
import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentMapper;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.HttpClient4Util;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


/**
 * @Description 甘肃系统：不合格处理service
 * @Date 2022/05/17 16:13
 * @Author xiaoyl
 * @Param
 * @return
 */
@Service
public class GSDataUnqualifiedTreatmentService extends BaseService<DataUnqualifiedTreatment, Integer> {

    private Logger log = Logger.getLogger(GSDataUnqualifiedTreatmentService.class);
    @Autowired
    private DataUnqualifiedTreatmentGSMapper mapper;
    @Autowired
    private DataUnqualifiedTreatmentMapper mapper1;

    @Autowired
    private DataUnqualifiedDisposeService disposeService;

    @Autowired
    private DataCheckRecordingMapper dataCheckRecordingMapper;


    public DataUnqualifiedTreatmentGSMapper getMapper() {
        return mapper;
    }

    /**
     * @return
     * @Description 根据检测数据的rid更新不合格处理状态
     * @Date 2022/05/18 15:00
     * @Author xiaoyl
     * @Param id 检测数据rid
     * @Param handledAssessment 考核状态
     * @Param handledRemark 备注
     */
    public int updateCheckDataAssessment(Integer rid, Integer hAssessment, String handledRemark) {
        int count=mapper.updateCheckDataAssessment(rid, hAssessment, handledRemark);
        //修改不合格处理考核状态，通过接口方式调用任务考核服务方法更新检测量统计
        String interfaceUrl= SystemConfigUtil.GS_ASSESSMENT_CONFIG.getString("update_checknum_url");
        interfaceUrl= interfaceUrl.replace("[RID]", ""+rid);
        String result = HttpClient4Util.doGet(interfaceUrl);
        if (StringUtils.isNotBlank(result)) {
            JSONObject resObj = JSONObject.parseObject(result);
            boolean success = resObj.getBoolean("success");
            if (!success) {
                log.error("*****更新检测量统计失败====>interfaceUrl：" + interfaceUrl + ",返回值：" + result);
            }

        } else {
            log.error("*****更新检测量统计失败====>interfaceUrl：" + interfaceUrl + ",返回值：" + result);
        }
        return count;
    }

    /**
     * @return
     * @Description 根据检测数据rid查询不合格处理情况
     * @Date 2022/05/18 15:19
     * @Author xiaoyl
     * @Param
     */
    public CheckResultModel queryByRid(Integer rid) {
        return mapper.queryByRid(rid);
    }

    /**
     * @return
     * @Description 删除不合格处理(软删除 ， 将delete_flag字段修改为1)
     * @Date 2022/05/18 14:43
     * @Author xiaoyl
     * @Param
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void deleteData(Integer id, String remark) throws Exception {
        mapper.deleteByRid(id, remark);
        //更新检测数据的不合格处理状态为未处理。
        mapper.updateCheckDataAssessment(id, null, "");
//        disposeService.deleteByUnid(id);
    }

    /**
     * @return
     * @Description 不合格处置考核状态更新
     * 1.查询近N天检测结果为不合格且未处理或者超时未处理的数据，考核状态<=1（包括''和1），
     * 2.循环遍历判断是否处理或者处理是否合规
     * 3.不合格则更新检测数据的状态
     * @Date 2022/05/18 10:16
     * @Author xiaoyl
     * @Param
     */
    public void updateHandledAssessment(String startDate) {
        //查询近N天检测结果为不合格且考核状态<=1(未处理或者超时未处理)的数据,N由“甘肃任务考核参数配置”中获取：update_interval
        JSONObject jsonObject= SystemConfigUtil.GS_ASSESSMENT_CONFIG.getJSONObject("unqualified_config");
        int updateInterval=jsonObject.getInteger("update_interval")==null ? 30 : jsonObject.getInteger("update_interval");
       //如果有传入startDate日期则使用传入的时间，没有的话则获取系统参数配置，如果系统参数未配置则默认为近30天：注意;前N天需要用负数表示，所以前面加-
        String start = StringUtil.isNotEmpty(startDate) ? startDate : DateUtil.xDayAgo(-updateInterval);
        String end = DateUtil.formatDate(new Date(), "yyyy-MM-dd") + " 59:59:59";
        Integer handledTime =jsonObject.getInteger("handled_time") == null ? 3 : jsonObject.getInteger("handled_time");//不合格处理有效性间隔，默认为3天
        List<DataCheckRecording> list = mapper.loadAllUnqualifieldData(start, end);
        if (list != null) {
            for (DataCheckRecording check : list) {
                updateSingleHandledAssessment(check.getId(),handledTime);
               /* int intervDay = 0;
                String handledRemark="";//考核状态说明
                //通过检测数据ID获取不合格处理
                CheckResultModel deal = mapper.queryByRid(check.getRid());
                if (deal == null || 0==deal.getDealMethod()) {//未处理或处理中，判断是否超时未处理，未超时则世界跳过
                    intervDay = DateUtil.getBetweenDays(check.getCheckDate(), new Date());
                    if (intervDay > handledTime) {//检测时间和当前时间对比，大于handledTime则表示超时
                        mapper.updateCheckDataAssessment(check.getRid(), 1, "");
                    }
                }else if (deal != null) {//已处理，进一步判断是否超时以及是否合规
                    int handledAssessment = 0;//核对检测世界和处理时间的间隔
                    intervDay = DateUtil.getBetweenDays(check.getCheckDate(), deal.getUpdateDate());
                    if (intervDay < handledTime && StringUtil.isNotEmpty(deal.getfFilePaths())) {//未超时且有附件，状态为0
                        handledAssessment = 0;
                    } else if (intervDay < handledTime && StringUtil.isEmpty(deal.getfFilePaths())) {//未超时没有附件表示不合规，状态为3
                        handledAssessment = 3;
                        handledRemark="没有上传处理材料";
                    } else if (intervDay > handledTime && StringUtil.isNotEmpty(deal.getfFilePaths())) {//超时且有附件，状态为2
                        handledAssessment = 2;
                        handledRemark="超时处理";
                    } else if (intervDay > handledTime && StringUtil.isEmpty(deal.getfFilePaths())) {//超时处理并且不合规，状态为4
                        handledAssessment = 4;
                        handledRemark="超时处理且没有上传处理材料";
                    }
                    mapper.updateCheckDataAssessment(check.getRid(), handledAssessment, handledRemark);
                }*/
            }
        }
    }

    /**
     * @return
     * @Description 处理单个不合格处置考核状态更新：根据检测数据rid更新处理的考核状态
     * @Date 2022/05/18 10:16
     * @Author xiaoyl
     * @Param rid 检测数据rid
     * @param handledTime 不合格处理有效期限
     */
    public int updateSingleHandledAssessment(Integer rid,Integer handledTime) {
        if(handledTime==null){
            JSONObject jsonObject= SystemConfigUtil.GS_ASSESSMENT_CONFIG.getJSONObject("unqualified_config");
            handledTime =jsonObject.getInteger("handled_time") == null ? 3 : jsonObject.getInteger("handled_time");//不合格处理有效性间隔，默认为3天
        }
        //通过检测数据ID获取不合格处理
        CheckResultModel deal = mapper.queryByRid(rid);
        int handledAssessment = 0;//不合格处理考核状态：默认为NULL，表示未处理；不合格处理状态：0正常，1超时未处理，2超时处理，3不合规，4超时不合规，5造假。
        String handledRemark="";//考核状态说明
        boolean intervDay =false;//判断是否超时：true，已超时，false，未超时
        if(deal == null || deal.getDealMethod()==0){//未处理或处理中，和当前时间对比是否超时,如果超时了则更新状态为1
            Date checkDate=null;//获取检测时间
            if(deal==null){
                CheckResultModel checkModel=dataCheckRecordingMapper.getRecording(rid);
                checkDate=checkModel.getCheckDate();
            }else{
                checkDate=deal.getCheckDate();
            }
            intervDay = DateUtil.checkIsTimeOut(checkDate, new Date(),handledTime);
            if(intervDay){
                return  mapper.updateCheckDataAssessment(rid, 1, "超时未处理");
            }
            return 0;
        }else{
            intervDay = DateUtil.checkIsTimeOut(deal.getCheckDate(), deal.getUpdateDate(),handledTime);//核对检测时间和处理时间的间隔
        }
        //已处理数据考核
        if(deal.getUdealType()==1){//直接进行无异议处理，只要判断是否超时和是否有附件既可以
            if (!intervDay && StringUtil.isNotEmpty(deal.getfFilePaths())) {//未超时且有附件，状态为0
                handledAssessment = 0;
            } else if (!intervDay && StringUtil.isEmpty(deal.getfFilePaths())) {//未超时没有附件表示不合规，状态为3
                handledAssessment = 3;
                handledRemark="没有上传处理材料";
            } else if (intervDay && StringUtil.isNotEmpty(deal.getfFilePaths())) {//超时且有附件，状态为2
                handledAssessment = 2;
                handledRemark="超时处理";
            } else if (intervDay && StringUtil.isEmpty(deal.getfFilePaths())) {//超时处理并且不合规，状态为4
                handledAssessment = 4;
                handledRemark="超时处理且没有上传处理材料";
            }
        }else  if(deal.getUdealType()==2 || deal.getUdealType()==3){//如果deal_type=2,3表示有异议处理，需要上传抽样单号
            if(!intervDay && StringUtil.isNotEmpty(deal.getfFilePaths()) && StringUtil.isEmpty(deal.getRemark())){//未超时且有附件和抽样单号，状态为0
                handledAssessment = 0;
            }else if (!intervDay && (StringUtil.isEmpty(deal.getfFilePaths()) || StringUtil.isEmpty(deal.getRemark()))) {//未超时没有附件或抽样单号表示不合规，状态为3
                handledAssessment = 3;
                handledRemark="没有上传处理材料或抽样单号";
            } else if (intervDay && StringUtil.isNotEmpty(deal.getfFilePaths()) && StringUtil.isNotEmpty(deal.getRemark())) {//超时且有附件和抽样单号，状态为2
                handledAssessment = 2;
                handledRemark="超时处理";
            } else if (intervDay && (StringUtil.isEmpty(deal.getfFilePaths()) || StringUtil.isEmpty(deal.getRemark()))) {//超时处理并且不合规，状态为4
                handledAssessment = 4;
                handledRemark="超时处理且没有上传处理材料或抽样单号";
            }
        }
       return  mapper.updateCheckDataAssessment(rid, handledAssessment, handledRemark);
    }

    /**
     * @return
     * @Description 根据ID查询不合格处理信息
     * @Date 2022/05/19 9:39
     * @Author xiaoyl
     * @Param
     */
    public CheckResultModel getRecording(Integer id) {
        return mapper.getRecording(id);
    }

/*    public static void main(String[] args) throws ParseException {
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date start=simpleDateFormat.parse("2022-06-26 15:28:26");
        Date end=simpleDateFormat.parse("2022-06-27 10:09:10");
//        System.out.println(DateUtil.getBetweenDays2Float(start,end));
        System.out.println("是否超时："+DateUtil.getBetweenDays2Float(start,end,3));
    }*/


    /**
     * 激活数据
     * 数据状态：超时处置 -> 正常数据
     *
     * @param rids      检测数据RID
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public void activation(String rids) throws Exception {
        String[] idsArr = rids.split(",");
        for (String id: idsArr) {
            CheckResultModel dcrm = dataCheckRecordingMapper.getRecording(Integer.parseInt(id));

            //仅限超时处置数据改正常数据
            if (dcrm.getHandledAssessment()!=null && dcrm.getHandledAssessment().intValue() == 2) {
                //修改状态
                mapper.updateCheckDataAssessment(Integer.parseInt(id), 0, "正常");

                //修改处理时间
                Calendar c = Calendar.getInstance();
                c.setTime(dcrm.getCheckDate());
                c.add(Calendar.DAY_OF_YEAR, 1);
                c.add(Calendar.SECOND, (int) (Math.random() * 10000));

                DataUnqualifiedTreatment dut0 = new DataUnqualifiedTreatment();
                dut0.setId(dcrm.getDutId().intValue());
                dut0.setSendDate(c.getTime());
                dut0.setUpdateDate(c.getTime());
                mapper1.updateByPrimaryKeySelective(dut0);
            }
        }
    }

}
