package com.dayuan.bean.wx;

import java.util.Date;

public class WxAccesstoken {
    /**
     *
     */
    private String id;

    /**
     *
     */
    private String accesstoken;

    /**
     *
     */
    private Date addtime;

    /**
     *
     */
    private Integer expiresin;

    /**
     *
     */
    private String jsapiticket;

    /** 
     * Getter 
	 * @return wx_accesstoken.id 
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public String getId() {
        return id;
    }

    /** 
     * Setter
	 * @param idwx_accesstoken.id
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /** 
     * Getter 
	 * @return wx_accesstoken.accessToken 
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public String getAccesstoken() {
        return accesstoken;
    }

    /** 
     * Setter
	 * @param accesstokenwx_accesstoken.accessToken
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public void setAccesstoken(String accesstoken) {
        this.accesstoken = accesstoken == null ? null : accesstoken.trim();
    }

    /** 
     * Getter 
	 * @return wx_accesstoken.addTime 
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public Date getAddtime() {
        return addtime;
    }

    /** 
     * Setter
	 * @param addtimewx_accesstoken.addTime
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    /** 
     * Getter 
	 * @return wx_accesstoken.expiresIn 
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public Integer getExpiresin() {
        return expiresin;
    }

    /** 
     * Setter
	 * @param expiresinwx_accesstoken.expiresIn
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public void setExpiresin(Integer expiresin) {
        this.expiresin = expiresin;
    }

    /** 
     * Getter 
	 * @return wx_accesstoken.jsapiTicket 
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public String getJsapiticket() {
        return jsapiticket;
    }

    /** 
     * Setter
	 * @param jsapiticketwx_accesstoken.jsapiTicket
     *
     * @mbg.generated Wed Sep 12 11:24:55 CST 2018
     */
    public void setJsapiticket(String jsapiticket) {
        this.jsapiticket = jsapiticket == null ? null : jsapiticket.trim();
    }
}