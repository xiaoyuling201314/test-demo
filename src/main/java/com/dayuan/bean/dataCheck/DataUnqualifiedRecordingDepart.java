package com.dayuan.bean.dataCheck;

import com.dayuan.util.StringUtil;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Description 用于封装机构用户的手机号码
 *
 * @Author teng
 * @Date 2021/11/18 15:00
 */
public class DataUnqualifiedRecordingDepart {
    private Integer departId;//机构ID
    private Integer departNumber;//机构检测不合格条数
    private String totalDurIds;//不合格检测数据ID(data_unqualified_recording表的ID)
    private String departPhones;//机构管理人员号码

    List<DataUnqualifiedRecordingPoint> durpList = new ArrayList<>();

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public Integer getDepartNumber() {
        int number = 0;
        if (durpList.size() > 0) {
            for (DataUnqualifiedRecordingPoint durp : durpList) {
                number += durp.getPointNumber();
            }
        }
        return number;
    }

    public void setDepartNumber(Integer departNumber) {
        this.departNumber = departNumber;
    }

    public String getDepartPhones() {
        return DataUnqualifiedRecordingPoint.getValidPhone(this.departPhones);
    }

    public void setDepartPhones(String departPhones) {
        this.departPhones = departPhones;
    }

    public List<DataUnqualifiedRecordingPoint> getDurpList() {
        return durpList;
    }

    public void setDurpList(List<DataUnqualifiedRecordingPoint> durpList) {
        this.durpList = durpList;
    }

    public String getTotalDurIds() {
        StringBuilder totalDurIds = new StringBuilder();
        if (durpList.size() > 0) {
            for (DataUnqualifiedRecordingPoint durp : durpList) {
                totalDurIds.append(",").append(durp.getDurIds());
            }
        }
        return StringUtil.handleComma(totalDurIds.toString());
    }

    public void setTotalDurIds(String totalDurIds) {
        this.totalDurIds = totalDurIds;
    }

    static String getValidIds(String totalIds) {//默认修饰符，同包可访问
        String[] phoneArr = totalIds.split(",");
        List<String> list = new ArrayList<>();
        for (String phone : phoneArr) {
            if (!list.contains(phone)) {//不为空，是11位数字，去重复（不存在list里面的就添加进list）
                list.add(phone);
            }
        }
        return StringUtils.join(list, ",");
    }
}
