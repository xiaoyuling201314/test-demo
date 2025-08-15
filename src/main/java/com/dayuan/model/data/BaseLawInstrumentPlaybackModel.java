package com.dayuan.model.data;

import java.util.Date;

import com.dayuan.model.BaseModel;
/**
 * 执法仪 回放视频
 * @author LuoYX
 * @date 2018年8月20日
 */
public class BaseLawInstrumentPlaybackModel extends BaseModel {
	private Integer id;
	/**
	 *
	 */
	private Integer instrumentId;

	/**
	 *
	 */
	private String devidno;

	/**
	 *
	 */
	private Date time;

	/**
	 * 录像类型
	 */
	private Short type;

	/**
	 * 设备通道
	 */
	private Short chn;

	/**
	 * 文件名称
	 */
	private String file;

	/**
	 * 文件大小
	 */
	private Double fileSize;
	
	private Date start;
	private Date end;
	
	
	
	
	

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * Getter
	 * @return base_law_instrument_playback.instrument_id
	 *
	 * @mbg.generated
	 */
	public Integer getInstrumentId() {
		return instrumentId;
	}

	/**
	 * Setter
	 * @param instrumentIdbase_law_instrument_playback.instrument_id
	 *
	 * @mbg.generated
	 */
	public void setInstrumentId(Integer instrumentId) {
		this.instrumentId = instrumentId;
	}

	/**
	 * Getter
	 * @return base_law_instrument_playback.devIdno
	 *
	 * @mbg.generated
	 */
	public String getDevidno() {
		return devidno;
	}

	/**
	 * Setter
	 * @param devidnobase_law_instrument_playback.devIdno
	 *
	 * @mbg.generated
	 */
	public void setDevidno(String devidno) {
		this.devidno = devidno == null ? null : devidno.trim();
	}

	/**
	 * Getter
	 * @return base_law_instrument_playback.time
	 *
	 * @mbg.generated
	 */
	public Date getTime() {
		return time;
	}

	/**
	 * Setter
	 * @param timebase_law_instrument_playback.time
	 *
	 * @mbg.generated
	 */
	public void setTime(Date time) {
		this.time = time;
	}

	/**
	 * Getter 录像类型
	 * @return base_law_instrument_playback.type 录像类型
	 *
	 * @mbg.generated
	 */
	public Short getType() {
		return type;
	}

	/**
	 * Setter录像类型
	 * @param typebase_law_instrument_playback.type
	 *
	 * @mbg.generated
	 */
	public void setType(Short type) {
		this.type = type;
	}

	/**
	 * Getter 设备通道
	 * @return base_law_instrument_playback.chn 设备通道
	 *
	 * @mbg.generated
	 */
	public Short getChn() {
		return chn;
	}

	/**
	 * Setter设备通道
	 * @param chnbase_law_instrument_playback.chn
	 *
	 * @mbg.generated
	 */
	public void setChn(Short chn) {
		this.chn = chn;
	}

	/**
	 * Getter 文件名称
	 * @return base_law_instrument_playback.file 文件名称
	 *
	 * @mbg.generated
	 */
	public String getFile() {
		return file;
	}

	/**
	 * Setter文件名称
	 * @param filebase_law_instrument_playback.file
	 *
	 * @mbg.generated
	 */
	public void setFile(String file) {
		this.file = file == null ? null : file.trim();
	}

	/**
	 * Getter 文件大小
	 * @return base_law_instrument_playback.file_size 文件大小
	 *
	 * @mbg.generated
	 */
	public Double getFileSize() {
		return fileSize;
	}

	/**
	 * Setter文件大小
	 * @param fileSizebase_law_instrument_playback.file_size
	 *
	 * @mbg.generated
	 */
	public void setFileSize(Double fileSize) {
		this.fileSize = fileSize;
	}

}
