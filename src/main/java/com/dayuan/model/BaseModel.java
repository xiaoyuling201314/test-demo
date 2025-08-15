package com.dayuan.model;

import java.util.Calendar;

//import com.dayuan3.terminal.model.IncomeModel;

/**
 * 共用属性
 * Description:
 * @Company: 广东达元
 * @author xyl
 * @date 2017年8月4日
 */
public class BaseModel {
	
	protected Integer departId;	//组织机构id
	protected Integer pointId;	//检测点id
	 
	/*********** 用于筛选数据 *************/
	protected Integer[] departArr;	//机构ID
	protected Integer[] pointArr;	//检测点ID
	protected Integer userRegId;	//监管对象ID
	 
	protected String keyWords;	//查询条件 - 关键词
	protected String startDateStr;	//查询条件 - 开始时间
	protected String endDateStr;	//查询条件 - 结束时间

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}

	public Integer getPointId() {
		return pointId;
	}

	public void setPointId(Integer pointId) {
		this.pointId = pointId;
	}

	public Integer[] getDepartArr() {
		return departArr;
	}

	public void setDepartArr(Integer[] departArr) {
		this.departArr = departArr;
	}

	public Integer[] getPointArr() {
		return pointArr;
	}

	public void setPointArr(Integer[] pointArr) {
		this.pointArr = pointArr;
	}

	public Integer getUserRegId() {
		return userRegId;
	}

	public void setUserRegId(Integer userRegId) {
		this.userRegId = userRegId;
	}

	public String getKeyWords() {
		return keyWords;
	}

	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}

	public String getStartDateStr() {
		return startDateStr;
	}

	public void setStartDateStr(String startDateStr) {
		this.startDateStr = startDateStr;
	}

	public String getEndDateStr() {
		return endDateStr;
	}

	public void setEndDateStr(String endDateStr) {
		this.endDateStr = endDateStr;
	}
	/**
	 * 拼接时间
	 * @param type
	 * @param month
	 * @param season
	 * @param year
	 * @param start
	 * @param end
	 * @return
	 */
	public BaseModel formatTime(String type,String month,String season,String year,String start,String end,BaseModel model){
		if(type.equals("month")){
			if(month.length()<2){
				month="0"+month;
			}
			start=year+"-"+month+"-01";
			end=year+"-"+month+"-31 23:59:59";
		}else if (type.equals("season")) {
			if(season.equals("1")){
				start=year+"-01-01";
				end=year+"-03-31 23:59:59";
			}else if (season.equals("2")) {
				start=year+"-04-01";
				end=year+"-06-30 23:59:59";
			}else if (season.equals("3")) {
				start=year+"-07-01";
				end=year+"-09-30 23:59:59";
			}else if (season.equals("4")) {
				start=year+"-10-01";
				end=year+"-12-31 23:59:59";
			}
		}else if (type.equals("year")) {
			start=year+"-01-01";
			end=year+"-12-31 23:59:59";
		}else if (type.equals("diy")) {
			end=end+" 23:59:59";
		}
		
		model.setStartDateStr(start);
		model.setEndDateStr(end);
		return model;
	}
}
