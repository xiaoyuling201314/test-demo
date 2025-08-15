package com.dayuan.controller.interfaces2;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 不合格处理接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iDataUnqualified")
public class IDataUnqualifiedController extends BaseInterfaceController {
	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Value("${resourcesUrl}")
	private String resourcesUrl;
	
	/**
	 * 不合格处理-待处理数据下载
	 * @param userToken	用户token
	 * @param pageNumber 页码
	 * @param recordNumber 每页数量
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/unprocessedData", method = RequestMethod.POST)
	public InterfaceJson unprocessedData(HttpServletRequest request, String userToken,
			@RequestParam(value="pageNumber",defaultValue="0",required=false)String pageNumber, 
			@RequestParam(value="recordNumber",defaultValue="50",required=false)String recordNumber){
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			StringBuffer sbuffer = new StringBuffer();
			//add by xiaoyl 2022/05/19增加过滤条件，已删除的数据都是待处理数据
			sbuffer.append("SELECT dcr.rid id, dcr.food_id, dcr.food_name, " + 
					" dcr.item_id, dcr.item_name, dcr.reg_id, dcr.reg_name, " + 
					" dcr.reg_user_id, dcr.reg_user_name, dcr.depart_id, " + 
					" dcr.depart_name, dcr.point_id, dcr.point_name, " + 
					" dcr.check_username, dcr.auditor_name, dcr.upload_name, " + 
					" dcr.upload_date, dcr.check_date, dcr.check_accord, " + 
					" dcr.limit_value, dcr.check_result, dcr.check_unit, dcr.conclusion, " + 
					" dcr.device_model, dcr.device_method, dcr.status_falg, " + 
					" dcr.delete_flag " + 
					"FROM " + 
					"	data_check_recording dcr " + 
					"	LEFT JOIN data_unqualified_treatment dut ON dcr.rid = dut.check_recording_id and dut.delete_flag=0 " +
					"	WHERE dcr.delete_flag = 0  AND dcr.param7 = 1 AND dcr.conclusion = '不合格' AND dcr.data_type = 0 AND dut.id IS NULL ");
					
			
			if(null != user.getPointId()){	//检测点用户
				sbuffer.append(" AND dcr.depart_id= "+ user.getDepartId() +"	AND dcr.point_id = "+ user.getPointId() +" ");
				
			}else if(null != user.getRegId()){	//监管对象用户
				sbuffer.append(" AND dcr.depart_id= "+ user.getDepartId() +"	AND dcr.reg_id = "+ user.getRegId() +" ");
				
			}else{	//机构用户
				sbuffer.append("	AND dcr.depart_id IN (SELECT id FROM t_s_depart " + 
						"	WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+ user.getDepartId() +"),'%')) ");
			}

			sbuffer.append(" ORDER BY dcr.update_date DESC ");
			
			limit(sbuffer, pageNumber, recordNumber);
			
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
	 * 不合格处理-处理中和已处理数据下载
	 * @param userToken 用户token
	 * @param lastUpdateTime 最后更新时间
	 * @param pageNumber 页码
	 * @param recordNumber 每页数量
	 * @return
	 */
	@RequestMapping(value = "/download", method = RequestMethod.POST)
	public InterfaceJson download(HttpServletRequest request, String userToken, @RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime,
			@RequestParam(required = true, defaultValue = "0") String pageNumber, @RequestParam(required = true, defaultValue = "50") String recordNumber){
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			List<Map<String, Object>> list = null;
			StringBuffer sbuffer = new StringBuffer();
			
			//***************************合并不合格处理方式以字符串返回***************************
//			sbuffer.append("SELECT " + 
//					"	dut.id, dut.deal_method, dut.deal_type, dut.sperson_name, " + 
//					"	dut.sperson_phone, dut.send_date, dut.recheck_date, dut.update_date end_date, " + 
//					"	dut.recheck_value, dut.recheck_result, dut.recheck_depart, " + 
//					"	dut.supervision_depart, dut.supervisor, dut.supervisor_phone, " + 
//					"	dut.deal_situation, dut.remark, dut.param1, dut.param2, dut.param3, " + 
//					"GROUP_CONCAT( " + 
//					"		IF( " + 
//					"			dud.dispose_value1 IS NOT NULL, " + 
//					"			CONCAT_WS('', duc.handle_name, ':', dud.dispose_value1, dud.dispose_type), " + 
//					"			CONCAT_WS('', duc.handle_name) " + 
//					"		) SEPARATOR ';' " + 
//					"	) AS disposal, " + 
//					" dcr.rid check_recording_id, dcr.food_name, dcr.reg_name, dcr.reg_user_name, " + 
//					" tf.signature, tf.evidence, " + 
//					" tsu.realname handler, tsd.depart_name handler_depart " + 
//					"FROM data_unqualified_treatment AS dut " + 
//					"LEFT JOIN data_unqualified_dispose AS dud ON dud.unid = dut.id " + 
//					"LEFT JOIN data_unqualified_config AS duc ON dud.dispose_id = duc.id " + 
//					"INNER JOIN data_check_recording AS dcr ON dcr.rid = dut.check_recording_id " + 
//					"LEFT JOIN (SELECT source_id, " + 
//					"GROUP_CONCAT( CASE WHEN source_type = 'signPic' THEN CONCAT_WS('', '"+ WebConstant.res.getString("resourcesUrl") +"', file_path) END SEPARATOR ',' ) AS signature, " + 
//					"GROUP_CONCAT( CASE WHEN source_type = 'Enforce' THEN CONCAT_WS('', '"+ WebConstant.res.getString("resourcesUrl") +"', file_path) END SEPARATOR ',' ) AS evidence " + 
//					"FROM tb_file WHERE source_type IN ('signPic', 'Enforce') GROUP BY source_id) tf ON tf.source_id = dut.id " + 
//					"LEFT JOIN t_s_user tsu ON tsu.id = dut.create_by " + 
//					"INNER JOIN t_s_depart tsd ON tsd.id = tsu.depart_id " + 
//					"WHERE 1=1");
//			
//			if(null == user.getPointId()){
//				//根据用户所属检测机构查询检测结果
//				List<TSDepart> departs = departService.getAllSonDepartsByID(user.getDepartId());
//				if(departs!=null && departs.size()>0) {
//					sbuffer.append(" AND dcr.depart_id IN ( ");
//					for(TSDepart depart : departs) {
//						sbuffer.append(depart.getId() + ",");
//					}
//					sbuffer.deleteCharAt(sbuffer.length()-1);
//					sbuffer.append(" ) ");
//				}
//			}else{
//				//根据用户所属检测点查询检测结果
//				sbuffer.append(" AND dcr.point_id='"+user.getPointId()+"' ");
//			}
//			
//			sbuffer.append("AND dut.update_date>=? ");
//			sbuffer.append("GROUP BY dut.id");
//			if(pNum > 0 && rNum > 0){
//				sbuffer.append(" LIMIT "+ ((pNum-1)*rNum < 0 ? 0 : (pNum-1)*rNum) +", "+rNum);
//			}
//			
//			list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] { lastUpdateTime });
//			aj.setObj(list);
			
			
			
			
			//***************************不合格处理方式以数组形式返回***************************
			sbuffer.append("SELECT " + 
					"	dut.id, dut.deal_method, dut.deal_type, dut.sperson_name, " + 
					"	dut.sperson_phone, dut.send_date, dut.recheck_date, dut.update_date end_date, " + 	//不合格处理表update_date代替end_date
					"	dut.recheck_value, dut.recheck_result, dut.recheck_depart, " + 
					"	dut.supervision_depart, dut.supervisor, dut.supervisor_phone, " + 
					"	dut.deal_situation, dut.remark, dut.param1, dut.param2, dut.param3, " + 
					"	dcr.rid check_recording_id, dcr.food_name, dcr.item_name, dcr.check_result, dcr.reg_name, dcr.reg_user_name, " + 
					"	'' signature, '' evidence, " +

//					"	tf.signature, tf.evidence, " +

//					" ( " +
//					"  SELECT GROUP_CONCAT( CONCAT('" + resourcesUrl + "', file_path ) SEPARATOR ',')   " +
//					"  FROM tb_file  " +
//					"  WHERE delete_flag=0 AND source_type='signPic' AND source_id=dut.id " +
//					" ) signature, " +
//					" ( " +
//					"  SELECT GROUP_CONCAT( CONCAT('" + resourcesUrl + "', file_path ) SEPARATOR ',')   " +
//					"  FROM tb_file  " +
//					"  WHERE delete_flag=0 AND source_type='Enforce' AND source_id=dut.id " +
//					" ) evidence," +

					"	tsu.realname handler, tsd.depart_name handler_depart " +
					"FROM data_unqualified_treatment AS dut " + 
					"INNER JOIN data_check_recording AS dcr ON dcr.rid = dut.check_recording_id and dut.delete_flag=0 " +
//					"LEFT JOIN (SELECT source_id, " +
//					"GROUP_CONCAT( CASE WHEN source_type = 'signPic' THEN CONCAT_WS('', '"+ WebConstant.res.getString("resourcesUrl") +"', file_path) END SEPARATOR ',' ) AS signature, " +
//					"GROUP_CONCAT( CASE WHEN source_type = 'Enforce' THEN CONCAT_WS('', '"+ WebConstant.res.getString("resourcesUrl") +"', file_path) END SEPARATOR ',' ) AS evidence " +
//					"FROM tb_file WHERE source_type IN ('signPic', 'Enforce') GROUP BY source_id) tf ON tf.source_id = dut.id " +
					"LEFT JOIN t_s_user tsu ON tsu.id = dut.create_by " + 
					"INNER JOIN t_s_depart tsd ON tsd.id = tsu.depart_id " + 
					"WHERE 1=1");
			
			if(null == user.getPointId()){
				//根据用户所属检测机构查询检测结果
				sbuffer.append(" AND dcr.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
			}else{
				//根据用户所属检测点查询检测结果
				sbuffer.append(" AND dcr.point_id='"+user.getPointId()+"' ");
			}
			//add by xiaoyl 2022/05/19增加过滤条件，过滤掉已删除的数据
			sbuffer.append("AND dut.update_date>=? AND dut.delete_flag=0 ");
			sbuffer.append("GROUP BY dut.id");
			
			limit(sbuffer, pageNumber, recordNumber);
			
			list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] { lastUpdateTime });
 			
