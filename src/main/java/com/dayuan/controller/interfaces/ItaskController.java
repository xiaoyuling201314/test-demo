package com.dayuan.controller.interfaces;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.task.TaskDetailService;
import com.dayuan.service.task.TaskService;
import com.dayuan.util.StringUtil;

/**
 * Description:
 * @Company: 食安科技
 * @author Dz
 * @date 2017年9月15日
 */
@Controller
@RequestMapping("/interfaces/task")
public class ItaskController extends BaseInterfaceController {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskDetailService taskDetailService;

	/**
	 * 未接收任务数量
	 * @param userToken 用户token
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/tasksNumber", method = RequestMethod.POST)
	public AjaxJson tasksNumber(HttpServletRequest request, String userToken) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("select count(1) tasksNumber from tb_task_detail ttd left join tb_task tt on ttd.task_id = tt.id ");
			sbuffer.append("where tt.task_status = 1 and ttd.receive_status = 0 ");		//任务状态 -1_终止,0_暂存,1_已下发,2_已完成
			
			if(user.getPointId() != null){
				//检测点
				sbuffer.append(" and ttd.receive_nodeid ="+user.getPointId()+" " );
			}else{
				//机构
				sbuffer.append(" and ttd.receive_pointid ="+user.getDepartId()+" " );
			}
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString());
			
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("tasks", list);
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 接收任务(可分页)
	 * @param userToken 用户token(必填)
	 * @param lastUpdateTime 最后更新时间(必填)
	 * @param pageNumber 页码(选填)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/receiveTasks", method = RequestMethod.POST)
	public AjaxJson receiveTasks(HttpServletRequest request, String userToken, @RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime, 
			String pageNumber) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("select tt.id t_id, tt.task_code t_task_code, tt.task_title t_task_title, tt.task_content t_task_content, tt.task_detail_pId t_task_detail_pId, tt.project_id t_project_id, tt.task_type t_task_type, tt.task_source t_task_source, ");
			sbuffer.append("tt.task_status t_task_status, tt.task_total t_task_total, tt.sample_number t_sample_number, tt.task_sdate t_task_sdate, tt.task_edate t_task_edate, tt.task_pdate t_task_pdate, tt.task_fdate t_task_fdate, ");
			sbuffer.append("tsd.depart_name t_task_departId, bw.worker_name t_task_announcer, tt.task_cdate t_task_cdate, tt.remark t_remark, tt.view_flag t_view_flag, tt.delete_flag t_delete_flag, tt.create_by t_create_by, ");
			sbuffer.append("tt.create_date t_create_date, tt.update_by t_update_by, tt.update_date t_update_date, ");
			
			sbuffer.append("ttd.id d_id, ttd.task_id d_task_id, ttd.detail_code d_detail_code, ttd.sample_id d_sample_id, ttd.sample d_sample, ");
			sbuffer.append("ttd.item_id d_item_id, ttd.item d_item, ttd.task_fdate d_task_fdate, ttd.receive_pointid d_receive_pointid, ttd.receive_point d_receive_point, ");
			sbuffer.append("ttd.receive_nodeid d_receive_nodeid, ttd.receive_node d_receive_node, ttd.receive_userid d_receive_userid, ttd.receive_username d_receive_username, ");
			sbuffer.append("ttd.receive_status d_receive_status, ttd.task_total d_task_total, ttd.sample_number d_sample_number, ttd.remark d_remark ");
			
			sbuffer.append("from tb_task_detail ttd inner join tb_task tt on ttd.task_id = tt.id ");
			sbuffer.append("left join base_workers bw on bw.id = tt.task_announcer ");
			sbuffer.append("left join t_s_depart tsd on tsd.id = tt.task_departId ");
			
			sbuffer.append("where 1=1 and tt.task_status != 0 ");		//任务状态 -1_终止,0_暂存,1_已下发,2_已完成
			
			if(user.getPointId() != null){
				//检测点
				sbuffer.append(" and ttd.receive_nodeid ="+user.getPointId()+" " );
			}else{
				//机构
				sbuffer.append(" and ttd.receive_pointid ="+user.getDepartId()+" " );
			}
			
			if(StringUtil.isNotEmpty(pageNumber)){
				int page = Integer.parseInt(pageNumber);
				sbuffer.append(" and tt.update_date >= ? limit "+ ((page-1)*30 < 0 ? 0 : (page-1)*30) +", 30");
			}else{
				sbuffer.append(" and tt.update_date >= ? ");
			}
			
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
			
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("tasks", list);
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 查看任务，更新接收状态
	 * @param userToken 用户token
	 * @param detailId 任务明细ID
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/viewTask", method = RequestMethod.POST)
	public AjaxJson viewTask(HttpServletRequest request, String userToken, String detailId) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(detailId, WebConstant.INTERFACE_CODE1, "参数detailId不能为空");
			
			TbTaskDetail taskDetail = taskDetailService.queryById(detailId);
			required(taskDetail, WebConstant.INTERFACE_CODE5, "任务不存在");
			
			taskDetail.setReceiveUserid(user.getId());
			taskDetail.setReceiveStatus((short) 1);
			taskDetailService.updateBySelective(taskDetail);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 获取我的任务数量（首页统计）
	 * @param userToken 用户token
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryTaskNum", method = RequestMethod.POST)
	public AjaxJson queryTaskNum(HttpServletRequest request, String userToken) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			aj.setObj(taskService.queryTaskNum(user));
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}

}
