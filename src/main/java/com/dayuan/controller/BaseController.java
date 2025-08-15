package com.dayuan.controller;

import com.dayuan.bean.system.TSFunction;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.util.StringUtil;
import net.sf.json.JSONArray;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.propertyeditors.PropertiesEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BaseController {
	
	private static final Logger log = Logger.getLogger(BaseController.class);
	
	public static final String OPT_LOG_TYPE_SUCCESS = "成功";
	public static final String OPT_LOG_TYPE_ERROR = "失败";
	public static final String FUN_EXPORT = "导出";

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		
		//日期时间格式化
		binder.registerCustomEditor(Date.class, new PropertiesEditor() {
			@Override
			public void setAsText(String source) throws IllegalArgumentException {
				SimpleDateFormat sdf = null;
				//日期格式化
				if(source == null || source.trim().equals("")){
				}else if(source.matches("^\\d{4}-\\d{1,2}$")){
					sdf = new SimpleDateFormat("yyyy-MM");
				}else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$")){
					sdf =  new SimpleDateFormat("yyyy-MM-dd");
				}else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}$")){
					sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm");
				}else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}:\\d{1,2}$")){
					sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				}else {
					throw new IllegalArgumentException("时间格式不正确，支持:yyyy-MM、yyyy-MM-dd、yyyy-MM-dd HH:mm和yyyy-MM-dd HH:mm:ss");
				}
				
				try {
					if(null != sdf){
						setValue(sdf.parseObject(source));
					}else {
						setValue(null);
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		});
		
		//字符串格式化
		binder.registerCustomEditor(String.class, new PropertiesEditor() {
			@Override
			public void setAsText(String arg0) throws IllegalArgumentException {
				if(arg0!=null && !"".equals(arg0)) {
					//首尾空白字符替换为''
		            Pattern p = Pattern.compile("(^\\s*)|(\\s*$)");   
		            Matcher m = p.matcher(arg0);   
		            setValue(m.replaceAll("")); 
		        }else {   
		        	setValue(null); 
		        }     
			}
		});
		
	}

	/**
	 * 1.根据请求url地址查找菜单ID 2.根据角色ID和菜单ID查找按钮操作权限
	 * @param path 请求url
	 * @param request
	 * @param tSFunctionService
	 * @param tSOperationService
	 * @author xyl
	 */
	public void getOperationList(String path, HttpServletRequest request, TSFunctionService tSFunctionService, TSOperationService tSOperationService) {
		try {
			TSFunction tsFunction = tSFunctionService.queryByFunctionUrl(path);
			List<TSOperation> btnList = tSOperationService.queryByRoleIdAndFunctionId(PublicUtil.getSessionUser().getRoleId(), tsFunction.getId());
			JSONArray json = new JSONArray().fromObject(btnList);
			request.getSession().setAttribute("btnList", json.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

	/**
	 * 文件上传
	 * @param request
	 * @param filePath 文件上传根路径
	 * @param file 文件
	 * @param reName 重命名
	 * @return 文件名
	 * @throws IOException
	 */
	public String uploadFile(HttpServletRequest request, String filePath, MultipartFile file, String reName) throws IOException {
		String path = WebConstant.res.getString("resources") + filePath; // request.getServletContext().getRealPath(filePath);
		
		File myFilePath = new File(path);
		if (!myFilePath.exists()) {
			myFilePath.mkdirs();
		}
		
		// reName为空时表示不对文件重命名
		String fileName = reName == null ? file.getOriginalFilename() : reName;
		if (!StringUtil.isEmpty(fileName)) {
			FileOutputStream fos = null;
			// try {
			fos = FileUtils.openOutputStream(new File(path + fileName));
			IOUtils.copy(file.getInputStream(), fos);
			// } catch (IOException e) {
			// e.printStackTrace();
			// } finally {
			// try {
			fos.close();
			// } catch (IOException e) {
			// e.printStackTrace();
			// }
			// }
			return fileName;
		}
		return null;
	}
	
	/**
	 * 上传文件
	 * @param filePath	目录
	 * @param file	文件
	 * @param fileName	重命名
	 * @return
	 * @throws IOException
	 */
	public String uploadFile(String filePath, MultipartFile file, String fileName) throws IOException {
		// fileName为空时表示不对文件重命名
		fileName = fileName == null || "".equals(fileName.trim()) ? file.getOriginalFilename() : fileName;
		
		//创建目录
		File fp = new File(filePath);
		if (!fp.exists()) {
			fp.mkdirs();
		}
		
		FileOutputStream fos = FileUtils.openOutputStream(new File(filePath + fileName));
		IOUtils.copy(file.getInputStream(), fos);
		fos.close();
		return fileName;
	}

	/**
	 * 文件上传方法
	 * 
	 * @param myFile文件列表数组
	 * @param realpath上传路径
	 * @author xyl
	 * @return
	 * @throws IOException
	 */
	public static void uploadFile(MultipartFile myFile, String realpath) throws IOException {
		File file = new File(realpath);
		if (!file.exists() && !file.isDirectory()) {
			file.mkdir();
		}
		CommonsMultipartFile msf = null;
		if (!myFile.isEmpty() && myFile.getSize() != 0) {
			myFile.getOriginalFilename();
			System.out.println("multipartFile为空");
			msf = (CommonsMultipartFile) myFile;
			FileUtils.copyInputStreamToFile(myFile.getInputStream(), new File(realpath, myFile.getOriginalFilename()));
			System.out.println("上传成功");
		}
	}

	/**
	 * 文件下载方法
	 * 
	 * @param fileName文件名
	 * @param outputFilePath文件所在的绝对路径
	 * @param fileName要下载的文件名称
	 * @return
	 */
	@SuppressWarnings("finally")
	public static ResponseEntity<byte[]> download(HttpServletRequest request, String outputFilePath, String fileName) {

		ResponseEntity<byte[]> responseEntity = null;
		String dfileName = "";
		HttpHeaders headers = new HttpHeaders();
		try {
			dfileName = new String(fileName.getBytes("gb2312"), "iso8859-1");
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.setContentDispositionFormData("attachment", dfileName);
			File file = new File(outputFilePath + "\\" + fileName);// 文件绝对路径
			if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
				responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);// HttpStatus.CREATED
			} else {
				responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);// HttpStatus.CREATED
			}
		} catch (UnsupportedEncodingException e) {
			log.error("文件下载异常====================" + e.getMessage());
		} catch (IOException e) {
			log.error("文件下载异常====================" + e.getMessage());
		} finally {
			return responseEntity;
		}
	}

	// 读取单元格的值
	public String getCellValue(Cell cell) {
		if (cell == null) {
			return null;
		}
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			return cell.getRichStringCellValue().getString().trim();
		case Cell.CELL_TYPE_NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 非线程安全
				return sdf.format(cell.getDateCellValue());
			} else {
//				Double d = cell.getNumericCellValue();
//				if(d%1<1){
//					return String.valueOf(d);
//				}
//				return String.valueOf(d.longValue());
				cell.setCellType(Cell.CELL_TYPE_STRING);  
				return String.valueOf(cell.getStringCellValue());
			}
		case Cell.CELL_TYPE_BOOLEAN:
			return String.valueOf(cell.getBooleanCellValue());
		case Cell.CELL_TYPE_FORMULA:
			return String.valueOf(cell.getNumericCellValue());
		default:
			return null;
		}
	}

	public boolean isEmptyRow(Row row) {
		for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
			Cell cell = row.getCell(c);
			if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK)
				return false;
		}
		return true;
	}

	/**
	* @Description 获取访问主机IP
	* @Date 2022/09/15 14:00
	* @Author xiaoyl
	* @Param
	* @return
	*/
	public String getRemoteIP(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		ip = "0:0:0:0:0:0:0:1".equals(ip) ? "127.0.0.1" : ip;
		return ip;
	}
}
