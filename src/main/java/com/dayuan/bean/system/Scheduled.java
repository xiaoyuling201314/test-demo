package com.dayuan.bean.system;

import com.dayuan.bean.BaseBean2;

import java.util.Date;

public class Scheduled extends BaseBean2 {

    private String scheduledName;

    private String scheduled;

    private Short off;

    private Short oldOff;

    private String departIds;//勾选的机构

    private String startUrl;//启动路径

    public Short getOldOff() {
        return oldOff;
    }

    public void setOldOff(Short oldOff) {
        this.oldOff = oldOff;
    }

    public String getDepartIds() {
        return departIds;
    }

    public void setDepartIds(String departIds) {
        this.departIds = departIds;
    }

    public String getStartUrl() {
        return startUrl;
    }

    public void setStartUrl(String startUrl) {
        this.startUrl = startUrl;
    }

    public String getScheduledName() {
        return scheduledName;
    }

    public void setScheduledName(String scheduledName) {
        this.scheduledName = scheduledName == null ? null : scheduledName.trim();
    }

    public String getScheduled() {
        return scheduled;
    }

    public void setScheduled(String scheduled) {
        this.scheduled = scheduled == null ? null : scheduled.trim();
    }

    public Short getOff() {
        return off;
    }

    public void setOff(Short off) {
        this.off = off;
    }
}