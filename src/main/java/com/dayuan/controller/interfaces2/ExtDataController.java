package com.dayuan.controller.interfaces2;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.util.DateUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

/**
 * 对外数据接口
 * @author Dz
 */
@RestController
@RequestMapping("/ext/data")
public class ExtDataController extends BaseInterfaceController {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 获取东营大屏检测分析数据
	 * @return
	 */
	@RequestMapping(value = "/getAnalysis", method = RequestMethod.POST)
	public InterfaceJson getAnalysis(String userToken){

		InterfaceJson result = new InterfaceJson();

		JSONObject obj = new JSONObject();
		JSONArray cdate = new JSONArray();

		try {
			//token验证
			TSUser user = tokenExpired(userToken);

			//获取检测分析数据，1:今日，2:今月，3:今年
			for (int type=1; type<=3; type++) {

				//检测数量
				int jcs = 0;
				//不合格
				int jcsBhg = 0;
				//处置数量
				int czs = 0;
				//销毁数量(KG)
				double xhs = 0.0;

				//开始时间
				String start = "";
				//结束时间
				String end = "";
				//机构ID
				Integer departId = user.getDepartId();

				JSONObject cdateObj = new JSONObject();
				if (departId != null) {
					StringBuffer sql = new StringBuffer();

					//获取检测分析数据，1:今日，2:今月，3:今年
					switch (type) {
						case 1:
							cdateObj.put("type", "day");
							Calendar c1 = Calendar.getInstance();
							start = DateUtil.formatDate(c1.getTime(), "yyyy-MM-dd 00:00:00");
							end = DateUtil.formatDate(c1.getTime(), "yyyy-MM-dd HH:mm:ss");
							break;

						case 2:
							cdateObj.put("type", "month");
							Calendar c2 = Calendar.getInstance();
							start = DateUtil.formatDate(c2.getTime(), "yyyy-MM-01 00:00:00");
							end = DateUtil.formatDate(c2.getTime(), "yyyy-MM-dd HH:mm:ss");
							break;

						case 3:
							cdateObj.put("type", "year");
							Calendar c3 = Calendar.getInstance();
							start = DateUtil.formatDate(c3.getTime(), "yyyy-MM-01 00:00:00");
							end = DateUtil.formatDate(c3.getTime(), "yyyy-MM-dd HH:mm:ss");

							sql.append("SELECT SUM(check_number) jcs, SUM(unqualified_number) jcsBhg, " +
									"   SUM(dispose_number) czs, SUM(destroy_number) xhs " +
									"FROM data_monthly_statistics " +
									"WHERE delete_flag = 0 " +
									"   AND depart_id = ? AND yyyy_mm LIKE ? ");

							Map<String, Object> qr = jdbcTemplate.queryForMap(sql.toString(), new Object[]{departId.intValue(), c3.get(Calendar.YEAR)+"%"});
							if (qr!=null && !qr.isEmpty()) {
								jcs = qr.containsKey("jcs") && qr.get("jcs") != null ? jcs + Integer.parseInt(qr.get("jcs").toString()) : jcs;
								jcsBhg = qr.containsKey("jcsBhg") && qr.get("jcsBhg") != null ? jcsBhg + Integer.parseInt(qr.get("jcsBhg").toString()) : jcsBhg;
								czs = qr.containsKey("czs") && qr.get("czs") != null ? czs + Integer.parseInt(qr.get("czs").toString()) : czs;
								xhs = qr.containsKey("xhs") && qr.get("xhs") != null ? xhs + Double.parseDouble(qr.get("xhs").toString()) : xhs;
							}
							break;

						default:
							break;
					}
					if (StringUtils.isNotBlank(start) && StringUtils.isNotBlank(end)) {
						sql.setLength(0);
						//检测数量、不合格数量
						sql.append("SELECT COUNT(1) jcs, SUM(IF(conclusion = '不合格', 1, 0)) jcsBhg " +
								"FROM data_check_recording " +
								"WHERE delete_flag = 0 AND param7 = 1 " +
								"  AND check_date BETWEEN ? AND ? " +
								"  AND depart_id IN (SELECT id FROM t_s_depart " +
								"    WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?),'%'))");

						List<Map<String, Object>> l1 = jdbcTemplate.queryForList(sql.toString(), new Object[]{start, end, departId.intValue()});
						if (l1 != null && l1.size() > 0) {
							Map<String, Object> qr1 = l1.get(0);
							if (qr1!=null && !qr1.isEmpty()) {
								jcs = qr1.containsKey("jcs") && qr1.get("jcs") != null ? jcs + Integer.parseInt(qr1.get("jcs").toString()) : jcs;
								jcsBhg = qr1.containsKey("jcsBhg") && qr1.get("jcsBhg") != null ? jcsBhg + Integer.parseInt(qr1.get("jcsBhg").toString()) : jcsBhg;
							}
						}

						sql.setLength(0);
						//已处理数量、销毁食品数量
						sql.append("SELECT COUNT(DISTINCT dut.id) czs, SUM(dud.dispose_value1) xhs  " +
								"FROM data_check_recording dcr  " +
								"  INNER JOIN data_unqualified_treatment dut ON dcr.rid = dut.check_recording_id  " +
								"  INNER JOIN data_unqualified_dispose dud ON dut.id = dud.unid  " +
								"WHERE dcr.delete_flag = 0 AND dcr.param7 = 1  " +
								"  AND dcr.check_date BETWEEN ? AND ?  " +
								"  AND dcr.conclusion = '不合格'  " +
								"  AND dcr.depart_id IN (SELECT id FROM t_s_depart   " +
								"    WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?),'%'))  " +
								"  AND dut.deal_method = 1 ");

						List<Map<String, Object>> l2 = jdbcTemplate.queryForList(sql.toString(), new Object[]{start, end, departId.intValue()});
						if (l2 != null && l2.size() > 0) {
							Map<String, Object> qr2 = l2.get(0);
							if (qr2!=null && !qr2.isEmpty()) {
								czs = qr2.containsKey("czs") && qr2.get("czs") != null ? czs + Integer.parseInt(qr2.get("czs").toString()) : czs;
								xhs = qr2.containsKey("xhs") && qr2.get("xhs") != null ? xhs + Double.parseDouble(qr2.get("xhs").toString()) : xhs;
							}
						}
					}
				}

				//检测数量（单位：批次）
				cdateObj.put("check_num", jcs);
				//合格数量（单位：批次）
				cdateObj.put("qualified_num", jcs - jcsBhg);
				//不合格数量（单位：批次）
				cdateObj.put("unqualified_num", jcsBhg);
				//合格率，取4位小数
				cdateObj.put("pass_rate", (jcs == 0 ? 1.0000 : new BigDecimal((jcs - jcsBhg) * 1.0 / jcs).setScale(4, RoundingMode.HALF_UP)));
				//处置率，取4位小数
				cdateObj.put("disposal_rate", (jcsBhg == 0 ? 1.0000 : new BigDecimal(czs * 1.0 / jcsBhg).setScale(4, RoundingMode.HALF_UP)));
				//销毁数量（单位：公斤）
				cdateObj.put("destroy_num", xhs);
				//预留1
				cdateObj.put("param1", "");
				//预留2
				cdateObj.put("param2", "");

				cdate.add(cdateObj);
			}

		} catch (MyException e) {
			setAjaxJson(result, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(result, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		obj.put("cdate", cdate);
		result.setObj(obj);

		return result;
	}

}
