package com.dayuan.service.data;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.data.BasePointVideoSurveillance;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.data.BasePointVideoSurveillanceMapper;
import com.dayuan.service.BaseService;
import com.dayuan.util.imouPlayer.LeChengMonitorUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 检测点的 监控摄像头 Service
 *
 * @author LuoYX
 * @date 2018年5月8日
 */
@Service
public class BasePointVideoSurveillanceService extends BaseService<BasePointVideoSurveillance, Integer> {
    private Logger log = Logger.getLogger(BasePointVideoSurveillanceService.class);
    @Autowired
    private BasePointVideoSurveillanceMapper mapper;

    @Override
    public BaseMapper<BasePointVideoSurveillance, Integer> getMapper() {
        return mapper;
    }

    public List<BasePointVideoSurveillance> selectByPointId(Integer pointId) {

        return mapper.selectByPointId(pointId);
    }

    /**
     * @return
     * @Description 查询单个或所有乐橙云类型的摄像头在线状态信息，状态不变的时候不更新，状态改变的时候更新状态和最后更新时间
     * 1.根据账号手机号码获取用户accessToken
     * 2.先根据设备序列号查询绑定情况，若设备号不属于当前账号则设置为-1异常状态
     * 3.根据设备号查询设备在线状态
     * 4.查询摄像头的录像存储类型,视频回放时需根据存储类型用不同的图标显示。（注意：在线状态的设备才能进一步查询录像存储类型）
     * 5.比较请求的状态与数据库记录的状态是否一致，一致则直接跳过，不一致则更新数据库的状态信息。
     * @Date 2022/07/18 15:26
     * @Author xiaoyl
     * @Param
     */
    public void syncVideoStatus(String dev) {
        List<BasePointVideoSurveillance> list = mapper.queryLeChengVideo(dev);
        if (list.size() > 0) {
            JSONObject resultJson = null;
            for (BasePointVideoSurveillance video : list) {
                try {
                    //1.获取用户accessToken
                    String accessToken = LeChengMonitorUtil.getToken(video.getAccountPhone(), video.getDev());
                    //2.根据设备序列号查询绑定情况,接口调用限制每日10000次
                    JSONObject jsonObject = LeChengMonitorUtil.getDeviceBindOrNot(accessToken, video.getAccountPhone(), video.getDev());
                    resultJson = jsonObject.getJSONObject("result");
                    //2.1当前设备已经被绑定并且是属于当前账号,code=OP1014，调用接口次数超出限制（每天）
                    if (resultJson.getString("code").equals("OP1014") || (resultJson.getString("code").equals("0") && resultJson.getJSONObject("data").getBoolean("isBind")
                            && resultJson.getJSONObject("data").getBoolean("isMine"))) {
                        //3.根据设备号查询设备在线状态，接口调用限制每日100000次
                        jsonObject = LeChengMonitorUtil.getDeviceOnLine(accessToken, video.getAccountPhone(), video.getDev());
                        resultJson = jsonObject.getJSONObject("result");
                        //设备在线状态，0：表示不在线；1：表示在线
                        Short status = resultJson.getJSONObject("data").getShort("onLine");
                        //4.只有在线状态的设备才能进一步查询录像存储类型,存储类型:0 无，1 TF内存卡，2 云存储
                        Short storageType = 0;
                        if (resultJson.getString("code").equals("0") && status == 1) {//只有在线状态的设备才能进一步查询存储类型
                            storageType = LeChengMonitorUtil.getDeviceStorageType(accessToken, video.getAccountPhone(), video.getDev());
                        }
                        //5.比较请求的状态与数据库记录的状态是否一致，一致则直接跳过，不一致则更新数据库的状态信息
                        if (resultJson.getString("code").equals("0") && !video.getOnlineStatus().equals(status)) {
                            video.setStorageType(storageType);
                            video.setOnlineStatus(status);
                            video.setSyncStatusDate(new Date());
                            mapper.updateByPrimaryKeySelective(video);
                        } else if (storageType != 0 && !video.getStorageType().equals(storageType)) {//存储类型不为0并且和数据库中的值不一样则进行更新操作
                            video.setStorageType(storageType);
                            mapper.updateByPrimaryKeySelective(video);
                        } else if (!resultJson.getString("code").equals("0")) {
                            log.error("查询乐橙摄像头在线错误！" + resultJson);
                        }
                    } else if (!video.getOnlineStatus().equals(-1) && (!resultJson.getJSONObject("data").getBoolean("isBind") || !resultJson.getJSONObject("data").getBoolean("isMine"))) {
                        //当前设备号不属于当前账号，设置状态为-1异常
                        video.setOnlineStatus((short) -1);
                        video.setSyncStatusDate(new Date());
                        mapper.updateByPrimaryKeySelective(video);
                    } else if (!resultJson.getString("code").equals("0")) {
                        log.error("查询乐橙摄像头绑定状态错误！" + resultJson);
                    }
                } catch (Exception e) {
                    log.error("同步乐橙摄像头在线状态异常，异常设备号：" + video.getDev() + "异常原因：" + resultJson + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
                }
            }
        }

    }
    /**
    * @Description 查询所有乐橙API的在线设备，用于东营可视化大屏进行播放
    * @Date 2022/09/26 9:53
    * @Author xiaoyl
    * @Param
    * @return
    */
    public List<BasePointVideoSurveillance> queryAllOnlineVideo(Integer departId) {
        return mapper.queryAllOnlineVideo(departId);
    }
}
