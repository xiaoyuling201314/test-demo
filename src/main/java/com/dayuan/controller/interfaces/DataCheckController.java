package com.dayuan.controller.interfaces;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BaseDevice;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.data.BaseDeviceService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author lwr
 * @date 2017年9月14日
 */
@Controller
@RequestMapping("/interfaces/dataChecking")
public class DataCheckController extends BaseInterfaceController{

	private final Logger log = Logger.getLogger(DataCheckController.class);
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private DataCheckRecordingService dataCheckRecordingService;
	@Autowired
	private BaseDeviceService baseDeviceService;
	@Autowired
	private BaseLedgerStockService stockService;
	
	/**
	 * 检测结果上传
	 * @param userToken 	 用户token
	 * @param result 传输的json数据
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadData", method = RequestMethod.POST)
	public AjaxJson uploadDataCheck(HttpServletRequest request,HttpServletResponse response,String userToken,
			@RequestParam(required = true, defaultValue = "A") String dataSource, String result){
		
		AjaxJson aj = new AjaxJson();

		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(result, WebConstant.INTERFACE_CODE1, "参数result不能为空");

			DataCheckRecording bean= JSONObject.parseObject(result,DataCheckRecording.class);
			required(bean, WebConstant.INTERFACE_CODE15, "参数result格式不正确");
			
			required(bean.getFoodId(), WebConstant.INTERFACE_CODE1, "参数foodId不能为空");
			required(bean.getFoodName(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
			required(bean.getItemId(), WebConstant.INTERFACE_CODE1, "参数itemId不能为空");
			required(bean.getItemName(), WebConstant.INTERFACE_CODE1, "参数itemName不能为空");
			required(bean.getCheckResult(), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
			required(bean.getConclusion(), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
			if(!"合格".equals(bean.getConclusion()) && !"不合格".equals(bean.getConclusion())) {
				throw new MyException("参数conclusion错误，只能是合格或不合格","参数conclusion错误，只能是合格或不合格",WebConstant.INTERFACE_CODE2);
			}

//			required(bean.getDeviceId(), WebConstant.INTERFACE_CODE1, "参数deviceId不能为空");
			required(bean.getDataSource(), WebConstant.INTERFACE_CODE1, "参数dataSource不能为空");
			required(bean.getDepartId(), WebConstant.INTERFACE_CODE1, "参数departId不能为空");
			required(bean.getDepartName(), WebConstant.INTERFACE_CODE1, "参数departName不能为空");
			required(bean.getPointId(), WebConstant.INTERFACE_CODE1, "参数pointId不能为空");
			required(bean.getPointName(), WebConstant.INTERFACE_CODE1, "参数pointName不能为空");
//			required(bean.getDataType(), WebConstant.INTERFACE_CODE1, "参数dataType不能为空");
			

			
//			//样品来源标识为空，默认为抽样单检测结果
//			if(bean.getDataType() == null) {
//				bean.setDataType((short) 0);
//			}
//
//			//送样单检测数据不验证市场ID、名称
//			if(bean.getDataType() == 0) {
//				required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//				required(bean.getRegName(), WebConstant.INTERFACE_CODE1, "参数regName不能为空");
//			}
//
//			//第三方平台上传标识
//			if(StringUtil.isEmpty(bean.getParam2())) {
//				bean.setParam2("0");
//			}
			
			int cMinute = 30;	//上传数据检测时间可大于当前时间最大时间（分钟）限制
			if(null ==  bean.getCheckDate()){
				//检测时间不能为空
				throw new MyException("参数checkDate不能为空", "参数checkDate不能为空", WebConstant.INTERFACE_CODE1);
				
			}else if(System.currentTimeMillis() < (bean.getCheckDate().getTime() - cMinute*60*1000)){
				//检测时间大于最大时间限制
				throw new MyException("参数checkDate不正确", "参数checkDate不正确", "0X00009");
			}

			//数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
			int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
			if (spotcheck == 1) {
				required(bean.getSamplingDetailId(), WebConstant.INTERFACE_CODE1, "禁止上传非抽样检测数据");

			} else if (spotcheck == -1) {
				aj.setSuccess(false);
				aj.setResultCode(WebConstant.INTERFACE_CODE14);
				aj.setMsg("上传失败，请联系管理员");
				return aj;
			}
			
			//add by xiaoyuling 2017-10-30 start 根据仪器唯一标识查询仪器信息
			if(StringUtil.isNotEmpty(bean.getDeviceId())) {
				BaseDevice device=baseDeviceService.queryBySerialNumber(bean.getDeviceId());
				if(device!=null){
					bean.setDeviceId(device.getId());
					bean.setDeviceName(device.getDeviceName());
				}
			}

			//检测人员
			if (null == bean.getCheckUsername() || "".equals(bean.getCheckUsername().trim())) {
				bean.setCheckUserid(user.getId());
				bean.setCheckUsername(user.getRealname());
			}
			
			//新增/重传检测数据
			dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);

			//返回值提示 20220525
			aj.setMsg("上传成功");
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			log.error("*****上传检测数据失败，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";result:"+result);
			if (e.getMessage().contains("reload_id")) {
				setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "上传失败，ID重复");
			} else {
				setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
			}
		}

		return aj;
		
	}
	
	/**
	 * 下载检测数据
	 * @param userToken 	 用户token
	 * @param lastUpdateTime 最后更新时间
	 * @param pageNumber 页码数
	 * @param serialNumber 仪器唯一标识(仪器下载时为必填项)
	 * @param regName 	监管对象名称
	 * @param regUserName 	档口编号
	 * @param foodName 	样品名称
	 * @param itemName 	检测项目名称
	 * @param conclusion 	检测结果(合格/不合格)
	 * @param dataType 	数据类型(null:全部数据，0:抽样单检测数据，1:送样单检测数据)
	 * @param checkDateStart 	开始时间（例：2000-01-01 00:00:00；checkDateStart非空，lastUpdateTime失效）
	 * @param checkDateEnd 		结束时间（例：2000-01-02 23:59:59；checkDateEnd非空，lastUpdateTime失效）
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/downloadData", method = RequestMethod.POST)
	public AjaxJson downloaddataCheck(HttpServletRequest request, String userToken, 
			@RequestParam(required=false,defaultValue="1") String pageNumber, 
			@RequestParam(required = false, defaultValue = "50") String recordNumber,
			@RequestParam(required = false, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime, 
			String serialNumber, String regName, String regUserName, String foodName, String itemName, 
			String conclusion, Integer dataType, String checkDateStart, String checkDateEnd){

		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append(" select dcr.rid id, "	//用id返回rid
					+ " dcr.check_accord, dcr.limit_value, dcr.check_result, dcr.check_unit, dcr.conclusion, dcr.check_date, dcr.check_code,"
					+ " dcr.check_username, dcr.auditor_name, dcr.upload_name,dcr.upload_date, dcr.task_name, dcr.depart_id, dcr.depart_name, dcr.device_model,"
					+ " dcr.device_method, dcr.device_company, dcr.data_source, dcr.point_id, dcr.item_id, dcr.item_name, dcr.food_name, dcr.point_name, dcr.task_id,"
					+ " dcr.sampling_id,dcr.sampling_detail_id,dcr.food_type_id, dcr.food_type_name,dcr.food_id,dcr.reg_id,dcr.reg_name,dcr.reg_user_id,dcr.reg_user_name,"
					+ " dcr.point_id, dcr.check_userid,dcr.auditor_id,dcr.auditor_name,dcr.upload_id, dcr.check_accord_id,dcr.check_accord,dcr.device_id,dcr.device_name,"
					+ " dcr.reload_flag,dcr.status_falg,dcr.create_by,dcr.create_date, dcr.update_by,dcr.update_date,dcr.remark,dcr.param1 param1,dcr.param2 param2,dcr.data_type,"
					
					//接口不提供监管对象和经营户信息，改为APP查询本地数据 --2019-03-06
//					+ " brb.ope_shop_name ope_shop_name,brb.ope_shop_code ope_shop_code,"
//					+ " brb.ope_name as reg_link_person,"	//用reg_link_person返回经营者名称
//					+ " brb.ope_phone ope_phone,"
//					
//					+ " bro.link_phone reg_link_phone,"
//					+ " bro.reg_address param3,"	//用param3返回监管对象地址
					
					+ " tbs.reg_licence,tbs.sampling_no,tbs.sampling_date,"
					+ " tbsd.sample_number,tbsd.purchase_amount,tbsd.purchase_date,tbsd.origin,tbsd.supplier,"
					+ " tbsd.supplier_address,tbsd.supplier_phone,tbsd.supplier_person,tbsd.batch_number, tbsd.sample_code");

			sbuffer.append(" FROM (SELECT * FROM data_check_recording WHERE delete_flag = 0 AND param7 = 1 ");



			if(null != user.getRegId()){
				//根据用户所属监管对象下载检测结果
				sbuffer.append(" AND depart_id= "+ user.getDepartId() +" AND reg_id = "+user.getRegId()+" ");

			}else if(null != user.getPointId()){
				//根据用户所属检测点下载检测结果
				sbuffer.append(" AND depart_id= "+ user.getDepartId() +" AND point_id = "+user.getPointId()+" ");

			}else {
				//根据用户所属检测机构下载检测结果
				sbuffer.append(" AND depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
			}


			if (StringUtils.isNotEmpty(serialNumber)) {
				sbuffer.append(" and device_id = '"+serialNumber+"' ");
			}

			//高级搜索
			if (StringUtils.isNotEmpty(regName)) {
				sbuffer.append(" and reg_name like concat('%','"+regName+"','%') ");
			}
			if (StringUtils.isNotEmpty(regUserName)) {
				sbuffer.append(" and reg_user_name like concat('%','"+regUserName+"','%') ");
			}
			if (StringUtils.isNotEmpty(foodName)) {
				sbuffer.append(" and food_name like concat('%','"+foodName+"','%') ");
			}
			if (StringUtils.isNotEmpty(itemName)) {
				sbuffer.append(" and item_name like concat('%','"+itemName+"','%') ");
			}
			if (StringUtils.isNotEmpty(conclusion)) {
				sbuffer.append(" and conclusion = '"+conclusion+"' ");
			}
			if(null != dataType) {
				sbuffer.append(" and data_type = "+dataType+" ");
			}

			int qTimeType = 0; // 查询条件： 0：最后更新时间；1：检测时间
			//开始检测时间
			if(StringUtil.isNotEmpty(checkDateStart)) {
				checkTime(checkDateStart, WebConstant.INTERFACE_CODE3, "参数checkDateStart格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
				sbuffer.append(" and check_date >= '"+checkDateStart+"' ");
				qTimeType= 1;
			}
			//结束检测时间
			if(StringUtil.isNotEmpty(checkDateEnd)) {
				checkTime(checkDateEnd, WebConstant.INTERFACE_CODE3, "参数checkDateEnd格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
				sbuffer.append(" and check_date <= '"+checkDateEnd+"' ");
				qTimeType= 1;
			}
			//最后更新时间
			if(qTimeType == 0) {
				sbuffer.append(" and check_date >= '"+lastUpdateTime+"' ");
			}

			sbuffer.append(" order by check_date desc ");

			//页码
			int pNum = 1;
			if(StringUtil.isNumeric(pageNumber)){
				pNum = Integer.parseInt(pageNumber);
			}

			//每页数量
			int rNum = 50;
			if(StringUtil.isNumeric(recordNumber)){
				rNum = Integer.parseInt(recordNumber);
			}

			if(pNum > 0 && rNum > 0){
				sbuffer.append(" LIMIT "+ ((pNum-1)*rNum < 0 ? 0 : (pNum-1)*rNum) +", "+rNum);
			}


			sbuffer.append(" ) dcr "
					+ " LEFT JOIN tb_sampling_detail tbsd ON dcr.sampling_detail_id = tbsd.id"
					+ " LEFT JOIN tb_sampling tbs ON tbs.id = tbsd.sampling_id ");
					
					//接口不提供监管对象和经营户信息，改为APP查询本地数据 --2019-03-06
//					+ " LEFT JOIN base_regulatory_object bro ON bro.id = dcr.reg_id "
//					+ " LEFT JOIN base_regulatory_business brb ON brb.id = dcr.reg_user_id "

			sbuffer.append(" order by dcr.check_date desc ");

			list = jdbcTemplate.queryForList(sbuffer.toString());
			map.put("result", list);
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	
	
	/**
	 * 获取经营户检测数据
	 * @param opeId 经营户ID
	 * @param checkDate 抽样时间
	 * @return
	 */
	@RequestMapping(value="/queryDataCheckByRegId")
	@ResponseBody
	public AjaxJson queryDataCheckByRegId(HttpServletRequest request, HttpServletResponse response, String opeId, String checkDate){

		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			required(opeId, WebConstant.INTERFACE_CODE1, "参数opeId不能为空");
			checkTime(checkDate, WebConstant.INTERFACE_CODE3, "参数checkDate格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			StringBuffer sbuffer = new StringBuffer();
			
			sbuffer.append(" SELECT " + 
					"	dcr.food_name AS foodName, dcr.item_name AS itemName, dcr.conclusion AS conclusion, dcr.reg_id AS regId, dcr.reg_user_id AS opeId, " + 
					"	tsd.batch_number AS batchNumer, tsd.purchase_date AS purchaseDate, tsd.purchase_amount AS purchaseAmount, tsd.origin AS origin, dcr.check_date  AS checkDate, " + 
					"	tsd.supplier AS supplier, tsd.supplier_address AS address, tsd.supplier_person AS persion, tsd.supplier_phone AS phone, " + 
					"	ts.sampling_date AS samplingDate " + 
					"FROM data_check_recording dcr " + 
					"LEFT JOIN	tb_sampling AS ts ON dcr.sampling_id = ts.id " + 
					"LEFT JOIN tb_sampling_detail AS tsd ON dcr.sampling_detail_id = tsd.id " + 
					"WHERE dcr.delete_flag = 0  AND dcr.param7 = 1 AND dcr.reg_user_id =? AND dcr.check_date >=? AND dcr.check_date <=? ");
			
			Map<String, Object> map = new HashMap<>();
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), opeId, checkDate+" 00:00:00", checkDate+" 23:59:59");
			
