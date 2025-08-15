package com.dayuan.bean;

import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author luoyx 时间:2018年5月16日17:01
 */
@Data
public class BaseBean2 implements Serializable {

	protected Integer id;
	protected String remark; // 备注

	@TableLogic
	protected Short deleteFlag = 0; // 删除状态；0未删除，1删除
	
	protected Short sorting = 1;	//排序

	protected String createBy; // 创建人id

	protected Date createDate; // 创建时间

	protected String updateBy; // 修改人id

	protected Date updateDate; // 修改时间
	
}
