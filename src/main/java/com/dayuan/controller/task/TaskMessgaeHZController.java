package com.dayuan.controller.task;

import com.dayuan.bean.message.TbTaskMessgaeLog;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.message.TbTaskMessgaeModel;
import com.dayuan.service.message.TbTaskMessgaeLogService;
import com.dayuan.service.message.TbTaskMessgaeService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/taskMessage")
public class TaskMessgaeHZController extends BaseController {
	private Logger log = Logger.getLogger(TaskMessgaeHZController.class);
	@Autowired
	private TbTaskMessgaeService messgaeService;
	@Autowired
	private TbTaskMessgaeLogService logService;
	@RequestMapping("/messages")
	public ModelAndView Message(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/task/message/message");
	}

	@RequestMapping("/messagefrom")
	public ModelAndView fromMessage(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/task/message/frommessage");
	}

	@RequestMapping("/messageto")
	public ModelAndView toMessage(HttpServletRequest request, HttpServletResponse response) {

		return new ModelAndView("/task/message/tomessage");
	}

	@RequestMapping("/sendmessage")
	public ModelAndView sendMessage(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/task/message/sendmessage");
	}

	@RequestMapping("/frommessagedetail")
	public ModelAndView MessageDetail(HttpServletRequest request, HttpServletResponse response, int id, HttpSession session) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TbTaskMessgaeModel messgaeModel = messgaeService.selectFromById(id);
		TSUser user = PublicUtil.getSessionUser();
		Date time = messgaeModel.getSendtime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = sdf.format(time);
		map.put("fromName", user.getRealname());
		map.put("tbTaskMessgae", messgaeModel);
		map.put("time", dateString);
		return new ModelAndView("/task/message/fromMessagedetail", map);
	}

	@RequestMapping("/tomessagedetail")
	public ModelAndView toMessageDetail(HttpServletRequest request, HttpServletResponse response, int id, HttpSession session) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TbTaskMessgaeLog messgaeLog = new TbTaskMessgaeLog();
		TbTaskMessgaeModel messgaeModel = messgaeService.selectToById(id);
		TSUser user = PublicUtil.getSessionUser();
		try {
			TbTaskMessgaeLog tbTaskMessgaeLog = logService.selectByOne(messgaeModel.getId(), user.getId());
			if (tbTaskMessgaeLog == null) {
				messgaeLog.setMessageId(messgaeModel.getId());
				messgaeLog.setUserId(user.getId());
				messgaeLog.setReadTime(new Date());
				logService.insertMessageLog(messgaeLog);
			}
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
		}
		Date time = messgaeModel.getSendtime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = sdf.format(time);
		map.put("toName", user.getRealname());
		map.put("tbTaskMessgae", messgaeModel);
		map.put("time", dateString);

		return new ModelAndView("/task/message/toMessagedetail", map);
	}
}
