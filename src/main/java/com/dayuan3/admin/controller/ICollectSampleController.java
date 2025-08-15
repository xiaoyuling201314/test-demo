package com.dayuan3.admin.controller;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.DateUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.OrderhistoryService;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.terminal.util.WXPayUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Description  收样登记
 * @Author xiaoyl
 * @Date 2025/6/19 9:31
 */
@RestController
@RequestMapping("/newCollectSample")
public class ICollectSampleController extends BaseController {
	private Logger log = Logger.getLogger(ICollectSampleController.class);
	@Autowired
	private TbSamplingService tbSamplingService;
	@Autowired
	private TbSamplingDetailService samplingDetailService;
	@Autowired
	private TbSamplingRequesterService samplingRequesterService;
	@Autowired
	private InspectionUnitService inspectionUnitService;
	@Autowired
	private InspectionUnitUserService inspectionUnitUserService;
	@Autowired
	private CommonLogUtilService logUtil;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Value("${sampleBarCode}")
	private String sampleBarCode;

	/**
	 * 收样登记
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		//样品码开头字母
		map.put("sampleBarCode", sampleBarCode);
		//微信订单开头字母
		map.put("wxOrderCode", WebConstant.SAMPLING_NUM1);
		//系统名称
		map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
		return new ModelAndView("/pretreatment_new/collectSample/list",map);
	}

	/**
	 * 扫描查看收样信息
	 * @param samplingId 订单ID
	 * @param collectCode	收样编号
	 * @return
	 */
	@RequestMapping("/detail")
	public ModelAndView detail(String samplingId, String collectCode){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			TbSampling sampling = tbSamplingService.getById(Integer.parseInt(samplingId));
			if(sampling == null){
				map.put("msg","订单不存在!");
				return new ModelAndView("/wxPay/404", map);
			}

			InspectionUnitUser insUnitUser = inspectionUnitUserService.queryById(Integer.parseInt(sampling.getCreateBy()));
			InspectionUnit insUnit = null;
			if (insUnitUser!=null){
				insUnit = inspectionUnitService.queryById(insUnitUser.getInspectionId());
			}
			List<TbSamplingDetail> sampleList = samplingDetailService.queryByCollectCode(Integer.parseInt(samplingId), collectCode);
			if(sampleList == null || sampleList.size()==0){
				map.put("msg","送检信息不存在!");
				return new ModelAndView("/wxPay/404", map);
			}

			//订单
			map.put("order",sampling);
			//送检样品
			map.put("sampleList",sampleList);

			//送检单位
			map.put("insUnit",insUnit);
			//送检人
			map.put("insUnitUser",insUnitUser);

//			//收样人
//			map.put("collectUser",sampleList.get(0).getParam4());
//			//收样时间
//			map.put("collectTime",sampleList.get(0).getSampleTubeTime());
			//收样码
			map.put("collectCode",collectCode);
			//获取进货数量的显示和必填配置传入界面
			map.put("showReq", WXPayUtil.getShowReq());
			return new ModelAndView("/pretreatment/collectSample/detail_app",map);

		} catch (Exception e) {
			log.error("*************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			map.put("msg","订单不存在!");
			return new ModelAndView("/wxPay/404", map);
		}
	}

