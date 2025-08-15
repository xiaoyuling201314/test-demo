package com.dayuan.controller.interfaces;

import java.util.Date;
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
import com.dayuan.bean.message.TbTaskMessgae;
import com.dayuan.bean.message.TbTaskMessgaeLog;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.message.TbTaskMessgaeLogService;
import com.dayuan.service.message.TbTaskMessgaeService;
import com.dayuan.util.StringUtil;

/**
 * 消息公告接口
 * @author Dz
 */
@Controller
@RequestMapping("/interfaces/taskMessage")
public class ItaskMessageController extends BaseInterfaceController { 

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TbTaskMessgaeService taskMessgaeService;
	@Autowired
	private TbTaskMessgaeLogService taskMessgaeLogService;

	/**
	 * 查询消息公告数量
	 * @param userToken 用户token
	 * @param lastUpdateTime 最后更新时间
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/taskMsgNumber", method = RequestMethod.POST)
	public AjaxJson taskMsgNumber(HttpServletRequest request, String userToken, @RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT COUNT(1) total, SUM(IF(ttml.id IS NULL, 1, 0)) unread FROM " +
					"	(SELECT id, from_user_id, to_user_id, to_user_type, title, " +
					"		content, file_path, sendtime, file_name, group_id, group_point_id  " +
					"	FROM tb_task_message  " +
					"	WHERE delete_flag = 0 AND (");
			
			if(StringUtil.isNotEmpty(user.getPointId())) {
				sbuffer.append(" to_user_id = '"+user.getId()+"' OR group_point_id = '"+user.getPointId()+"' ");
			}else if(StringUtil.isNotEmpty(user.getDepartId())){
				sbuffer.append(" to_user_id = '"+user.getId()+"' OR group_id = '"+user.getDepartId()+"' ");
			}else {
				sbuffer.append(" to_user_id = '"+user.getId()+"' ");
			}
			sbuffer.append(")) AS ttm " +
					"LEFT JOIN tb_task_message_log AS ttml ON ttml.message_id = ttm.id " +
					"LEFT JOIN t_s_user tsu ON tsu.id = ttm.from_user_id " +
					"WHERE (ttml.delete_flag IS NULL OR ttml.delete_flag = 0) AND (ttml.user_id = ? OR ttml.user_id IS NULL) AND ttm.sendtime > ? ");
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), user.getId(), lastUpdateTime);
			Map<String, Object> map = null;
			if(list!=null && list.size()>0) {
				map = list.get(0);
				if(map!=null && !StringUtil.isNotEmpty(map.get("unread"))) {
					map.put("unread", 0);
				}
			}
			
			//返回公告总数和未读数量
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
	 * 下载消息公告
	 * @param userToken 用户token(必填)
	 * @param lastUpdateTime 最后更新时间(必填)
	 * @param pageNumber 页码(选填)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/downloadTaskMsg", method = RequestMethod.POST)
	public AjaxJson downloadTaskMsg(HttpServletRequest request, String userToken, @RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime, 
			String pageNumber) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " +
					"	ttm.id, ttm.from_user_id, tsu.realname from_user_name, ttm.to_user_id, ttm.to_user_type, " +
					"	ttm.title, ttm.content, ttm.file_path, ttm.file_name,  ttm.sendtime, " +
					"	ttm.group_id, ttm.group_point_id, ttml.id log_id, ttml.read_status log_read_status, ttml.read_time log_read_time " +
					"FROM " +
					"	(SELECT id, from_user_id, to_user_id, to_user_type, title, " +
					"		content, file_path, sendtime, file_name, group_id, group_point_id  " +
					"	FROM tb_task_message  " +
					"	WHERE delete_flag = 0 AND (");
			
			if(StringUtil.isNotEmpty(user.getPointId())) {
				sbuffer.append(" to_user_id = '"+user.getId()+"' OR group_point_id = '"+user.getPointId()+"' ");
			}else if(StringUtil.isNotEmpty(user.getDepartId())){
				sbuffer.append(" to_user_id = '"+user.getId()+"' OR group_id = '"+user.getDepartId()+"' ");
			}else {
				sbuffer.append(" to_user_id = '"+user.getId()+"' ");
			}
			sbuffer.append(")) AS ttm " +
					"LEFT JOIN tb_task_message_log AS ttml ON ttml.message_id = ttm.id " +
					"LEFT JOIN t_s_user tsu ON tsu.id = ttm.from_user_id " +
					"WHERE (ttml.delete_flag IS NULL OR ttml.delete_flag = 0) AND (ttml.user_id = ? OR ttml.user_id IS NULL) AND ttm.sendtime > ? ");
			
			if(StringUtil.isNumeric(pageNumber)){
				int page = Integer.parseInt(pageNumber);
				sbuffer.append(" limit "+ ((page-1)*50 < 0 ? 0 : (page-1)*50) +", 50");
			}
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), user.getId(), lastUpdateTime);
			
			//返回消息公告
			aj.setObj(list);	
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 更新消息公告查看状态
	 * @param userToken 用户token
	 * @param taskMsgId 公告ID
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/viewed", method = RequestMethod.POST)
	public AjaxJson viewed(HttpServletRequest request, String userToken, String taskMsgId) {

		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(taskMsgId, WebConstant.INTERFACE_CODE1, "参数taskMsgId不能为空");
			
			TbTaskMessgae taskMessgae = taskMessgaeService.queryById(taskMsgId);
			required(taskMessgae, WebConstant.INTERFACE_CODE5, "公告不存在");
			
			TbTaskMessgaeLog taskMessgaeLog = taskMessgaeLogService.selectByOne(taskMsgId, user.getId());
			
			if(taskMessgaeLog == null) {
				//新增公告接收日志
				taskMessgaeLog = new TbTaskMessgaeLog();
				taskMessgaeLog.setMessageId( taskMessgae.getId().toString() );
				taskMessgaeLog.setUserId(user.getId());
				taskMessgaeLog.setReadTime(new Date());
				taskMessgaeLogService.insertSelective(taskMessgaeLog);
			}else {
				//更新公告接收日志
			}
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}

}
