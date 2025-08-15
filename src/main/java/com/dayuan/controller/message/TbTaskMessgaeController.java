package com.dayuan.controller.message;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.controller.interfaces.SMSTemplateController;
import com.dayuan.exception.MyException;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.system.TSUserService;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.message.TbTaskMessgae;
import com.dayuan.bean.message.TbTaskMessgaeLog;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.message.TbTaskMessgaeModel;
import com.dayuan.service.message.TbTaskMessgaeLogService;
import com.dayuan.service.message.TbTaskMessgaeService;

/**
 * @project 快速服务云平台
 * @author wtt
 * @date 2017年10月25日
 */
@Controller
@RequestMapping("/message")
public class TbTaskMessgaeController extends BaseController {
	private final Logger log = Logger.getLogger(TbTaskMessgaeController.class);
	@Autowired
	private TbTaskMessgaeService messgaeService;
	@Autowired
	private TbTaskMessgaeLogService logService;

	@Autowired
	private TSUserService userService;

	@Autowired
	private BasePointService pointService;

	private TSDepartService departService;

	@RequestMapping("/messages")
	public ModelAndView Message(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/message/message");
	}

	@RequestMapping("/messagefrom")
	public ModelAndView fromMessage(HttpServletRequest request, HttpServletResponse response) {

		return new ModelAndView("/message/frommessage");
	}

	@RequestMapping("/messageto")
	public ModelAndView toMessage(HttpServletRequest request, HttpServletResponse response) {

		return new ModelAndView("/message/tomessage");
	}

	@RequestMapping("/sendmessage")
	public ModelAndView sendMessage(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/message/sendmessage");
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
		return new ModelAndView("/message/fromMessagedetail", map);
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
		//根据发送类型ID查询接收人或接收机构的名称
		String receiveUserOrDepart=messgaeService.queryReceiveObject(messgaeModel);
		Date time = messgaeModel.getSendtime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = sdf.format(time);
		map.put("toName", user.getRealname());
		map.put("tbTaskMessgae", messgaeModel);
		map.put("time", dateString);
		map.put("receiveUserOrDepart", receiveUserOrDepart);
		return new ModelAndView("/message/toMessagedetail", map);
	}

