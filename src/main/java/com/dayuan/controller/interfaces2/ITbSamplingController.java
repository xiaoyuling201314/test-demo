package com.dayuan.controller.interfaces2;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.sampling.TbSamplingDetailRecevieService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 仪器检测任务接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iTbSampling")
public class ITbSamplingController extends BaseInterfaceController{
	
	@Autowired
	private TbSamplingDetailService tbSamplingDetailService;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TbSamplingDetailRecevieService tbSamplingDetailRecevieService;
	@Autowired
	private TSOperationService operationService;

	@Value("${resourcesUrl}")
	private String resourcesUrl;
	@Value("${samplingQr}")
	private String samplingQr;
	@Value("${opeSignaturePath}")
	private String opeSignaturePath;
	@Autowired
	private TSDepartService departService;

	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	/**
	 * 仪器查询本仪器的等待检测的任务数量
	 * @param userToken 用户token
	 * @param serialNumber 仪器唯一标识
	 * @return 返回检测任务数量
	 */
	@RequestMapping(value = "/samplingNumber", method = RequestMethod.POST)
	public InterfaceJson samplingNumber(HttpServletRequest request, String userToken,String serialNumber) {
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT count(1) from tb_sampling_detail d");
			sbuffer.append(" INNER JOIN tb_sampling s on d.sampling_id=s.id");
//			sbuffer.append(" LEFT JOIN tb_task_detail td on d.param2=td.id");
//			sbuffer.append(" LEFT JOIN tb_task t on t.id=s.task_id");
			sbuffer.append(" where d.status=0 and s.delete_flag=0 and d.recevie_device=?");
			int count= jdbcTemplate.queryForObject(sbuffer.toString(),Integer.class, new Object[]{serialNumber});
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("count", count);
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 下载检测任务
	 * @param userToken 	 用户token
	 * @param serialNumber	仪器唯一标识
	 * @param detailId		样品ID
	 * @param detailCode		样品编码
	 * @param enforce		强制下载(0:非强制下载；1:强制下载)
	 * @param pageNumber 页码数
	 * @param recordNumber 分页每页记录数量
	 * @return
	 */
	@RequestMapping(value = "/downloadCTasks", method = RequestMethod.POST)
	public InterfaceJson downloadCTasks(HttpServletRequest request, String userToken, String serialNumber, String detailId, String detailCode, @RequestParam(defaultValue = "0")String enforce,
			@RequestParam(required = true, defaultValue = "0") String pageNumber, @RequestParam(required = true, defaultValue = "50") String recordNumber){
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");

			if(StringUtil.isEmpty(detailId) && StringUtil.isEmpty(detailCode)) {		//仪器下载检测任务
				
				StringBuffer sbuffer = new StringBuffer();
				sbuffer.append("SELECT " + 
						"	tsd.id,	tsd.sampling_id, ts.sampling_date, tsd.sample_code, tsd.food_id, " + 
						"	tsd.food_name, tsd.item_id, tsd.item_name, tsd.purchase_date, " + 
						"	tsd.remark, tsd.param2 td_id, " + 
						"	ts.reg_id AS s_reg_id, ts.reg_name AS s_reg_name, ts.ope_id AS s_ope_id, " + 
						"	ts.ope_shop_code AS s_ope_shop_code, ts.ope_shop_name AS s_ope_shop_name, " + 
						"	tt.id AS t_id, tt.task_title AS t_task_title, " + 
						"	NULL param1, NULL param2, NULL param3 " + 
						"FROM " + 
						"	tb_sampling_detail tsd " + 
						"INNER JOIN tb_sampling ts ON tsd.sampling_id = ts.id " + 
						"LEFT JOIN tb_task tt ON tt.id = ts.task_id " + 
						"WHERE " + 
						"	ts.delete_flag = 0 AND tsd.status = 0  " + 
						"AND tsd.recevie_device = ? ");
				
				limit(sbuffer, pageNumber, recordNumber);
				
				 List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {serialNumber}); //检测任务
				aj.setObj(list);
				
			} else {		//扫码下载任务
				List<Map<String, Object>> list = null;		//检测任务
				StringBuffer sbuffer = new StringBuffer();
				sbuffer.append("SELECT    " + 
						"	tsd.id,	tsd.sampling_id, ts.sampling_date, tsd.sample_code, tsd.food_id,    " + 
						"	tsd.food_name, tsd.item_id, tsd.item_name, tsd.purchase_date,    " + 
						"	tsd.remark, tsd.param2 td_id,    " + 
						"	ts.reg_id AS s_reg_id, ts.reg_name AS s_reg_name, ts.ope_id AS s_ope_id,    " + 
						"	ts.ope_shop_code AS s_ope_shop_code, ts.ope_shop_name AS s_ope_shop_name,    " + 
						"	tt.id AS t_id, tt.task_title AS t_task_title,    " + 
						"	NULL param1, NULL param2, NULL param3, " + 
						"	ts.delete_flag, tsd.status, tsd.recevie_device " + 
						"FROM    " + 
						"	tb_sampling_detail tsd    " + 
						"INNER JOIN tb_sampling ts ON tsd.sampling_id = ts.id    " + 
						"LEFT JOIN tb_task tt ON tt.id = ts.task_id    " + 
						"WHERE  1=1 ");
				
				if(StringUtil.isNotEmpty(detailId)) {
					sbuffer.append("	AND tsd.id = ?   ");
					list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {detailId});
					
				}else {
					sbuffer.append("	AND tsd.sample_code = ?   ");
					list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {detailCode});
				}
				
