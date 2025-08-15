package com.dayuan.controller.data;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.bean.system.TSUser;
import com.dayuan.util.*;
import com.jcraft.jsch.ChannelSftp;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseStandard;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseStandardModel;
import com.dayuan.service.data.BaseStandardService;

/**
 * 检测标准管理 Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月4日
 */
@Controller
@RequestMapping("/data/standard")
public class BaseStandardController extends BaseController {
	
	private final Logger log = Logger.getLogger(BaseStandardController.class);
	
	@Autowired
	private BaseStandardService baseStandardService;

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
	@Autowired
	private JdbcTemplate jdbcTemplate;

//	@Value("${ftpDownload}")
//	private String ftpDownload;
	@Value("${standardPath}")
	private String standardPath;

	/**
	 * 进入检测标准表页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/data/standard/list");
	}

	/**
	 * 数据列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/datagrid")
	@ResponseBody
	public AjaxJson datagrid(BaseStandardModel model, Page page, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("asc");
			page = baseStandardService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	
	/**
	 * 添加/修改检测标准 1.检查检测标准是否已存在 
	 * 2.不存在，查询检测标准编号，生成即将要插入的标准编号，保存数据
	 * 3.检测标准已存在，不执行数据库操作并返回提示信息
	 * @param bean
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public AjaxJson save(BaseStandard bean,@RequestParam(value="urlPathFile",required=false) MultipartFile file,HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		BaseStandard baDetectStandard = baseStandardService.queryByStandardName(bean.getStdCode());
		try {
			if(file!=null && file.getSize()>0){
				String fileName = file.getOriginalFilename();

				SFTPUtil sftp = new SFTPUtil();
				sftp.connectServer(CodecUtils.aesDecrypt(ftpAddress, ftpKey), Integer.parseInt(CodecUtils.aesDecrypt(ftpPort, ftpKey)), CodecUtils.aesDecrypt(ftpUserName, ftpKey), CodecUtils.aesDecrypt(ftpPassword, ftpKey));
				sftp.uploadFile(standardPath+"/"+fileName, file.getInputStream());
				sftp.close();

				bean.setUrlPath(fileName);
			}
			if (null == bean.getSorting()) {
				bean.setSorting(1);
			}
			// 新增数据
			if (bean.getId() == null) {
				if (baDetectStandard == null) {
					PublicUtil.setCommonForTable(bean, true);
					baseStandardService.save(bean);
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该标准已存在，请重新输入.");
				}

			// 修改数据
			} else {
				PublicUtil.setCommonForTable(bean, false);
				if (baDetectStandard == null || bean.getId().equals(baDetectStandard.getId())) {
					baseStandardService.updateById(bean);
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该标准已存在，请重新输入.");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
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
	public AjaxJson queryById(String id, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		BaseStandard bean = null;
		try {
			bean = baseStandardService.getById(id);
			if (bean == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		jsonObject.setObj(bean);
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
			baseStandardService.removeByIds(Arrays.asList(ida));
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
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
		BaseStandard bean = null;
		try {
			bean = baseStandardService.getById(id);

			SFTPUtil sftp = new SFTPUtil();
			sftp.connectServer(CodecUtils.aesDecrypt(ftpAddress, ftpKey), Integer.parseInt(CodecUtils.aesDecrypt(ftpPort, ftpKey)), CodecUtils.aesDecrypt(ftpUserName, ftpKey), CodecUtils.aesDecrypt(ftpPassword, ftpKey));
			byte[] fileByte = sftp.downloadFile(standardPath+"/"+bean.getUrlPath());
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
				response.getWriter().write("下载文件不存在<a href='"+request.getContextPath()+"/data/standard/list.do'><i class='icon iconfont icon-fanhui'></i>返回</a>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("法律法规下载异常*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			try {
				response.setContentType("text/html;charset=UTF-8"); 
				response.getWriter().write("下载文件不存在<a href='"+request.getContextPath()+"/data/standard/list.do'><i class='icon iconfont icon-fanhui'></i>返回</a>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}

	/**
	 * select2检测标准数据
	 * @param page 页码
	 * @param row 每页数量
	 * @param standardCode 检测标准编号
	 * @return
	 */
	@RequestMapping("/select2StandardData")
	@ResponseBody
	public Map select2StandardData(Integer page, Integer row, String standardCode) {
		Map map = new HashMap();
		int total = 0;	//总数
		List standards = new ArrayList();	//检测标准

		try {
			if (standardCode != null){
				standardCode = standardCode.replace("'","");
			}
			//使用浏览器缓存数据，后台不查询
			if (!"本地历史数据".equals(standardCode)) {
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT id, std_code name " +
						" FROM base_standard  " +
						"WHERE delete_flag = 0 AND use_status = 1 ");
				if (StringUtil.isNotEmpty(standardCode)) {
					sql.append(" AND std_code LIKE '%"+standardCode+"%' ");
				}
				if (page>0 && row>0) {
					sql.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
				}
				jdbcTemplate.query(sql.toString(), new RowCallbackHandler() {
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						do {
							Map standard = new HashMap(3);
							standard.put("id", rs.getInt("id"));	//检测标准ID
							standard.put("name", rs.getString("name"));	//检测标准名称
							standards.add(standard);
						} while (rs.next());
					}
				});

				sql.setLength(0);
				sql.append("SELECT COUNT(1) FROM base_standard WHERE delete_flag = 0 AND use_status = 1 ");
				if (StringUtil.isNotEmpty(standardCode)) {
					sql.append(" AND std_code LIKE '%"+standardCode+"%' ");
				}
				total = jdbcTemplate.queryForObject(sql.toString(), Integer.class);

//				//没有匹配的检测标准，返回当前录入名称
//				if (total == 0) {
//					Map standard = new HashMap(3);
//					standard.put("id", -System.currentTimeMillis());	//检测标准ID
//					standard.put("name", "[录]"+standardCode);	//检测标准名称
//					standards.add(standard);
//					total = 1;
//				}
			}
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		map.put("standards", standards);
		map.put("total", total);
		return map;
	}
}
