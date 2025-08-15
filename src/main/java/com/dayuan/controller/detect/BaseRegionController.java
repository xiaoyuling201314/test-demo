package com.dayuan.controller.detect;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.data.BaseRegion;
import com.dayuan.controller.BaseController;
import com.dayuan.service.data.BaseRegionService;

/**
 * 行政区域Controller
 * @author LuoYX
 * @date 2018年5月4日
 */
@Controller
@RequestMapping("/region")
public class BaseRegionController extends BaseController {

	@Autowired
	private BaseRegionService regionService;
	/**
	 * 查询子行政机构
	 * @param pId 机构Id
	 * @return
	 * @author LuoYX
	 * @date 2018年4月23日
	 */
	@RequestMapping("/queryRegionByRegionId")
	public @ResponseBody List<BaseRegion> queryRegionByPId(Integer regionId){
		return regionService.querySubRegionById(regionId);
	}
	
	
}
