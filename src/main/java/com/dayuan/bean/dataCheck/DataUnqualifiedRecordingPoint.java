package com.dayuan.bean.dataCheck;

import com.dayuan.util.StringUtil;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Description 用于封装检测点用户的手机号码
 *
 * @Author teng
 * @Date 2021/11/18 15:00
 */
public class DataUnqualifiedRecordingPoint {
    private Integer pointId;//检测点ID
    private Integer pointNumber;//检测点检测不合格条数
    private String durIds;//不合格检测数据ID(data_unqualified_recording表的ID)
    private String pointPhones;//检测点人员号码
    private String pointName;//检测点名称
    private String departPhones;//机构管理人员号码(用于机构号码去重复，里面包含机构的号码就去除)

    public Integer getPointId() {
        return pointId;
    }

    public void setPointId(Integer pointId) {
        this.pointId = pointId;
    }

    public Integer getPointNumber() {
        return pointNumber;
    }

    public void setPointNumber(Integer pointNumber) {
        this.pointNumber = pointNumber;
    }

    public String getPointPhones() {
        //当该检测点的号码和其机构管理员号码相同时，这里需要进行过滤，把检测点这里的号码删除，只发机构那边的短信通知即可
        List<String> dPhoneList = getValidPhoneList(this.departPhones);
        List<String> pPhoneList = getValidPhoneList(this.pointPhones);
        //去重操作,检测点号码集合中某个和号码存在于机构号码就删除
        if (dPhoneList != null && pPhoneList != null) {
            pPhoneList.removeIf(dPhoneList::contains);
            return StringUtils.join(pPhoneList, ",");
        }
        return getValidPhone(this.pointPhones);
    }

    public void setPointPhones(String pointPhones) {
        this.pointPhones = pointPhones;
    }

    public String getDepartPhones() {
        return departPhones;
    }

    public void setDepartPhones(String departPhones) {
        this.departPhones = departPhones;
    }


    public String getDurIds() {
        return durIds;
    }

    public void setDurIds(String durIds) {
        this.durIds = durIds;
    }

    /**
     * 拆分手机号码获取有效手机号码，并完成去重操作
     *
     * @param phones 多个用户名用逗号隔开，因为某些用户名可能不是手机号码，所以此处进行拆分过滤
     */
    static String getValidPhone(String phones) {//默认修饰符，同包可访问
        if (StringUtil.isNotEmpty(phones)) {
            phones = phones.replace("，", ",");
            String[] phoneArr = phones.split(",");
            List<String> list = new ArrayList<>();
            for (String phone : phoneArr) {
                phone = phone.trim();//去空格
                if (StringUtil.isNumeric(phone) && phone.length() == 11 && !list.contains(phone)) {//不为空，是11位数字，去重复（不存在list里面的就添加进list）
                    list.add(phone);
                }
            }
            return StringUtils.join(list, ",");
        }
        return "";
    }


    /**
     * 拆分手机号码获取有效手机号码，并完成去重操作
     *
     * @param phones 多个用户名用逗号隔开，因为某些用户名可能不是手机号码，所以此处进行拆分过滤
     */
    private List<String> getValidPhoneList(String phones) {
        if (StringUtil.isNotEmpty(phones)) {
            phones = phones.replace("，", ",");
            List<String> list = new ArrayList<>();
            String[] phoneArr = phones.split(",");
            for (String phone : phoneArr) {
                phone = phone.trim();//去空格
                if (StringUtil.isNumeric(phone) && phone.length() == 11 && !list.contains(phone)) {//不为空，是11位数字，去重复（不存在list里面的就添加进list）
                    list.add(phone);
                }
            }
            return list;
        }
        return null;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }
}