	// 发送信息
	@RequestMapping(value = "sendMessageOne")
	@ResponseBody
	public AjaxJson sendMessageForOne(HttpServletResponse response, HttpServletRequest request, @RequestParam(value = "file", required = false) MultipartFile[] file) {
		AjaxJson ajaxJson = new AjaxJson();
		TbTaskMessgaeLog messgaeLog = new TbTaskMessgaeLog();
		Map<String, Object> mapoo = new HashMap<String, Object>();
		String filename = null;
		String sqlpath = null;
		try {
			// 得到message相关 一般用实体类就好了
			String messageContent = request.getParameter("content");
			String groupID = request.getParameter("groupID");
			String[] split = groupID.split(",");
			String title = request.getParameter("title");
			String toUserType = request.getParameter("toUserType");
			HttpSession session = request.getSession();
			SimpleDateFormat dateformat = new SimpleDateFormat("yyyy/MM/dd/HH");
			HashMap<String, Object> map = new HashMap<String, Object>();
			StringBuilder filenames = new StringBuilder();
			StringBuilder sqlpaths = new StringBuilder();
			String test = null;
			if (!file[0].isEmpty()) {
				for (int ii = 0; ii < file.length; ii++) {
					test = file[ii].getOriginalFilename();
					filenames.append(test).append(",");
				}
				filename = filenames.substring(0, filenames.length() - 1);
				/** 构建文件保存的目录* */
				String logoPathDir = "/messageFile/" + dateformat.format(new Date());
				/** 得到文件保存目录的真实路径* */
				String logoRealPathDir = WebConstant.res.getString("resources") + logoPathDir;
				/** 根据真实路径创建目录* */
				File logoSaveFile = new File(logoRealPathDir);
				if (!logoSaveFile.exists())
					logoSaveFile.mkdirs();

				MultipartFile[] multipartFile = file;
				for (int j = 0; j < multipartFile.length; j++) {
					if (multipartFile[j].getSize() < 1) {

					} else {
						/** 获取文件的后缀* */
						String suffix = multipartFile[j].getOriginalFilename().substring(multipartFile[j].getOriginalFilename().lastIndexOf("."));
						/** 使用UUID生成文件名称* */
						String fileNameSuffix = UUID.randomUUID() + suffix;// 构建文件名称
						/** 拼成完整的文件保存路径加文件* */
						String fileName = logoRealPathDir + "/" + fileNameSuffix;
						// 上传附件地址
						sqlpaths.append(logoPathDir + "/" + fileNameSuffix).append(",");
						File files = new File(fileName);
						try {
							multipartFile[j].transferTo(files);
						} catch (IllegalStateException e) {
							map.put("result", "fail");
							log.error("**********************" + e.getMessage() + e.getStackTrace());

						} catch (IOException e) {

							log.error("**********************" + e.getMessage() + e.getStackTrace());
						}
					}
				}

				sqlpath = sqlpaths.substring(0, sqlpaths.length() - 1);
			}
			TbTaskMessgae mp = new TbTaskMessgae();
			List<String> sendPhones=new ArrayList<>();
			TSDepart depart=null;
			BasePoint point=null;
			TSUser user=null;
			if (toUserType.equals("1")) {// 发送给机构
				for (int i = 0; i < split.length; i++) {
					mp.setGroupId(Integer.parseInt(split[i]));
					mp.setSendtime(new Date());
					mp.setTitle(title);
					mp.setToUserType(toUserType);
					TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
					mp.setFromUserId(tsUser.getId());
					mp.setContent(messageContent);
					mp.setFilePath(sqlpath);
					mp.setFileName(filename);
					messgaeService.sendMessage(mp);
					depart=departService.getById(mp.getGroupId());
					if(StringUtil.isNotEmpty(depart.getMobilePhone())){
						sendPhones.add(depart.getMobilePhone());
					}
				}
			} else if (toUserType.equals("0")) {// 发送给个人
				for (int i = 0; i < split.length; i++) {
					mp.setToUserId(split[i]);
					mp.setSendtime(new Date());
					mp.setTitle(title);
					mp.setToUserType(toUserType);
					TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
					mp.setFromUserId(tsUser.getId());
					mp.setContent(messageContent);
					mp.setFilePath(sqlpath);
					mp.setFileName(filename);
					messgaeService.sendMessage(mp);
					user=userService.getById(mp.getToUserId());
					if(StringUtil.isNotEmpty(user.getUserName())){
						sendPhones.add(user.getUserName());
					}
				}
			} else if (toUserType.equals("2")) {// 发送给检测点
				for (int i = 0; i < split.length; i++) {
					mp.setGroupPointId(Integer.parseInt(split[i]));
					mp.setSendtime(new Date());
					mp.setTitle(title);
					mp.setToUserType(toUserType);
					TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
					mp.setFromUserId(tsUser.getId());
					mp.setContent(messageContent);
					mp.setFilePath(sqlpath);
					mp.setFileName(filename);
					messgaeService.sendMessage(mp);
					point=pointService.queryById(mp.getGroupPointId());
					if(StringUtil.isNotEmpty(point.getPhone())){
						sendPhones.add(point.getPhone());
					}
				}
			}
			if(sendPhones.size()>0){
				sendSmsByPhone(sendPhones.toArray(new String[sendPhones.size()]),"食品安全检测数据平台",log);
			}
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("操作失败");
		}
		mapoo.put("ajaxJson", ajaxJson);
		// return new ModelAndView("/message/sendmessage",mapoo);
		return ajaxJson;
	}

