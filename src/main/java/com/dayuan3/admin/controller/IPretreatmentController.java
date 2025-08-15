package com.dayuan3.admin.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.mapper.sampling.TbSamplingDetailCodeMapper;
import com.dayuan.service.sampling.TbSamplingDetailCodeService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.pretreatment.model.TbSamplingDetailCodeModel;
import com.dayuan3.terminal.controller.OrderController;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * Description 前处理
 * @Author xiaoyl
 * @Date 2025/6/20 15:47
 */
@RestController
@RequestMapping("/newPretreatment")
public class IPretreatmentController extends BaseController {
	private Logger log = Logger.getLogger(IPretreatmentController.class);
	@Autowired
	private TbSamplingService tbSamplingService;
	@Autowired
	private TbSamplingDetailService samplingDetailService;
	@Autowired
	private TbSamplingDetailCodeService samplingDetailCodeService;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Value("${sampleBarCode}")
	private String sampleBarCode;
	@Value("${tubeBarCode}")
	private String tubeBarCode;
	@Value("${tubeCodeValidity}")
	private int tubeCodeValidity;

	@Autowired
	private CommonLogUtilService logUtil;
	/**
	 * 进入前处理页面
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sampleBarCode", sampleBarCode);
		map.put("tubeBarCode", tubeBarCode);
		//系统名称
		map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
		return new ModelAndView("/pretreatment_new/list",map);
	}
	/**
	 * 前处理统计
	 * @param date 统计日期
	 * @return
	 */
	@RequestMapping(value="/statistic")
	public AjaxJson statistic(String date, HttpServletRequest request){
		AjaxJson jsonObject = new AjaxJson();
		try {
			TSUser user = PublicUtil.getSessionUser();
			Map<String, Object> map = new HashMap<String, Object>();
			if (DateUtil.checkDate(date)) {
				StringBuffer sql = new StringBuffer("SELECT COUNT(1) yingChuLi, " +
						" SUM(IF(tsdc.tube_code_time1 IS NOT NULL OR (dcr.delete_flag = 0 AND (dcr.conclusion = '合格' OR (dcr.conclusion = '不合格' AND dcr.reload_flag < ? ))) , 1, 0)) yiChuLi " +
						"FROM tb_sampling_detail tsd ");
				/*if (user.getPointId() == null && user.getDepartId() != null) {
					//机构用户能查看下级数据
					sql.append(" INNER JOIN (SELECT id FROM t_s_depart  " +
							" WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) tb1 ON tb1.id = tsd.depart_id ");
				}*/
				sql.append(" LEFT JOIN tb_sampling_detail_code tsdc ON tsd.id = tsdc.sampling_detail_id " +
						" LEFT JOIN data_check_recording dcr ON tsd.id = dcr.sampling_detail_id " +
						" WHERE tsdc.sample_code_time BETWEEN ? AND ? ");
				/*if (user.getPointId() != null) {
					//检测点用户只能查看本部数据
					sql.append("AND tsd.point_id = "+user.getPointId()+" ");
				}*/

				int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
				List<Map<String, Object>> list1 = jdbcTemplate.queryForList(sql.toString(), new Object[]{recheckNumber, date+" 00:00:00", date+" 23:59:59"});
				if (list1.size()>0 && list1.get(0) != null) {
					Map map1 = list1.get(0);
					Integer yingChuLi = null==map1.get("yingChuLi") || "".equals(map1.get("yingChuLi").toString()) ? 0 : Integer.parseInt(map1.get("yingChuLi").toString());	//应处理数量
					Integer yiChuLi = null==map1.get("yiChuLi") || "".equals(map1.get("yiChuLi").toString()) ? 0 : Integer.parseInt(map1.get("yiChuLi").toString());	//已处理数量
					Integer weiChuLi = yingChuLi - yiChuLi;	//未处理数量

					map.put("yingChuLi", yingChuLi);
					map.put("yiChuLi", yiChuLi);
					map.put("weiChuLi", weiChuLi);
				}else{
					map.put("yingChuLi", 0);	//应处理数量
					map.put("yiChuLi", 0);	//已处理数量
					map.put("weiChuLi", 0);	//未处理数量
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
	/**
	 * 获取两周内已收样未处理样品数量
	 * @return
	 */
	@RequestMapping("/getUntreatedNumber")
	public Integer getUntreatedNumber(){
		int number = 0;
		String sql = "SELECT COUNT(1)  " +
				"FROM tb_sampling_detail_code tsdc  " +
				" LEFT JOIN data_check_recording dcr ON dcr.sampling_detail_id = tsdc.sampling_detail_id " +
				"WHERE tsdc.update_date >= SUBDATE(CURRENT_DATE(), 14) " +
				" AND (tsdc.tube_code1 IS NULL OR tsdc.tube_code1 = '') " +
				" AND dcr.id IS NULL";
		number = jdbcTemplate.queryForObject(sql, Integer.class);
		return number;
	}

	/**
	 * 前处理-根据样品条码获取样品信息
	 * @param barcode
	 * @return
	 */
	@RequestMapping("/queryByBarCode")
	public AjaxJson queryByBarCode(String barcode){
		AjaxJson jsonObj = new AjaxJson();
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			//获取样品条码信息
			List<TbSamplingDetail> samplingDetails = samplingDetailService.queryByBarCode(barcode);
			if (samplingDetails != null && samplingDetails.size()>0){
				TbSampling tbSampling = tbSamplingService.selectById(samplingDetails.get(0).getSamplingId());
				if(samplingDetails.get(0).getPrintCodeNum()==0){
					jsonObj.setSuccess(false);
					jsonObj.setMsg("数据查询失败，请先进行订单分拣");
					return jsonObj;
				}
				map.put("tbSampling",tbSampling);
				map.put("samplingDetails",samplingDetails);
			}
			jsonObj.setObj(map);
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("读取失败");
		}
		return jsonObj;
	}

	/**
	 * 校验试管码是否有效
	 * 试管码有效期：扫描后30天内
	 * @param tubecode
	 * @return
	 */
	@RequestMapping("/queryByTubeCode")
	public AjaxJson queryByTubeCode(String tubecode, HttpServletRequest request){
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<TbSamplingDetailCode> samplingDetailCodes = samplingDetailCodeService.queryByTubeCode(tubecode);
			jsonObj.setObj(samplingDetailCodes);
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("读取失败");
		}
		logUtil.saveOperatorLog((short)0, ModularConstant.OPERATION_MODULE_PRETREAMENT, OrderController.class.toString(), "queryByTubeCode", "根据有效试管码获取样品条码信息", jsonObj.isSuccess(),jsonObj.getMsg(), request);
		return jsonObj;
	}


	/**
	 * 保存
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public AjaxJson save(TbSamplingDetailCodeModel model, HttpServletRequest request){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//首先判断是否进行订单分拣
			int result=samplingDetailCodeService.bulkUpdateTubeCode(model.getSamplingDetailCodes());
			if(result==0){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("前处理失败！");
			}
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败，请联系工作人员。");
		}
		logUtil.saveOperatorLog((short)0, ModularConstant.OPERATION_MODULE_PRETREAMENT, OrderController.class.toString(), "save", "前处理完成", jsonObject.isSuccess(), jsonObject.getMsg(), request);
		return jsonObject;
	}


	/**
	 * 条码信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/codeInfo")
	public ModelAndView codeInfo(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sampleBarCode", sampleBarCode);
		map.put("tubeBarCode", tubeBarCode);
		return new ModelAndView("/pretreatment_new/codeInfo",map);
	}

	/**
	 * 获取条码信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/datagrid")
	public AjaxJson datagrid(TbSamplingDetailCodeModel model, Page page, String code){
		AjaxJson jsonObj = new AjaxJson();
		try {
			if (StringUtil.isNotEmpty(model.getSampleCode()) || StringUtil.isNotEmpty(model.getTubeCode())){

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				Calendar calendar = Calendar.getInstance();
				calendar.add(Calendar.DAY_OF_MONTH, -tubeCodeValidity);

				HashMap map = new HashMap();
				map.put("validityTime", sdf.format(calendar.getTime()));

				page.setDateMap(map);
				page = samplingDetailCodeService.loadDatagrid(page, model, TbSamplingDetailCodeMapper.class, "loadDatagridCodeInfo", "getRowTotalCodeInfo");
			}
			jsonObj.setObj(page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}


}
