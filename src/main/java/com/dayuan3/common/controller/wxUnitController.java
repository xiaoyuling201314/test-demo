package com.dayuan3.common.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.controller.BaseController;
import com.dayuan.util.DateUtil;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.sampleDetail;
import com.dayuan3.terminal.service.RequesterUnitService;
import com.dayuan3.terminal.util.WXPayUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 扫描查询委托单位
 *
 * @author cola_hu
 *2019年8月14日
 */
@Controller
@RequestMapping("/wx/unit")
public class wxUnitController extends BaseController {
	private Logger log=Logger.getLogger(wxUnitController.class);

	@Autowired
	private RequesterUnitService requesterUnitService;


	 /**
	  *扫描委托单位二维码页面
	  * @param id
	  * @param response
	  * @return
	  */
	@RequestMapping("/scanQrcode")
	@ResponseBody
	public ModelAndView scanQrcode(Integer id,String openid){
		Map<String, Object> map=new HashMap<>();
		try {
		RequesterUnit unit=requesterUnitService.queryById(id);
		map.put("openid", openid);
		map.put("unit", unit);
		map.put("id", id);
        //获取进货数量的显示和必填配置传入界面
        map.put("showReq", WXPayUtil.getShowReq());
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		return new ModelAndView("/terminal/requester/scanQrcode",map);
	}
	@RequestMapping("/queryData")
	@ResponseBody
	public AjaxJson queryData(HttpServletRequest request,HttpServletResponse response,Page page,Integer id,String day){
		AjaxJson jsonObj = new AjaxJson();
		try {
			if(day==null||day.equals("")){
				day=DateUtil.formatDate(new Date(), "yyyy-MM-dd");
			}
			List<sampleDetail>	list=requesterUnitService.queryDataCheckById2(id,page.getRowOffset(),page.getPageSize(),day,day);
			jsonObj.setObj(list);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	@RequestMapping("/queryData2")
	@ResponseBody
	public AjaxJson queryData2(String startDate,String endDate,Page page,Integer id){
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<sampleDetail>	list=requesterUnitService.queryDataCheckById2(id,page.getRowOffset(),page.getPageSize(),startDate,endDate);
			jsonObj.setObj(list);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

}
