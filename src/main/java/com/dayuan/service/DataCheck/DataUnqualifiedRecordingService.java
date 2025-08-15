package com.dayuan.service.DataCheck;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.dataCheck.*;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.interfaces.SMSTemplateController;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.dataCheck.DataUnqualifiedRecordingMapper;
import com.dayuan.service.BaseService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.wx.WxTemplateMsgService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;


/**
 * 不合格数据
 *
 * @author Dz
 */
@Service
public class DataUnqualifiedRecordingService extends BaseService<DataUnqualifiedRecording, Integer> {
    private Logger log = Logger.getLogger(DataUnqualifiedRecordingService.class);
    @Autowired
    private TbSamplingDetailService samplingDetailService;
    @Autowired
    private WxTemplateMsgService wxTemplateMsgService;

    @Autowired
    private DataUnqualifiedRecordingLogService dataUnqualifiedRecordingLogService;
    @Value("${systemUrl}")
    private String systemUrl;
    @Autowired
    private DataUnqualifiedRecordingMapper mapper;

    public DataUnqualifiedRecordingMapper getMapper() {
        return mapper;
    }

    /**
     * 通过检测数据rid查询不合格数据
     *
     * @param rid 检测数据rid
     * @return
     */
    public DataUnqualifiedRecording queryByRid(Integer rid) {
        return mapper.queryByRid(rid);
    }

    /**
     * 更新检测数据删除状态
     *
     * @param rid
     * @return
     */
    public Integer deleteCheckRecording(Integer rid) {
        return mapper.deleteCheckRecording(rid);
    }

    /**
     * 写入不合格数据
     * 条件：(检测结果=不合格 && 状态已审核 && 检测次数==2) || (检测次数>=3 && 历史检测出现不合格（即出现历史数据）)
     *
     * @param dcr  检测数据
     * @param user 操作用户
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void save(DataCheckRecording dcr, TSUser user) throws Exception {

        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");

//        //合格数据、平台上传数据\导入数据或者没有抽样单ID的数据视为最终结果
//        if (dcr.getReloadFlag() >= recheckNumber || dcr.getDataType() == 3 || dcr.getDataType() == 4 || dcr.getSamplingDetailId() == null) {
//            //历史数据
//            DataUnqualifiedRecording dur0 = queryByRid(dcr.getRid());
//            //(检测结果=不合格 && 状态已审核 && 检测次数==2) || (检测次数>=3 && 历史检测出现不合格（即出现历史数据）)
//            if (("不合格".equals(dcr.getConclusion()) && dcr.getParam7()==1 )) {//|| dur0 != null
//                //样品编号
//                String sampleCode = null;
//                if (dcr.getSamplingDetailId() != null) {
//                    TbSamplingDetail tsd = samplingDetailService.getById(dcr.getSamplingDetailId());
//                    if (tsd != null) {
//                        sampleCode = tsd.getSampleCode();
//                    }
//                }
//
//                //写入数据
//                DataUnqualifiedRecording dur = new DataUnqualifiedRecording(dcr.getRid(), dcr.getSamplingId(), dcr.getSamplingDetailId(), sampleCode, dcr.getFoodId(), dcr.getFoodName(),
//                        dcr.getItemId(), dcr.getItemName(), dcr.getRegId(), dcr.getRegName(), dcr.getRegUserId(), dcr.getRegUserName(), dcr.getDepartId(), dcr.getDepartName(),
//                        dcr.getPointId(), dcr.getPointName(), dcr.getCheckUsername(), dcr.getUploadDate(), dcr.getCheckDate(), dcr.getCheckResult(), dcr.getCheckUnit(),
//                        dcr.getConclusion(), dcr.getReloadFlag(), null, null, null, 0, null, null, null);
//
//                if (dur0 == null) {
//                    if (user != null) {
//                        dur.setCreateBy(user.getId());
//                        dur.setUpdateBy(user.getId());
//                    }
//                    insertSelective(dur);
//                } else {
//                    dur.setId(dur0.getId());
//                    if (user != null) {
//                        dur.setUpdateBy(user.getId());
//                    }
//                    updateBySelective(dur);
//                }
//            }
//        }
    }

    /**
     * 发送不合格短信通知1
     *
     * @param ids      多个待处理id用逗号隔开
     * @param phoneStr 手机号码，多个手机号码用逗号分割
     * @param remark   备注信息
     * @param number   number 短信需要的参数number 如： 监管平台发现 number 条检测不合格，请登录平台进行处理！
     * @param jsonObj  返回的json对象
     * @param type     0:系统发送，1用户发送
     * @throws Exception
     */
    public AjaxJson sendUnqualifiedSmsNotice(String ids, String phoneStr, String remark, String name, String number, TSUser sessionUser, AjaxJson jsonObj, int type) throws Exception {
        //对手机号码进行拆分
        String[] phoneArr = phoneStr.split(",");
        List<Map<String, String>> sendOk = new ArrayList<>();
        List<Map<String, String>> sendFail = new ArrayList<>();
        sendSmsByPhone(phoneArr, name, number, log, sendOk, sendFail);//发送短信
        Short sendState = new Short("1");//发送状态:0_未发送,1_发送成功,2_发送失败
        //发送完成后统计成功和失败的情况
        if (sendOk.size() == phoneArr.length) {//所有都发送成功
            jsonObj.setSuccess(true);
            jsonObj.setMsg("发送成功");
        } else if (sendFail.size() == phoneArr.length) {//存在发送失败的手机号码
            jsonObj.setSuccess(false);
            jsonObj.setMsg("发送失败");
            Map<String, Object> objMap = new HashMap<>();
            objMap.put("sendFail", sendFail);
            jsonObj.setObj(objMap);
            sendState = new Short("2");
        } else {
            jsonObj.setSuccess(false);
            jsonObj.setMsg("部分号码发送成功");
            Map<String, Object> objMap = new HashMap<>();
            objMap.put("sendOk", sendOk);
            objMap.put("sendFail", sendFail);
            jsonObj.setObj(objMap);
        }
        //设置操作人和操作方式
        String userId = type == 1 ? sessionUser.getId() : "0";
        String sendName = type == 1 ? "手动 " : "定时 ";
        //更新不合格数据表的信息并写入日志信息
        String[] idArr = ids.split(",");
        Date sendTime = new Date();
        for (String durId : idArr) {
            //更新 不合格数据表 的信息
            updateDUR(userId, durId, phoneStr, sendState, sendTime, remark,0);
            //同时写入日志信息
            insertLog(userId, durId, sendState, sendTime, remark, sendOk, sendFail, sendName);
        }
        return jsonObj;
    }

