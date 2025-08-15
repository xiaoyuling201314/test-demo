package com.dayuan.logs.bean;

import java.util.Date;

/**
 * @Description IP地址和物理地址对应表
 * @Author xiaoyl
 * @Date 2022/03/03 14:55:32
 */
public class SysIpAdress{

    private Integer id;//主键ID
    private String systemIp;//IP地址
    private String systemAddress;//物理地址
    private Short deleteFlag;//删除状态：0未删除，1已删除
    private Date createDate;//创建时间
    private Date updateDate;//修改时间
    private String param1;//预留参数1
    private String param2;//预留参数2
    private String param3;//预留参数3



   public Integer getId() {
        return id;
   }

   public void setId(Integer id) {
        this.id = id;
   }

   public String getSystemIp() {
        return systemIp;
   }

   public void setSystemIp(String systemIp) {
        this.systemIp = systemIp;
   }

   public String getSystemAddress() {
        return systemAddress;
   }

   public void setSystemAddress(String systemAddress) {
        this.systemAddress = systemAddress;
   }

   public Short getDeleteFlag() {
        return deleteFlag;
   }

   public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
   }

   public java.util.Date getCreateDate() {
        return createDate;
   }

   public void setCreateDate(java.util.Date createDate) {
        this.createDate = createDate;
   }

   public java.util.Date getUpdateDate() {
        return updateDate;
   }

   public void setUpdateDate(java.util.Date updateDate) {
        this.updateDate = updateDate;
   }

   public String getParam1() {
        return param1;
   }

   public void setParam1(String param1) {
        this.param1 = param1;
   }

   public String getParam2() {
        return param2;
   }

   public void setParam2(String param2) {
        this.param2 = param2;
   }

   public String getParam3() {
        return param3;
   }

   public void setParam3(String param3) {
        this.param3 = param3;
   }


}
