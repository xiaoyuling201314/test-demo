package com.dayuan3.pretreatment.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.sampling.TbSamplingModel;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.DateUtil;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.OrderhistoryService;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.terminal.util.WXPayUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *  收样
 * @author Dz
 * @date 2019年8月7日
 */
@Controller
@RequestMapping("/collectSample")
public class CollectSampleController extends BaseController {
	private Logger log = Logger.getLogger(CollectSampleController.class);
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
	private OrderhistoryService orderHistory ;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Value("${sampleBarCode}")
	private String sampleBarCode;
	@Value("${tubeBarCode}")
	private String tubeBarCode;

	/**
	 * 收样登记
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView terminalOrder(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();

		//样品码开头字母
		map.put("sampleBarCode", sampleBarCode);
		//试管码开头字母
		map.put("tubeBarCode", tubeBarCode);
		//自助终端订单开头字母
		map.put("zdOrderCode", WebConstant.SAMPLING_NUM5);
		//微信订单开头字母
		map.put("wxOrderCode", WebConstant.SAMPLING_NUM6);
		//系统名称
		map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));

		return new ModelAndView("/pretreatment/collectSample/list",map);
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
	 * 根据送检用户ID查询选择过的委托单位
	 *
	 * @param userId 送检用户ID
	 * @return
	 */
	@RequestMapping(value = "/queryReqUnitsByUserId")
	@ResponseBody
	public AjaxJson queryReqUnitsByUserId(Integer userId) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			Map map = new HashMap();
			//用户选择过的委托单位
			List<RequesterUnit>	rUnitsHis = orderHistory.selectUnitHistory(userId);
			map.put("rUnitsHis", rUnitsHis);

			jsonObj.setObj(map);
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
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
	@ResponseBody
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
	 * @param samplingNo 订单号
	 * @return
	 */
	@RequestMapping(value = "/queryBySamplingNo")
	@ResponseBody
	public AjaxJson queryBySamplingNo(String samplingNo, HttpServletRequest request) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			Map<String,Object> map = new HashMap<String,Object>();

			//查询订单
			TbSampling bean = tbSamplingService.queryBySamplingNo(samplingNo);

			//已支付订单
			if (bean != null && bean.getOrderStatus() == 2){
				bean.setSamplingDetails(samplingDetailService.queryBySamplingId2(bean.getId(),0));
				map.put("order", bean);

				//委托单位
				List<TbSamplingRequester> rUnits = samplingRequesterService.queryBySamplingId(bean.getId());
				map.put("rUnits", rUnits);

//				//停用历史委托单位 --Dz 20200111
//				//用户选择过的委托单位
//				List<RequesterUnit>	rUnitsHis = orderHistory.selectUnitHistory(Integer.parseInt(bean.getCreateBy()));
//				map.put("rUnitsHis", rUnitsHis);
			}


			//查询送检单位名称
//			StringBuffer strBuf = new StringBuffer();
//			strBuf.append("SELECT iu.company_name " +
//					" FROM inspection_unit_user iuu  " +
//					" INNER JOIN inspection_unit iu ON iuu.inspection_id = iu.id " +
//					"WHERE iuu.id = ? ");
//			List<String> inspectionUnit = jdbcTemplate.queryForList(strBuf.toString(), new Object[]{bean.getCreateBy()}, String.class);

//			if (inspectionUnit!=null && inspectionUnit.size()>0){
//				map.put("inspectionUnitName", inspectionUnit.get(0));
//			}
			jsonObj.setObj(map);
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}


	/**
	 * 保存
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public AjaxJson save(TbSamplingModel model, HttpServletRequest request){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//更新样品码
			Map map = samplingDetailService.bulkUpdateCode(model.getTbSampling(), model.getTbSamplingDetails(), model.getTbSamplingRequesters());
			//收样时间、收样编号
			jsonObject.setObj(map);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败，请联系工作人员。");
		}
		logUtil.saveOperatorLog((short)0, ModularConstant.OPERATION_MODULE_COLLECTSAMPLE, CollectSampleController.class.toString(), "save", "确认收样", jsonObject.isSuccess(), jsonObject.getMsg(), request);
		return jsonObject;
	}

	/**
	 * 收样登记统计
	 * @param date 统计日期
	 * @return
	 */
	@RequestMapping(value="/statistic")
	@ResponseBody
	public AjaxJson statistic(String date, HttpServletRequest request){
		AjaxJson jsonObject = new AjaxJson();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("yingShou", 0);	//应收数量
			map.put("yiShou", 0);	//已收数量
			map.put("weiShou", 0);	//未收数量
			if (DateUtil.checkDate(date)) {
				StringBuffer sql = new StringBuffer("SELECT COUNT(1) yingShou, " +
						" SUM(IF(tsd.sample_tube_time IS NULL, 0, 1)) yiShou " +
						"FROM tb_sampling ts " +
						" INNER JOIN tb_sampling_detail tsd ON ts.id = tsd.sampling_id " +
						"WHERE ts.delete_flag = 0  " +
						" AND ts.pay_date BETWEEN ? AND ? ");
				List<Map<String, Object>> list1 = jdbcTemplate.queryForList(sql.toString(), new Object[]{date+" 00:00:00", date+" 23:59:59"});
				if (list1.size()>0 && list1.get(0) != null) {
					Map map1 = list1.get(0);
					Integer yingShou = null==map1.get("yingShou") || "".equals(map1.get("yingShou").toString()) ? 0 : Integer.parseInt(map1.get("yingShou").toString());	//应收数量
					Integer yiShou = null==map1.get("yiShou") || "".equals(map1.get("yiShou").toString()) ? 0 : Integer.parseInt(map1.get("yiShou").toString());	//已收数量
					Integer weiShou = yingShou - yiShou;	//未收数量

					map.put("yingShou", yingShou);
					map.put("yiShou", yiShou);
					map.put("weiShou", weiShou);
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

}