    private void sendSmsByPhone(String[] phoneArr, String name, String number, Logger log, List<Map<String, String>> sendOk, List<Map<String, String>> sendFail) {
        //对手机号码进行拆分
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("name", name);
        paramMap.put("number", number);
        SMSTemplateController smst = new SMSTemplateController();
        //循环发送短信
        for (String phone : phoneArr) {
            Map<String, String> sendMap = new HashMap<>();//phone：发送的手机号码 state:0发送成功 1发送失败
            sendMap.put("phone", phone);
            log.debug("发送短信：**************************号码：" + phone + "参数：" + JSON.toJSONString(paramMap));
            try {
                smst.sendSmsLocal("", phone, paramMap);
                sendMap.put("msg", "发送成功");
                sendMap.put("code", WebConstant.INTERFACE_CODE0);
                sendOk.add(sendMap);//把map放入成功的集合
                log.debug("发送短信成功：**************************号码：" + phone);
            } catch (MyException me) {
                sendMap.put("msg", "发送失败，" + me.getMessage() + "，" + me.getText());
                sendMap.put("code", me.getCode());
                sendFail.add(sendMap);//把map放入失败的集合
                me.printStackTrace();
                log.error("发送短信失败：******************************" + me.getMessage() + "，" + me.getText() + "====>" + me.getStackTrace()[0].getClassName() + "." + me.getStackTrace()[0].getMethodName() + ":" + me.getStackTrace()[0].getLineNumber());
            } catch (Exception e) {
                sendMap.put("msg", "发送失败，未知异常");
                sendMap.put("code", WebConstant.INTERFACE_CODE11);
                sendFail.add(sendMap);//把map放入失败的集合
                e.printStackTrace();
                log.error("发送短信失败：******************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            }
        }
    }

    //设置发送详情的日志内容
    private String setLogContent(Date sendTime, List<Map<String, String>> sendOk, List<Map<String, String>> sendFail, String sendName) {
        String result = "";
        if (sendOk.size() > 0 && sendFail.size() > 0) {
            result = " 成功：" + sendOk.toString() + "， 失败：" + sendFail.toString();
        } else if (sendOk.size() > 0) {
            result = " 成功：" + sendOk.toString();
        } else {
            result = " 失败：" + sendFail.toString();
        }
        return sendName + DateUtil.datetimeFormat.format(sendTime) + result;
    }


    /**
     * 监控不合格数据表的数据，定时发送短信
     */
    public void sendSmsNotice() throws Exception {
        //1.查询待发送短信的不合格数据,拿到一个集合(过滤已合格的、已发送过的、已删除的；根据所属机构来分组，拿到不合格的个数)
        List<DataUnqualifiedRecordingDepart> durdList = mapper.querySmsToniceData();
        //先发机构的再发检测点的
        System.out.println(JSON.toJSONString(durdList));
        AjaxJson jsonObj = new AjaxJson();
        //循环迭代给机构用户发送短信通知
        for (DataUnqualifiedRecordingDepart durd : durdList) {
            List<DataUnqualifiedRecordingPoint> durpList = durd.getDurpList();
            //获取检测点用户信息给检测点用户发短信通知
            if (durpList.size() > 0) {
                StringBuilder totalName = new StringBuilder();
                //循环给每个检测点负责人发短信
                for (DataUnqualifiedRecordingPoint durp : durpList) {
                    //给检测点人员发送短信通知，同时写入日志信息
                    if (StringUtil.isNotEmpty(durp.getPointPhones())) {
                        this.sendUnqualifiedSmsNotice(durp.getDurIds(), durp.getPointPhones(), "", durp.getPointName(), durp.getPointNumber() + "", null, jsonObj, 0);//发送不合格短信通知给检测点用户
                    }
                    totalName.append(",");
                    totalName.append(durp.getPointName());
                }
                //给机构人员发送短信通知提醒
                if (StringUtil.isNotEmpty(durd.getDepartPhones())) {
                    totalName = new StringBuilder(StringUtil.handleComma(totalName.toString()).replace(",", "，"));
                    this.sendUnqualifiedSmsNotice(durd.getTotalDurIds(), durd.getDepartPhones(), "", totalName.toString(), durd.getDepartNumber() + "", null, jsonObj, 0);//发送不合格短信通知给机构用户
                }
            }
        }
    }

    /**
     * 监控不合格数据表的数据，定时发送公众号“不合格通知”提醒到给上级机构用户
     */
    public void sendWXNotice() throws Exception {
        //1.查询2小时内的待发送短信的不合格数据,拿到一个集合(过滤已合格的、已发送过的、已删除的；根据所属机构来分组，拿到不合格的个数)
        List<DataUnqualifiedRecording> durdList = mapper.wxQueryUnqualData2Msg();
        //微信公众号通知黑名单配置，黑名单中的用户不发送通知
        JSONObject blackListConfig=SystemConfigUtil.WXMSG_BLAKLIST_CONFIG;
        String[] blacklist=null;
        if(blackListConfig!=null){
            JSONArray arrJson =blackListConfig.getJSONArray("blackList");
            blacklist=arrJson.toArray(new String[arrJson.size()]);
        }

        AjaxJson jsonObj = new AjaxJson();
        //循环给机构用户发送微信公众号通知
        for (DataUnqualifiedRecording durd : durdList) {
                // wx_openid,user_name
                List<Map<String, String>> userOpenIDs=mapper.queryOpenIdByDepartID(durd.getDepartId(),blacklist);
                //给机构人员发送公众号提醒
                if (userOpenIDs!=null && userOpenIDs.size()>0) {
//                    String returnUrl=systemUrl+"/wx/data_statis/unqualifiedList.do?";
                    //rootPath:项目根路径，东营系统支持http和https，微信公众号使用https，所以需要指定消息详情的根据经为https，不然的话会导致查询数据失败
                    JSONObject json = SystemConfigUtil.WECHAT_PUSH_TEMPLATE_CONFIG;
                    String rootPath=StringUtil.isEmpty(json.getString("unqualfiedURL")) ? systemUrl : json.getString("unqualfiedURL");
                     String returnUrl=rootPath+"/wx/data_statis/unqualifiedDetail.do?rid="+durd.getRid();
                    List<String> sendOk=new ArrayList<>();
                    List<String> sendFail=new ArrayList<>();
                    Date sendTime=new Date();//发送时间
                    StringBuilder sendUser=new StringBuilder();//要发送的账号姓名
                    for (Map<String, String> item:userOpenIDs) {
                        sendUser.append(item.get("user_name")+",");
                        Boolean sendSuccess=wxTemplateMsgService.unqualifiedNoticeMsg(item.get("wx_openid"),returnUrl,durd);
                       if(sendSuccess){
                            sendOk.add(item.get("user_name"));
                        }else{
                            sendFail.add(item.get("user_name"));
                        }
                    }
                    Short sendState = new Short("1");//发送状态:0_未发送,1_发送成功,2_发送失败
                    if(sendFail.size()>0){
                        sendState=2;
                    }
                    //更新 不合格数据表 的信息
                    updateDUR("0", durd.getId()+"", sendUser.toString(), sendState, sendTime, "",1);
                    insertLog2Wx("0",durd.getId().toString(),sendState,sendTime,"",sendOk,sendFail,"定时");
                }
        }
    }

    /**
     * 写入日志信息
     */
    private void insertLog(String userId, String durId, Short sendState, Date sendTime, String remark, List<Map<String, String>> sendOk, List<Map<String, String>> sendFail, String sendName) {
        try {
            //同时写入日志信息
            DataUnqualifiedRecordingLog durLog = new DataUnqualifiedRecordingLog();
            durLog.setCreateBy(userId);
            durLog.setUpdateBy(userId);
            durLog.setDurId(Integer.valueOf(durId));
            durLog.setSendState(sendState);
            durLog.setSendTime(sendTime);
            durLog.setSendRemark(remark);
            String content = setLogContent(sendTime, sendOk, sendFail, sendName);//设置日志内容
            durLog.setContent(content);
            dataUnqualifiedRecordingLogService.insert(durLog);
        } catch (Exception e) {
            e.printStackTrace();
            log.debug("写入不合格通知短信日志信息失败 ******************************==>" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());//打印日志内容
        }
    }


    /**
     * 更新不合格数据表信息
     *
     * @param userId    用户ID
     * @param durId     不合格数据表ID
     * @param phoneStr  多个用户手机号码逗号隔开
     * @param sendState 发送状态:0_未发送,1_发送成功,2_发送失败
     * @param sendTime  发送时间
     * @param remark    备注信息
     * @throws Exception
     */
    private void updateDUR(String userId, String durId, String phoneStr, Short sendState, Date sendTime, String remark,int sendType) {
        try {
            DataUnqualifiedRecording dur = new DataUnqualifiedRecording();
            dur.setUpdateBy(userId);
            dur.setId(Integer.valueOf(durId));
            dur.setSendPhone(phoneStr);
            dur.setSendState(sendState);
            dur.setSendTime(sendTime);
            dur.setSendRemark(remark);
            dur.setParam2(sendType);
            this.updateBySelective(dur);
        } catch (Exception e) {
            e.printStackTrace();
            log.debug("更新不合格数据表信息失败 ******************************==>" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());//打印日志内容
        }
    }
    /**
     * 写入日志信息
     */
    private void insertLog2Wx(String userId, String durId, Short sendState, Date sendTime, String remark, List<String> sendOk, List<String> sendFail, String sendName) {
        try {
            //同时写入日志信息
            DataUnqualifiedRecordingLog durLog = new DataUnqualifiedRecordingLog();
            durLog.setCreateBy(userId);
            durLog.setUpdateBy(userId);
            durLog.setDurId(Integer.valueOf(durId));
            durLog.setSendState(sendState);
            durLog.setSendTime(sendTime);
            durLog.setSendRemark(remark);
            String result = "";
            if (sendOk.size() > 0 && sendFail.size() > 0) {
                result=String.format("成功%d条，成功名单：%s；失败：%d,失败名单：%s",sendOk.size(),sendFail.size(),sendOk.toString(),sendFail.toString());
            } else if (sendOk.size() > 0) {
                result=String.format("成功%d条，成功名单：%s",sendOk.size(),sendOk.toString());
            } else {
                result=String.format("失败%d条，失败名单：%s",sendFail.size(),sendFail.toString());
            }
            String content=sendName + DateUtil.datetimeFormat.format(sendTime) + result;//设置日志内容
            durLog.setContent(content);
            dataUnqualifiedRecordingLogService.insert(durLog);
        } catch (Exception e) {
            e.printStackTrace();
            log.debug("写入不合格通知短信日志信息失败 ******************************==>" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());//打印日志内容
        }
    }

    /**
     * 监控不合格数据表的数据，定时发送短信 （当前未使用 多个检测点分开发）
     */
    public void sendSmsNotice2() throws Exception {
        //1.查询待发送短信的不合格数据,拿到一个集合(过滤已合格的、已发送过的、已删除的；根据所属机构来分组，拿到不合格的个数)
        List<DataUnqualifiedRecordingDepart> durdList = mapper.querySmsToniceData();
        //先发机构的再发检测点的
        System.out.println(JSON.toJSONString(durdList));
        AjaxJson jsonObj = new AjaxJson();
        //循环迭代给机构用户发送短信通知
        for (DataUnqualifiedRecordingDepart durd : durdList) {
            List<DataUnqualifiedRecordingPoint> durpList = durd.getDurpList();
            int pointNumber = durpList.size();//检测点个数
            //Short sendState = new Short("2");//发送状态:0_未发送,1_发送成功,2_发送失败(对于机构用户)
            //List<Map<String, String>> sendOk = new ArrayList<>();
            //List<Map<String, String>> sendFail = new ArrayList<>();
            boolean haveDPhone = StringUtil.isNotEmpty(durd.getDepartPhones());
            //获取检测点用户信息给检测点用户发短信通知
            if (pointNumber > 0) {
                //循环给每个检测点负责人发短信
                for (int i = 0; i < pointNumber; i++) {
                    DataUnqualifiedRecordingPoint durp = durpList.get(i);
                    //给机构人员发送短信通知提醒
                    if (haveDPhone) {
                        if ((i + 1) % 2 == 0) {//如果是偶数那就把检测点拆分发送，一次发两个检测点的通知
                            String totalName = durpList.get(i - 1).getPointName() + "，" + durp.getPointName();
                            Integer totalNumber = durpList.get(i - 1).getPointNumber() + durp.getPointNumber();
                            this.sendUnqualifiedSmsNotice(durd.getTotalDurIds(), durd.getDepartPhones(), "", totalName, totalNumber + "", null, jsonObj, 0);//发送不合格短信通知给机构用户
                            //boolean isOk = this.sendUnqualifiedSmsNotice2(durd.getDepartPhones(), totalName, totalNumber + "", sendOk, sendFail);//发送不合格短信通知给机构用户
                            //if (isOk) sendState = new Short("1");//发送状态,当需要发送的所有短信都失败的时候就算是失败
                        } else if ((i + 1) == pointNumber) {//如果为基数且当前数和总数相等就直接发送
                            //boolean isOk = this.sendUnqualifiedSmsNotice2(durd.getDepartPhones(), durp.getPointName(), durp.getPointNumber() + "", sendOk, sendFail);//发送不合格短信通知给机构用户
                            //if (isOk) sendState = new Short("1");//发送状态,当需要发送的所有短信都失败的时候就算是失败
                            this.sendUnqualifiedSmsNotice(durd.getTotalDurIds(), durd.getDepartPhones(), "", durp.getPointName(), durp.getPointNumber() + "", null, jsonObj, 0);//发送不合格短信通知给机构用户

                        }
                    }

                    //给检测点人员发送短信通知，同时写入日志信息
                    if (StringUtil.isNotEmpty(durp.getPointPhones())) {
                        this.sendUnqualifiedSmsNotice(durp.getDurIds(), durp.getPointPhones(), "", durp.getPointName(), durp.getPointNumber() + "", null, jsonObj, 0);//发送不合格短信通知给检测点用户
                    }
                }
                //写入机构人员发送短信的日志信息
                /*if (haveDPhone) {
                    String totalDurIds = durd.getTotalDurIds();
                    String[] idArr = totalDurIds.split(",");
                    Date sendTime = new Date();
                    for (String durId : idArr) {
                        //更新 不合格数据表 的信息
                        updateDUR("0", durId, durd.getDepartPhones(), sendState, sendTime, "");
                        //同时写入日志信息
                        insertLog("0", durId, sendState, sendTime, "", sendOk, sendFail, "定时 ");
                    }
                }*/
            }
        }

    }

    /**
     * 发送不合格短信通知2（当前未使用）
     *
     * @param phoneStr 手机号码，多个手机号码用逗号分割
     * @param number   number 短信需要的参数number 如： 监管平台发现 number 条检测不合格，请登录平台进行处理！
     * @return
     * @throws Exception
     */
    public boolean sendUnqualifiedSmsNotice2(String phoneStr, String name, String number, List<Map<String, String>> sendOk, List<Map<String, String>> sendFail) {
        //对手机号码进行拆分
        String[] phoneArr = phoneStr.split(",");
        sendSmsByPhone(phoneArr, name, number, log, sendOk, sendFail);
        boolean sendState = true;//发送状态:成功true  失败false
        //发送完成后统计成功和失败的情况
        if (sendFail.size() == phoneArr.length) {//所有都发送失败才算失败
            sendState = false;
        }
        return sendState;
    }
}