	/**
	 * 发信列表
	 * @param model
	 * @param page
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "frommessage")
	@ResponseBody
	public AjaxJson fromdatagrid(TbTaskMessgaeModel model, Page page, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
		AjaxJson jsonObj = new AjaxJson();
		TbTaskMessgae tbTaskMessgae = new TbTaskMessgae();

		try {
			page.setOrder("desc");
			TSUser user = PublicUtil.getSessionUser();
			if (null != user && null != model) {
				if (model.getTbTaskMessgae() != null) {
					tbTaskMessgae.setTitle(model.getTbTaskMessgae().getTitle());
					tbTaskMessgae.setContent(model.getTbTaskMessgae().getContent());
				}
				tbTaskMessgae.setFromUserId(user.getId());
				/*tbTaskMessgae.setGroupId(user.getDepartId());*/
				model.setTbTaskMessgae(tbTaskMessgae);
			}
			page = messgaeService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
		}
		return jsonObj;
	}

	/**
	 * 收件列表
	 * @param model
	 * @param page
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "tomessage")
	@ResponseBody
	public AjaxJson todatagrid(TbTaskMessgaeModel model, Page page, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
		AjaxJson jsonObj = new AjaxJson();
		TbTaskMessgae tbTaskMessgae = new TbTaskMessgae();

		try {
			page.setOrder("desc");
			TSUser user = PublicUtil.getSessionUser();
			if (null != user && null != model) {
				if (model.getTbTaskMessgae() != null) {
					tbTaskMessgae.setTitle(model.getTbTaskMessgae().getTitle());
					tbTaskMessgae.setContent(model.getTbTaskMessgae().getContent());
				}
				tbTaskMessgae.setToUserId(user.getId());
				tbTaskMessgae.setGroupId(user.getDepartId());
				tbTaskMessgae.setGroupPointId(user.getPointId());
				model.setTbTaskMessgae(tbTaskMessgae);
			}
			page = messgaeService.loadDatagrid(page, model);

			List list = page.getResults();
			for (int i = 0; i < list.size(); i++) {
				TbTaskMessgaeModel messgaeModel = (TbTaskMessgaeModel) list.get(i);
				if (messgaeModel.getDeleteFlag() != null) {
					if (messgaeModel.getDeleteFlag() == 1) {
						list.remove(i);
						page.setRowTotal(page.getRowTotal() - 1);
						i--;
					}
				}
			}
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
		}
		return jsonObj;
	}

	/**
	 * 邮件提示未读
	 * @param model
	 * @param page
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "num")
	@ResponseBody
	public AjaxJson noRead(TbTaskMessgaeModel model, Page page, HttpServletResponse response, HttpSession session) {
		AjaxJson jsonObj = new AjaxJson();
		TbTaskMessgae tbTaskMessgae = new TbTaskMessgae();

		try {
			page.setOrder("desc");
			TSUser user = PublicUtil.getSessionUser();
			if (null != user && null != model) {
				tbTaskMessgae.setToUserId(user.getId());
				tbTaskMessgae.setGroupId(user.getDepartId());
				tbTaskMessgae.setGroupPointId(user.getPointId());
				model.setTbTaskMessgae(tbTaskMessgae);
			}
			page = messgaeService.loadDatagrid(page, model);

			List list = page.getResults();
			for (int i = 0; i < list.size(); i++) {
				TbTaskMessgaeModel messgaeModel = (TbTaskMessgaeModel) list.get(i);
				if (messgaeModel.getDeleteFlag() != null) {
					if (messgaeModel.getDeleteFlag() == 1) {
						list.remove(i);
						page.setRowTotal(page.getRowTotal() - 1);
						i--;
					}
				}
			}

			int count = logService.getCount(user.getId());
			int rowTotal = page.getRowTotal();
			int num = rowTotal - count;
			if(num<0){
				num=0;
			}
			Page page2 = new Page();
			page2.setRowTotal(rowTotal);
			page2.setPageCount(num);
			jsonObj.setObj(page2);
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
		}
		return jsonObj;
	}

	@RequestMapping("/count")
	@ResponseBody
	public AjaxJson count(HttpServletResponse response, HttpSession session) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			TSUser user = PublicUtil.getSessionUser();
			int count = logService.getCount(user.getId());
			jsonObject.setObj(count);
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
		}
		return jsonObject;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(int id, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			TbTaskMessgae taskMessgae = new TbTaskMessgae();
			taskMessgae.setId(id);
			taskMessgae.setDeleteFlag((short) 1);
			messgaeService.updateBySelective(taskMessgae);
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
		}
		return jsonObject;
	}

	@RequestMapping("/deletes")
	@ResponseBody
	public AjaxJson deletes(int id, HttpServletResponse response, HttpSession session) {
		AjaxJson jsonObject = new AjaxJson();
		TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
		try {
			TbTaskMessgaeLog messgaeLog = logService.selectByOne(id + "", tsUser.getId());
			if(messgaeLog!=null){
				messgaeLog.setDeleteFlag((short) 1);
				logService.updateBySelective(messgaeLog);
			}else {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("请先阅读消息后再进行删除!");
			}
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
		}
		return jsonObject;
	}

	/**
	 * 下载文件
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/download")
	public void download(HttpServletRequest request, HttpServletResponse response, String id) {
		try {
			TbTaskMessgae bean = messgaeService.queryById(id);

			if (bean.getFilePath() != null) {
				String[] filepath = bean.getFilePath().split(",");

				String[] filenames = bean.getFileName().split(",");
				List<File> files = new ArrayList<File>();
				File file = null;
				if (filepath.length > 1) {
					for (int i = 0; i < filepath.length; i++) {
						String fileName = WebConstant.res.getString("resources") + filepath[i];
						file = new File(fileName);
						files.add(file);
					}
					String fileName = UUID.randomUUID() + ".zip";
					// 在服务器端创建打包下载的临时文件
					String outFilePath = "D:\\" + fileName;
					File filess = new File(outFilePath);
					// 文件输出流
					FileOutputStream outStream = new FileOutputStream(filess);
					// 压缩流
					ZipOutputStream toClient = new ZipOutputStream(outStream);
					toClient.setEncoding("gbk");
					zipFile(files, toClient, filenames);
					toClient.close();
					outStream.close();
					this.downloadZip(filess, response);
				} else {
					// 需要下载的文件路径
					String fileName = WebConstant.res.getString("resources") + bean.getFilePath();
					// 获取输入流
					InputStream bis = new BufferedInputStream(new FileInputStream(new File(fileName)));
					byte[] buffer = new byte[bis.available()];
					bis.read(buffer);
					bis.close();
					// 假如以中文名下载的话
					String filename = bean.getFileName();
					// 转码，免得文件名中文乱码
					filename = URLEncoder.encode(filename, "UTF-8");
					// 设置文件下载头
					response.addHeader("Content-Disposition", "attachment;filename=" + filename);
					// 设置文件ContentType类型，这样设置，会自动判断下载文件类型
					response.setContentType("multipart/form-data");
					BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
					out.write(buffer);
					out.flush();
					out.close();
				}
			} else {
				System.out.println(request.getRequestURI() + "===" + request.getContextPath() + "===" + request.getHeader("Referer"));
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("下载文件不存在<a href='javascript:history.back(-1)'><i class='icon iconfont icon-fanhui'></i>返回</a>");
			}
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
		}
	}

	/**
	 * 压缩文件列表中的文件
	 * @param files
	 * @param outputStream
	 * @throws IOException
	 */
	public static void zipFile(List files, ZipOutputStream outputStream, String[] filenames) throws IOException, ServletException {
		try {
			int size = files.size();
			// 压缩列表中的文件
			for (int i = 0; i < size; i++) {
				File file = (File) files.get(i);
				zipFile(file, outputStream, filenames[i]);
			}
		} catch (IOException e) {
			throw e;
		}
	}

	/**
	 * 将文件写入到zip文件中
	 * @param inputFile
	 * @param outputstream
	 * @throws Exception
	 */
	public static void zipFile(File inputFile, ZipOutputStream outputstream, String filename) throws IOException, ServletException {
		try {
			if (inputFile.exists()) {
				if (inputFile.isFile()) {
					FileInputStream inStream = new FileInputStream(inputFile);
					BufferedInputStream bInStream = new BufferedInputStream(inStream);
					ZipEntry entry = new ZipEntry(filename);
					outputstream.putNextEntry(entry);

					final int MAX_BYTE = 10 * 1024 * 1024; // 最大的流为10M
					long streamTotal = 0; // 接受流的容量
					int streamNum = 0; // 流需要分开的数量
					int leaveByte = 0; // 文件剩下的字符数
					byte[] inOutbyte; // byte数组接受文件的数据

					streamTotal = bInStream.available(); // 通过available方法取得流的最大字符数
					streamNum = (int) Math.floor(streamTotal / MAX_BYTE); // 取得流文件需要分开的数量
					leaveByte = (int) streamTotal % MAX_BYTE; // 分开文件之后,剩余的数量

					if (streamNum > 0) {
						for (int j = 0; j < streamNum; ++j) {
							inOutbyte = new byte[MAX_BYTE];
							// 读入流,保存在byte数组
							bInStream.read(inOutbyte, 0, MAX_BYTE);
							outputstream.write(inOutbyte, 0, MAX_BYTE); // 写出流
						}
					}
					// 写出剩下的流数据
					inOutbyte = new byte[leaveByte];
					bInStream.read(inOutbyte, 0, leaveByte);
					outputstream.write(inOutbyte);
					outputstream.closeEntry(); // Closes the current ZIP entry
												// and positions the stream for
												// writing the next entry
					bInStream.close(); // 关闭
					inStream.close();
				}
			} else {
				throw new ServletException("文件不存在！");
			}
		} catch (IOException e) {
			throw e;
		}
	}

	/**
	 * 下载打包的文件
	 * @param file
	 * @param response
	 */
	public void downloadZip(File file, HttpServletResponse response) {
		try {
			// 以流的形式下载文件。
			InputStream fis = new BufferedInputStream(new FileInputStream(file.getPath()));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer);
			fis.close();
			// 清空response
			response.reset();

			BufferedOutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
			toClient.write(buffer);
			toClient.flush();
			toClient.close();
			file.delete(); // 将生成的服务器端文件删除
		} catch (IOException ex) {
			log.error("**********************" + ex.getMessage() + ex.getStackTrace());
		}
	}

	/**
	 * 查询首页列表信息
	 * @param model
	 * @param page
	 * @param response
	 * @param session
	 * @return
	 * @throws MissSessionExceprtion
	 */
	@RequestMapping(value = "selectIndex")
	@ResponseBody
	public AjaxJson selectIndex(HttpServletResponse response, HttpSession session) throws MissSessionExceprtion {
		AjaxJson jsonObj = new AjaxJson();
		TSUser user = PublicUtil.getSessionUser();
		List<TbTaskMessgaeModel> messgaeModels = messgaeService.selectIndex(user.getId(),user.getDepartId(),user.getPointId());
		for (int i = 0; i < messgaeModels.size(); i++) {
			TbTaskMessgaeModel messgaeModel = messgaeModels.get(i);
			if (messgaeModel.getDeleteFlag() != null) {
				if (messgaeModel.getDeleteFlag() == 1) {
					messgaeModels.remove(i);
					i--;
				}
			}
		}
		jsonObj.setObj(messgaeModels);
		return jsonObj;
	}
	private void sendSmsByPhone(String[] phoneArr, String name, Logger log) {
		//对手机号码进行拆分
		Map<String, String> paramMap = new HashMap<>();
		paramMap.put("name", name);
		SMSTemplateController smst = new SMSTemplateController();
		//循环发送短信
		for (String phone : phoneArr) {
			Map<String, String> sendMap = new HashMap<>();//phone：发送的手机号码 state:0发送成功 1发送失败
			sendMap.put("phone", phone);
			log.debug("发送短信：**************************号码：" + phone + "参数：" + JSON.toJSONString(paramMap));
			try {
				smst.sendSmsLocal("", phone, paramMap);
				sendMap.put("msg", "发送成功");
				sendMap.put("code", WebConstant.INTERFACE_CODE0);
				log.debug("发送短信成功：**************************号码：" + phone);
			} catch (MyException me) {
				sendMap.put("msg", "发送失败，" + me.getMessage() + "，" + me.getText());
				sendMap.put("code", me.getCode());
				me.printStackTrace();
				log.error("发送短信失败：******************************" + me.getMessage() + "，" + me.getText() + "====>" + me.getStackTrace()[0].getClassName() + "." + me.getStackTrace()[0].getMethodName() + ":" + me.getStackTrace()[0].getLineNumber());
			} catch (Exception e) {
				sendMap.put("msg", "发送失败，未知异常");
				sendMap.put("code", WebConstant.INTERFACE_CODE11);
				e.printStackTrace();
				log.error("发送短信失败：******************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			}
		}
	}

}