				Map<String, Object> map = null;	//检测任务
				if(list !=null && list.size()>0) {
					map = list.get(0);
				}
				
				if(map == null || 1 == (Integer)map.get("delete_flag")) {
					throw new MyException("样品不存在或已删除", "样品不存在或已删除", WebConstant.INTERFACE_CODE5);
				}
				
				if(1 == (Integer)map.get("status") && !"1".equals(enforce)) {	//已接受任务，非强制下载
					throw new MyException("检测任务已被仪器("+(String)map.get("recevie_device")+")接收", "检测任务已被仪器("+(String)map.get("recevie_device")+")接收", WebConstant.INTERFACE_CODE16);
				}
				
				
				//接收检测任务
				tbSamplingDetailRecevieService.receivingTask((Integer) map.get("id"), serialNumber);

				//清除非返回参数
				map.remove("delete_flag");
				map.remove("status");
				map.remove("recevie_device");
				
				aj.setObj(map);
			}
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}

	/**
	 * 仪器获取检测任务，增加新规的部分字段
	 * 2023/03/02
	 * @param userToken 	 用户token
	 * @param serialNumber	仪器唯一标识
	 * @param pageNumber 页码数
	 * @param recordNumber 分页每页记录数量
	 * @return
	 */
	@RequestMapping(value = "/getCheckTasks", method = RequestMethod.POST)
	public InterfaceJson getCheckTasks(String userToken, String serialNumber,
			@RequestParam(required = true, defaultValue = "0") String pageNumber, @RequestParam(required = true, defaultValue = "50") String recordNumber){
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证

			required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");

			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT  " +
					" tsd.id sdId, tsd.sample_code sampleCode, " +
					" ts.sampling_date samplingDate, " +
					" ts.sampling_username samplingUser,  " +
					" " +
					" ts.reg_id regId, ts.reg_name regName," +
					" ts.reg_link_person regUser, ts.reg_link_phone regUserPhone, " +
					" " +
					" ts.ope_id opeId, " +
					" ts.ope_shop_code opeCode, ts.ope_shop_name opeName, " +
					" ts.ope_name opeUser, ts.ope_phone opeUserPhone, " +
					" ts.ope_signature opeUserSign," +
					" " +
					" ts.place_x x, ts.place_y y, " +
					" " +
					" tsd.food_id foodId, tsd.food_name foodName, " +
					" tsd.item_id itemId, tsd.item_name itemName, " +
					" " +
					" tsd.sample_number sampleNumber, " +
					" tsd.purchase_amount purchaseAmount, tsd.purchase_date purchaseDate," +
					" " +
					" tsd.supplier, tsd.supplier_address supplierAddress, " +
					" tsd.supplier_person supplierUser, tsd.supplier_phone supplierUserPhone, " +
					" tsd.batch_number batchNumber, tsd.origin" +
					" " +
					"FROM " +
					" tb_sampling_detail tsd  " +
					"INNER JOIN tb_sampling ts ON tsd.sampling_id = ts.id " +
					"WHERE  " +
					" ts.delete_flag = 0 AND tsd.status = 0   " +
					"AND tsd.recevie_device = ? ");

			limit(sbuffer, pageNumber, recordNumber);

			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {serialNumber}); //检测任务
			aj.setObj(list);

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;

	}

	/**
	 * 对外-其他厂家仪器下载检测任务
	 * @param userToken 	 用户token
	 * @param length 	 时长	取值范围：1~12,默认为1。返回当前检测室N小时内的检测任务
	 * @return
	 */
	@RequestMapping(value = "/getCTask", method = RequestMethod.POST)
	public InterfaceJson getCTask(HttpServletRequest request, String userToken,@RequestParam(required = false, defaultValue = "1") int length){
		InterfaceJson aj = new InterfaceJson();
		try {
			//token验证
			TSUser user = tokenExpired(userToken);

			if (length < 1) {
				length=1;
			} else if (length > 12) {
				length=12;
			}


			Calendar c = Calendar.getInstance();
			String endTime = DateUtil.formatDate(c.getTime(),"yyyy-MM-dd HH:mm:ss");
			c.add(Calendar.HOUR_OF_DAY, -length);
			String startTime = DateUtil.formatDate(c.getTime(),"yyyy-MM-dd HH:mm:ss");

			if(user != null) {
				StringBuffer sbuffer = new StringBuffer();
				sbuffer.append("SELECT " +
						"	tsd.id,	tsd.sampling_id, ts.sampling_date, tsd.sample_code, " +
						"	tsd.food_id, tsd.food_name, tsd.item_id, tsd.item_name, " +
						"	ts.reg_id, ts.reg_name, ts.ope_id, ts.ope_shop_code " +
						"FROM " +
						"	tb_sampling ts " +
						"INNER JOIN tb_sampling_detail tsd ON tsd.sampling_id = ts.id " +
						"LEFT JOIN data_check_recording dcr ON tsd.id = dcr.sampling_detail_id " +
						"WHERE " +
						"	ts.delete_flag = 0 AND ts.point_id = ? AND ts.sampling_date BETWEEN ? AND ? " +
						"	AND tsd.status = 0 AND (tsd.recevie_device IS NULL OR tsd.recevie_device ='') " +
						"	AND dcr.rid IS NULL ");

				 List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {user.getPointId(), startTime, endTime}); //检测任务
				aj.setObj(list);
			}

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
	}

	/**
	 * APP下载抽样单、送样单
	 * @param userToken 	 用户token
	 * @param pageNumber 页码数
	 * @param recordNumber 分页每页记录数量
	 * @return
	 */
	@RequestMapping(value = "/downloadSampling", method = RequestMethod.POST)
	public InterfaceJson downloadSampling(HttpServletRequest request, String userToken,
			@RequestParam(required = true, defaultValue = "1") String pageNumber, 
			@RequestParam(required = true, defaultValue = "50") String recordNumber){
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " + 
					"	ts.id, ts.sampling_no, ts.sampling_date, ts.depart_id, ts.point_id, " + 
					"	ts.ope_id, ts.ope_name, ts.ope_phone, ts.ope_shop_code, ts.ope_shop_name, ts.qrcode, ts.ope_signature, " +
					"	ts.reg_id, ts.reg_name, ts.reg_licence, ts.reg_link_person, ts.reg_link_phone, ts.task_id, " + 
					"	ts.delete_flag, ts.personal, ts.place_x, ts.place_y, ts.param1, ts.param2, ts.param3, " + 
					"	(SELECT COUNT(1) FROM tb_sampling_detail tsd WHERE tsd.sampling_id = ts.id) total, " + 
					"	(SELECT COUNT(1) FROM data_check_recording dcr FORCE INDEX(idx_sampling_id) WHERE dcr.sampling_id = ts.id AND dcr.delete_flag = 0  AND dcr.param7 = 1) completionNum," +
					"	'' as ticket ");
			
			sbuffer.append(" FROM tb_sampling ts " + 
					"	WHERE ts.delete_flag = 0 ");
			
			if(null != user.getDepartId()){
				//根据用户所属检测机构下载抽样单
				sbuffer.append(" AND ts.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
			}
			if(null != user.getRegId()){
				//根据用户所属监管对象下载抽样单
				sbuffer.append(" AND ts.reg_id = "+user.getRegId()+" ");
				
			}else if(null != user.getPointId()){
				//根据用户所属检测点下载抽样单
				sbuffer.append(" AND ts.point_id = "+user.getPointId()+" ");
			}else if(null == user.getDepartId()){
				return setAjaxJson(aj, WebConstant.INTERFACE_CODE1, "用户所属机构不能为空，请检查用户完整性！");
			}else{
				//update by xiaoyl 2023/09/16 优化用户查询，提示查询效率
				//根据用户所属检测机构下载抽样单
				List<Integer> departIds=departService.querySonDeparts(user.getDepartId());
				if(departIds.size()>0) {
					sbuffer.append(" AND ts.depart_id IN ( ");
					for (Integer departId : departIds) {
						sbuffer.append( departId+",");
					}
					sbuffer.deleteCharAt(sbuffer.length()-1);
					sbuffer.append(" ) ");
				}
//				sbuffer.append(" AND ts.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
			}
			
			sbuffer.append(" ORDER BY ts.sampling_date DESC ");
			limit(sbuffer, pageNumber, recordNumber);
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString());

			if (list!=null && list.size()>0) {
				StringBuffer samplingIdsStr = new StringBuffer();
				for(int i=0;i<list.size();i++) {
					samplingIdsStr.append(list.get(i).get("id")).append(",");
				}
				samplingIdsStr.deleteCharAt(samplingIdsStr.length() - 1);

				//查询附件
				sbuffer.setLength(0);
				sbuffer.append(" select source_id, GROUP_CONCAT(CONCAT(?, file_path)) ticket from tb_file where delete_flag = 0 AND source_id IN (").append(samplingIdsStr.toString()).append(") and source_type = 'shoppingRec' GROUP BY source_id ");
				List<Map<String, Object>> files = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] { resourcesUrl});

				for(Map<String, Object> map1 : list) {
					//附件
					if (files!=null) {
						Iterator<Map<String, Object>> filesIt = files.iterator();
						while (filesIt.hasNext()) {
							Map<String, Object> filesMap = filesIt.next();
							if(map1.get("id").toString().equals(filesMap.get("source_id").toString())) {
								map1.put("ticket", filesMap.get("ticket"));
								filesIt.remove();
								break;
							}
						}
					}

					//修改抽样单二维码、经营户签名地址
					map1.put("qrcode", resourcesUrl + samplingQr + map1.get("qrcode"));
					map1.put("ope_signature", resourcesUrl + opeSignaturePath + map1.get("ope_signature"));
				}
			}
			
			aj.setObj(list);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 查看抽样单详情
	 * @param userToken 	 用户token
	 * @param samplingId	  抽样单ID
	 * @return
	 */
	@RequestMapping(value = "/samplingDetail", method = RequestMethod.POST)
	public InterfaceJson samplingDetail(HttpServletRequest request, String userToken, int samplingId){
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " + 
					"	id, sampling_no, sampling_date, " + 
					"	depart_id, point_id, task_id, " + 
					"	reg_id, reg_name, reg_licence, " + 
					"	reg_link_person, reg_link_phone, " + 
					"	ope_id, ope_shop_code, ope_shop_name, " + 
					"	ope_name, ope_phone, ope_signature, qrcode, " + 
					"	personal, param1, param2, param3 " + 
					"FROM " + 
					"	tb_sampling WHERE id = ? ");
			List<Map<String, Object>> samplingList = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {samplingId});
			Map<String, Object> sampling = null;
			if(samplingList!=null && samplingList.size()>0) {
				sampling = samplingList.get(0);
			}else {
				throw new MyException("抽样单不存在", "抽样单不存在", WebConstant.INTERFACE_CODE5);
			}
			
			//修改抽样单二维码、经营户签名地址
			sampling.put("qrcode", WebConstant.res.getString("resourcesUrl") + WebConstant.res.getString("samplingQr") + sampling.get("qrcode"));
			sampling.put("ope_signature", WebConstant.res.getString("resourcesUrl") + WebConstant.res.getString("opeSignaturePath") + sampling.get("ope_signature"));
			
			sbuffer.setLength(0);
			sbuffer.append("SELECT " + 
					"	id d_id, sample_code d_sample_code, food_id d_food_id, food_name d_food_name, " + 
					"	sample_number d_sample_number, purchase_amount d_purchase_amount, sample_date d_sample_date, " + 
					"	purchase_date d_purchase_date, item_id d_item_id, item_name d_item_name, origin d_origin, " + 
					"	supplier d_supplier, supplier_address d_supplier_address, supplier_person d_supplier_person, " + 
					"	supplier_phone d_supplier_phone, batch_number d_batch_number, status d_status, " + 
					"	recevie_device d_recevie_device, update_date d_update_date, " + 
					"	remark d_remark, param1 d_param1, param2 d_param2, param3 d_param3 " + 
					"FROM " + 
					"	tb_sampling_detail " + 
					"WHERE " + 
					"	sampling_id = ? ");
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {samplingId});
			
			for (Map<String, Object> sd : list) {
				sd.put("d_sampling_id", sampling.get("id"));	//抽样单ID
				sd.put("d_sampling_aid", sampling.get("param2"));	//抽样单APP-ID
			}
			
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("sampling", sampling);
			result.put("details", list);
			
			aj.setObj(result);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 仪器更新仪器接收检测任务的状态
	 * @param userToken
	 * @param sdId 抽样单明细ID
	 * @param serialNumber 设备唯一标识
	 * @param recevieStatus 接收状态：0未接收，1接收，2拒绝
	 * @return
	 */
	@RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
	public InterfaceJson updateStatus(HttpServletRequest request, String userToken, Integer sdId, String serialNumber, Short recevieStatus) {
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(sdId, WebConstant.INTERFACE_CODE1, "参数sdId不能为空");
			required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
			required(recevieStatus, WebConstant.INTERFACE_CODE1, "参数recevieStatus不能为空");
			
			
			boolean resend = true;
			for(String pperationCode : user.getOperationCode()) {
				if("321-13".equals(pperationCode) ) {//禁止自动分配检测任务
					resend = false;
					break;
				}
			}
			
			//接收/拒绝检测任务
			tbSamplingDetailRecevieService.updateStatus(user, sdId, serialNumber, recevieStatus, resend);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}

	/**
	 * 小程序根据搜索内容实时查询抽样单
	 * yxp
	 * 2021/4/20
	 * @param userToken 	 用户token
	 * @param pageNumber 页码数
	 * @param recordNumber 分页每页记录数量
	 * @param searchValue   搜索的值
	 * @return
	 */
	@RequestMapping(value = "/sampleListSearch", method = RequestMethod.POST)
	public InterfaceJson sampleListSearch(HttpServletRequest request, String userToken,String searchValue,
										  @RequestParam(required = true, defaultValue = "1") String pageNumber,
										  @RequestParam(required = true, defaultValue = "50") String recordNumber){
		InterfaceJson aj = new InterfaceJson();

		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证

			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " +
					"	ts.id, ts.sampling_no, ts.sampling_date, ts.depart_id, ts.point_id, " +
					"	ts.ope_id, ts.ope_name, ts.ope_phone, ts.ope_shop_code, ts.ope_shop_name, ts.qrcode, ts.ope_signature, " +
					"	ts.reg_id, ts.reg_name, ts.reg_licence, ts.reg_link_person, ts.reg_link_phone, ts.task_id, " +
					"	ts.delete_flag, ts.personal, ts.place_x, ts.place_y, ts.param1, ts.param2, ts.param3, " +
					"	(SELECT COUNT(1) FROM tb_sampling_detail tsd WHERE tsd.sampling_id = ts.id) total, " +
					"	(SELECT COUNT(1) FROM data_check_recording dcr FORCE INDEX(idx_sampling_id) WHERE dcr.sampling_id = ts.id AND dcr.delete_flag = 0  and dcr.param7 = 1) completionNum," +
					"	'' as ticket ");

			sbuffer.append(" FROM tb_sampling ts " +
					"	WHERE ts.delete_flag = 0 ");
