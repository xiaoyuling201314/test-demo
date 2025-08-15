package com.dayuan.service.statistics;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.Page;
import com.dayuan.bean.statistics.DataRegStatistics;
import com.dayuan.mapper.statistics.DataRegStatisticsMapper;
import com.dayuan.model.statistics.DataRegStatisticsModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.ArithUtil;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;

@Service("DataRegStatisticsService")
public class DataRegStatisticsService extends BaseService<DataRegStatistics, Integer>{
	@Autowired
	private DataRegStatisticsMapper mapper;
	
	private final SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
	
	public DataRegStatisticsMapper getMapper() {
		return mapper;
	}
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 批量新增
	 * @param list
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public int insertList(List<DataRegStatistics> list) {
		return mapper.insertList(list);
	}
	
	/**
	 * 根据机构和月份获取市场统计
	 * @param departId 机构ID
	 * @param regId 监管对象ID
	 * @param yyyyMM 年月
	 * @return
	 */
	public List<DataRegStatistics> queryByDepart(Integer departId, Integer regId, Date yyyyMM) {
		return mapper.queryByDepart(departId, regId, yyyy_MM.format(yyyyMM));
	}
	
	 /**
	  * 获取当月统计记录数量
	  * @author Dz
	  * 2019年3月14日 上午11:10:28
	  * @param yyyyMM
	  * @return
	  */
	public int queryNumByYm(Date yyyyMM) {
		return mapper.queryNumByYm(yyyy_MM.format(yyyyMM));
	}
	
	 /**
	  * 根据机构和月份获取市场统计分页数据
	  * @param page
	  * @param model
	  * @return
	  * @throws Exception
	  */
	public Page loadDatagridByDepart(Page page, DataRegStatisticsModel model) throws Exception{
		
		SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
		Date date1 = yyyy_MM.parse(DateUtil.firstDayOfMonth());	//当月
		
		if (model.getYyyyMM().getTime() < date1.getTime()) {	//历史统计
			return loadDatagrid(page, model);
			
		} else {	//实时统计
			List<DataRegStatistics> regStatistics = queryRegStatstics(date1, model.getDepartId(), model.getUserRegId());
			
			// 初始化分页参数
			if (null == page) {
				page = new Page();
			}

			// 每次查询记录总数量,防止新增或删除记录后总数量错误
			page.setRowTotal(regStatistics.size());

			// 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
			page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
			
			//查看页不存在,修改查看页序号
			if(page.getPageNo() <= 0){
				page.setPageNo(1);
			}else if(page.getPageNo() > page.getPageCount()){
				page.setPageNo(page.getPageCount());
			}
			
			List<DataRegStatistics> dataList = new ArrayList<DataRegStatistics>();
			int ps = page.getRowOffset();
			while (ps <= page.getRowTail()) {
				dataList.add(regStatistics.get(ps));
				ps++;
			}
			
			page.setResults(dataList);
			
			return page;
		}
		
	}

