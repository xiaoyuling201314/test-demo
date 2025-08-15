package com.dayuan.logs.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.logs.aop.QrcodeScanCountAopAction;
import com.dayuan.logs.bean.SysIpAdress;
import com.dayuan.logs.mapper.SysIpAdressMapper;
import com.dayuan.logs.model.IP138ResultModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.HttpClient4Util;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * @Description IP地址和物理地址对应表 service
 * @Author xiaoyl
 * @Date 2022/03/03 14:55:32
 */
@Service
public class SysIpAdressService extends BaseService<SysIpAdress, Integer> {
    @Autowired
    private SysIpAdressMapper mapper;

    @Autowired
    private SysLogService sysLogService;
    private Logger log = Logger.getLogger(SysIpAdressService.class);

    public SysIpAdressMapper getMapper() {
        return mapper;
    }

    public void saveOrUpdate(SysIpAdress sysIpAdress) throws Exception {
        boolean isCreate = sysIpAdress.getId() == null;
//        PublicUtil.setCommonForTable(sysIpAdress, isCreate);
        if (isCreate) {
            mapper.insert(sysIpAdress);
        } else {
            mapper.updateByPrimaryKeySelective(sysIpAdress);
        }
    }

    /**
     * @return
     * @Description IP138获取地理地址
     * 处理流程：1.查询日志表近三天没有物理地址的IP信息
     * 2.遍历IP进行处理，首先查询sys_ip_adress表是否存在，
     * 2.1.如果sys_ip_adress表不存在，或者是更新日期>10天，前往ip38接口获取最新的物理地址信息；然后写入或更新sys_ip_adress表，最后更新日志表的地址信息
     * 2.2.如果sys_ip_adress表存在，并且更新日期<10,直接更新日志表的地址信息
     * //系统参数接口配置信息
     * {
     * "request_url": "https://api.ip138.com/ip/?ip=IP&token=TOKEN",
     * "token": "7e95db98d081942b55e48606cc4d9e303",
     * "interval": 10
     * }
     * @Date 2022/03/03 16:30
     * @Author xiaoyl
     * @Param
     */
    public void syncDealIPAddress() {
        //1.查询日志表近三天没有物理地址的IP信息
        List<String> ipList = sysLogService.queryIpForNotAddress();
        JSONObject reportConfig = SystemConfigUtil.IP138_INTERFACE_CONFIG;
        int interval = reportConfig.getInteger("interval") != null ? reportConfig.getInteger("interval") : 10;
        ipList.forEach((ip) -> {
            SysIpAdress ipBean = mapper.querByIp(ip);
            //2.1如果sys_ip_adress表不存在，或者是更新日期>interval天，前往ip38接口获取最新的物理地址信息；然后写入或更新sys_ip_adress表，最后更新日志表的地址信息
            if (ipBean == null || DateUtil.getBetweenDays(new Date(), ipBean.getUpdateDate()) > interval) {
                String requestURL = reportConfig.getString("request_url").replace("IP", ip).replace("TOKEN", reportConfig.getString("token"));
                String result = HttpClient4Util.doGet(requestURL);
                IP138ResultModel model = JSONObject.parseObject(result, IP138ResultModel.class);
                if (model.getRet().equals("ok")) { //获取地址成功
                    //2.1.1写入或更新sys_ip_adress表
                    String systemAddress = getAddress(model.getData());
                    if (ipBean == null) {//如果sys_ip_adress表不存在,创建新的对象并写入
                        ipBean = new SysIpAdress();
                        ipBean.setSystemIp(ip);
                    }
                    ipBean.setSystemAddress(systemAddress);
                    try {
                        saveOrUpdate(ipBean);
                        //2.1.2 更新日志表的地址信息
                        sysLogService.updateLogsByIp(ip, ipBean.getSystemAddress());
                    } catch (Exception e) {
                        log.error("IP138接口保存到sys_ip_adress表异常**************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
                    }
                } else {
                    log.error("IP138接口查询异常：" + result);
                }

            } else if (ipBean != null || DateUtil.getBetweenDays(new Date(), ipBean.getUpdateDate()) < interval) {
                //2.2如果该IP在sys_ip_adress表存在，并且更新日期<interval,直接更新日志表的地址信息
                sysLogService.updateLogsByIp(ip, ipBean.getSystemAddress());
            }
        });
    }
    /**
    * @Description 查询单个IP物理地址并更新历史库
    * @Date 2022/03/10 9:34
    * @Author xiaoyl
    * @Param
    * @return
    */
//    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public String syncDealIPAddress(String remoteIp) throws MyException {
        String systemAddress ="";
        JSONObject reportConfig = SystemConfigUtil.IP138_INTERFACE_CONFIG;
        SysIpAdress ipBean = mapper.querByIp(remoteIp);
        String requestURL = reportConfig.getString("request_url").replace("IP", remoteIp).replace("TOKEN", reportConfig.getString("token"));
        String result = HttpClient4Util.doGet(requestURL);
        IP138ResultModel model = JSONObject.parseObject(result, IP138ResultModel.class);
        if (model.getRet().equals("ok")) { //获取地址成功
            //写入或更新sys_ip_adress表
            systemAddress = getAddress(model.getData());
            if (ipBean == null) {//如果sys_ip_adress表不存在,创建新的对象并写入
                ipBean = new SysIpAdress();
                ipBean.setSystemIp(remoteIp);
            }
            ipBean.setSystemAddress(systemAddress);
            try {
                saveOrUpdate(ipBean);
            } catch (Exception e) {
                log.error("IP138接口保存到sys_ip_adress表异常**************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            }
        } else {
            log.error("IP138接口查询异常：" + result);
            throw new MyException("IP138接口查询异常", "IP138接口查询异常:"+result, WebConstant.INTERFACE_CODE11);
        }
        return systemAddress;
    }

    /**
     * @return
     * @Description 处理从IP138接口获取的物理地址信息，增加相应的省市区
     * @Date 2022/03/04 14:59
     * @Author xiaoyl
     * @Param
     */
    private String getAddress(String[] dataArray) {
        String[] specialCity = {"北京", "天津", "上海", "重庆"};//4个直辖市
        if (StringUtil.isNotEmpty(dataArray[1])) {
            if (Arrays.asList(specialCity).contains(dataArray[1])) {
                dataArray[1] += "市";
            } else {
                dataArray[1] += "省";
            }
        }
        if (StringUtil.isNotEmpty(dataArray[2])) {
            dataArray[2] += "市";
        }
       /* if (StringUtil.isNotEmpty(dataArray[3])) {
            dataArray[3] += "区";
        }*/
        String systemAddress = dataArray[1] + dataArray[2] + dataArray[3];
        return systemAddress;
    }
/*
    public static void main(String[] args) {
        String result="{\"ret':'ok','ip\":\"202.106.212.226\",\"data\":[\"中国\",\"北京\",\"北京\",\"\",\"联通\",\"100000\",\"010\"]}";
        IP138ResultModel model= JSONObject.parseObject(result, IP138ResultModel.class);
        System.out.println(model.getData().toString());
    }*/
}
