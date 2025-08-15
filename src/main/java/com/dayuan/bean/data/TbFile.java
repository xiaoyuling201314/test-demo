package com.dayuan.bean.data;

import com.dayuan.bean.BaseBean;

public class TbFile extends BaseBean {

    /**
     * 附件来源ID
     */
    private Integer sourceId;
    /**
     * 附件来源类型
     * signPic(不合格处理监督人签名)
     * Enforce(不合格处理取证文件)
     * shoppingRec(抽样单购样小票)
     * evidence(监督执法证据附件)
     * evidenceSign(监督执法被检单位签名附件)
     * check(检测数据附件)
     */
    private String sourceType;
    /**
     * 附件名称
     */
    private String fileName;
    /**
     * 附件路径
     */
    private String filePath;
    /**
     * 附件类型（未使用）
     */
    private String param1;
    /**
     * 预留参数2
     */
    private String param2;
    /**
     * 预留参数3
     */
    private String param3;
    
    /************************ 非数据库字段 ****************************/
//    /**
//     * 文件字节流
//     */
//    private byte[] fileBytes;
//    /**
//     * 文件
//     */
//    private File file;
    /**
     * 文件网络地址
     */
    private String fileUrl;

    public Integer getSourceId() {
        return sourceId;
    }

    public void setSourceId(Integer sourceId) {
        this.sourceId = sourceId;
    }

    public String getSourceType() {
        return sourceType;
    }

    public void setSourceType(String sourceType) {
        this.sourceType = sourceType == null ? null : sourceType.trim();
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath == null ? null : filePath.trim();
    }

    public String getParam1() {
        return param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    public String getParam2() {
        return param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

//	public byte[] getFileBytes() {
//		return fileBytes;
//	}
//
//	public void setFileBytes(byte[] fileBytes) {
//		this.fileBytes = fileBytes;
//	}
//
//	public File getFile() {
//		return file;
//	}
//
//	public void setFile(File file) {
//		this.file = file;
//	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
}