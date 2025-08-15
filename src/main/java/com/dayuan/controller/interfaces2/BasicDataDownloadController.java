package com.dayuan.controller.interfaces2;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.serializer.ValueFilter;
import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * 基础数据下载接口
 * @author LuoYX
 * @date 2018年7月3日
 */
@RestController
@RequestMapping("/iDownload")
public class BasicDataDownloadController extends BaseInterfaceController {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BasePointService pointService;
	@Autowired
	private BaseFoodTypeService foodTypeService;
	
	@Value("${resources}")
	private String resources;
	@Value("${basicDataTemp}")
	private String basicDataTemp;
	@Value("${zipPassword}")
	private String zipPassword;

	@Value("${ftpKey}")
	private String ftpKey;
	@Value("${ftpDownload}")
	private String ftpDownload;
	@Value("${standardPath}")
	private String standardPath;
	@Value("${lawPath}")
	private String lawPath;
	@Value("${systemUrl}")
	private String systemUrl;

	/**
	 * 下载基础数据
	 * @author LuoYX
	 * @date 2018年7月3日
	 * @param request
	 * @param response
	 * @param userToken
	 * @param type	接口类型
	 * @param serialNumber
	 * @param lastUpdateTime
	 * @param pageNumber
	 * @param recordNumber
	 * @param outside 内部接口标识：0_对外，1_内部
	 * @param id
	 * @return
	 */
	@RequestMapping("/getBasicData")
	public InterfaceJson getBasicData(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userToken",required=false)String userToken, 
			@RequestParam(value="type",required=false)String type, @RequestParam(value="serialNumber",required=false)String serialNumber, 
			@RequestParam(value="lastUpdateTime",defaultValue="2000-01-01 00:00:01")String lastUpdateTime, 
			@RequestParam(value="pageNumber",defaultValue="0",required=false)String pageNumber, 
			@RequestParam(value="recordNumber",defaultValue="50",required=false)String recordNumber, 
			@RequestParam(value="outside",defaultValue="0",required=false)Integer outside,
			@RequestParam(value="machineCode",required=false)String machineCode,
			@RequestParam(value="hardwareVersion",required=false)String hardwareVersion,
			@RequestParam(value="id",required=false)String id) {
		
		//跨域
		response.setHeader("Access-Control-Allow-Origin", "*");
		
		InterfaceJson json = new InterfaceJson();
		try {
			TSUser user = tokenExpired(userToken);
			required(type, WebConstant.INTERFACE_CODE1, "参数type不能为空");
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");

			//对外接口
			if (outside == 0) {
				//只允许分页下载
				if (Integer.parseInt(pageNumber) < 1) {
					pageNumber = "1";
				}
				//每页数量最大500
				if (Integer.parseInt(recordNumber) < 1 || Integer.parseInt(recordNumber) > 500) {
					recordNumber = "50";
				}
			}
			
			List<Map<String, Object>> list = null;
			Map<String, Object> map = new HashMap<>();
			StringBuffer sbuffer = new StringBuffer();
				switch (type) {
				case "food"://下载食品信息；根据update_date进行增量更新
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT id,food_name,food_name_en,food_name_other,parent_id,cimonitor_level, "
								+ " sorting,checked,isFood,delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " FROM base_food_type where update_date>=?");
					}else{
						//外部接口，未审核状态食品种类当作已删除数据
						sbuffer.append("SELECT id,food_name,food_name_other,parent_id, "
								+ " isFood,IF((checked = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " FROM base_food_type where update_date>=?");
					}

					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 and checked=1 ");
					}

					//过滤二级"其他类"下数据
					sbuffer.append(" AND food_code NOT LIKE ( " +
							"  IF( " +
							"   (SELECT food_code FROM base_food_type WHERE delete_flag = 0 AND food_code LIKE '________' AND food_name = '其他类') IS NULL,  " +
							"   '9999%',  " +
							"   (SELECT CONCAT( food_code, '%' ) FROM base_food_type WHERE delete_flag = 0 AND food_code LIKE '________' AND food_name = '其他类') " +
							"  ) " +
							" ) ");

					//获取指定种类下的样品
					if(StringUtil.isNotEmpty(id)) {
						BaseFoodType f = foodTypeService.getById(Integer.valueOf(id));
						if (f != null) {
							//食品种类
							if (f.getIsfood() == 0) {
								sbuffer.append(" AND food_code LIKE (SELECT CONCAT(food_code,'%') FROM base_food_type WHERE id = "+id+") ");

							//食品名称
							} else if (f.getIsfood() == 1) {
								sbuffer.append(" AND id = "+id+" ");
							}
						}
					}
					
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("food", list);
					break;
				case "standard"://下载检测标准
					sbuffer.setLength(0);
					if(outside==1){
//						String ftpDownload0 = CodecUtils.aesDecrypt(ftpDownload, ftpKey);
//						sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
//								+ " CONCAT('"+ftpDownload0+standardPath+"/',url_path) url_path,use_status,std_id,sorting,remark,delete_flag,NULL param1,NULL param2,NULL param3 "
//								+ " from base_standard where update_date>=?");

						sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
								+ " CONCAT('"+systemUrl+"data/standard/download?id=', id) url_path,use_status,std_id,sorting,remark,delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " from base_standard where update_date>=?");
					}else{
						//外部接口，未使用状态检测标准当作已删除数据
						sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
								+ " IF((use_status = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " from base_standard where update_date>=?");
					}
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("standard", list);
					break;
				case "item"://下载检测项目
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT i.id,detect_item_name,detect_item_typeid,standard_id,detect_sign,detect_value, ");
						sbuffer.append("	detect_value_unit,checked,cimonitor_level,i.remark, " );
						sbuffer.append("	t.item_name item_type_name, t.sorting item_type_sorting, " );
						sbuffer.append("	i.delete_flag,NULL param1,NULL param2,NULL param3 ");
						sbuffer.append("FROM base_detect_item i "); 
						sbuffer.append("INNER JOIN base_item_type t ON i.detect_item_typeid=t.id ");
						sbuffer.append("where (i.update_date>=? or t.update_date>=?)");
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and i.delete_flag=0 and i.checked=1 and t.delete_flag=0 ");
						}
					}else{
						//外部接口，未审核状态检测项目当作已删除数据
						sbuffer.append("SELECT i.id, i.detect_item_name, i.detect_sign, i.detect_value, i.detect_value_unit, ");
						sbuffer.append("	bs.std_name standard_name, IF((i.checked = 0 OR i.delete_flag = 1), 1, 0) delete_flag, NULL param1,NULL param2,NULL param3 " );
						sbuffer.append("FROM base_detect_item i "); 
						sbuffer.append("LEFT JOIN base_standard bs ON i.detect_item_typeid = bs.id ");
						sbuffer.append("where (i.update_date>=? or bs.update_date>=?)");
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and i.delete_flag=0 and i.checked=1 ");
						}
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("detectItem", list);
					break;
				case "foodItem"://下载样品与关联的检测项目信息
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT " + 
								"	bfi.id, bfi.checked, " + 
								"	bft.id food_id, bft.food_name, " + 
								"	bdi.id item_id, bdi.detect_item_name item_name, " + 
								"	bs.id std_id, bs.std_name std_name, " + 
								"	IF(bfi.use_default=0, bdi.detect_sign, bfi.detect_sign) detect_sign, " + 
								"	IF(bfi.use_default=0, bdi.detect_value, bfi.detect_value) detect_value, " + 
								"	IF(bfi.use_default=0, bdi.detect_value_unit, bfi.detect_value_unit) detect_value_unit, " + 
								"	bfi.remark, " + 
								"	IF(bfi.delete_flag = 0 AND bft.delete_flag = 0 AND bdi.delete_flag = 0, 0, 1) delete_flag, " + 
								"	NULL param1, NULL param2, NULL param3 " + 
								"FROM base_food_item bfi " + 
								"INNER JOIN base_food_type bft ON bfi.food_id = bft.id " + 
								"INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " + 
								"LEFT JOIN base_standard bs ON bdi.standard_id = bs.id " + 
								"WHERE (bfi.update_date >=? OR bft.update_date >=? OR bdi.update_date >=?) ");
					}else{
						sbuffer.append("SELECT " + 
								"	bfi.id, " + 
								"	bft.id food_id, bft.food_name, " + 
								"	bdi.id item_id, bdi.detect_item_name item_name, " + 
								"	IF(bfi.delete_flag = 0 AND bft.delete_flag = 0 AND bdi.delete_flag = 0 AND bfi.checked = 1, 0, 1) delete_flag, " + 
								"	NULL param1, NULL param2, NULL param3 " + 
								"FROM base_food_item bfi " + 
								"INNER JOIN base_food_type bft ON bfi.food_id = bft.id " + 
								"INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " + 
								"WHERE (bfi.update_date >=? OR bft.update_date >=? OR bdi.update_date >=?) ");
					}
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" AND bfi.delete_flag=0 AND bfi.checked=1 AND bdi.delete_flag=0 AND bdi.checked=1 AND bft.delete_flag=0 AND bft.checked=1 ");
					}
					
					//获取指定样品与关联的检测项目信息
					if(StringUtil.isNotEmpty(id)) {
						BaseFoodType f = foodTypeService.getById(Integer.valueOf(id));
						if (f != null) {
							//食品种类
							if (f.getIsfood() == 0) {
								sbuffer.append(" AND bft.food_code LIKE (SELECT CONCAT(food_code,'%') FROM base_food_type WHERE id = "+id+") ");

								//食品名称
							} else if (f.getIsfood() == 1) {
								sbuffer.append(" AND bft.id = "+id+" ");
							}
						}
					}
					
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime, lastUpdateTime);
					map.put("foodItem", list);
					break;
				case "deviceSeries"://下载仪器系列
					sbuffer.setLength(0);
					sbuffer.append("select id, device_name, device_series, device_version, device_maker, "
							+ " description, concat('"+ WebConstant.res.getString("systemUrl") +"',file_path) file_path, remark, checked, delete_flag, param1, param2, param3 "
							+ " from base_device_type where type = 0 and update_date>=?");
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("deviceSeries", list);
					break;
				case "deviceItem"://下载仪器检测项目
					required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
					sbuffer.setLength(0);
					sbuffer.append("SELECT " + 
							"	p.id, p.device_type_id, p.item_id, " +
							"	bdi.detect_item_name item_name," +
							"	p.project_type, " +
							"	p.detect_method, p.detect_unit, p.operation_password, " + 
							"	p.food_code, p.invalid_value, p.check_hole1, " + 
							"	p.check_hole2, p.wavelength, p.pre_time, p.dec_time,  " + 
							"	p.stdA0, p.stdA1, p.stdA2, p.stdA3, " + 
							"	p.stdB0, p.stdB1, p.stdB2, p.stdB3, " + 
							"	p.stdA, p.stdB, p.national_stdmin, p.national_stdmax, " + 
							"	p.yin_min, p.yin_max, p.yang_min, p.yang_max, " + 
							"	p.yinT, p.yangT, p.absX, p.ctAbsX, p.division, " + 
							"	p.parameter, p.trailingEdgeC, p.trailingEdgeT, " + 
							"	p.suspiciousMin, p.suspiciousMax, " + 
							"	p.reserved1, p.reserved2, p.reserved3, " + 
							"	p.reserved4, p.reserved5, p.remark, p.delete_flag " + 
							"FROM base_device bd " +
							"	INNER JOIN base_device_parameter p ON bd.device_type_id = p.device_type_id" +
							"	INNER JOIN base_detect_item bdi ON p.item_id = bdi.id  " +
							"WHERE " +
							"	bd.delete_flag=0 AND bd.serial_number =? " +
							"	AND bdi.delete_flag=0" +
							"	AND p.delete_flag=0 " +
							"	AND p.update_date >=? ");
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and bd.delete_flag=0 and p.delete_flag=0 and bdi.delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), serialNumber,lastUpdateTime);
					map.put("deviceItem", list);
					break;
				case "laws"://下载法律法规
					sbuffer.setLength(0);
					if(outside==1){
//						String ftpDownload0 = CodecUtils.aesDecrypt(ftpDownload, ftpKey);
//						sbuffer.append("select id,law_name,law_type,law_unit,law_num,law_status,law_notes,rel_date,");
//						sbuffer.append("imp_date,failure_date,CONCAT('"+ftpDownload0+lawPath+"/',url_path) url_path,");
//						sbuffer.append("use_status,delete_flag,NULL param1,NULL param2,NULL param3 ");
//						sbuffer.append("from base_laws_regulations  where update_date>=? ");

						sbuffer.append("select id,law_name,law_type,law_unit,law_num,law_status,law_notes,rel_date,");
						sbuffer.append("imp_date,failure_date,CONCAT('"+systemUrl+"data/laws/download?id=', id) url_path,");
						sbuffer.append("use_status,delete_flag,NULL param1,NULL param2,NULL param3 ");
						sbuffer.append("from base_laws_regulations  where update_date>=? ");
					}else{
						//外部接口，未使用状态法律法规当作已删除数据
						sbuffer.append("select id,law_name,law_num,IF((use_status = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 ");
						sbuffer.append("from base_laws_regulations  where update_date>=? ");
					}
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("laws", list);
					break;

					//下载监管对象，只查询当前用户机构下的监管对象
				case "regulatory":
				case "REG":
					sbuffer.setLength(0);
					if ("REG".equals(type)) {
						//对外接口，返回数据齐全
						sbuffer.append("SELECT " +
								"	bro.id id, bro.reg_name reg_name, brt.reg_type reg_type, " +
								"	bro.credit_code credit_code, bro.legal_person legal_person, " +
								"	bro.link_user link_user, bro.link_phone link_phone, " +
								"	bro.reg_address reg_address, IF((bro.checked = 0 OR bro.delete_flag = 1), 1, 0) delete_flag, " +
								"	NULL param1, NULL param2, NULL param3 ");

					} else if(outside==1){
						//内部接口
						sbuffer.append("SELECT " + 
								"	bro.id id, bro.depart_id depart_id, bro.reg_name reg_name, " + 
								"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " + 
								"	bro.reg_address reg_address, bro.place_x place_x, bro.place_y place_y, bro.remark remark, bro.checked checked, " + 
								"	bro.delete_flag delete_flag, brt.show_business show_business, " + 
								"	NULL param1, NULL param2, NULL param3 ");
					}else{
						//外部接口，未审核状态监管对象当作已删除数据
						sbuffer.append("SELECT " + 
								"	bro.id id, bro.reg_name reg_name, " +
								"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " + 
								"	bro.reg_address reg_address, IF((bro.checked = 0 OR bro.delete_flag = 1), 1, 0) delete_flag, " + 
								"	NULL param1, NULL param2, NULL param3 ");
					}
					
					sbuffer.append("	FROM base_regulatory_object bro " +
							"	LEFT JOIN base_regulatory_type brt ON brt.id = bro.reg_type " +
							"	WHERE (bro.update_date>=? OR brt.update_date>=?) ");
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and bro.delete_flag=0 and brt.delete_flag=0 ");
					}
					//根据用户权限查询监管对象
					if(null != user.getRegId()){
						sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
					}else if(null != user.getDepartId()){

						BasePoint point = null;
						if (user.getPointId() != null) {
							point = pointService.queryById(user.getPointId());
						}
						if (point != null && !StringUtils.isBlank(point.getRegulatoryId())) {
							//企业检测室用户
							sbuffer.append(" AND bro.id = "+point.getRegulatoryId()+" ");

						} else {
							sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
						}
					}else {
						sbuffer.append(" AND 1=0 ");
					}
					
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("regulatory", list);
					break;

					//下载经营户，只查询当前用户机构下的经营户
				case "business":
				case "BUS":
					sbuffer.setLength(0);
					if ("BUS".equals(type)) {
						//对外接口，返回数据齐全
						sbuffer.append("SELECT " +
								"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " +
								"	brb.contacts, brb.ope_phone, brb.credit_code, " +
								"	brb.ope_name, CONCAT(brb.type,'') type, IF((brb.checked = 0 OR brb.delete_flag = 1), 1, 0) delete_flag, " +
								"	NULL param1, NULL param2, NULL param3 ");

					} else if(outside==1){
						sbuffer.append("SELECT " + 
								"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " + 
								"	brb.ope_name, brb.ope_phone, brb.credit_rating, " + 
								"	brb.monitoring_level, brb.remark, brb.checked, CONCAT(brb.type,'') type, " +
								"	brb.delete_flag, NULL param1, NULL param2, NULL param3 ");
					}else{
						//外部接口，未审核状态监管对象当作已删除数据
						sbuffer.append("SELECT " + 
								"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " + 
								"	brb.ope_name, CONCAT(brb.type,'') type, IF((brb.checked = 0 OR brb.delete_flag = 1), 1, 0) delete_flag, " +
								"	NULL param1, NULL param2, NULL param3 ");
					}
							
					sbuffer.append(" FROM base_regulatory_business brb INNER JOIN base_regulatory_object bro ON brb.reg_id = bro.id "
							+ " WHERE brb.update_date>=? ");

					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and brb.delete_flag=0 and bro.delete_flag=0 ");
					}
					//根据用户权限查询经营户
					if(null != user.getRegId()){
						sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
					}else if(null != user.getDepartId()){

						BasePoint point = null;
						if (user.getPointId() != null) {
							point = pointService.queryById(user.getPointId());
						}
						if (point != null && !StringUtils.isBlank(point.getRegulatoryId())) {
							//企业检测室用户
							sbuffer.append(" AND bro.id = "+point.getRegulatoryId()+" ");

						} else {
							sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
						}
					}else {
						sbuffer.append(" AND 1=0 ");
					}
					
					//获取指定监管对象下的经营户
					if(StringUtil.isNotEmpty(id)) {
						sbuffer.append(" AND bro.id = "+id+" ");
					}
					
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("business", list);
					break;
					
				default:
					throw new MyException("数据类型type不正确", "数据类型type不正确", WebConstant.INTERFACE_CODE4);
				}
				json.setObj(map);
				
		} catch (MyException e) {
			setAjaxJson(json, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(json, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}
		
		return json;
		
	}
	
	/**
	 * 下载基础数据(压缩文件)
	 * @author Dz
	 * 2019年2月25日 上午9:47:25
	 */
	@RequestMapping("/getBasicDataZip")
	public void getBasicDataZip(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userToken",required=false)String userToken,
			@RequestParam(value="type",required=false)String type, @RequestParam(value="serialNumber",required=false)String serialNumber, 
			@RequestParam(value="lastUpdateTime",defaultValue="2000-01-01 00:00:00")String lastUpdateTime,
			@RequestParam(value="recordNumber",defaultValue="500",required=false)String recordNumber, 
			@RequestParam(value="outside",defaultValue="0",required=false)Integer outside,
			@RequestParam(value="machineCode",required=false)String machineCode,
			@RequestParam(value="hardwareVersion",required=false)String hardwareVersion,
			@RequestParam(value="id",required=false)String id) {
		
		//跨域
		response.setHeader("Access-Control-Allow-Origin", "*");
		
		InterfaceJson json = new InterfaceJson();
		try {
			TSUser user = tokenExpired(userToken);
			required(type, WebConstant.INTERFACE_CODE1, "参数type不能为空");
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");

			//更新2018年的数据，当作重置数据
			Calendar c = Calendar.getInstance();
			c.set(2018, Calendar.FEBRUARY, 1, 0, 0, 0);
			if (DateUtil.parseDate(lastUpdateTime, "yyyy-MM-dd").getTime() <= c.getTime().getTime()) {
                lastUpdateTime = "2000-01-01 00:00:00";
            }

			//判断是否用旧压缩包
            String filename4 = "";
            String realPath4 = resources + basicDataTemp + "bak/" + type + "/" + outside + "/";	//临时文件夹目录
            File f4 = null;
            //查询数据的压缩包
            if (lastUpdateTime.contains("2000-01-01") && ("food".equals(type) || "standard".equals(type)
                    || "foodItem".equals(type) || "laws".equals(type) )) {
                ArrayList<File> bakfiles = DyFileUtil.getListFiles(realPath4);
                //最新压缩时间
                long lastfiletime1 = 0;
                if (bakfiles != null && bakfiles.size() > 0) {
                    for (File bakfile : bakfiles) {
                        String bakfilename1 = bakfile.getName();
                        long lastfiletime2 = Long.parseLong(bakfilename1.substring(0, bakfilename1.lastIndexOf(".")));
                        if (lastfiletime1 < lastfiletime2) {
                            if (lastfiletime1 != 0) {
                                //删除过期文件
                                DyFileUtil.deleteFolder(realPath4 + lastfiletime1 + ".zip");
                            }
                            lastfiletime1 = lastfiletime2;
                        }
                    }
                    filename4 = lastfiletime1 + ".zip";

                    //最后更新时间
                    String lut = DateUtil.formatDate(DateUtil.parseDate(lastfiletime1+"", "yyyyMMddHHmmss"), "yyyy-MM-dd HH:mm:ss");
                    //待更新数量
                    int upn = 0;
                    StringBuffer sbuffer1 = new StringBuffer();
                    switch (type) {
                        case "food":
                            sbuffer1.append("SELECT COUNT(1) " +
                                    "FROM base_food_type " +
                                    "WHERE update_date>=? ");

							//重置数据，不下载已删除数据
							if (lastUpdateTime.contains("2000-01-01")) {
								sbuffer1.append(" and delete_flag=0 and checked=1 ");
							}

							//过滤二级"其他类"下数据
							sbuffer1.append(" AND food_code NOT LIKE ( " +
									"  IF( " +
									"   (SELECT food_code FROM base_food_type WHERE delete_flag = 0 AND food_code LIKE '________' AND food_name = '其他类') IS NULL,  " +
									"   '9999%',  " +
									"   (SELECT CONCAT( food_code, '%' ) FROM base_food_type WHERE delete_flag = 0 AND food_code LIKE '________' AND food_name = '其他类') " +
									"  ) " +
									" ) ");

                            upn = jdbcTemplate.queryForObject(sbuffer1.toString(), Integer.class, lut);
                            break;
                        case "foodItem":
                            sbuffer1.append("SELECT COUNT(1) " +
                                    "FROM base_food_item bfi " +
									"INNER JOIN base_food_type bft ON bfi.food_id = bft.id " +
									"INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " +
                                    "WHERE (bfi.update_date >=? OR bft.update_date >=? OR bdi.update_date >=?) ");
                            upn = jdbcTemplate.queryForObject(sbuffer1.toString(), Integer.class, lut, lut, lut);
                            break;
                        case "standard":
                            sbuffer1.append("SELECT COUNT(1) " +
                                    "FROM base_standard " +
                                    "WHERE update_date>=? ");
                            upn = jdbcTemplate.queryForObject(sbuffer1.toString(), Integer.class, lut);
                            break;
                        case "laws":
                            sbuffer1.append("SELECT COUNT(1) " +
                                    "FROM base_laws_regulations " +
                                    "WHERE update_date>=? ");
                            upn = jdbcTemplate.queryForObject(sbuffer1.toString(), Integer.class, lut);
                            break;
                        default:
                            break;
                    }
                    //无待更新数据
                    if (upn == 0) {
                        f4 = new File(realPath4 + filename4);
                    }
                }
            }
			if (f4 != null && f4.exists()){		//返回压缩文件
				response.setHeader("content-disposition", "attachment;filename=" + filename4);
				InputStream in = new FileInputStream(realPath4 + filename4);
				int len = 0;
				byte[] buffer = new byte[1024];
				OutputStream out = response.getOutputStream();
				while ((len = in.read(buffer)) > 0) {
					out.write(buffer,0,len);
				}
				in.close();

			} else {
				List<Map<String, Object>> list = null;
				Map<String, Object> map = new HashMap<>();
				StringBuffer sbuffer = new StringBuffer();
				switch (type) {
					case "food"://下载食品信息；根据update_date进行增量更新
						sbuffer.setLength(0);
						if(outside==1){
							sbuffer.append("SELECT id,food_name,food_name_en,food_name_other,parent_id,cimonitor_level, "
									+ " sorting,checked,isFood,delete_flag,NULL param1,NULL param2,NULL param3 "
									+ " FROM base_food_type where update_date>=? ");
						}else{
							//外部接口，未审核状态食品种类当作已删除数据
							sbuffer.append("SELECT id,food_name,food_name_en,food_name_other,parent_id, "
									+ " isFood,IF((checked = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 "
									+ " FROM base_food_type where update_date>=? ");
						}
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and delete_flag=0 AND checked=1 ");
						}

						//获取指定种类下的样品
						if(StringUtil.isNotEmpty(id)) {
							BaseFoodType f = foodTypeService.getById(Integer.valueOf(id));
							if (f != null) {
								//食品种类
								if (f.getIsfood() == 0) {
									sbuffer.append(" AND food_code LIKE (SELECT CONCAT(food_code,'%') FROM base_food_type WHERE id = "+id+") ");

									//食品名称
								} else if (f.getIsfood() == 1) {
									sbuffer.append(" AND id = "+id+" ");
								}
							}
						}

						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
						map.put("food", list);
						break;

					case "standard"://下载检测标准
						sbuffer.setLength(0);
						if(outside==1){
//							String ftpDownload0 = CodecUtils.aesDecrypt(ftpDownload, ftpKey);
//							sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
//									+ " CONCAT('"+ftpDownload0+standardPath+"/',url_path) url_path,use_status,std_id,sorting,remark,delete_flag,NULL param1,NULL param2,NULL param3 "
//									+ " from base_standard where update_date>=?");

							sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
									+ " CONCAT('"+systemUrl+"data/standard/download?id=', id) url_path,use_status,std_id,sorting,remark,delete_flag,NULL param1,NULL param2,NULL param3 "
									+ " from base_standard where update_date>=?");
						}else{
							//外部接口，未使用状态检测标准当作已删除数据
							sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
									+ " IF((use_status = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 "
									+ " from base_standard where update_date>=?");
						}
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and delete_flag=0 ");
						}
						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
						map.put("standard", list);
						break;

					case "item"://下载检测项目
						sbuffer.setLength(0);
						if(outside==1){
							sbuffer.append("SELECT i.id,detect_item_name,detect_item_typeid,standard_id,detect_sign,detect_value, ");
							sbuffer.append("detect_value_unit,checked,cimonitor_level,i.remark, " );
							sbuffer.append("t.item_name item_type_name, t.sorting item_type_sorting, " );
							sbuffer.append("i.delete_flag,NULL param1,NULL param2,NULL param3 ");
							sbuffer.append("FROM base_detect_item i ");
							sbuffer.append("INNER JOIN base_item_type t ON i.detect_item_typeid=t.id ");
							sbuffer.append("where (i.update_date>=? or t.update_date>=?)");
						}else{
							//外部接口，未审核状态检测项目当作已删除数据
							sbuffer.append("SELECT i.id,detect_item_name,detect_item_typeid,standard_id,detect_sign,detect_value,");
							sbuffer.append("detect_value_unit,t.item_name item_type_name,IF((i.checked = 0 OR i.delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 " );
							sbuffer.append("FROM base_detect_item i ");
							sbuffer.append("INNER JOIN base_item_type t ON i.detect_item_typeid=t.id ");
							sbuffer.append("where (i.update_date>=? or t.update_date>=?)");
						}
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and i.delete_flag=0 AND i.checked=1 and t.delete_flag=0 ");
						}
						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
						map.put("detectItem", list);
						break;

					case "foodItem"://下载样品与关联的检测项目信息
						sbuffer.setLength(0);
						if(outside==1){
							sbuffer.append("SELECT " +
									"	bfi.id, bfi.checked, " +
									"	bft.id food_id, bft.food_name, " +
									"	bdi.id item_id, bdi.detect_item_name item_name, " +
									"	bs.id std_id, bs.std_name std_name, " +
									"	IF(bfi.use_default=0, bdi.detect_sign, bfi.detect_sign) detect_sign, " +
									"	IF(bfi.use_default=0, bdi.detect_value, bfi.detect_value) detect_value, " +
									"	IF(bfi.use_default=0, bdi.detect_value_unit, bfi.detect_value_unit) detect_value_unit, " +
									"	bfi.remark, " +
									"	IF(bfi.delete_flag = 0 AND bft.delete_flag = 0 AND bdi.delete_flag = 0, 0, 1) delete_flag, " +
									"	NULL param1, NULL param2, NULL param3 " +
									"FROM base_food_item bfi " +
									"INNER JOIN base_food_type bft ON bfi.food_id = bft.id " +
									"INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " +
									"LEFT JOIN base_standard bs ON bdi.standard_id = bs.id " +
									"WHERE (bfi.update_date >=? OR bft.update_date >=? OR bdi.update_date >=?) ");
						}else{
							sbuffer.append("SELECT " +
									"	bfi.id, " +
									"	bft.id food_id, bft.food_name, " +
									"	bdi.id item_id, bdi.detect_item_name item_name, " +
									"	IF(bfi.delete_flag = 0 AND bft.delete_flag = 0 AND bdi.delete_flag = 0 AND bfi.checked = 1, 0, 1) delete_flag, " +
									"	NULL param1, NULL param2, NULL param3 " +
									"FROM base_food_item bfi " +
									"INNER JOIN base_food_type bft ON bfi.food_id = bft.id " +
									"INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " +
									"WHERE (bfi.update_date >=? OR bft.update_date >=? OR bdi.update_date >=?) ");
						}
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" AND bfi.delete_flag=0 AND bfi.checked=1 AND bdi.delete_flag=0 AND bdi.checked=1 AND bft.delete_flag=0 AND bft.checked=1 ");
						}

						//获取指定样品与关联的检测项目信息
						if(StringUtil.isNotEmpty(id)) {
							BaseFoodType f = foodTypeService.getById(Integer.valueOf(id));
							if (f != null) {
								//食品种类
								if (f.getIsfood() == 0) {
									sbuffer.append(" AND bft.food_code LIKE (SELECT CONCAT(food_code,'%') FROM base_food_type WHERE id = "+id+") ");

									//食品名称
								} else if (f.getIsfood() == 1) {
									sbuffer.append(" AND bft.id = "+id+" ");
								}
							}
						}

						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime, lastUpdateTime);
						map.put("foodItem", list);
						break;

					case "deviceSeries"://下载仪器系列
						sbuffer.setLength(0);
						sbuffer.append("select id, device_name, device_series, device_version, device_maker, "
								+ " description, concat('"+ WebConstant.res.getString("systemUrl") +"',file_path) file_path, remark, checked, delete_flag, param1, param2, param3 "
								+ " from base_device_type where type = 0 and update_date>=?");
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and delete_flag=0 ");
						}
						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
						map.put("deviceSeries", list);
						break;

					case "deviceItem"://下载仪器检测项目
						required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
						sbuffer.setLength(0);
						sbuffer.append("SELECT " +
								"	p.id, p.device_type_id, p.item_id, " +
								"	bdi.detect_item_name item_name," +
								"	p.project_type, " +
								"	p.detect_method, p.detect_unit, p.operation_password, " +
								"	p.food_code, p.invalid_value, p.check_hole1, " +
								"	p.check_hole2, p.wavelength, p.pre_time, p.dec_time,  " +
								"	p.stdA0, p.stdA1, p.stdA2, p.stdA3, " +
								"	p.stdB0, p.stdB1, p.stdB2, p.stdB3, " +
								"	p.stdA, p.stdB, p.national_stdmin, p.national_stdmax, " +
								"	p.yin_min, p.yin_max, p.yang_min, p.yang_max, " +
								"	p.yinT, p.yangT, p.absX, p.ctAbsX, p.division, " +
								"	p.parameter, p.trailingEdgeC, p.trailingEdgeT, " +
								"	p.suspiciousMin, p.suspiciousMax, " +
								"	p.reserved1, p.reserved2, p.reserved3, " +
								"	p.reserved4, p.reserved5, p.remark, p.delete_flag " +
								"FROM base_device bd " +
								"	INNER JOIN base_device_parameter p ON bd.device_type_id = p.device_type_id" +
								"	INNER JOIN base_detect_item bdi ON p.item_id = bdi.id  " +
								"WHERE " +
								"	bd.serial_number =? " +
								"	AND (bd.update_date >=? OR p.update_date >=? OR bdi.update_date >=? )");
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" AND bd.delete_flag=0 AND p.delete_flag=0 AND bdi.delete_flag=0 ");
						}
						list = jdbcTemplate.queryForList(sbuffer.toString(), serialNumber,lastUpdateTime,lastUpdateTime,lastUpdateTime);
						map.put("deviceItem", list);
						break;

					case "laws"://下载法律法规
						sbuffer.setLength(0);
						if(outside==1){
							sbuffer.append("select id,law_name,law_type,law_unit,law_num,law_status,law_notes,rel_date,");
							sbuffer.append("imp_date,failure_date,CONCAT('"+systemUrl+"data/laws/download?id=',id) url_path,");
							sbuffer.append("use_status,delete_flag,NULL param1,NULL param2,NULL param3 ");
							sbuffer.append("from base_laws_regulations  where update_date>=? ");
						}else{
							//外部接口，未使用状态法律法规当作已删除数据
							sbuffer.append("select id,law_name,law_num,IF((use_status = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 ");
							sbuffer.append("from base_laws_regulations  where update_date>=? ");
						}
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" AND delete_flag=0 ");
						}
						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
						map.put("laws", list);
						break;

					case "regulatory"://下载监管对象，只查询当前用户机构下的监管对象
						sbuffer.setLength(0);
						if(outside==1){
							sbuffer.append("SELECT " +
									"	bro.id id, bro.depart_id depart_id, bro.reg_name reg_name, " +
									"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " +
									"	bro.reg_address reg_address, bro.place_x place_x, bro.place_y place_y, bro.remark remark, bro.checked checked, " +
									"	bro.delete_flag delete_flag, brt.show_business show_business, " +
									"	NULL param1, NULL param2, NULL param3 ");
						}else{
							//外部接口，未审核状态监管对象当作已删除数据
							sbuffer.append("SELECT " +
									"	bro.id id, bro.depart_id depart_id, bro.reg_name reg_name, " +
									"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " +
									"	bro.reg_address reg_address, IF((bro.checked = 0 OR bro.delete_flag = 1), 1, 0) delete_flag, " +
									"	NULL param1, NULL param2, NULL param3 ");
						}

						sbuffer.append("	FROM base_regulatory_object bro " +
								"	LEFT JOIN base_regulatory_type brt ON brt.id = bro.reg_type " +
								"	WHERE (bro.update_date>=? OR brt.update_date>=?) ");
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" AND bro.delete_flag=0 AND brt.delete_flag=0 ");
						}
						//根据用户权限查询监管对象
						if(null != user.getRegId()){
							sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
						}else if(null != user.getDepartId()){

							BasePoint point = null;
							if (user.getPointId() != null) {
								point = pointService.queryById(user.getPointId());
							}
							if (point != null && !StringUtils.isBlank(point.getRegulatoryId())) {
								//企业检测室用户
								sbuffer.append(" AND bro.id = "+point.getRegulatoryId()+" ");

							} else {
								sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
							}
						}else {
							sbuffer.append(" AND 1=0 ");
						}

						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
						map.put("regulatory", list);
						break;

					case "business"://下载经营户，只查询当前用户机构下的经营户
						sbuffer.setLength(0);
						if(outside==1){
							sbuffer.append("SELECT " +
									"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " +
									"	brb.ope_name, brb.ope_phone, brb.credit_rating, " +
									"	brb.monitoring_level, brb.remark, brb.checked, CONCAT(brb.type,'') type, " +
									"	brb.delete_flag, NULL param1, NULL param2, NULL param3 ");
						}else{
							//外部接口，未审核状态监管对象当作已删除数据
							sbuffer.append("SELECT " +
									"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " +
									"	brb.ope_name, CONCAT(brb.type,'') type, IF((brb.checked = 0 OR brb.delete_flag = 1), 1, 0) delete_flag, NULL param1, NULL param2, NULL param3 ");
						}

						sbuffer.append(" FROM base_regulatory_business brb INNER JOIN base_regulatory_object bro ON brb.reg_id = bro.id "
								+ " WHERE brb.update_date>=? ");

						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" AND brb.delete_flag=0 AND bro.delete_flag=0 ");
						}
						//根据用户权限查询经营户
						if(null != user.getRegId()){
							sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
						}else if(null != user.getDepartId()){

							BasePoint point = null;
							if (user.getPointId() != null) {
								point = pointService.queryById(user.getPointId());
							}
							if (point != null && !StringUtils.isBlank(point.getRegulatoryId())) {
								//企业检测室用户
								sbuffer.append(" AND bro.id = "+point.getRegulatoryId()+" ");

							} else {
								sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
							}
						}else {
							sbuffer.append(" AND 1=0 ");
						}

						//获取指定监管对象下的经营户
						if(StringUtil.isNotEmpty(id)) {
							sbuffer.append(" AND bro.id = "+id+" ");
						}

						list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
						map.put("business", list);
						break;

					default:
						throw new MyException("下载类型未定义", "下载类型未定义", WebConstant.INTERFACE_CODE4);
				}

				//返回JSON数据最大数量限制
				int rNum = 500;
				if(StringUtil.isNumeric(recordNumber)){
					rNum = Integer.parseInt(recordNumber);
				}

				if(list == null || list.size() <= rNum) {	//返回JSON
					json.setObj(map);
					OutputStream os = response.getOutputStream();
					response.setHeader("content-type", "application/json;charset=UTF-8");
					String listStr = JSONObject.toJSONString(json, new ValueFilter() {
						@Override
						public Object process(Object object, String name, Object value) {
							if(value==null) {
								return "";
							}else {
								return value;
							}
						}
					}, SerializerFeature.WriteDateUseDateFormat,SerializerFeature.WriteNullListAsEmpty);
					byte[] dataByteArr = listStr.getBytes(StandardCharsets.UTF_8);
					os.write(dataByteArr);

				}else {		//返回压缩文件
					String uuid = UUIDGenerator.generate();		//临时ID
					String filename = uuid + ".zip";	//压缩文件名称
					String realPath1 = resources + basicDataTemp + uuid + "/";	//临时文件夹目录
					String realPath2 = realPath1 + "files/";	//基础数据文件目录

					Iterator it = list.iterator();
					int fileNum = 1;//压缩文件序号
					int blxh = 1;//遍历次数
					List list2 = new ArrayList();
					while (it.hasNext()) {
						list2.add(it.next());
						if(blxh%rNum==0) {
							DyFileUtil.writeToJSON(list2, realPath2 + fileNum +".txt");

							fileNum++;
							list2 = new ArrayList();
						}
						blxh++;

						if(!it.hasNext() && list2.size() > 0) {
							DyFileUtil.writeToJSON(list2, realPath2 + fileNum +".txt");
						}
					}

					File f = new File(realPath2);
					ZipUtils.toZip(f, realPath1 + filename, false);

					//保留重置数据的压缩包
					if ("2000-01-01 00:00:00".equals(lastUpdateTime) && ("food".equals(type) || "standard".equals(type)
                            || "foodItem".equals(type) || "laws".equals(type) )) {
                        String filename3 = DateUtil.formatDate(new Date(), "yyyyMMddHHmmss") + ".zip";	//压缩文件名称
                        String realPath3 = resources + basicDataTemp + "bak/" + type + "/" + outside + "/";	//临时文件夹目录

                        DyFileUtil.createFolder(realPath3);
                        if (!new File(realPath3 + filename3).exists()){
                            ZipUtils.toZip(f, realPath3 + filename3, false);
                        }
                    }

					response.setHeader("content-disposition", "attachment;filename=" + filename);
					InputStream in = new FileInputStream(realPath1 + filename);
					int len = 0;
					byte[] buffer = new byte[1024];
					OutputStream out = response.getOutputStream();
					while ((len = in.read(buffer)) > 0) {
						out.write(buffer,0,len);
					}
					in.close();

					//删除临时文件
					DyFileUtil.deleteFolder(realPath1);
				}
			}

		} catch (MyException e) {
			e.printStackTrace();
			setAjaxJson(json, e.getCode(), e.getText());
			try {
				OutputStream os = response.getOutputStream();
				response.setHeader("content-type", "application/json;charset=UTF-8");
				String listStr = JSONObject.toJSONString(json, new ValueFilter() {
					@Override
					public Object process(Object object, String name, Object value) {
						if(value==null) {
							return "";
						}else {
							return value;
						}
					}
				});
				byte[] dataByteArr = listStr.getBytes(StandardCharsets.UTF_8);
				os.write(dataByteArr);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			setAjaxJson(json, WebConstant.INTERFACE_CODE11, "操作失败！", e);
			try {
				OutputStream os = response.getOutputStream();
				response.setHeader("content-type", "application/json;charset=UTF-8");
				String listStr = JSONObject.toJSONString(json, new ValueFilter() {
					@Override
					public Object process(Object object, String name, Object value) {
						if(value==null) {
							return "";
						}else {
							return value;
						}
					}
				});
				byte[] dataByteArr = listStr.getBytes(StandardCharsets.UTF_8);
				os.write(dataByteArr);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}
	
	
	/**
	 * 获取有经营户的监管对象
	 * @param request
	 * @param response
	 * @param userToken
	 * @return
	 */
	@RequestMapping("/getRegulatory")
	public InterfaceJson getRegulatory(HttpServletRequest request, HttpServletResponse response, String userToken) {
		
		response.addHeader("Access-Control-Allow-Origin", "*");
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " + 
					"	bro.id id, bro.depart_id depart_id, bro.reg_name reg_name, " + 
					"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " + 
					"	bro.reg_address reg_address, bro.remark remark, bro.checked checked, " + 
					"	bro.delete_flag delete_flag, brt.show_business show_business, " + 
					"	NULL param1, NULL param2, NULL param3 " + 
					"	from base_regulatory_object bro left join base_regulatory_type brt on brt.id = bro.reg_type " + 
					"	where brt.show_business=1 AND bro.management_type IS NOT NULL AND  bro.management_type != '' ");

			List<Integer> departIds = departService.querySonDeparts(user.getDepartId());
			if(departIds.size()>0) {
				sbuffer.append(" and bro.depart_id in ( ");
				for (Integer departId : departIds) {
					sbuffer.append( departId+",");
				}
				sbuffer.deleteCharAt(sbuffer.length()-1);
				sbuffer.append(" ) ");
			}
			sbuffer.append(" ORDER BY bro.management_type ASC ");
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString());
			
			aj.setObj(list);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 通过监管对象ID获取经营户
	 * @param request
	 * @param response
	 * @param userToken
	 * @param regId 监管对象ID
	 * @return
	 */
	@RequestMapping("/getBusiness")
	public InterfaceJson getBusiness(HttpServletRequest request, HttpServletResponse response, String userToken, int regId) {
		
		response.addHeader("Access-Control-Allow-Origin", "*");
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " + 
					"	brb.id, brb.reg_id, brb.ope_shop_name, " + 
					"	brb.ope_shop_code, brb.ope_name, brb.ope_phone, " + 
					"	brb.credit_rating, brb.monitoring_level, " + 
					"	brb.remark, brb.checked, brb.delete_flag " + 
					"FROM " + 
					"	base_regulatory_business brb " + 
					"INNER JOIN base_regulatory_object bro ON brb.reg_id = bro.id " + 
					"WHERE " + 
					"	brb.reg_id =?");
			
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), regId);
			
			aj.setObj(list);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	/**
	 * 根据扫码返回id查询（监管对象,经营户）
	 * @author yxp
	 * @date 2021年4月22日
	 * @param request
	 * @param response
	 * @param userToken
	 * @param type	接口类型
	 * @param lastUpdateTime
	 * @param pageNumber
	 * @param recordNumber
	 * @param id
	 * @return
	 */
	@RequestMapping("/queryRegulatoryId")
	public InterfaceJson queryRegulatoryId(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userToken",required=false)String userToken,
										   @RequestParam(value="type",required=false)String type, @RequestParam(value="lastUpdateTime",defaultValue="2000-01-01 00:00:01")String lastUpdateTime,
										   @RequestParam(value="pageNumber",defaultValue="0",required=false)String pageNumber,
										   @RequestParam(value="recordNumber",defaultValue="50",required=false)String recordNumber,
										   @RequestParam(value="id",required=false)String id,@RequestParam(value="searchValue",required=false)String searchValue) {

		//跨域
		response.setHeader("Access-Control-Allow-Origin", "*");

		InterfaceJson json = new InterfaceJson();
		try {
			TSUser user = tokenExpired(userToken);
			required(type, WebConstant.INTERFACE_CODE1, "参数type不能为空");
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");


			List<Map<String, Object>> list = null;
			Map<String, Object> map = new HashMap<>();
			StringBuffer sbuffer = new StringBuffer();
			switch (type) {
				case "regulatory"://下载监管对象，只查询当前用户机构下的监管对象
					sbuffer.setLength(0);

					sbuffer.append("SELECT " +
							"	bro.id id, bro.depart_id depart_id, bro.reg_name reg_name, " +
							"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " +
							"	bro.reg_address reg_address, bro.place_x place_x, bro.place_y place_y, bro.remark remark, bro.checked checked, " +
							"	bro.delete_flag delete_flag, brt.show_business show_business, " +
							"	NULL param1, NULL param2, NULL param3 ");

					sbuffer.append("	FROM base_regulatory_object bro " +
							"	LEFT JOIN base_regulatory_type brt ON brt.id = bro.reg_type " +
							"	WHERE (bro.update_date>=? OR brt.update_date>=?) ");
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and bro.delete_flag=0 and brt.delete_flag=0 ");
					}
					//根据用户权限查询监管对象
					if(null != user.getRegId()){
						sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
					}else if(null != user.getDepartId()){
						sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
					}else {
						sbuffer.append(" AND 1=0 ");
					}
					if(StringUtil.isNotEmpty(id)) {
						sbuffer.append(" AND  bro.id = "+id+" ");
					}

					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("regulatory", list);
					break;

				case "business"://下载经营户，只查询当前用户机构下的经营户
					sbuffer.setLength(0);

					sbuffer.append("SELECT " +
							"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " +
							"	brb.ope_name, brb.ope_phone, brb.credit_rating, " +
							"	brb.monitoring_level, brb.remark, brb.checked, CONCAT(brb.type,'') type, " +
							"	brb.delete_flag,bro.id,bro.reg_name,bro.reg_address,bro.link_user,bro.link_phone, NULL param1, NULL param2, NULL param3 ");


					sbuffer.append(" FROM base_regulatory_business brb INNER JOIN base_regulatory_object bro ON brb.reg_id = bro.id "
							+ " WHERE brb.update_date>=? ");

					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and brb.delete_flag=0 and bro.delete_flag=0 ");
					}
					//根据用户权限查询经营户
					if(null != user.getRegId()){
						sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
					}else if(null != user.getDepartId()){
						sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
					}else {
						sbuffer.append(" AND 1=0 ");
					}


					//获取指定监管对象下的经营户
					if(StringUtil.isNotEmpty(id)) {
						sbuffer.append(" AND brb.id= "+id+" ");
					}

					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("business", list);
					break;

				default:
					throw new MyException("下载类型未定义", "下载类型未定义", WebConstant.INTERFACE_CODE4);
			}
			json.setObj(map);

		} catch (MyException e) {
			setAjaxJson(json, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(json, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return json;

	}
	/**
	 * 搜索查询（监管对象,经营户，样品，检测项目）
	 * @author yxp
	 * @date 2021年4月21日
	 * @param request
	 * @param response
	 * @param userToken
	 * @param type	接口类型
	 * @param serialNumber
	 * @param lastUpdateTime
	 * @param pageNumber
	 * @param recordNumber
	 * @param outside 内部接口标识：0_对外，1_内部
	 * @param id
	 * @return
	 */
	@RequestMapping("/queryRegulatory")
	public InterfaceJson queryRegulatory(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="userToken",required=false)String userToken,
										 @RequestParam(value="type",required=false)String type, @RequestParam(value="serialNumber",required=false)String serialNumber,
										 @RequestParam(value="lastUpdateTime",defaultValue="2000-01-01 00:00:01")String lastUpdateTime,
										 @RequestParam(value="pageNumber",defaultValue="0",required=false)String pageNumber,
										 @RequestParam(value="recordNumber",defaultValue="50",required=false)String recordNumber,
										 @RequestParam(value="outside",defaultValue="0",required=false)Integer outside,
										 @RequestParam(value="machineCode",required=false)String machineCode,
										 @RequestParam(value="hardwareVersion",required=false)String hardwareVersion,
										 @RequestParam(value="id",required=false)String id,@RequestParam(value="searchValue",required=false)String searchValue) {

		//跨域
		response.setHeader("Access-Control-Allow-Origin", "*");

		InterfaceJson json = new InterfaceJson();
		try {
			TSUser user = tokenExpired(userToken);
			required(type, WebConstant.INTERFACE_CODE1, "参数type不能为空");
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");

			//对外接口
			if (outside == 0) {
				//只允许分页下载
				if (Integer.parseInt(pageNumber) < 1) {
					pageNumber = "1";
				}
				//每页数量最大500
				if (Integer.parseInt(recordNumber) < 1 || Integer.parseInt(recordNumber) > 500) {
					recordNumber = "50";
				}
			}

			List<Map<String, Object>> list = null;
			Map<String, Object> map = new HashMap<>();
			StringBuffer sbuffer = new StringBuffer();
			switch (type) {
				case "food"://下载食品信息；根据update_date进行增量更新
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT instr(food_name, \""+searchValue+"\"),length( food_name ),id,food_name,food_name_en,food_name_other,parent_id,cimonitor_level, "
								+ " sorting,checked,isFood,delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " FROM base_food_type where update_date>=?");
					}else{
						//外部接口，未审核状态食品种类当作已删除数据
						sbuffer.append("SELECT id,food_name,food_name_other,parent_id, "
								+ " isFood,IF((checked = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " FROM base_food_type where update_date>=?");
					}

					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 and checked=1 ");
					}

					//获取指定种类下的样品
					if(StringUtil.isNotEmpty(id)) {
						BaseFoodType f = foodTypeService.getById(Integer.valueOf(id));
						if (f != null) {
							//食品种类
							if (f.getIsfood() == 0) {
								sbuffer.append(" AND food_code LIKE (SELECT CONCAT(food_code,'%') FROM base_food_type WHERE id = "+id+") ");

								//食品名称
							} else if (f.getIsfood() == 1) {
								sbuffer.append(" AND id = "+id+" ");
							}
						}
					}

					//获取样品搜索内容匹配数据
					if(null != searchValue){
						sbuffer.append(" AND (food_name like \"%" + searchValue + "%\" or food_name_other like \"%" + searchValue + "%\") ");

						sbuffer.append(" AND isFood=1 ");
						sbuffer.append(" ORDER BY IF(instr(food_name, \""+searchValue+"\") = 1,-1,instr(food_name, \""+searchValue+"\")),length( food_name ), id ASC");

					}

					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("food", list);
					break;
				case "standard"://下载检测标准
					sbuffer.setLength(0);
					if(outside==1){
//						String ftpDownload0 = CodecUtils.aesDecrypt(ftpDownload, ftpKey);
//						sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
//								+ " CONCAT('"+ftpDownload0+standardPath+"/',url_path) url_path,use_status,std_id,sorting,remark,delete_flag,NULL param1,NULL param2,NULL param3 "
//								+ " from base_standard where update_date>=?");

						sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
								+ " CONCAT('"+systemUrl+"data/standard/download?id=', id) url_path,use_status,std_id,sorting,remark,delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " from base_standard where update_date>=?");
					}else{
						//外部接口，未使用状态检测标准当作已删除数据
						sbuffer.append("select id,std_code,std_name,std_title,std_unit,std_type,std_status,imp_time,rel_time, "
								+ " IF((use_status = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 "
								+ " from base_standard where update_date>=?");
					}
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("standard", list);
					break;
				case "item"://下载检测项目
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT i.id,detect_item_name,detect_item_typeid,standard_id,detect_sign,detect_value, ");
						sbuffer.append("	detect_value_unit,checked,cimonitor_level,i.remark, " );
						sbuffer.append("	t.item_name item_type_name, t.sorting item_type_sorting, " );
						sbuffer.append("	i.delete_flag,NULL param1,NULL param2,NULL param3 ");
						sbuffer.append("FROM base_detect_item i ");
						sbuffer.append("INNER JOIN base_item_type t ON i.detect_item_typeid=t.id ");
						sbuffer.append("where (i.update_date>=? or t.update_date>=?)");
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and i.delete_flag=0 and i.checked=1 and t.delete_flag=0 ");
						}
					}else{
						//外部接口，未审核状态检测项目当作已删除数据
						sbuffer.append("SELECT i.id, i.detect_item_name, i.detect_sign, i.detect_value, i.detect_value_unit, ");
						sbuffer.append("	bs.std_name standard_name, IF((i.checked = 0 OR i.delete_flag = 1), 1, 0) delete_flag, NULL param1,NULL param2,NULL param3 " );
						sbuffer.append("FROM base_detect_item i ");
						sbuffer.append("LEFT JOIN base_standard bs ON i.detect_item_typeid = bs.id ");
						sbuffer.append("where (i.update_date>=? or bs.update_date>=?)");
						//重置数据，不下载已删除数据
						if (lastUpdateTime.contains("2000-01-01")) {
							sbuffer.append(" and i.delete_flag=0 and i.checked=1 ");
						}
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("detectItem", list);
					break;
				case "foodItem"://下载样品与关联的检测项目信息
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT " +
								"	bfi.id, bfi.checked, " +
								"	bft.id food_id, bft.food_name, " +
								"	bdi.id item_id, bdi.detect_item_name item_name, " +
								"	bs.id std_id, bs.std_name std_name, " +
								"	IF(bfi.use_default=0, bdi.detect_sign, bfi.detect_sign) detect_sign, " +
								"	IF(bfi.use_default=0, bdi.detect_value, bfi.detect_value) detect_value, " +
								"	IF(bfi.use_default=0, bdi.detect_value_unit, bfi.detect_value_unit) detect_value_unit, " +
								"	bfi.remark, " +
								"	IF(bfi.delete_flag = 0 AND bft.delete_flag = 0 AND bdi.delete_flag = 0, 0, 1) delete_flag, " +
								"	NULL param1, NULL param2, NULL param3 " +
								"FROM base_food_item bfi " +
								"INNER JOIN base_food_type bft ON bfi.food_id = bft.id " +
								"INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " +
								"LEFT JOIN base_standard bs ON bdi.standard_id = bs.id " +
								"WHERE (bfi.update_date >=? OR bft.update_date >=? OR bdi.update_date >=?) ");
					}else{
						sbuffer.append("SELECT " +
								"	bfi.id, " +
								"	bft.id food_id, bft.food_name, " +
								"	bdi.id item_id, bdi.detect_item_name item_name, " +
								"	IF(bfi.delete_flag = 0 AND bft.delete_flag = 0 AND bdi.delete_flag = 0 AND bfi.checked = 1, 0, 1) delete_flag, " +
								"	NULL param1, NULL param2, NULL param3 " +
								"FROM base_food_item bfi " +
								"INNER JOIN base_food_type bft ON bfi.food_id = bft.id " +
								"INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " +
								"WHERE (bfi.update_date >=? OR bft.update_date >=? OR bdi.update_date >=?) ");
					}
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" AND bfi.delete_flag=0 AND bfi.checked=1 AND bdi.delete_flag=0 AND bdi.checked=1 AND bft.delete_flag=0 AND bft.checked=1 ");
					}

					//获取指定样品与关联的检测项目信息
					if(StringUtil.isNotEmpty(id)) {
						BaseFoodType f = foodTypeService.getById(Integer.valueOf(id));
						if (f != null) {
							//食品种类
							if (f.getIsfood() == 0) {
								sbuffer.append(" AND bft.food_code LIKE (SELECT CONCAT(food_code,'%') FROM base_food_type WHERE id = "+id+") ");

								//食品名称
							} else if (f.getIsfood() == 1) {
								sbuffer.append(" AND bft.id = "+id+" ");
							}
						}
					}

					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime, lastUpdateTime);
					map.put("foodItem", list);
					break;
				case "deviceSeries"://下载仪器系列
					sbuffer.setLength(0);
					sbuffer.append("select id, device_name, device_series, device_version, device_maker, "
							+ " description, concat('"+ WebConstant.res.getString("systemUrl") +"',file_path) file_path, remark, checked, delete_flag, param1, param2, param3 "
							+ " from base_device_type where type = 0 and update_date>=?");
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("deviceSeries", list);
					break;
				case "deviceItem"://下载仪器检测项目
					required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
					sbuffer.setLength(0);
					sbuffer.append("SELECT " +
							"	p.id, p.device_type_id, p.item_id, " +
							"	bdi.detect_item_name item_name," +
							"	p.project_type, " +
							"	p.detect_method, p.detect_unit, p.operation_password, " +
							"	p.food_code, p.invalid_value, p.check_hole1, " +
							"	p.check_hole2, p.wavelength, p.pre_time, p.dec_time,  " +
							"	p.stdA0, p.stdA1, p.stdA2, p.stdA3, " +
							"	p.stdB0, p.stdB1, p.stdB2, p.stdB3, " +
							"	p.stdA, p.stdB, p.national_stdmin, p.national_stdmax, " +
							"	p.yin_min, p.yin_max, p.yang_min, p.yang_max, " +
							"	p.yinT, p.yangT, p.absX, p.ctAbsX, p.division, " +
							"	p.parameter, p.trailingEdgeC, p.trailingEdgeT, " +
							"	p.suspiciousMin, p.suspiciousMax, " +
							"	p.reserved1, p.reserved2, p.reserved3, " +
							"	p.reserved4, p.reserved5, p.remark, p.delete_flag " +
							"FROM base_device bd " +
							"	INNER JOIN base_device_parameter p ON bd.device_type_id = p.device_type_id" +
							"	INNER JOIN base_detect_item bdi ON p.item_id = bdi.id  " +
							"WHERE " +
							"	bd.delete_flag=0 AND bd.serial_number =? " +
							"	AND bdi.delete_flag=0" +
							"	AND p.delete_flag=0 " +
							"	AND p.update_date >=? ");
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and bd.delete_flag=0 and p.delete_flag=0 and bdi.delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), serialNumber,lastUpdateTime);
					map.put("deviceItem", list);
					break;
				case "laws"://下载法律法规
					sbuffer.setLength(0);
					if(outside==1){
//						String ftpDownload0 = CodecUtils.aesDecrypt(ftpDownload, ftpKey);
//						sbuffer.append("select id,law_name,law_type,law_unit,law_num,law_status,law_notes,rel_date,");
//						sbuffer.append("imp_date,failure_date,CONCAT('"+ftpDownload0+lawPath+"/',url_path) url_path,");
//						sbuffer.append("use_status,delete_flag,NULL param1,NULL param2,NULL param3 ");
//						sbuffer.append("from base_laws_regulations  where update_date>=? ");

						sbuffer.append("select id,law_name,law_type,law_unit,law_num,law_status,law_notes,rel_date,");
						sbuffer.append("imp_date,failure_date,CONCAT('"+systemUrl+"data/laws/download?id=', id) url_path,");
						sbuffer.append("use_status,delete_flag,NULL param1,NULL param2,NULL param3 ");
						sbuffer.append("from base_laws_regulations  where update_date>=? ");
					}else{
						//外部接口，未使用状态法律法规当作已删除数据
						sbuffer.append("select id,law_name,law_num,IF((use_status = 0 OR delete_flag = 1), 1, 0) delete_flag,NULL param1,NULL param2,NULL param3 ");
						sbuffer.append("from base_laws_regulations  where update_date>=? ");
					}
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and delete_flag=0 ");
					}
					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("laws", list);
					break;
				case "regulatory"://下载监管对象，只查询当前用户机构下的监管对象
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT " +
								"	bro.id id, bro.depart_id depart_id, bro.reg_name reg_name, " +
								"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " +
								"	bro.reg_address reg_address, bro.place_x place_x, bro.place_y place_y, bro.remark remark, bro.checked checked, " +
								"	bro.delete_flag delete_flag, brt.show_business show_business, " +
								"	NULL param1, NULL param2, NULL param3 ");
					}else{
						//外部接口，未审核状态监管对象当作已删除数据
						sbuffer.append("SELECT " +
								"	bro.id id, bro.reg_name reg_name, " +
								"	brt.reg_type reg_type, bro.link_user link_user, bro.link_phone link_phone, " +
								"	bro.reg_address reg_address, IF((bro.checked = 0 OR bro.delete_flag = 1), 1, 0) delete_flag, " +
								"	NULL param1, NULL param2, NULL param3 ");
					}

					sbuffer.append("	FROM base_regulatory_object bro " +
							"	LEFT JOIN base_regulatory_type brt ON brt.id = bro.reg_type " +
							"	WHERE (bro.update_date>=? OR brt.update_date>=?) ");
					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and bro.delete_flag=0 and brt.delete_flag=0 ");
					}
					//根据用户权限查询监管对象
					if(null != user.getRegId()){
						sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
					}else if(null != user.getDepartId()){
						sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
					}else {
						sbuffer.append(" AND 1=0 ");
					}
					//根据用户搜索内容查询监管对象
					if(null != searchValue){
						sbuffer.append(" AND bro.reg_name like \"%" + searchValue + "%\" ");
					}

					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("regulatory", list);
					break;

				case "business"://下载经营户，只查询当前用户机构下的经营户
					sbuffer.setLength(0);
					if(outside==1){
						sbuffer.append("SELECT " +
								"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " +
								"	brb.ope_name, brb.ope_phone, brb.credit_rating, " +
								"	brb.monitoring_level, brb.remark, brb.checked, CONCAT(brb.type,'') type, " +
								"	brb.delete_flag, NULL param1, NULL param2, NULL param3 ");
					}else{
						//外部接口，未审核状态监管对象当作已删除数据
						sbuffer.append("SELECT " +
								"	brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " +
								"	brb.ope_name, CONCAT(brb.type,'') type, IF((brb.checked = 0 OR brb.delete_flag = 1), 1, 0) delete_flag, NULL param1, NULL param2, NULL param3 ");
					}

					sbuffer.append(" FROM base_regulatory_business brb INNER JOIN base_regulatory_object bro ON brb.reg_id = bro.id "
							+ " WHERE brb.update_date>=? ");

					//重置数据，不下载已删除数据
					if (lastUpdateTime.contains("2000-01-01")) {
						sbuffer.append(" and brb.delete_flag=0 and bro.delete_flag=0 ");
					}
					//根据用户权限查询经营户
					if(null != user.getRegId()){
						sbuffer.append(" AND bro.id = "+user.getRegId()+" ");
					}else if(null != user.getDepartId()){
						sbuffer.append(" AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
					}else {
						sbuffer.append(" AND 1=0 ");
					}
					if(null != searchValue){
						sbuffer.append(" AND (brb.ope_shop_code like \"%" + searchValue + "%\" or brb.ope_shop_name like \"%" + searchValue + "%\") ");
					}

					//获取指定监管对象下的经营户
					if(StringUtil.isNotEmpty(id)) {
						sbuffer.append(" AND bro.id = "+id+" ");
					}

					limit(sbuffer, pageNumber, recordNumber);
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("business", list);
					break;

				default:
					throw new MyException("下载类型未定义", "下载类型未定义", WebConstant.INTERFACE_CODE4);
			}
			json.setObj(map);

		} catch (MyException e) {
			setAjaxJson(json, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(json, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return json;

	}
	
}
