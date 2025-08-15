package com.dayuan.controller.statistics;

import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.controller.BaseController;
import com.dayuan.controller.data.BaseDeviceController;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.MD5Utils;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;


/**
 * 数据公示
 */
@Controller
@RequestMapping("/publicity")
public class PublicityController extends BaseController {

	private Logger log = Logger.getLogger(BaseDeviceController.class);

	@Autowired
	private BaseRegulatoryObjectService regulatoryObjectService;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 安卓显示器数据公示
	 *
	 * @param r     监管对象ID
	 * @param s     刷新频率（秒）
	 * @param p     读取最大数据量
	 * @param key       MD5加密大写(DAYUAN+监管对象ID)
	 * @author Dz
	 * @date 2023年2月14日
	 */
	@RequestMapping("/page1")
	public ModelAndView page1(int r, Integer s, Integer p, String key) {
		Map map = new HashMap();

		//默认刷新频率（秒）
		if (s == null || s.intValue()<0) {
			s = 300;
		}

		//读取最大数据量
		if (p == null || p.intValue()<0 || p.intValue()>100) {
			p = 25;
		}

		//密钥校验
		String key0 = MD5Utils.md5UpperCase("DAYUAN"+r);
		//取数据密钥
		String dKey = "";
		//错误key：0正常,1异常
		int errorKey = 0;
		if (key0.equals(key)) {
			errorKey = 0;
			dKey = MD5Utils.md5UpperCase("DAYUAN"+r+p.intValue());
		} else {
			//错误key
			errorKey = 1;
		}

		//市场名称
		String regName = "";
		try {
			if (errorKey == 0) {
				BaseRegulatoryObject reg = regulatoryObjectService.queryById(r);
				if (reg != null) {
					regName = reg.getRegName();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		//系统名称
		String systemName = SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName");
		//版权
		String copyright = SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2");


		map.put("errorKey", errorKey);
		map.put("dKey", dKey);
		map.put("r", r);
		map.put("s", s.intValue());
		map.put("p", p.intValue());
		map.put("regName", regName);
		map.put("systemName", systemName);
		map.put("copyright", copyright);

		return new ModelAndView("/statistics/publicity/page1", map);
	}

	/**
	 * 取数据公示1数据
	 * @param r     监管对象ID
	 * @param p     读取最大数据量
	 * @param key       MD5加密大写(DAYUAN+监管对象ID+读取最大数据量)
	 * @author Dz
	 * @date 2023年2月14日
	 */
	@RequestMapping(value="/pageData1")
	@ResponseBody
	public Map pageData1(int r, int p, String key){
		Map map = new HashMap();

		//检测总数
		int zs = 0;
		//不合格数
		int bhg = 0;
		//检测数据
		List checkData = new ArrayList();

		try {
			//取数据密钥
			String key0 = MD5Utils.md5UpperCase("DAYUAN"+r+p);

			if (key0.equals(key)) {

				//取月数据时间
				String start = DateUtil.formatDate(new Date(), "yyyy-MM-01 00:00:00");
				String end = DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss");

				StringBuffer sql = new StringBuffer();

				//查月总数、不合格数
				sql.append("SELECT SUM(IF(tb1.zs IS NULL, 0, tb1.zs)) zs, SUM(IF(tb1.bhg IS NULL, 0, tb1.bhg)) bhg " +
						"FROM " +
						"( " +

						//取检测总数 -停用，暂时只取月数据
//						"  SELECT SUM(drs.r_check_num) zs, SUM(drs.r_unqualified_num) bhg " +
//						"    FROM data_reg_statistics drs " +
//						"  WHERE drs.delete_flag=0 AND drs.reg_id=? " +
//						"  UNION " +

						"  SELECT COUNT(1) zs, SUM(IF(dcr.conclusion = '不合格', 1, 0)) bhg " +
						"    FROM data_check_recording dcr " +
						"  WHERE dcr.delete_flag=0 AND dcr.check_date BETWEEN ? AND ?  " +
						"    AND dcr.reg_id=? " +
						") tb1 ");
				Map map1 = jdbcTemplate.queryForMap(sql.toString(), new Object[]{start, end, r});
				zs = Integer.parseInt(map1.get("zs").toString());
				bhg = Integer.parseInt(map1.get("bhg").toString());

				sql.setLength(0);
				//查日检测数据
				sql.append("SELECT food_name foodName, item_name itemName, reg_user_name shopCode, conclusion, check_date checkDate " +
						" FROM data_check_recording  " +
						"WHERE delete_flag=0 AND reg_id=? " +
						" AND check_date BETWEEN ? AND ? " +
						"ORDER BY check_date DESC ");
				checkData = jdbcTemplate.queryForList(sql.toString(), new Object[]{r, DateUtil.formatDate(new Date(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")});

				//当天数据小于p，取当月数据前p数据
				if (checkData.size() < p) {
					sql.setLength(0);
					//查月检测数据
					sql.append("SELECT food_name foodName, item_name itemName, reg_user_name shopCode, conclusion, check_date checkDate " +
							" FROM data_check_recording  " +
							"WHERE delete_flag=0 AND reg_id=? " +
							" AND check_date BETWEEN ? AND ? " +
							"ORDER BY check_date DESC LIMIT 0, ? ");
					checkData = jdbcTemplate.queryForList(sql.toString(), new Object[]{r, start, end, p});
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}

		map.put("zs", zs);
		map.put("bhg", bhg);
		map.put("checkData", checkData);

		return map;
	}

}
