package com.dayuan.service.wx;

import com.dayuan.bean.wx.WxsignIn;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.wx.WxsignInMapper;
import com.dayuan.model.wx.WxsignInModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class WxsignInService extends BaseService<WxsignIn, String> {

    @Autowired
    private WxsignInMapper mapper;

    @Override
    public BaseMapper<WxsignIn, String> getMapper() {

        return mapper;
    }

    public List<WxsignInModel> queryByDepartIds(Integer departId, String signDate, String nickName) {
        List<WxsignInModel> signs = mapper.queryByDepartIds(departId, signDate, nickName);
        return signs;
    }

    /**
     * 通过机构ID查询所有有签到记录的日期
     *
     * @param departArr
     * @return
     * @author Dz
     */
    public List<String> querySignDate(String[] departArr) {
        List<String> signs = mapper.querySignDate(departArr);
        return signs;
    }

    /**
     * 获取签到人某天签到记录
     *
     * @param userId //签到人ID
     * @param date   //签到日期
     * @return
     * @author Dz
     */
    public List<WxsignInModel> queryByUserId(String userId, Date date) {
        String dateStr = DateUtil.date_sdf.format(date);
        List<WxsignInModel> signs = mapper.queryByUserId(userId, dateStr);
        return signs;
    }

    /**
     * shit添加:查询签到信息
     *
     * @param map
     * @return
     */
    public List<WxsignIn> selectSignIn(Map<String, Object> map) throws Exception {
        return mapper.selectSignIn(map);
    }

    /**
     * 查询打卡前的考勤信息
     * @param dateStr           当前天 2018-10-18
     * @param userId            当前用户id 110
     * @param punchTime         当天上午打卡时间 2018-10-18 08:40
     */
    public WxsignIn selectBeforeCardSignIn(String dateStr, Integer userId,String punchTime) {
        return mapper.selectBeforeCardSignIn(dateStr,userId,punchTime);
    }
}
