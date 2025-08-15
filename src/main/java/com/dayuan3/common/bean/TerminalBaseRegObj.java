package com.dayuan3.common.bean;

/**
  *  自助终端--样品来源
 * @author xiaoyl
 * @date   2019年7月23日
 */
public class TerminalBaseRegObj {
	/**
	 * id
	 */
	private Integer id; 
	/**
	 * 监管对象名 作为来源名称
	 */
    private String regName;
    
    /**
     * 	委托单位首字母
     */
    private String regFirstLetter;

    /**
     * 	委托单位全拼音
     */
    private String regFullLetter;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getRegFirstLetter() {
		return regFirstLetter;
	}

	public void setRegFirstLetter(String regFirstLetter) {
		this.regFirstLetter = regFirstLetter;
	}

	public String getRegFullLetter() {
		return regFullLetter;
	}

	public void setRegFullLetter(String regFullLetter) {
		this.regFullLetter = regFullLetter;
	}
    
 
}