	/**
	 * 根据手机号查询已支付订单信息
	 *
	 * @param phone 手机号
	 * @param startTime 下单时间查询范围-开始时间
	 * @param endTime 下单时间查询范围-结束时间
	 * @return
	 */
	@RequestMapping(value = "/queryByPhone")
	public AjaxJson queryByPhone(String phone, String startTime, String endTime, HttpServletRequest request) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<TbSampling> orders = tbSamplingService.queryByPhone(phone, startTime, endTime);
			jsonObj.setObj(orders);
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 扫描订单号查询已支付订单信息
	 *
	 * @description
	 * @param orderNumber 订单号
	 * @param queryReCheck 是否查询复检明细：0 否，1 是
	 * @return
	 */
	@RequestMapping(value = "/queryBySamplingNo")
	public AjaxJson queryBySamplingNo(String orderNumber,@RequestParam(required = false,defaultValue = "0") int queryReCheck) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			//查询订单
			TbSampling bean = tbSamplingService.queryBySamplingNo(orderNumber);
			if(bean==null){
				jsonObj.setSuccess(false);
				jsonObj.setMsg("没有找到订单，请扫描或输入正确的订单号");
				return jsonObj;
			}
			//已支付订单
			if(bean.getOrderStatus()==1){
				jsonObj.setSuccess(false);
				jsonObj.setMsg("订单待支付，请稍后操作！");
				jsonObj.setObj(bean.getIsSampling());
			}else if(bean.getIsSampling()!=2){
				jsonObj.setSuccess(false);
				jsonObj.setMsg("订单暂未取样，请稍后操作！");
				jsonObj.setObj(bean.getIsSampling());
			}else if (bean != null && (bean.getOrderStatus() == 2 || bean.getOrderStatus() == 6)){
				bean.setSamplingDetails(samplingDetailService.queryBySamplingId2(bean.getId(),queryReCheck));
				map.put("order", bean);
				//委托单位
				List<TbSamplingRequester> rUnits = samplingRequesterService.queryBySamplingId(bean.getId());
				map.put("rUnits", rUnits);
				jsonObj.setObj(map);
			}
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}


	/**
	* @Description 订单分拣，将样品编号写入样品条码与试管码记录表，同时记录打印条码时间和次数
	* @Date 2025/06/21 11:32
	* @Author xiaoyl
	* @Param samplId:订单ID
	* @Param sampleDetailId:订单明细ID
	* @Param sampleCode:样品码
	* @return
	*/
	@RequestMapping(value="/save")
	public AjaxJson save(Integer  samplId,
						 @RequestParam(required = false) Integer sampleDetailId,
						 @RequestParam(required = false) String sampleCode,
						 HttpServletRequest request){
		AjaxJson jsonObject = new AjaxJson();
		try {
			samplingDetailService.bulkSampleCode(samplId,sampleDetailId,sampleCode);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败，请联系工作人员。");
		}
		logUtil.saveOperatorLog((short)0, ModularConstant.OPERATION_MODULE_COLLECTSAMPLE, ICollectSampleController.class.toString(), "save", "打印样品码分拣", jsonObject.isSuccess(), jsonObject.getMsg(), request);
		return jsonObject;
	}

	/**
	 * 收样登记统计
	 * @param date 统计日期
	 * @return
	 */
	@RequestMapping(value="/statistic")
	public AjaxJson statistic(String date){
		AjaxJson jsonObject = new AjaxJson();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (DateUtil.checkDate(date)) {
				StringBuffer sql = new StringBuffer("SELECT COUNT(1) yingShou, " +
						"  count(DISTINCT sampling_id) yiShou "+
						" FROM tb_sampling ts " +
                        " left join tb_sampling_detail tsd on tsd.sampling_id=ts.id and print_code_num>0"+
						" WHERE ts.delete_flag = 0 and ts.is_sampling=2  " +
						" AND ts.order_time BETWEEN ? AND ? ");
				List<Map<String, Object>> list1 = jdbcTemplate.queryForList(sql.toString(), new Object[]{date+" 00:00:00", date+" 23:59:59"});
				if (list1.size()>0 && list1.get(0) != null) {
					Map map1 = list1.get(0);
					Integer yingShou = null==map1.get("yingShou") || "".equals(map1.get("yingShou").toString()) ? 0 : Integer.parseInt(map1.get("yingShou").toString());	//应收数量
					Integer yiShou = null==map1.get("yiShou") || "".equals(map1.get("yiShou").toString()) ? 0 : Integer.parseInt(map1.get("yiShou").toString());	//已收数量
					Integer weiShou = yingShou - yiShou;	//未收数量

					map.put("yingShou", yingShou);
					map.put("yiShou", yiShou);
					map.put("weiShou", weiShou);
				}else{
					map.put("yingShou", 0);	//应收数量
					map.put("yiShou", 0);	//已收数量
					map.put("weiShou", 0);	//未收数量
				}
			}
			jsonObject.setObj(map);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败，请联系工作人员。");
		}
		return jsonObject;
	}
	/******************************************复检订单*********************************************/
	@RequestMapping(value="/statisticReCheck")
	public AjaxJson statisticReCheck(String startTime, String endTime){
		AjaxJson jsonObject = new AjaxJson();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
				StringBuffer sql = new StringBuffer("SELECT COUNT(1) yingShou, " +
						" count(DISTINCT sampling_id) yiShou "+
						" FROM tb_sampling ts " +
						" left join tb_sampling_detail tsd on tsd.sampling_id=ts.id and recheck_detail_id!='' and print_code_num>0 "+
						" WHERE ts.delete_flag = 0 and ts.order_status=6   " +
						" AND ts.order_time BETWEEN ? AND ? ");
				List<Map<String, Object>> list1 = jdbcTemplate.queryForList(sql.toString(), new Object[]{startTime+" 00:00:00", endTime+" 23:59:59"});
				if (list1.size()>0 && list1.get(0) != null) {
					Map map1 = list1.get(0);
					Integer yingShou = null==map1.get("yingShou") || "".equals(map1.get("yingShou").toString()) ? 0 : Integer.parseInt(map1.get("yingShou").toString());	//应收数量
					Integer yiShou = null==map1.get("yiShou") || "".equals(map1.get("yiShou").toString()) ? 0 : Integer.parseInt(map1.get("yiShou").toString());	//已收数量
					Integer weiShou = yingShou - yiShou;	//未收数量
					map.put("yingShou", yingShou);
					map.put("yiShou", yiShou);
					map.put("weiShou", weiShou);
				}else{
					map.put("yingShou", 0);	//应收数量
					map.put("yiShou", 0);	//已收数量
					map.put("weiShou", 0);	//未收数量
				}
			jsonObject.setObj(map);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败，请联系工作人员。");
		}
		return jsonObject;
	}
	/**
	 * 复检订单分拣
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/list_recheck")
	public ModelAndView listreCheck(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		//样品码开头字母
		map.put("sampleBarCode", sampleBarCode);
		//微信订单开头字母
		map.put("wxOrderCode", WebConstant.SAMPLING_NUM1);
		//系统名称
		map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
		return new ModelAndView("/pretreatment_new/collectSample/list_recheck",map);
	}

	/**
	 * Description  查询近7天的待复检订单
	 * @Author xiaoyl
	 * @Date 2025/7/5 11:25
	 */
	@RequestMapping(value = "/queryReCheck")
	public AjaxJson queryReCheck(String startTime, String endTime) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<TbSampling> orders = tbSamplingService.queryReCheck(startTime, endTime);
			jsonObj.setObj(orders);
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * @Description 订单分拣，将样品编号写入样品条码与试管码记录表，同时记录打印条码时间和次数
	 * @Date 2025/06/21 11:32
	 * @Author xiaoyl
	 * @Param samplId:订单ID
	 * @Param sampleDetailId:订单明细ID
	 * @Param sampleCode:样品码
	 * @return
	 */
	@RequestMapping(value="/saveRecheck")
	public AjaxJson saveRecheck( HttpServletRequest request,String result){
		AjaxJson jsonObject = new AjaxJson();
		try {
			List<TbSamplingDetail> detail= JSON.parseArray(result,TbSamplingDetail.class);
			samplingDetailService.bulkRecheckSampleCode(detail);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败，请联系工作人员。");
		}
		logUtil.saveOperatorLog((short)0, ModularConstant.OPERATION_MODULE_COLLECTSAMPLE, ICollectSampleController.class.toString(), "save", "打印样品码分拣", jsonObject.isSuccess(), jsonObject.getMsg(), request);
		return jsonObject;
	}
}