	 /**
	  * 根据监管对象和月份获取市场统计分页数据
	  * @param page
	  * @param model
	  * @return
	  * @throws Exception
	  */
	public Page loadDatagridByReg(Page page, DataRegStatisticsModel model) throws Exception{

		SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
		Date date1 = yyyy_MM.parse(DateUtil.firstDayOfMonth());	//当月

		if (model.getYyyyMM().getTime() < date1.getTime()) {	//历史统计
			return loadDatagrid(page, model);

		} else {	//实时统计
			List<DataRegStatistics> regStatistics = queryRegStatstics(date1, null, model.getUserRegId());

			// 初始化分页参数
			if (null == page) {
				page = new Page();
			}

			// 每次查询记录总数量,防止新增或删除记录后总数量错误
			page.setRowTotal(regStatistics.size());

			// 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
			page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

			//查看页不存在,修改查看页序号
			if(page.getPageNo() <= 0){
				page.setPageNo(1);
			}else if(page.getPageNo() > page.getPageCount()){
				page.setPageNo(page.getPageCount());
			}

			List<DataRegStatistics> dataList = new ArrayList<DataRegStatistics>();
			int ps = page.getRowOffset();
			while (ps <= page.getRowTail()) {
				dataList.add(regStatistics.get(ps));
				ps++;
			}

			page.setResults(dataList);

			return page;
		}

	}
	
	
	/**
    * 根据机构和月份获取市场覆盖率
	 * @param yyyyMM 统计年月
	 * @param departId 机构ID
	 * @param regId 监管对象ID
    * @return
	 * @throws Exception 
    */
	public List<DataRegStatistics> queryRegStatstics(Date yyyyMM, Integer departId, Integer regId) throws Exception{
		
		SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
		Date date1 = yyyy_MM.parse(DateUtil.firstDayOfMonth());	//当月

		if (yyyyMM.getTime() < date1.getTime()) {
			//历史统计
			return this.queryByDepart(departId, regId, yyyyMM);
			
		}else {
			//实时统计
			List<DataRegStatistics> statstics = regStatstics(date1, departId, regId);
			
			//排序
//			statstics.sort(new myComparator());
			
			return statstics;
		}
	}
	
	private final DecimalFormat decimalFormat = new DecimalFormat("###.###%");
	/**
	 * 覆盖率排序
	 * @author Dz
	 * 2019年3月12日 上午10:48:46
	 */
	private class myComparator implements Comparator {
		@Override
		public int compare(Object o1, Object o2) {
			
			DataRegStatistics rs1 = (DataRegStatistics) o1;
			DataRegStatistics rs2 = (DataRegStatistics) o2;
			
			//按档口覆盖率和样品覆盖率倒序排列
//			Double scr1 = 0.0;
//			Double scr2 = 0.0;
//			Double sfr1 = 0.0;
//			Double sfr2 = 0.0;
//			
//			try {
//				scr1 = decimalFormat.parse(rs1.getStallCheckRate()).doubleValue();
//				scr2 = decimalFormat.parse(rs2.getStallCheckRate()).doubleValue();
//				sfr1 = decimalFormat.parse(rs1.getFoodCheckRate()).doubleValue();
//				sfr2 = decimalFormat.parse(rs2.getFoodCheckRate()).doubleValue();
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
//			
//			if(scr1 != scr2)
//				return scr2 > scr1 ? 1 : -1;
//				else
//					return sfr2 > sfr1 ? 1 : -1;
			
			
			//按档口检测数量和样品检测数量倒序排列
			int scr1 = rs1.getStallCheckNum();
			int scr2 = rs2.getStallCheckNum();
			int sfr1 = rs1.getFoodCheckNum();
			int sfr2 = rs2.getFoodCheckNum();
			
			if(scr1 != scr2)
	            return scr2 > scr1 ? 1 : -1;
	        else
	            return sfr2 > sfr1 ? 1 : -1;
	            
		}
		
	}
	