//			sbuffer.append(" AND ")
			if(null != user.getDepartId()){
				//根据用户所属检测机构下载抽样单
				sbuffer.append(" AND ts.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
			}
			if(null != user.getRegId()){
				//根据用户所属监管对象下载抽样单
				sbuffer.append(" AND ts.reg_id = "+user.getRegId()+" ");

			}else if(null != user.getPointId()){
				//根据用户所属检测点下载抽样单
				sbuffer.append(" AND ts.point_id = "+user.getPointId()+" ");
			}

			if(null != searchValue){
//				sbuffer.append(" AND (ts.reg_name like \"%").append(searchValue).append("%\" or ts.sampling_no like \"%")
//				.append(searchValue).append("%\") ");
				sbuffer.append(" AND (ts.reg_name like \"%" + searchValue + "%\" or ts.sampling_no like \"%" + searchValue + "%\") ");
			}

			sbuffer.append(" ORDER BY ts.sampling_date DESC ");
			limit(sbuffer, pageNumber, recordNumber);

			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString());

			if (list!=null && list.size()>0) {
				StringBuffer samplingIdsStr = new StringBuffer();
				for(int i=0;i<list.size();i++) {
					samplingIdsStr.append(list.get(i).get("id")).append(",");
				}
				samplingIdsStr.deleteCharAt(samplingIdsStr.length() - 1);

				//查询附件
				sbuffer.setLength(0);
				sbuffer.append(" select source_id, GROUP_CONCAT(CONCAT(?, file_path)) ticket from tb_file where delete_flag = 0 AND source_id IN (?) and source_type = 'shoppingRec' ");
				List<Map<String, Object>> files = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] { resourcesUrl, samplingIdsStr.toString()});

				for(Map<String, Object> map1 : list) {
					//附件
					if (files!=null) {
						Iterator<Map<String, Object>> filesIt = files.iterator();
						while (filesIt.hasNext()) {
							Map<String, Object> filesMap = filesIt.next();
							if(map1.get("id").equals(filesMap.get("source_id"))) {
								map1.put("ticket", filesMap.get("ticket"));
								filesIt.remove();
								break;
							}
						}
					}

					//修改抽样单二维码、经营户签名地址
					map1.put("qrcode", resourcesUrl + samplingQr + map1.get("qrcode"));
					map1.put("ope_signature", resourcesUrl + opeSignaturePath + map1.get("ope_signature"));
				}
			}

			aj.setObj(list);

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;

	}
}
