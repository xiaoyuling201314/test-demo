package com.dayuan3.terminal.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.controller.BaseController;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.ModularConstant;

/**
 * 送检账号
 * 
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Controller
@RequestMapping("/reportPrint")
public class ReportNonLoginController extends BaseController {
	private Logger log = Logger.getLogger(ReportNonLoginController.class);

	@Autowired
	private TbSamplingService tbSamplingService;
	
	@Autowired
	private TbSamplingDetailService tbSamplingDetailService;
	
	@Autowired
	private TbSamplingRequesterService samplingRequesterService;
	
	@Autowired
	private CommonLogUtilService logUtil;

	@RequestMapping({ "/printNoLogin" })
	public ModelAndView printNoLogin(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/terminal/report/index");
	}
	
	/**
	 * 扫描订单号或取报告码查询订单信息
	 * 
	 * @description
	 * @param samplingId 订单ID
	 * @param collectCode 送样批次码
	 * @return
	 * @author xiaoyl
	 * @date 2019年7月27日
	 */
	@RequestMapping(value = "/queryOrder")
	@ResponseBody
	public AjaxJson queryOrder(Integer samplingId, String collectCode,HttpServletRequest request) {
		AjaxJson jsonObj = new AjaxJson();
		String description="";
		String message="";
		TbSampling bean = null;
		try {
			List<Map<String, Object>> list=null;
			if(samplingId!=null && StringUtil.isNotEmpty(collectCode)) {//扫描二维码打印报告
				list=tbSamplingDetailService.queryCollectCodeBySamplingId(samplingId, collectCode);
				description="扫描取报告码查看报告";
			}else if(StringUtil.isNotEmpty(collectCode) && collectCode.length()>9) {//根据订单号查询 
				bean= tbSamplingService.queryBySamplingNo(collectCode);
				description="输入订单号查看报告进行打印";
			 }else if(samplingId==null && StringUtil.isNotEmpty(collectCode)) {//输入取报告码
				bean =tbSamplingService.queryByReportCode(collectCode);
				description="输入取报告码查看报告进行打印";
			}
			if(list!=null && list.size()>0) {
				jsonObj.setObj(list);
			} else if(bean!=null) {
				jsonObj.setObj(bean);
			}else {
				jsonObj.setSuccess(false);
				jsonObj.setMsg("请扫描正确的取报告码");
			}
			samplingId=samplingId!=null?samplingId : bean.getId();
			int requestCount=samplingRequesterService.queryCountBySamplingId(samplingId);
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("requestCount", requestCount);
			jsonObj.setAttributes(map);
			request.getSession().setAttribute("outPrint",1);
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() + e.getStackTrace());
			message=e.getMessage();
			e.printStackTrace();
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		logUtil.savePrintLog((short)0, ModularConstant.OPERATION_MODULE_PRINT, ReportNonLoginController.class.toString(), "queryOrder", description, jsonObj.isSuccess(), message, request);
		return jsonObj;
	}

	/**
	 * 进入待打印页面
	 * 
	 * @description
	 * @param samplingId
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date 2019年7月27日
	 */
	@RequestMapping({ "/printBefore" })
	public ModelAndView printBefore(Integer samplingId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("samplingId", samplingId);
		request.getSession().setAttribute("outPrint",1);
		return new ModelAndView("/terminal/report/list", map);
	}
}