			String souce = WebConstant.res.getString("toSource");
			map.put("souce", souce);
			if(souce.equals("1")){//获取台账管理信息
				for (Map<String, Object> map1 : list) {
					
					String date=null;
					if(StringUtil.isNotEmpty(map1.get("samplingDate"))){
						date=DateUtil.formatDate((Timestamp) map1.get("samplingDate"), "yyyy-MM-dd");
					}else if(StringUtil.isNotEmpty(map1.get("checkDate"))){
						date=DateUtil.formatDate((Timestamp) map1.get("checkDate"), "yyyy-MM-dd");
					}else{
						date=DateUtil.formatDate(new Date(), "yyyy-MM-dd");
					}
					BaseLedgerStock ledgerStock = stockService.queryByBatchNumber((Integer)map1.get("regId"), (Integer)map1.get("opeId"), (String)map1.get("foodName"), (String)map1.get("batchNumer"),  date);//根据经营户查询溯源信息
					map1.put("ledgerStock", ledgerStock);
				}
			}
			
			map.put("recordings", list);
			aj.setObj(map);
			
		} catch (MyException e) {
			e.printStackTrace();
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			e.printStackTrace();
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 获取监管对象检测数据
	 * @param regId 监管对象ID
	 * @param checkDate 抽样时间
	 * @return
	 */
	@RequestMapping(value="/queryDataCheckByRegobjId")
	@ResponseBody
	public AjaxJson queryDataCheckByRegobjId(HttpServletRequest request, HttpServletResponse response, String regId, String checkDate,String endDate){
	
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			required(regId, WebConstant.INTERFACE_CODE1, "参数regId不能为空");
			checkTime(checkDate, WebConstant.INTERFACE_CODE3, "参数checkDate格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			StringBuffer sbuffer = new StringBuffer();
			
			sbuffer.append(" SELECT " + 
					"	dcr.food_name AS foodName, dcr.item_name AS itemName, dcr.conclusion AS conclusion, dcr.check_accord AS checkAccord, dcr.reg_id AS regId, dcr.reg_user_id AS opeId, dcr.reg_user_name AS opeShopCode," +
					"	tsd.batch_number AS batchNumer, tsd.purchase_date AS purchaseDate, tsd.purchase_amount AS purchaseAmount, tsd.origin AS origin, dcr.check_date AS checkDate, " + 
					"	tsd.supplier AS supplier, tsd.supplier_address AS address, tsd.supplier_person AS persion, tsd.supplier_phone AS phone, " + 
					"	ts.sampling_date AS samplingDate " + 
					"FROM data_check_recording dcr " + 
					"LEFT JOIN	tb_sampling AS ts ON dcr.sampling_id = ts.id " + 
					"LEFT JOIN tb_sampling_detail AS tsd ON dcr.sampling_detail_id = tsd.id " +
					"WHERE dcr.delete_flag = 0  AND dcr.param7 = 1 AND dcr.reg_id =? AND dcr.check_date >=? AND dcr.check_date <=? ");


			Map<String, Object> map = new HashMap<>();
			if(StringUtil.isEmpty(endDate)){
				endDate=checkDate;
			}
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {regId, checkDate+" 00:00:00", endDate+" 23:59:59"});
			
			String souce = WebConstant.res.getString("toSource");
			map.put("souce", souce);
			if(souce.equals("1")){//获取台账管理信息
				for (Map<String, Object> map1 : list) {
					
					String date=null;
					if(StringUtil.isNotEmpty(map1.get("samplingDate"))){
						date=DateUtil.formatDate((Timestamp) map1.get("samplingDate"), "yyyy-MM-dd");
					}else if(StringUtil.isNotEmpty(map1.get("checkDate"))){
						date=DateUtil.formatDate((Timestamp) map1.get("checkDate"), "yyyy-MM-dd");
					}else{
						date=DateUtil.formatDate(new Date(), "yyyy-MM-dd");
					}
					BaseLedgerStock ledgerStock = stockService.queryByBatchNumber((Integer)map1.get("regId"), (Integer)map1.get("opeId"), (String)map1.get("foodName"), (String)map1.get("batchNumer"),  date);//根据经营户查询溯源信息
					map1.put("ledgerStock", ledgerStock);
				}
			}
			
			map.put("recordings", list);
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
	}
	
	
	/**
	 * 获取当月检测数据数量（首页统计）
	 * @param userToken 用户token
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryCheckNumM", method = RequestMethod.POST)
	public AjaxJson queryCheckNumM(HttpServletRequest request, String userToken) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			aj.setObj(dataCheckRecordingService.queryCheckNumM(user));
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 获取近7天检测数据数量（首页统计）
	 * @param userToken 用户token
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryCheckNumW", method = RequestMethod.POST)
	public AjaxJson queryCheckNumW(HttpServletRequest request, String userToken) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证

			Calendar start = Calendar.getInstance();
			start.add(Calendar.DAY_OF_MONTH, -7);
			Calendar end = Calendar.getInstance();
			aj.setObj(dataCheckRecordingService.queryCheckNumW(user.getPointId(), user.getDepartId(),start.getTime(), end.getTime()));
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
}
