package com.dayuan.controller.data;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.util.CodecUtils;
import com.dayuan.util.SFTPUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseLawsRegulations;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseLawsRegulationsModel;
import com.dayuan.service.data.BaseLawsRegulationsService;
import com.dayuan.util.FtpUtil;

/**
 * 法律法规管理 Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月4日
 */
@Controller
@RequestMapping("/data/laws")
public class BaseLawsRegulationsController extends BaseController {
	
	private final Logger log = Logger.getLogger(BaseLawsRegulationsController.class);
	
	@Autowired
	private BaseLawsRegulationsService baseLawsRegulationsService;

	@Value("${ftpKey}")
	private String ftpKey;
	@Value("${ftpAddress}")
	private String ftpAddress;
	@Value("${ftpPort}")
	private String ftpPort;
	@Value("${ftpUserName}")
	private String ftpUserName;
	@Value("${ftpPassword}")
	private String ftpPassword;


	@Value("${lawPath}")
	private String lawPath;
	
	/**
	 * 进入页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return new ModelAndView("/data/laws/list");
	}

	/**
	 * 数据列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/datagrid")
	@ResponseBody
	public AjaxJson datagrid(BaseLawsRegulationsModel model, Page page, HttpServletResponse response) throws Exception {
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseLawsRegulationsService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 
	 * @param bean
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public AjaxJson save(BaseLawsRegulations bean, @RequestParam(value = "urlPathFile", required = false) MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		AjaxJson jsonObject = new AjaxJson();
		try {
			BaseLawsRegulations baseBean =baseLawsRegulationsService.queryByLawName(bean.getLawName());
			if(file!=null && file.getSize()>0){
				String fileName=file.getOriginalFilename();

				SFTPUtil sftp = new SFTPUtil();
				sftp.connectServer(CodecUtils.aesDecrypt(ftpAddress, ftpKey), Integer.parseInt(CodecUtils.aesDecrypt(ftpPort, ftpKey)), CodecUtils.aesDecrypt(ftpUserName, ftpKey), CodecUtils.aesDecrypt(ftpPassword, ftpKey));
				sftp.uploadFile(lawPath+"/"+fileName, file.getInputStream());
				sftp.close();

				bean.setUrlPath(fileName);
			}
			if (StringUtils.isBlank(bean.getId())) {// 新增数据
				if (baseBean == null) {
					PublicUtil.setCommonForTable(bean, true);
					baseLawsRegulationsService.insert(bean);
				}else{
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该法律法规已存在，请重新输入.");
				}
			} else {// 修改数据
				PublicUtil.setCommonForTable(bean, false);
				if (baseBean == null || bean.getId().equals(baseBean.getId())) {
					baseLawsRegulationsService.updateBySelective(bean);
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该法律法规已存在，请重新输入.");
				}
			}

		} catch (Exception e) {
			log.error("*************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}

	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(String id, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			BaseLawsRegulations bean = baseLawsRegulationsService.queryById(id);
			if (bean == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
			
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}

	/**
	 * 删除数据，单条删除与批量删除通用方法
	 * @param request
	 * @param response
	 * @param ids 要删除的数据记录id集合
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			baseLawsRegulationsService.delete(ida);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
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
		BaseLawsRegulations bean = null;
		try {
			bean = baseLawsRegulationsService.queryById(id);

			SFTPUtil sftp = new SFTPUtil();
			sftp.connectServer(CodecUtils.aesDecrypt(ftpAddress, ftpKey), Integer.parseInt(CodecUtils.aesDecrypt(ftpPort, ftpKey)), CodecUtils.aesDecrypt(ftpUserName, ftpKey), CodecUtils.aesDecrypt(ftpPassword, ftpKey));
			byte[] fileByte = sftp.downloadFile(lawPath+"/"+bean.getUrlPath());
			sftp.close();
			
			if(fileByte!=null && fileByte.length>0){
				response.setContentType("application/octet-stream"); 
				response.setCharacterEncoding("utf-8");
				//处理中文文件名乱码问题
				String fileName=new String(bean.getUrlPath().getBytes("gb2312"), StandardCharsets.ISO_8859_1);
				response.setHeader("Content-disposition","attachment; filename="+fileName+"");
				OutputStream out=response.getOutputStream();
				out.write(fileByte);
			    out.close();
			}else{
				response.setContentType("text/html;charset=UTF-8"); 
				response.getWriter().write("下载文件不存在<a href='"+request.getContextPath()+"/data/laws/list.do'><i class='icon iconfont icon-fanhui'></i>返回</a>");
			}
		} catch (Exception e) {
			log.error("法律法规下载异常**********************"+e.getMessage()+e.getStackTrace());
			try {
				response.setContentType("text/html;charset=UTF-8"); 
				response.getWriter().write("下载文件不存在<a href='"+request.getContextPath()+"/data/laws/list.do'><i class='icon iconfont icon-fanhui'></i>返回</a>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}
}