	/**
	 * 保存市场覆盖率
	 * @param yyyyMM 统计年月
	 * @param departId 机构ID
	 * @param regId 监管对象ID
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void saveRegStatstics(Date yyyyMM, Integer departId, Integer regId) throws Exception{
		
		SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
		Date date1 = yyyy_MM.parse(DateUtil.firstDayOfMonth());	//当月
		
		if (yyyyMM.getTime() < date1.getTime()) {
			//批量新增
			this.insertList(regStatstics(yyyyMM,  departId, regId));
		}
		
	}
	
	
	 /**
     * 根据机构和年月统计市场覆盖率
     * @param yyyyMM 统计年月
     * @param departId 机构ID
     * @param regId 监管对象ID
     * @return
	 * @throws Exception 
     */
	private List<DataRegStatistics> regStatstics(Date yyyyMM, Integer departId, Integer regId) throws Exception{
		
		Date dt1 = new Date();//计算耗时
		SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
		
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.setTime(yyyyMM);
        
		String ym1 = yyyy_MM.format(calendar.getTime());//统计年月

		String startTime = ym1+"-01 00:00:00";
		String lastTime = ym1 +"-"+ calendar.getActualMaximum(Calendar.DAY_OF_MONTH) + " 23:59:59";

		calendar.add(Calendar.MONTH, -1);
		String ym2 = yyyy_MM.format(calendar.getTime());	//统计年月的前一个月(样品对照库)


		Map<String, Object> map = new HashMap<String, Object>();
		StringBuffer sbuffer = new StringBuffer();
		//统计上个月已检档口的检测数据
		sbuffer.setLength(0);
		sbuffer.append("SELECT ? AS 'yyyy_mm', dcr.reg_id 'reg_id', " + 
				"	dcr.reg_user_id 'stall_id', " + 
				"	COUNT(1) 's_check_num', SUM(IF(dcr.conclusion='不合格',1,0)) 's_unqualified_num' " + 
				"	FROM data_check_recording dcr FORCE INDEX(`idx_ckdate`) " +
				"	WHERE dcr.delete_flag = 0 AND dcr.param7 = 1 ");
		if(null != departId) {
			sbuffer.append("	AND dcr.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = " + departId + "), '%'))  ");
		}
		if(null != regId) {
			sbuffer.append("	AND dcr.reg_id = " + regId + " ");
		}
		sbuffer.append("	AND dcr.check_date >= ? AND dcr.check_date <= ? " + 
				"	AND dcr.reg_id IS NOT NULL AND dcr.reg_user_id IS NOT NULL " + 
				"	GROUP BY dcr.reg_user_id");
		List<Map<String, Object>> list4 = jdbcTemplate.queryForList(sbuffer.toString(), ym1, startTime, lastTime);
		
		//统计上个月已检市场的每种样品检测数据
		sbuffer.setLength(0);
		sbuffer.append("SELECT ? AS 'yyyy_mm', dcr.reg_id 'reg_id', " + 
				"	dcr.food_id 'food_id', dcr.food_name 'food_name', " + 
				"	COUNT(1) 'f_check_num', SUM(IF(dcr.conclusion='不合格',1,0)) 'f_unqualified_num' " + 
				"	FROM data_check_recording dcr FORCE INDEX(`idx_ckdate`) " +
				"	WHERE dcr.delete_flag = 0 AND dcr.param7 = 1 ");
		if(null != departId) {
			sbuffer.append("	AND dcr.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = " + departId + "), '%'))  ");
		}
		if(null != regId) {
			sbuffer.append("	AND dcr.reg_id = " + regId + " ");
		}
		sbuffer.append("	AND dcr.check_date >= ? AND dcr.check_date <= ? " + 
				"	AND dcr.reg_id IS NOT NULL AND dcr.food_id IS NOT NULL " + 
				"	GROUP BY dcr.reg_id, dcr.food_id");
		List<Map<String, Object>> list5 = jdbcTemplate.queryForList(sbuffer.toString(), ym1, startTime, lastTime);
		
		//查询全部市场和档口，按市场ID排序
		sbuffer.setLength(0);
		sbuffer.append("SELECT bro.id reg_id, bro.reg_name reg_name, bro.delete_flag reg_delete_flag, bro.checked reg_checked, " + 
				"	brb.id stall_id, brb.ope_shop_code stall_code, brb.delete_flag stall_delete_flag, brb.checked stall_checked " + 
				"	FROM base_regulatory_object bro LEFT JOIN base_regulatory_business brb ON bro.id = brb.reg_id " + 
				"	WHERE 1=1  ");
		if(null != departId) {
			sbuffer.append("	AND bro.depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = " + departId + "), '%')) ");
		}
		if(null != regId) {
			sbuffer.append("	AND bro.id = " + regId + " ");
		}
		sbuffer.append("	ORDER BY bro.id ASC ");
		List<Map<String, Object>> list2 = jdbcTemplate.queryForList(sbuffer.toString());
		
		Iterator it2 = list2.iterator();	//全部全部市场和档口
		String wRegId = "";	//当前遍历市场ID
		int wRegDeleteFlag = 0; 	//当前遍历市场删除标记
		int wRegChecked = 0; 	//当前遍历市场审核标记
		
		int wRegCheckNum = 0;	//每个市场检测数量
		int wRegUnqualifiedNum = 0;//每个市场检测不合格数量
		
		int wRegStallNum = 0; //每个市场档口总数量
		int wRegCStallNum = 0; //每个市场已检测档口数量
		
		int wRegCFoodNum = 0; //每个市场已检测样品种类数量
		int wRegUCFoodNum = 0; //每个市场未检测样品种类数量
		
		DataRegStatistics regStatistics = null;	//市场统计
		
		List<DataRegStatistics> rsList = new ArrayList<DataRegStatistics>();	//市场档口
		List<Map<String,Object>> regStalls = null;	//市场档口
		List<Map<String,Object>> regFoods = null;	//市场样品
		while(it2.hasNext()) {
			Map map2 = (Map) it2.next();
			
			if("".equals(wRegId)) {	//首个或另一个市场
				
				wRegId = map2.get("reg_id").toString();
				wRegDeleteFlag = Integer.parseInt(map2.get("reg_delete_flag").toString()); 	//当前遍历市场删除标记
				wRegChecked = Integer.parseInt(map2.get("reg_checked").toString()); 	//当前遍历市场审核标记
				
				regStalls = new ArrayList<Map<String,Object>>();	//市场档口
				regFoods = new ArrayList<Map<String,Object>>();	//市场样品
				
				//保存市场统计
				regStatistics = new DataRegStatistics();
				regStatistics.setYyyyMm(ym1);
				regStatistics.setRegId((Integer) map2.get("reg_id"));
				regStatistics.setRegName((String) map2.get("reg_name"));
				regStatistics.setCreateDate(dt1);
				regStatistics.setUpdateDate(dt1);
				
				if(null != map2.get("stall_id") && !"".equals((map2.get("stall_id")+""))) {	//市场有档口
					
					//统计市场档口总数量、已检测档口数量;统计档口检测数量、不合格数量、不合格率
					Iterator it4 = list4.iterator();	//上个月每个档口检测数据统计
					if(!it4.hasNext()) {
						//保存档口统计数据
						Map<String,Object> rs = new HashMap<String, Object>();
						rs.put("s_id", map2.get("stall_id"));
						rs.put("s_code", map2.get("stall_code"));
						rs.put("s_check_num", 0);
						rs.put("s_unqualified_num", 0);
						rs.put("s_unqualified_rate", "0.0%");
						regStalls.add(rs);
						
						//当前市场档口总数量+1
						wRegStallNum++;
						
					}else {
						while(it4.hasNext()) {
							Map map4 = (Map) it4.next();
							
							if(wRegId.equals(map4.get("reg_id")+"") && (map2.get("stall_id")+"").equals(map4.get("stall_id")+"")) {	//同一个档口
								
								//保存档口统计数据
								Map<String,Object> rs = new HashMap<String, Object>();
								rs.put("s_id", map4.get("stall_id"));
								rs.put("s_code", map2.get("stall_code"));
								rs.put("s_check_num", ((Long)map4.get("s_check_num")).intValue());
								rs.put("s_unqualified_num", Integer.valueOf(map4.get("s_unqualified_num").toString()));
								if(Integer.valueOf(map4.get("s_unqualified_num").toString()) == 0 || ((Long)map4.get("s_check_num")).intValue() == 0) {
									rs.put("s_unqualified_rate", "0.0%");
								}else {
									rs.put("s_unqualified_rate", (ArithUtil.percentage(Integer.valueOf(map4.get("s_unqualified_num").toString()), ((Long)map4.get("s_check_num")).intValue())) + "%");
								}
								regStalls.add(rs);
								
								//市场已检测档口数量+1
								wRegCStallNum++;
								//当前市场档口总数量+1
								wRegStallNum++;
								
								it4.remove();
								break;
							}
							
							//（未删除且已审核）档口没有抽检				
							if(!it4.hasNext() && null != map2.get("stall_delete_flag") && "0".equals(map2.get("stall_delete_flag").toString())
									&& null != map2.get("stall_checked") && "1".equals(map2.get("stall_checked").toString()) ) {
								//保存档口统计数据
								Map<String,Object> rs = new HashMap<String, Object>();
								rs.put("s_id", map4.get("stall_id"));
								rs.put("s_code", map2.get("stall_code"));
								rs.put("s_check_num", 0);
								rs.put("s_unqualified_num", 0);
								rs.put("s_unqualified_rate", "0.0%");
								regStalls.add(rs);
								
								//当前市场档口总数量+1
								wRegStallNum++;
							}
						}
					}
				}
				
				it2.remove();
				
			}else if(wRegId.equals((map2.get("reg_id")+""))) {	//与上一个市场ID相同
				
				if(null != map2.get("stall_id") && !"".equals((map2.get("stall_id")+""))) {	//市场有档口
					
					//统计市场档口总数量、已检测档口数量;统计档口检测数量、不合格数量、不合格率
					Iterator it4 = list4.iterator();	//上个月每个档口检测数据统计
					if(!it4.hasNext()) {
						//保存档口统计数据
						Map<String,Object> rs = new HashMap<String, Object>();
						rs.put("s_id", map2.get("stall_id"));
						rs.put("s_code", map2.get("stall_code"));
						rs.put("s_check_num", 0);
						rs.put("s_unqualified_num", 0);
						rs.put("s_unqualified_rate", "0.0%");
						regStalls.add(rs);
						
						//当前市场档口总数量+1
						wRegStallNum++;
						
					}else {
						while(it4.hasNext()) {
							Map map4 = (Map) it4.next();
							
							if(wRegId.equals(map4.get("reg_id")+"") && (map2.get("stall_id")+"").equals(map4.get("stall_id")+"")) {	//同一个档口
								
								//保存档口统计数据
								Map<String,Object> rs = new HashMap<String, Object>();
								rs.put("s_id", map4.get("stall_id"));
								rs.put("s_code", map2.get("stall_code"));
								rs.put("s_check_num", ((Long)map4.get("s_check_num")).intValue());
								rs.put("s_unqualified_num", Integer.valueOf(map4.get("s_unqualified_num").toString()));
								if(Integer.valueOf(map4.get("s_unqualified_num").toString()) == 0 || ((Long)map4.get("s_check_num")).intValue() == 0) {
									rs.put("s_unqualified_rate", "0.0%");
								}else {
									rs.put("s_unqualified_rate", (ArithUtil.percentage(Integer.valueOf(map4.get("s_unqualified_num").toString()), ((Long)map4.get("s_check_num")).intValue())) + "%");
								}
								regStalls.add(rs);
								
								//市场已检测档口数量+1
								wRegCStallNum++;
								//当前市场档口总数量+1
								wRegStallNum++;
								
								it4.remove();
								break;
							}
							
							//（未删除且已审核）档口没有抽检
							if(!it4.hasNext() && null != map2.get("stall_delete_flag") && "0".equals(map2.get("stall_delete_flag").toString())
									&& null != map2.get("stall_checked") && "1".equals(map2.get("stall_checked").toString()) ) {
								//保存档口统计数据
								Map<String,Object> rs = new HashMap<String, Object>();
								rs.put("s_id", map4.get("stall_id"));
								rs.put("s_code", map2.get("stall_code"));
								rs.put("s_check_num", 0);
								rs.put("s_unqualified_num", 0);
								rs.put("s_unqualified_rate", "0.0%");
								regStalls.add(rs);
								
								//当前市场档口总数量+1
								wRegStallNum++;
							}
						}
					}
				}
				
				it2.remove();	
				
			}else {		//与上一个市场ID不同
				
				//获取该市场再上一个月的检测数量大于0的样品种类作为样品种类对照库
				sbuffer.setLength(0);
				sbuffer.append("SELECT food_statistics FROM data_reg_statistics WHERE yyyy_mm = ? AND reg_id = ? AND delete_flag = 0 ");
				List<Map<String, Object>> fsm = jdbcTemplate.queryForList(sbuffer.toString(), ym2, wRegId);
				String foodStatistics = "[]";
				if(fsm!=null&&fsm.size()>0) {
					foodStatistics = (String) fsm.get(0).get("food_statistics");
				}
				List<Map<String, Object>> list6 = (List<Map<String, Object>>) JSONArray.parse(foodStatistics);
				
				//统计市场样品种类总数、已检测样品种类数量、未检测样品种类数量、样品种类覆盖率
				Iterator it5 = list5.iterator();	//上个月每个市场的每种样品检测数据统计
				while(it5.hasNext()) {
					Map map5 = (Map) it5.next();
					if(wRegId.equals(map5.get("reg_id")+"")) {	//同一个市场

						//删除对照库已检测或检测数量为0的样品种类
						Iterator it6 = list6.iterator();
						while(it6.hasNext()) {
							Map map6 = (Map) it6.next();
							if(map5.get("food_id").equals(map6.get("f_id")) || 0 == Integer.valueOf(map6.get("f_check_num").toString())) {
								it6.remove();
							}
						}
						
						//统计上个月已检测样品数据
						Map<String,Object> rf = new HashMap<String, Object>();
						rf.put("f_id", map5.get("food_id"));
						rf.put("f_name", map5.get("food_name"));
						rf.put("f_check_num", ((Long)map5.get("f_check_num")).intValue());
						rf.put("f_unqualified_num", Integer.valueOf(map5.get("f_unqualified_num").toString()));
						if(Integer.valueOf(map5.get("f_unqualified_num").toString()) == 0 || ((Long)map5.get("f_check_num")).intValue() == 0) {
							rf.put("f_unqualified_rate", "0.0%");
						}else {
							rf.put("f_unqualified_rate", (ArithUtil.percentage(Integer.valueOf(map5.get("f_unqualified_num").toString()), ((Long)map5.get("f_check_num")).intValue())) + "%");
						}
						regFoods.add(rf);
						
						//市场检测数量
						wRegCheckNum += ((Long)map5.get("f_check_num")).intValue();
						//市场检测不合格数量
						wRegUnqualifiedNum += Integer.valueOf(map5.get("f_unqualified_num").toString());
						
						//市场已检测样品种类数量+1
						wRegCFoodNum++;
						
						it5.remove();
					}
				}
				
				//统计上个月未检测样品种类
				Iterator it6 = list6.iterator();
				while(it6.hasNext()) {
					Map map6 = (Map) it6.next();
					Map<String,Object> rf = new HashMap<String, Object>();
					rf.put("f_id", map6.get("f_id"));
					rf.put("f_name", map6.get("f_name"));
					rf.put("f_check_num", 0);
					rf.put("f_unqualified_num", 0);
					rf.put("f_unqualified_rate", "0.0%");
					regFoods.add(rf);
					
					//市场未检测样品种类数量+1
					wRegUCFoodNum++;
				}
				
				//统计上一个市场检测次数、不合格次数、不合格率
				regStatistics.setrCheckNum(wRegCheckNum);
				regStatistics.setrUnqualifiedNum(wRegUnqualifiedNum);
				if(wRegUnqualifiedNum == 0 || wRegCheckNum == 0) {
					regStatistics.setrUnqualifiedRate("0.0%");
				}else {
					regStatistics.setrUnqualifiedRate((ArithUtil.percentage(wRegUnqualifiedNum, wRegCheckNum)) + "%");
				}
				
				//统计上一个市场档口总数量、已检测档口数量、未检测档口数量、检测档口覆盖率
				regStatistics.setStallAllNum(wRegStallNum);
				regStatistics.setStallCheckNum(wRegCStallNum);
				regStatistics.setStallUncheckNum(wRegStallNum - wRegCStallNum);
				if(wRegCStallNum == 0 || wRegStallNum == 0) {
					regStatistics.setStallCheckRate("0.0%");
				}else {
					regStatistics.setStallCheckRate((ArithUtil.percentage(wRegCStallNum, wRegStallNum)) + "%");
				}
				
				//统计上一个市场样品种类总数量、已检测样品种类数量、未检测样品种类数量、检测样品种类覆盖率
				regStatistics.setFoodAllNum(wRegCFoodNum + wRegUCFoodNum);
				regStatistics.setFoodCheckNum(wRegCFoodNum);
				regStatistics.setFoodUncheckNum(wRegUCFoodNum);
				if(wRegCFoodNum == 0) {
					regStatistics.setFoodCheckRate("0.0%");
				}else {
					regStatistics.setFoodCheckRate((ArithUtil.percentage(wRegCFoodNum, wRegCFoodNum + wRegUCFoodNum)) + "%");
				}
				
				//市场档口统计
				regStatistics.setStallStatistics(JSONObject.toJSONString(regStalls));
				//市场样品统计
				regStatistics.setFoodStatistics(JSONObject.toJSONString(regFoods));
				
				//检测次数大于0或未删除且已审核的市场				
				if(0 < regStatistics.getrCheckNum() || ( 0 == wRegDeleteFlag && 1 == wRegChecked ) ) {
					rsList.add(regStatistics);
				}
				
				//重新开始统计下一个市场
				wRegId = "";	//当前遍历市场ID
				wRegDeleteFlag = 0; 	//当前遍历市场删除标记
				wRegChecked = 0; 	//当前遍历市场审核标记
				wRegCheckNum = 0;	//每个市场检测数量
				wRegUnqualifiedNum = 0;//每个市场检测不合格数量
				wRegStallNum = 0; //每个市场档口总数量
				wRegCStallNum = 0; //每个市场已检测档口数量
				wRegCFoodNum = 0; //每个市场已检测样品种类数量
				wRegUCFoodNum = 0; //每个市场未检测样品种类数量
				it2 = list2.iterator();
				
			}
			
			if(!it2.hasNext()) {//最后一个市场档口

				//获取该市场再上一个月的检测数量大于0的样品种类作为样品种类对照库
				sbuffer.setLength(0);
				sbuffer.append("SELECT food_statistics FROM data_reg_statistics WHERE yyyy_mm = ? AND reg_id = ? AND delete_flag = 0 ");
				List<Map<String, Object>> fsm = jdbcTemplate.queryForList(sbuffer.toString(), ym2, wRegId);
				String foodStatistics = "[]";
				if(fsm!=null&&fsm.size()>0) {
					foodStatistics = (String) fsm.get(0).get("food_statistics");
				}
				List<Map<String, Object>> list6 = (List<Map<String, Object>>) JSONArray.parse(foodStatistics);
				
				//统计市场样品种类总数、已检测样品种类数量、未检测样品种类数量、样品种类覆盖率
				Iterator it5 = list5.iterator();	//上个月每个市场的每种样品检测数据统计
				while(it5.hasNext()) {
					Map map5 = (Map) it5.next();
					if(wRegId.equals(map5.get("reg_id")+"")) {	//同一个市场
						
						//删除对照库已检测或检测数量为0的样品种类
						Iterator it6 = list6.iterator();
						while(it6.hasNext()) {
							Map map6 = (Map) it6.next();
							if(map5.get("food_id").equals(map6.get("f_id")) || 0 == Integer.valueOf(map6.get("f_check_num").toString())) {
								it6.remove();
							}
						}
						
						//统计上个月已检测样品数据
						Map<String,Object> rf = new HashMap<String, Object>();
						rf.put("f_id", map5.get("food_id"));
						rf.put("f_name", map5.get("food_name"));
						rf.put("f_check_num", ((Long)map5.get("f_check_num")).intValue());
						rf.put("f_unqualified_num", Integer.valueOf(map5.get("f_unqualified_num").toString()));
						if(Integer.valueOf(map5.get("f_unqualified_num").toString()) == 0 || ((Long)map5.get("f_check_num")).intValue() == 0) {
							rf.put("f_unqualified_rate", "0.0%");
						}else {
							rf.put("f_unqualified_rate", (ArithUtil.percentage(Integer.valueOf(map5.get("f_unqualified_num").toString()), ((Long)map5.get("f_check_num")).intValue())) + "%");
						}
						regFoods.add(rf);
						
						//市场检测数量
						wRegCheckNum += ((Long)map5.get("f_check_num")).intValue();
						//市场检测不合格数量
						wRegUnqualifiedNum += Integer.valueOf(map5.get("f_unqualified_num").toString());
						
						//市场已检测样品种类数量+1
						wRegCFoodNum++;
						
						it5.remove();
					}
				}
				
				//统计上个月未检测样品种类
				Iterator it6 = list6.iterator();
				while(it6.hasNext()) {
					Map map6 = (Map) it6.next();
					
					Map<String,Object> rf = new HashMap<String, Object>();
					rf.put("f_id", map6.get("f_id"));
					rf.put("f_name", map6.get("f_name"));
					rf.put("f_check_num", 0);
					rf.put("f_unqualified_num", 0);
					rf.put("f_unqualified_rate", "0.0%");
					regFoods.add(rf);
					
					//市场未检测样品种类数量+1
					wRegUCFoodNum++;
				}
				
				//统计上一个市场检测次数、不合格次数、不合格率
				regStatistics.setrCheckNum(wRegCheckNum);
				regStatistics.setrUnqualifiedNum(wRegUnqualifiedNum);
				if(wRegUnqualifiedNum == 0 || wRegCheckNum == 0) {
					regStatistics.setrUnqualifiedRate("0.0%");
				}else {
					regStatistics.setrUnqualifiedRate((ArithUtil.percentage(wRegUnqualifiedNum, wRegCheckNum)) + "%");
				}
				
				//统计上一个市场档口总数量、已检测档口数量、未检测档口数量、检测档口覆盖率
				regStatistics.setStallAllNum(wRegStallNum);
				regStatistics.setStallCheckNum(wRegCStallNum);
				regStatistics.setStallUncheckNum(wRegStallNum - wRegCStallNum);
				if(wRegCStallNum == 0 || wRegStallNum == 0) {
					regStatistics.setStallCheckRate("0.0%");
				}else {
					regStatistics.setStallCheckRate((ArithUtil.percentage(wRegCStallNum, wRegStallNum)) + "%");
				}
				
				//统计上一个市场样品种类总数量、已检测样品种类数量、未检测样品种类数量、检测样品种类覆盖率
				regStatistics.setFoodAllNum(wRegCFoodNum + wRegUCFoodNum);
				regStatistics.setFoodCheckNum(wRegCFoodNum);
				regStatistics.setFoodUncheckNum(wRegUCFoodNum);
				if(wRegCFoodNum == 0) {
					regStatistics.setFoodCheckRate("0.0%");
				}else {
					regStatistics.setFoodCheckRate((ArithUtil.percentage(wRegCFoodNum, wRegCFoodNum + wRegUCFoodNum)) + "%");
				}
				
				//市场档口统计
				regStatistics.setStallStatistics(JSONObject.toJSONString(regStalls));
				//市场样品统计
				regStatistics.setFoodStatistics(JSONObject.toJSONString(regFoods));
				
				//检测次数大于0或未删除且已审核的市场				
				if(0 < regStatistics.getrCheckNum() || ( 0 == wRegDeleteFlag && 1 == wRegChecked ) ) {
					rsList.add(regStatistics);
				}
				
			}
		}
		
//		System.out.println(ym1+"市场覆盖率统计完成，耗时:"+(new Date().getTime()-dt1.getTime())+"ms");
		return rsList;
		
	}
	
	
}
