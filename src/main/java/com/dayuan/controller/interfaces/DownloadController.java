package com.dayuan.controller.interfaces;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dayuan.bean.data.BasePoint;
import com.dayuan.service.data.BasePointService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.StringUtil;

/**
 * 对外接口 Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月25日
 */
@Controller
@RequestMapping("/interfaces/download")
public class DownloadController extends BaseInterfaceController {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BasePointService pointService;
	
	/**
	 * 基础数据下载接口
	 * @param userToken 	 用户token
	 * @param type			 下载类型
	 * @param serialNumber	 仪器唯一标识
	 * @param lastUpdateTime 最后更新时间
	 * @param pageNumber 页码数
	 * @param recordNumber 每页数量
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/basicData", method = RequestMethod.POST)
	public AjaxJson downloadBasicData(HttpServletRequest request, String userToken, String type, @RequestParam(required = false) String serialNumber,
			@RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime,@RequestParam(required = false) String pageNumber,
			String recordNumber){
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(type, WebConstant.INTERFACE_CODE1, "参数type不能为空");
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			//设置每页数量
			int num = 50;
			if(StringUtil.isNumeric(recordNumber)){
				num = Integer.parseInt(recordNumber);
				num = num < 1 ? 50:num;
			}
			
			List<Map<String, Object>> list = null;
			Map<String, Object> map = new HashMap<>();
			StringBuffer sbuffer = new StringBuffer();
				switch (type) {
				case "food"://下载食品信息；根据update_date进行增量更新
					sbuffer.setLength(0);
					sbuffer.append("select * from base_food_type where update_date>=?");
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

					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(),
                            lastUpdateTime);
					map.put("food", list);
					break;
					
				case "standard"://下载检测标准
					sbuffer.setLength(0);
					sbuffer.append(" select * from base_standard where update_date>=?");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and delete_flag=0 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(),
                            lastUpdateTime);
					map.put("standard", list);
					break;
					
				case "item"://下载检测项目
					sbuffer.setLength(0);
					sbuffer.append("select i.*,");
					sbuffer.append(" t.id t_id, t.item_name t_item_name, t.sorting t_sorting, t.remark t_remark, t.delete_flag t_delete_flag,");
					sbuffer.append(" t.create_by t_create_by, t.create_date t_create_date, t.update_by t_update_by, t.update_date t_update_date");
					sbuffer.append(" from base_detect_item i ");
					sbuffer.append(" LEFT JOIN base_item_type t on i.detect_item_typeid=t.id  ");
					sbuffer.append(" where (i.update_date>=? or t.update_date>=?)");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and i.delete_flag=0 and i.checked=1 and t.delete_flag=0 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("detectItem", list);
					break;
					
				case "foodItem"://下载样品与关联的检测项目信息
					sbuffer.setLength(0);
					sbuffer.append("SELECT bfi.id id, bfi.food_id food_id, bfi.item_id item_id, " + 
							" IF(bfi.use_default=0, bdi.detect_sign, bfi.detect_sign) detect_sign, " + 
							" IF(bfi.use_default=0, bdi.detect_value, bfi.detect_value) detect_value, " + 
							" IF(bfi.use_default=0, bdi.detect_value_unit, bfi.detect_value_unit) detect_value_unit, " + 
							" bfi.remark remark, bfi.use_default use_default, bfi.checked checked, " + 
							" bfi.delete_flag delete_flag, bfi.create_by create_by, bfi.create_date create_date, " + 
							" bfi.update_by update_by, bfi.update_date update_date " + 
							"	FROM base_food_item bfi  " + 
							"	INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id " );
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" INNER JOIN base_food_type bft ON bfi.food_id = bft.id ");
					}
					sbuffer.append("	WHERE (bfi.update_date >= ? or bdi.update_date >= ?) ");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" AND bfi.delete_flag=0 AND bfi.checked=1 AND bdi.delete_flag=0 AND bdi.checked=1 AND bft.delete_flag=0 AND bft.checked=1 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("foodItem", list);
					break;
					
				case "deviceSeries"://下载仪器系列
					sbuffer.setLength(0);
					sbuffer.append("select * from base_device_type where update_date>=?");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and delete_flag=0 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(),
                            lastUpdateTime);
					map.put("deviceSeries", list);
					break;
					
				case "deviceItem"://下载仪器检测项目
					required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
					
					sbuffer.setLength(0);
					sbuffer.append("select p.* from base_device_parameter p");
					sbuffer.append(" where p.id in (select i.device_parameter_id from base_devices_item i");
					sbuffer.append(" INNER JOIN base_device d on i.device_id=d.id ");
					sbuffer.append(" where d.serial_number=? ");
					sbuffer.append(" and (i.update_date>=? or d.update_date>=? ))");
					sbuffer.append(" and p.update_date>=? ");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and p.delete_flag=0 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), serialNumber,lastUpdateTime,lastUpdateTime,lastUpdateTime);
					map.put("deviceItem", list);
					break;
					
				case "laws"://下载法律法规
					sbuffer.setLength(0);
					sbuffer.append("select * from base_laws_regulations where update_date>=? ");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and delete_flag=0 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(),
                            lastUpdateTime);
					map.put("laws", list);
					break;
					
				case "regulatory"://下载监管对象，只查询当前用户机构下的监管对象
					
					sbuffer.setLength(0);
					sbuffer.append("select bro.id id, bro.depart_id depart_id, bro.reg_name reg_name, brt.reg_type reg_type, ");
					sbuffer.append("bro.link_user link_user, bro.link_phone link_phone, bro.link_idcard link_idcard, bro.fax fax, bro.post post, ");
					sbuffer.append("bro.region_id region_id, bro.reg_address reg_address, bro.place_x place_x, bro.place_y place_y, ");
					sbuffer.append("brt.show_business remark, bro.checked checked, bro.delete_flag delete_flag, bro.sorting sorting, ");
					sbuffer.append("bro.create_by create_by, bro.create_date create_date, bro.update_by update_by, bro.update_date update_date ");
					sbuffer.append("from base_regulatory_object bro ");
					sbuffer.append("left join base_regulatory_type brt on brt.id = bro.reg_type ");
					sbuffer.append("where (bro.update_date>=? or brt.update_date>=?) ");

					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
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
					
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime, lastUpdateTime);
					map.put("regulatory", list);
					break;
					
				case "license"://下载许可证
					sbuffer.setLength(0);
					sbuffer.append("select * from base_regulatory_license where update_date>=? ");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and delete_flag=0 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("license", list);
					break;
					
				case "business"://下载经营户，只查询当前用户机构下的经营户
					sbuffer.setLength(0);
					sbuffer.append("SELECT brb.id id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, " 
							+ "	brb.ope_name, brb.ope_idcard, brb.ope_phone, brb.credit_rating, " 
							+ "	brb.monitoring_level, brb.qrcode, brb.remark, brb.checked, CONCAT(brb.type,'') type, "
							+ "	brb.delete_flag, brb.sorting, brb.create_by, brb.create_date, "
							+ "	brb.update_by, brb.update_date "
							+ " FROM base_regulatory_business brb INNER JOIN base_regulatory_object bro ON brb.reg_id = bro.id WHERE brb.update_date>=? ");

					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and brb.delete_flag=0 and bro.delete_flag=0 ");
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
					
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] { lastUpdateTime });
					map.put("business", list);
					break;
					
				case "personnel"://下载监管对象人员
					sbuffer.setLength(0);
					sbuffer.append("select * from base_regulatory_personnel where update_date>=? ");
					//重置数据，不下载已删除数据
					if ("2000-01-01 00:00:01".equals(lastUpdateTime)) {
						sbuffer.append(" and delete_flag=0 ");
					}
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*num < 0 ? 0 : (page-1)*num) +", "+num);
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(),
                            lastUpdateTime);
					map.put("personnel", list);
					break;
					
				default:
					throw new MyException("下载类型未定义", "下载类型未定义", WebConstant.INTERFACE_CODE5);
				}
				aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
}