 			List<Map<String, Object>> list1 = null;
 			if(list!=null && list.size() > 0) {

				//获取不合格处理主表ID数组
//				int[] dutIds = new int[list.size()];
				StringBuffer dutIdsStr = new StringBuffer();
				for(int i=0;i<list.size();i++) {
// 				dutIds[i] = (int) list.get(i).get("id");
					dutIdsStr.append(list.get(i).get("id")).append(",");
				}
				dutIdsStr.deleteCharAt(dutIdsStr.length() - 1);

				//查询附件
				sbuffer.setLength(0);
				sbuffer.append(
						"   SELECT source_id, " +
						"   GROUP_CONCAT( CASE WHEN source_type = 'signPic' THEN CONCAT('" + resourcesUrl + "', file_path) END SEPARATOR ',' ) AS signature, " +
						"   GROUP_CONCAT( CASE WHEN source_type = 'Enforce' THEN CONCAT('" + resourcesUrl + "', file_path) END SEPARATOR ',' ) AS evidence " +
						"   FROM tb_file " +
						"   WHERE delete_flag = 0 AND source_type IN ('signPic', 'Enforce') " +
						"   AND source_id IN (" + dutIdsStr.toString() + ") " +
						"   GROUP BY source_id ");
				List<Map<String, Object>> files = jdbcTemplate.queryForList(sbuffer.toString());

 				//查询不合格处理方式数据
 				sbuffer.setLength(0);
 				sbuffer.append("SELECT " + 
 						"	dud.id, dud.unid, duc.id config_id, duc.handle_name, " + 
 						"IF(dud.dispose_value IS NULL OR dud.dispose_value = '', dud.dispose_value1, dud.dispose_value) dispose_value, duc.value_type " + 
 						"FROM data_unqualified_dispose dud INNER JOIN data_unqualified_config duc ON dud.dispose_id = duc.id WHERE dud.unid IN (" + dutIdsStr.toString() + ") ");
 				
 				list1 = jdbcTemplate.queryForList(sbuffer.toString());

				List<Map<String, Object>> disposals = null;
				//不合格处理主表
				for(Map<String, Object> map : list) {
					//附件
					if (files!=null) {
						Iterator<Map<String, Object>> filesIt = files.iterator();
						while (filesIt.hasNext()) {
							Map<String, Object> filesMap = filesIt.next();
							if(map.get("id").toString().equals(filesMap.get("source_id").toString())) {
								map.put("signature", filesMap.get("signature"));
								map.put("evidence", filesMap.get("evidence"));
//								filesIt.remove();
								break;
							}
						}
					}

					//每条不合格处理记录加上处理方式数组
					if(list1!=null && list1.size()>0) {
						disposals = new ArrayList<Map<String, Object>>();
						for(Map<String, Object> map1 : list1) {
							if(map.get("id").equals(map1.get("unid"))) {
								map1.remove("unid");
								disposals.add(map1);
							}
						}
						map.put("disposals", disposals);

					}else {
						disposals = new ArrayList<Map<String, Object>>();
						map.put("disposals", disposals);
					}
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
