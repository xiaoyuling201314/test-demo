package com.dayuan.controller.interfaces;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.service.DataCheck.GSDataUnqualifiedTreatmentService;
import com.dayuan3.common.util.SystemConfigUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.model.dataCheck.DataUnqualifiedTreatmentModel;
import com.dayuan.service.DataCheck.DataUnqualifiedTreatmentService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.StringUtil;

/**
 * 不合格处理对外接口
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年10月18日
 */
@Controller
@RequestMapping("/interfaces/dataUnqualified")
public class DataUnqualifiedController extends BaseInterfaceController {
	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TSDepartService departService;
	
	@Autowired
	private DataUnqualifiedTreatmentService dataUnqualifiedTreatmentService;

	@Autowired
	private GSDataUnqualifiedTreatmentService gsDataUnqualifiedTreatmentService;
	/**
	 * 不合格处理数据下载
	 * @param userToken用户token
	 * @param type 下载类型
	 * @param lastUpdateTime 最后更新时间
	 * @param pageNumber 页码数
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/download", method = RequestMethod.POST)
	public AjaxJson download(HttpServletRequest request, String userToken,String type,@RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime
			,@RequestParam(required = false) String pageNumber){
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<Map<String, Object>> list = null;
			StringBuffer sbuffer = new StringBuffer();
				switch (type) {
				case "config":	//处理规则下载
					sbuffer.setLength(0);
					sbuffer.append(" select * from data_unqualified_config where update_date>? ");
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*50 < 0 ? 0 : (page-1)*50) +", 50");
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("result", list);
					aj.setObj(map);
					break;
					
				case "dataUnqualified":	//不合格处理数据下载
					sbuffer.setLength(0);
					sbuffer.append("SELECT " + 
							"	dut.id, dut.check_recording_id, dut.deal_method, " + 
							"	dut.deal_type, dut.deal_imgURL, dut.sperson_name, " + 
							"	dut.sperson_phone, dut.send_date, dut.recheck_date, " + 
							"	dut.end_date, dut.recheck_value, dut.recheck_result, " + 
							"	dut.recheck_depart,  dut.supervisor, dut.supervisor_phone,  " + 
							"	dut.deal_situation, dut.remark, dut.create_date, dut.update_date, " + 
							"	dut.update_by, dut.param1, dut.param2, dut.param3,  " + 
							"	tsu.realname create_by, tsd.depart_name supervision_depart, " + 
							"	dud.id dud_id, dud.unid dud_unid, dud.dispose_id dud_dispose_id, " + 
							"	dud.dispose_value dud_dispose_value, dud.dispose_value1 dud_dispose_value1, " + 
							"	dud.dispose_type dud_dispose_type " + 
							"FROM " + 
							"	data_unqualified_treatment dut " + 
							"LEFT JOIN data_unqualified_dispose dud ON dut.id = dud.unid " + 
							"LEFT JOIN t_s_user tsu ON tsu.id = dut.create_by " + 
							"INNER JOIN t_s_depart tsd ON tsd.id = tsu.depart_id " + 
							"WHERE 1=1 ");
					
					StringBuffer sbuffer1 = new StringBuffer();
					if(null == user.getPointId()){
						//根据用户所属检测机构查询检测结果
						List<TSDepart> departs = departService.getAllSonDepartsByID(user.getDepartId());
						if(departs!=null && departs.size()>0) {
							sbuffer1.append(" SELECT rid from data_check_recording where depart_id in ( ");
							for(TSDepart depart : departs) {
								sbuffer1.append(depart.getId() + ",");
							}
							sbuffer1.deleteCharAt(sbuffer1.length()-1);
							sbuffer1.append(" ) ");
						}
					}else{
						//根据用户所属检测点查询检测结果
						sbuffer1.append(" SELECT rid from data_check_recording where point_id='"+user.getPointId()+"' ");
					}
					List<Map<String, Object>> list1 = jdbcTemplate.queryForList(sbuffer1.toString());
					
					if(list1.size()>0) {
						sbuffer.append(" and dut.check_recording_id in (");
						for (int i = 0; i < list1.size(); i++) {
							sbuffer.append( list1.get(i).get("rid")+",");
						}
						sbuffer.deleteCharAt(sbuffer.length()-1);
						sbuffer.append(" ) ");
					}
					
					sbuffer.append(" and dut.update_date>=?");
					if(StringUtil.isNotEmpty(pageNumber)){
						int page = Integer.parseInt(pageNumber);
						sbuffer.append(" limit "+ ((page-1)*50 < 0 ? 0 : (page-1)*50) +", 50");
					}
					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
					map.put("result", list);
					aj.setObj(map);
					break;
					
				default:
					break;
				}
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	/**
	 * 不合格处理数据上传
	 * @param userToken		用户token
	 * @param result		传输的json数据
	 * @param result		不合格处理取证材料
	 * @return				
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadUnqualifiedData", method = RequestMethod.POST)
	public AjaxJson uploadUnqualifiedData(HttpServletRequest request,HttpServletResponse response,String userToken,String result,@RequestParam(required=false)MultipartFile file){
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(result, WebConstant.INTERFACE_CODE1, "参数result不能为空");
			
			result = URLDecoder.decode(result, "utf-8").replaceAll("\"", "\\\"");
			JSONObject jsonObject = JSONObject.parseObject(result);
			DataUnqualifiedTreatmentModel bean= JSONObject.parseObject(jsonObject.getString("result"),DataUnqualifiedTreatmentModel.class);
			
			int id = dataUnqualifiedTreatmentService.addSelective(bean, user, file);	
			//add by xiaoyl 2022/05/19 根据系统参数配置是否更新不合格处理考核状态,如果没有配置系统参数则设置默认为1关闭
			Integer assessmentState =SystemConfigUtil.GS_ASSESSMENT_CONFIG==null? 1 : SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("assessment_state");
			if(null!=assessmentState && assessmentState==0){
				gsDataUnqualifiedTreatmentService.updateSingleHandledAssessment(bean.getTreatment().getCheckRecordingId(),null);
			}
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("id", id);	//不合格处理ID
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			e.printStackTrace();
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 获取当月不合格处理数量（首页统计）
	 * @param userToken 用户token
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryProcessingNum", method = RequestMethod.POST)
	public AjaxJson queryProcessingNum(HttpServletRequest request, String userToken) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			aj.setObj(dataUnqualifiedTreatmentService.queryProcessingNum(user));
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
}
