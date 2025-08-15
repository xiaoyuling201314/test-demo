//package com.dayuan.controller.sampling;
//
//import com.alibaba.fastjson.JSONObject;
//import com.dayuan.bean.AjaxJson;
//import com.dayuan.bean.Page;
//import com.dayuan.bean.data.TbFile;
//import com.dayuan.bean.ledger.BaseLedgerStock;
//import com.dayuan.bean.regulatory.BaseRegulatoryObject;
//import com.dayuan.bean.sampling.TbSampling;
//import com.dayuan.bean.sampling.TbSamplingDetail;
//import com.dayuan.common.PublicUtil;
//import com.dayuan.controller.BaseController;
//import com.dayuan.model.sampling.TbSamplingModel;
//import com.dayuan.service.data.TbFileService;
//import com.dayuan.service.ledger.BaseLedgerStockService;
//import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
//import com.dayuan.service.sampling.TbSamplingDetailRecevieService;
//import com.dayuan.service.sampling.TbSamplingDetailService;
//import com.dayuan.service.sampling.TbSamplingService;
//import com.dayuan.util.DateUtil;
//import com.dayuan.util.DyFileUtil;
//import com.dayuan.util.QrcodeUtil;
//import com.dayuan.util.StringUtil;
//import com.dayuan3.common.util.SystemConfigUtil;
//import org.apache.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.File;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
///**
// * 抽样单管理
// * Description:
// * @Company: 食安科技
// * @author bill
// * @date 2017年8月4日
// */
//@Controller
//@RequestMapping("/samplingDetail")
//public class TbSamplingDetailController extends BaseController {
//
//	private final Logger log=Logger.getLogger(TbSamplingDetailController.class);
//
//	@Autowired
//	private TbSamplingService tbSamplingService;
//	@Autowired
//	private TbSamplingDetailService tbSamplingDetailService;
//	@Autowired
//	private TbSamplingDetailRecevieService samplingDetailRecevieService;
//	@Autowired
//	private TbFileService fileService;
//	@Autowired
//	private BaseLedgerStockService baseLedgerStockService;
//	@Autowired
//	private BaseRegulatoryObjectService baseRegulatoryObjectService;
//	@Value("${resources}")
//	private String resources;
//	@Value("${samplingQr}")
//	private String samplingQr;
//	@Value("${samplingQrPath}")
//	private String samplingQrPath;
//	/**
//	 * 进入抽样单明细
//	 * @author Dz
//	 * @param id 抽样单ID
//	 * @param samplingNo 抽样单单号
//	 * @param source 来源（抽样单/实时监控）
//	 * @return
//	 */
//	@RequestMapping("/details")
//	public ModelAndView details(HttpServletRequest request,HttpServletResponse response,
//			Integer id,String source,String samplingNo){
//		Map<String,Object> map = new HashMap<String,Object>();
//		TbSampling sampling = null;
//		List<TbFile> files = null;
//		BaseRegulatoryObject regObject = null;
//		try {
//			if(StringUtil.isNotEmpty(id)){
//				sampling = tbSamplingService.getById(id);
//				files = fileService.queryBySource(id, "shoppingRec");
//				if(null != sampling){
//					regObject = baseRegulatoryObjectService.queryById(sampling.getRegId());
//				}
//			}else{
//				sampling = tbSamplingService.queryBySamplingNo(samplingNo);
//				if(null != sampling){
//					files = fileService.queryBySource(sampling.getId(), "shoppingRec");
//					regObject = baseRegulatoryObjectService.queryById(sampling.getRegId());
//				}
//			}
//			//add by xiaoyl 2022/03/25 查看抽样单详情，先校验抽样单二维码是否存在，不存在则先生成
//			String rootPath = resources + samplingQr;
//			DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
//			File qrFile = new File(rootPath + sampling.getQrcode());
//			if (!qrFile.exists()) {
//				QrcodeUtil.generateSamplingQrcode(request, sampling.getQrcode(), samplingQrPath + sampling.getSamplingNo(), rootPath);
//			}
//		} catch (Exception e) {
//			log.error("**********************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//		}
//		//购样费用功能；0_关闭，1_开启
//		Integer showSampleCost = 0;
//		JSONObject config = SystemConfigUtil.OTHER_CONFIG;
//		if (config != null && config.getJSONObject("system_config") != null && config.getJSONObject("system_config").getInteger("show_sample_cost") != null) {
//			showSampleCost = config.getJSONObject("system_config").getInteger("show_sample_cost");
//		}
//		map.put("showSampleCost", showSampleCost);
//
//		map.put("sampling", sampling);
//		map.put("files", files);
//		map.put("source", source);
//		map.put("regObject", regObject);
//		if(sampling != null && sampling.getPersonal()==1){//进入送样单详情查看页面
//			return new ModelAndView("/sampling/sendSamples/detail",map);
//		}else{
//			return new ModelAndView("/sampling/samplingDetail",map);
//		}
//	}
//
//	/**
//	 * 数据列表
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/datagrid")
//	@ResponseBody
//	public AjaxJson datagrid(TbSamplingModel model,Page page,HttpServletResponse response){
//		AjaxJson jsonObj = new AjaxJson();
//		try {
//			if (model.getSamplingDateEndDate() != null && model.getSamplingDateEndDate().trim().length() == 10) {
//				model.setSamplingDateEndDate(model.getSamplingDateEndDate().trim() + " 23:59:59");
//			}
//			page = tbSamplingDetailService.loadDatagrid(page, model);
//			jsonObj.setObj(page);
//		} catch (Exception e) {
//			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//			jsonObj.setSuccess(false);
//			jsonObj.setMsg("操作失败");
//		}
//		return jsonObj;
//	}
//
//	/**
//	 * 溯源
//	 * @param request
//	 * @param response
//	 * @param sdId 抽样明细ID
//	 * @return
//	 */
//	@RequestMapping("/checkTraceability")
//	@ResponseBody
//	public AjaxJson checkTraceability(HttpServletRequest request,HttpServletResponse response, Integer sdId){
//		AjaxJson jsonObj = new AjaxJson();
//		BaseLedgerStock ledgerStock = null;	//溯源
//		try {
//			TbSamplingDetail sd = tbSamplingDetailService.queryById(sdId);
//			if(sd != null) {
//				TbSampling sampling = tbSamplingService.getById(sd.getSamplingId());
//				if(sampling != null) {
//						ledgerStock = baseLedgerStockService.queryByBatchNumber(sampling.getRegId(), sampling.getOpeId(), sd.getFoodName(), sd.getBatchNumber(), DateUtil.formatDate(sampling.getSamplingDate(), "yyyy-MM-dd") );
//				}
//			}
//
//			if(ledgerStock == null) {
//				jsonObj.setSuccess(false);	//无溯源信息
//			}
//		} catch (Exception e) {
//			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//			jsonObj.setSuccess(false);
//			jsonObj.setMsg("操作失败");
//		}
//		return jsonObj;
//	}
//
//	/**
//	 * 溯源
//	 * @param request
//	 * @param response
//	 * @param sdId 抽样明细ID
//	 * @return
//	 */
//	@RequestMapping("/traceability")
//	public ModelAndView traceability(HttpServletRequest request,HttpServletResponse response, Integer sdId){
//		Map<String,Object> map = new HashMap<String, Object>();
//		BaseLedgerStock ledgerStock = new BaseLedgerStock();	//溯源
//
//		try {
//			TbSamplingDetail sd = tbSamplingDetailService.queryById(sdId);
//			if(sd != null) {
//				TbSampling sampling = tbSamplingService.getById(sd.getSamplingId());
//				if(sampling != null) {
//						ledgerStock = baseLedgerStockService.queryByBatchNumber(sampling.getRegId(), sampling.getOpeId(), sd.getFoodName(), sd.getBatchNumber(), DateUtil.formatDate(sampling.getSamplingDate(), "yyyy-MM-dd") );
//				}
//			}
//
//		} catch (Exception e) {
//			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//		}
//
//		map.put("ledgerStock", ledgerStock);
//		return new ModelAndView("/dataCheck/traceability",map);
//	}
//
//	/**
//	 * 重发检测任务
//	 * @author Dz
//	 * 2019年3月26日 下午4:04:17
//	 * @param samplingDetailId	抽样样品ID
//	 * @param serialNumber	仪器唯一标识
//	 * @return
//	 */
//	@RequestMapping("/reissueCheckTask")
//	@ResponseBody
//	public AjaxJson reissueCheckTask(Integer samplingDetailId, String serialNumber){
//		AjaxJson jsonObj = new AjaxJson();
//		try {
//			//仪器拒收后重发到另一台仪器
//			samplingDetailRecevieService.updateStatus(PublicUtil.getSessionUser(), samplingDetailId, serialNumber, (short) 2, true);
//
//			TbSamplingDetail samplingDetail = tbSamplingDetailService.queryById(samplingDetailId);
//			//所有仪器拒收任务
//			if (StringUtil.isEmpty(samplingDetail.getRecevieDevice())) {
//				//新一轮重发
//				samplingDetailRecevieService.updateStatus(PublicUtil.getSessionUser(), samplingDetailId, "", (short) 2, true);
//			}
//		} catch (Exception e) {
//			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//			jsonObj.setSuccess(false);
//			jsonObj.setMsg("下发失败");
//		}
//		return jsonObj;
//	}
//
//
//}
