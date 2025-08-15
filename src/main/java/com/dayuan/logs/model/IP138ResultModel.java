package com.dayuan.logs.model;

/**
 * @Description IP138接口返回对象封装
 * @Author xiaoyl
 * @Date 2022-03-04 14:13
 */
public class IP138ResultModel {
    /*
    返回格式示例
    {
	"ret": "ok",
	"ip": "121.32.197.217",
	"data": [
		"中国",
		"广东",
		"广州",
		"黄埔区",
		"电信",
		"510700",
		"020"
        ]
    }
    {"ret":"err","msg":"无效token"}
    */
    private String ret;//请求结果：ok，err
    private String ip;
    private String[] data;//物理地址的数组信息，格式["中国","广东","广州","黄埔区","电信","510700","020"]

    public String getRet() {
        return ret;
    }

    public void setRet(String ret) {
        this.ret = ret;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String[] getData() {
        return data;
    }

    public void setData(String[] data) {
        this.data = data;
    }
}
