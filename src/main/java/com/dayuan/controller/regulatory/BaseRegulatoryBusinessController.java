package com.dayuan.controller.regulatory;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.aspose.cells.License;
import com.aspose.cells.SaveFormat;
import com.aspose.cells.Workbook;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryLicense;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.regulatory.BaseRegulatoryBusinessModel;
import com.dayuan.model.regulatory.BaseRegulatoryObjectModel;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryLicenseService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.system.SystemConfigJsonService;
import com.dayuan.util.*;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.util.Units;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xwpf.usermodel.*;
import org.json.JSONException;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.math.BigInteger;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.*;

/**
 * 经营户
 * @Description:
 * @Company:食安科技
 * @author Dz
 * @date 2017年8月15日
 */
@Controller
@RequestMapping("/regulatory/business")
public class BaseRegulatoryBusinessController extends BaseController {

	private final Logger log = Logger.getLogger(BaseRegulatoryBusinessController.class);

	@Autowired
	private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
	@Autowired
	private BaseRegulatoryLicenseService baseRegulatoryLicenseService;
	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;
	@Autowired
	private TBImportHistoryService importHistoryService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private SystemConfigJsonService systemConfigJsonService;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Value("${systemUrl}")
	private String systemUrl;
	@Value("${resources}")
	private String resources;
	@Value("${businessQr}")
	private String businessQr;
//	@Value("${businessPath}")
//	private String businessPath;

	/**
	 * 进入经营户管理界面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response,Integer regId){
		Map<String,Object> map = new HashMap<String,Object>();
		BaseRegulatoryObject regulatoryObject = null;
		try {
			//
			if(StringUtil.isNotEmpty(regId)){
				regulatoryObject = baseRegulatoryObjectService.queryById(regId);
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		map.put("regulatoryObject", regulatoryObject);
		return new ModelAndView("/regulatory/regulatoryBusiness/list",map);
	}

	/**
	 * 数据列表
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, HttpServletResponse response, BaseRegulatoryObjectModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseRegulatoryBusinessService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 保存经营户
	 */
	@RequestMapping("/save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request,HttpServletResponse response,BaseRegulatoryBusinessModel model,@RequestParam(value="filePathImage",required=false) MultipartFile file){
		AjaxJson aj = new AjaxJson();
		try {
			if(model.getRegulatoryBusiness() != null){
				if(StringUtil.isNotEmpty(model.getRegulatoryBusiness().getId())){
					//更新经营户
					PublicUtil.setCommonForTable(model.getRegulatoryBusiness(), false);
					baseRegulatoryBusinessService.updateBySelective(model.getRegulatoryBusiness());
				}else{

					if( StringUtil.isNotEmpty(model.getRegulatoryBusiness().getOpeShopCode()) ) {	//新增经营户档口编号不为空
						List<BaseRegulatoryBusiness> rbs = baseRegulatoryBusinessService.queryByRegid(model.getRegulatoryBusiness().getRegId(), null);
						for(BaseRegulatoryBusiness rb : rbs) {
							if( rb.getOpeShopCode().equals(model.getRegulatoryBusiness().getOpeShopCode()) ) {
								//档口编号重复
								aj.setMsg("档口编号已存在");
								aj.setSuccess(false);
								return aj;
							}
						}
					}

					//新增经营户
//					model.getRegulatoryBusiness().setId(UUIDGenerator.generate());
					//model.getRegulatoryBusiness().setChecked((short) 1);
					PublicUtil.setCommonForTable(model.getRegulatoryBusiness(), true);
					baseRegulatoryBusinessService.insert(model.getRegulatoryBusiness());
				}

				if(model.getRegulatoryLicense() != null){
					//保存图片
					if(null != file){
						String fileName = uploadFile(request,"licenseImage/",file,null);
						model.getRegulatoryLicense().setLicenseImage("/resources/licenseImage/"+fileName);
					}
					if(StringUtil.isNotEmpty(model.getRegulatoryLicense().getId())){
						//更新营业执照
						PublicUtil.setCommonForTable(model.getRegulatoryLicense(), false);
						baseRegulatoryLicenseService.updateBySelective(model.getRegulatoryLicense());
					}else{
						//新增营业执照
//						model.getRegulatoryLicense().setId(UUIDGenerator.generate());
						model.getRegulatoryLicense().setSourceId(model.getRegulatoryBusiness().getId());
						model.getRegulatoryLicense().setSourceType("1");
						model.getRegulatoryLicense().setLicenseType((short) 0);
						model.getRegulatoryLicense().setChecked((short) 1);
						PublicUtil.setCommonForTable(model.getRegulatoryLicense(), true);
						baseRegulatoryLicenseService.insert(model.getRegulatoryLicense());
					}
				}
				aj.setObj(model);
			}else{
				aj.setSuccess(false);
				aj.setMsg("保存失败");
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			aj.setSuccess(false);
			aj.setMsg("保存失败");
		}
		return aj;
	}

	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(Integer id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(id)){
				BaseRegulatoryBusinessModel businessModel = new BaseRegulatoryBusinessModel();
				BaseRegulatoryBusiness business = baseRegulatoryBusinessService.queryById(id);
				BaseRegulatoryLicense license = null;

				if(null != business){
					license = baseRegulatoryLicenseService.queryByBusinessId(id);
				}
				businessModel.setRegulatoryBusiness(business);
				businessModel.setRegulatoryLicense(license);
				jsonObject.setObj(businessModel);
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败");
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
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			Integer[] idas = new Integer[ida.length];
			for (int i = 0; i < ida.length; i++) {
				idas[i] = Integer.parseInt(ida[i]);
			}
			baseRegulatoryBusinessService.delete(idas);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 根据监管对象ID加载经营户信息
	 * @param request
	 * @param response
	 * @param regId 被检单位ID
	 * @return
	 */
	@RequestMapping("/queryByRegId")
	@ResponseBody
	public AjaxJson queryByRegId(HttpServletRequest request, HttpServletResponse response, Integer regId){
		AjaxJson jsonObject = new AjaxJson();
		List<BaseRegulatoryBusiness> list=null;
		try {
			list = baseRegulatoryBusinessService.queryByRegid(regId, null);
			//查询营业执照信息
			BaseRegulatoryLicense bean=baseRegulatoryLicenseService.queryBySourceIdAndType(regId,0);
			Map<String, Object> map=new HashMap<>();
			map.put("license", bean);
			jsonObject.setAttributes(map);
		} catch (Exception e) {
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询证照号码失败");
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		jsonObject.setObj(list);
		return jsonObject;
	}

	/**
	 * select2档口数据
	 * @param request
	 * @param response
	 * @param page 页码
	 * @param row 每页数量
	 * @param regId 被检单位ID
	 * @param shopCode 档口编号
	 * @return
	 */
	@RequestMapping("/select2BusinessData")
	@ResponseBody
	public Map select2BusinessData(HttpServletRequest request, HttpServletResponse response,
			Integer page, Integer row, Integer regId, String shopCode) {
		Map map = new HashMap();
		int total = 0;	//总数
		List business = new ArrayList();	//档口

		try {
			if (regId != null) {
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT id, ope_shop_code shopCode, ope_name opeName " +
						" FROM base_regulatory_business " +
						"WHERE delete_flag = 0 " +
						" AND reg_id = "+regId);
				if (StringUtil.isNotEmpty(shopCode)) {
					sql.append(" AND ope_shop_code LIKE '%"+shopCode+"%' ");
				}
				if (page>0 && row>0) {
					sql.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
				}
				jdbcTemplate.query(sql.toString(), new RowCallbackHandler() {
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						do {
							Map ope = new HashMap();
							ope.put("id", rs.getString("id"));	//档口ID
							ope.put("name", rs.getString("shopCode"));	//档口编号
							ope.put("opeName", rs.getString("opeName"));	//经营者名称
							business.add(ope);
						} while (rs.next());
					}
				});

				sql.setLength(0);
				sql.append("SELECT COUNT(1) " +
						" FROM base_regulatory_business " +
						"WHERE delete_flag = 0 " +
						" AND reg_id = "+regId);
				if (StringUtil.isNotEmpty(shopCode)) {
					sql.append(" AND ope_shop_code LIKE '%"+shopCode+"%' ");
				}
				total = jdbcTemplate.queryForObject(sql.toString(), Integer.class);
			}

			if (total == 0 && shopCode != null && !"".equals(shopCode.trim())){
				Map ope = new HashMap();
				ope.put("id", -System.currentTimeMillis());	//档口ID
				ope.put("name", "[录]"+shopCode);	//档口编号
				ope.put("opeName", "");	//经营者名称
				business.add(ope);
				total = 1;
			}
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
		}
		map.put("business", business);
		map.put("total", total);
		return map;
	}

	/**
	 * 查看经营户二维码
	 * @param ids 经营户ID
	 * @return
	 */
	@RequestMapping("/businessQrcode")
	@ResponseBody
	public AjaxJson businessQrcode(HttpServletRequest request,HttpServletResponse response, String ids) {
		AjaxJson aj = new AjaxJson();
		try {
			String[] ida = ids.split(",");

			String rootPath = resources + businessQr;
			DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建

			BaseRegulatoryBusiness business = null;
			List qrcodes = new ArrayList();	//二维码
			for(String businessId : ida){
				Map<String,Object> map = new HashMap<String,Object>();
				business = baseRegulatoryBusinessService.queryById(Integer.parseInt(businessId));
				if(business == null){
					throw new Exception("查看经营户二维码失败，经营户不存在！");
				}

				if(StringUtil.isNotEmpty(business.getQrcode())){
					//读取二维码
					File qrFile = new File(rootPath+business.getQrcode());
					if(!qrFile.exists()){
						QrcodeUtil.generateSamplingQrcode(request, business.getQrcode(), systemUrl + "iRegulatory/businessApp.do?id=" + business.getId(), rootPath);
					}
				}else{
					//生成二维码
					String qrcodeName = UUIDGenerator.generate()+".png";
					QrcodeUtil.generateSamplingQrcode(request, qrcodeName, systemUrl + "iRegulatory/businessApp.do?id=" +  + business.getId(), rootPath);
					business.setQrcode(qrcodeName);
					baseRegulatoryBusinessService.updateBySelective(business);
				}
				map.put("qrcodeSrc", "/resources/" + businessQr + business.getQrcode());
				map.put("opeShopName", business.getOpeShopName());
				map.put("opeShopCode", business.getOpeShopCode());
				qrcodes.add(map);
			}
			aj.setObj(qrcodes);
		} catch (Exception e) {
			aj.setSuccess(false);
			log.error("********************************"+e.getMessage()+e.getStackTrace());
		}
		return aj;
	}


	@RequestMapping(value = "/exportFile")
	private @ResponseBody ResponseEntity<byte[]> exportFile(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, String types, Integer regId,String opeShopName) {
		ResponseEntity<byte[]> responseEntity = null;
		String rootPath = resources + WebConstant.res.getString("storageDirectory") + "business/";
		File logoSaveFile = new File(rootPath);
		if (!logoSaveFile.exists()) {
			logoSaveFile.mkdirs();
		}
		String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
		try {
			SXSSFWorkbook workbook = null;

			List<BaseRegulatoryBusiness> list=baseRegulatoryBusinessService.queryByRegIdAndRegName(regId, opeShopName);

			if ("word".equals(types)) {
				String docName = fileName + ".doc";
				/*ItextTools.createDepartWordDocument(rootPath, rootPath + docName, Excel.BUSINESS_HEADERS, list, null, request);*/
				responseEntity = DyFileUtil.download(request, response, rootPath, docName);
				return responseEntity;
			}

			String xlsName = fileName + ".xlsx";
			workbook = new SXSSFWorkbook(100);
			String[] names;
			String[] attributes;
            String title = "";//标题
			if(null!=SystemConfigUtil.EXPORT_CONFIG){
				names = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("REGULATORYBUSINESS").getString("names").split(",");
				attributes = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("REGULATORYBUSINESS").getString("attributes").split(",");
                title = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("REGULATORYBUSINESS").getString("title");
			}else{
				names=Excel.BUSINESS_HEADERS;
				attributes=Excel.BUSINESS_FIELDS;
			}
			Excel.outputExcelFile(workbook, names, attributes, list, rootPath + xlsName, "1",title);
			FileOutputStream fOut = new FileOutputStream(rootPath + xlsName);
			workbook.write(fOut);
			fOut.flush();
			fOut.close();
			if ("excel".equals(types)) {
				responseEntity = DyFileUtil.download(request, response, rootPath, xlsName);
			} else if ("pdf".equals(types)) {
				if (!getLicense()) {
					return null;
				}
				Workbook wb = new Workbook(rootPath + xlsName);
				String pdfName = fileName + ".pdf";
				wb.removeExternalLinks();
				wb.save(new FileOutputStream(new File(rootPath + pdfName)), SaveFormat.PDF);
				responseEntity = DyFileUtil.download(request, response, rootPath, pdfName);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}

		return responseEntity;
	}

	/**
	 * 导出经营户二维码
	 * @param request
	 * @param response
	 * @param regId 监管对象ID
	 * @param busIds 经营户ID，多个以,隔开
	 * @param opeShopName 经营户
	 * @param type 类型 0经营户,1车辆
	 * @return
	 */
	@RequestMapping(value = "/exportQrcode")
	@ResponseBody
	public ResponseEntity<byte[]> exportQrcode(HttpServletRequest request, HttpServletResponse response, Integer regId, String busIds, String opeShopName, Integer type) {

		ResponseEntity<byte[]> responseEntity = null;
		try {
			//获取经营户二维码
			String rootPath = resources+businessQr;
			DyFileUtil.createFolder(rootPath);

			BaseRegulatoryObject regObject = baseRegulatoryObjectService.queryById(regId);
			List<BaseRegulatoryBusiness> bs = new ArrayList<BaseRegulatoryBusiness>();
			if (StringUtils.hasText(busIds)) {
				String[] busIds0 = busIds.split(",");
				Integer[] busIds1 = (Integer[]) ConvertUtils.convert(busIds0,Integer.class);
				bs = baseRegulatoryBusinessService.queryByIds(busIds1);

			} else {
				bs = baseRegulatoryBusinessService.queryByRegid(regId, null);

				StringBuffer sql = new StringBuffer();
				sql.append("SELECT brb.id, brb.reg_id, brb.ope_shop_name, brb.ope_shop_code, brb.ope_name " +
						"FROM base_regulatory_business brb " +
						"WHERE brb.delete_flag=0 AND brb.reg_id = "+regId+" ");
				if (StringUtils.hasText(opeShopName)) {
					sql.append(" AND (ope_shop_name LIKE '%"+opeShopName+"%' " +
							"OR ope_name LIKE '%"+opeShopName+"%' " +
							"OR ope_shop_code LIKE '%"+opeShopName+"%') ");
				}
				if (type != null) {
					sql.append(" AND type = ").append(type).append(" ");
				}

				bs = (List<BaseRegulatoryBusiness>) jdbcTemplate.query(sql.toString(), new ResultSetExtractor(){
					@Override
					public Object extractData(ResultSet rs) throws SQLException, DataAccessException {
						List<BaseRegulatoryBusiness> brbs = new ArrayList<BaseRegulatoryBusiness>();
						while(rs.next())
						{
							BaseRegulatoryBusiness brb = new BaseRegulatoryBusiness();
							brb.setId(rs.getInt(1));
							brb.setRegId(rs.getInt(2));
							brb.setOpeShopName(rs.getString(3));
							brb.setOpeShopCode(rs.getString(4));
							brb.setOpeName(rs.getString(5));
							brbs.add(brb);
						}
						return brbs;
					}
				});
			}

			//二维码风格
			//尺寸
			Integer size = 100;
			//logo
			Integer logoNo = null;
			String logoStr = null;
			//添加文字
			String title = "";
			Integer fontSize = 14;
			JSONObject regQrcodeStyle = systemConfigJsonService.getSystemConfig(SystemConfigJsonService.systemConfigType.REG_QRCODE_STYLE);
			if (regQrcodeStyle != null) {
				if (regQrcodeStyle.getInteger("size") != null) {
					size = regQrcodeStyle.getInteger("size");
				}
				if (regQrcodeStyle.getInteger("logoNo") != null) {
					logoNo = regQrcodeStyle.getInteger("logoNo");

					JSONArray logos = regQrcodeStyle.getJSONArray("logos");
					if (logos != null && logos.size()>logoNo) {
						logoStr = logos.getString(logoNo);
					}
					if (regQrcodeStyle.getString("title") != null) {
						title = regQrcodeStyle.getString("title");
					}
					if (regQrcodeStyle.getString("fontSize") != null) {
						fontSize = Integer.parseInt(regQrcodeStyle.getString("fontSize").replaceAll("px",""));
					}
				}
			}



			//生成Word
			//表格列数
			int colNum = 3;
			//表格列宽
			int tableCellWidth = 3500;
			//单元格内边距 - 上 左 下 右
			int[] cellMargins = new int[]{200, 50, 200, 50};

			//大尺寸二维码
			if (size == 200) {
				colNum = 2;
				tableCellWidth = 5000;
				cellMargins = new int[]{200, 100, 200, 100};
			}

			//创建Word文件
			XWPFDocument doc = new CustomXWPFDocument();

			// 设置页面大小间距 A4大小
			POIUtil.setPageSize(doc,11907,16840,1000,1000,1000,1000);

			//创建表格
			XWPFTable table = doc.createTable(1, colNum);
			//设置单元格边距
			table.setCellMargins(cellMargins[0],cellMargins[1],cellMargins[2],cellMargins[3]);

			XWPFTableRow tableRow = null;
			for (int i = 0; i < bs.size(); i++) {
				//获取单元格
				XWPFTableCell tableCell = null;
				if ((i + 1) % colNum == 1) {
					if (i == 0) {
						tableRow = table.getRow(0);
					} else {
						tableRow = table.createRow();
					}
					tableCell = tableRow.getCell(0);
				} else {
					tableCell = tableRow.getCell(i % colNum);
				}
				//设置单元格宽度
				POIUtil.setCellWidthAndVAlign(tableCell, tableCellWidth, XWPFTableCell.XWPFVertAlign.CENTER, STJc.CENTER);

				//创建段落对象
				XWPFParagraph p1 = tableCell.getParagraphArray(0);
				//设置段落的对齐方式
				setParagraphVAlign(p1);

				//添加文字
				if (StringUtil.isNotEmpty(title)) {
					XWPFRun run1 = p1.createRun();
					run1.setFontSize(fontSize);
					run1.setText(title);
					//换行
					run1.addBreak(BreakType.TEXT_WRAPPING);

				}

				//监管对象名称
				XWPFRun run2 = p1.createRun();
				run2.setText(regObject.getRegName());
				run2.setFontSize(fontSize);
				//换行
				run2.addBreak(BreakType.TEXT_WRAPPING);

				//设置二维码
				XWPFRun run3 = p1.createRun();
				InputStream qrcode = QrcodeUtil.generateQrcode3(systemUrl+"iRegulatory/businessApp.do?id=" + bs.get(i).getId(), size, size, logoStr);
				run3.addPicture(qrcode, XWPFDocument.PICTURE_TYPE_PNG, bs.get(i).getId()+".png", Units.toEMU(size*0.75) , Units.toEMU(size*0.75));
				//换行
				run3.addBreak(BreakType.TEXT_WRAPPING);

				//经营户编号
				XWPFRun run4 = p1.createRun();
				run4.setText(bs.get(i).getOpeShopCode());
				run4.setFontSize(fontSize);

			}

			//导出经营户二维码临时文件目录
			String wordTempPath = resources + businessQr + "temp/";
			//导出经营户二维码word
			String tempFile = UUIDGenerator.generate() + ".doc";
			DyFileUtil.createFolder(wordTempPath);

			FileOutputStream out = new FileOutputStream(wordTempPath + tempFile);
			doc.write(out);
			out.close();

			responseEntity = DyFileUtil.download(request, response, wordTempPath, tempFile);
			//删除临时文件
			DyFileUtil.deleteFolder(wordTempPath + tempFile);

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}

		return responseEntity;
	}

	/**
	* @Description: 设置列宽
	*/
	private void setCellWidthAndVAlign(XWPFTableCell cell, String width) {
		cell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);	//垂直居中
		CTTc cttc = cell.getCTTc();
		CTTcPr cellPr = cttc.addNewTcPr();
		CTTblWidth tblWidth = cellPr.isSetTcW() ? cellPr.getTcW() : cellPr.addNewTcW();
		if(!StringUtil.isEmpty(width)){
			tblWidth.setW(new BigInteger(width));
			tblWidth.setType(STTblWidth.DXA);
		}
	}

	/**
	* @Description: 设置段落的对齐方式
	*/
	private void setParagraphVAlign(XWPFParagraph p) {
		p.setAlignment(ParagraphAlignment.CENTER);// 设置段落的水平对齐方式
		p.setVerticalAlignment(TextAlignment.CENTER);// 设置段落的垂直对齐方式
	}

	public static boolean getLicense() {
		boolean result = false;
		try {
			InputStream is = BaseController.class.getClassLoader().getResourceAsStream("\\license.xml");
			License aposeLic = new License();
			aposeLic.setLicense(is);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	/**
	* @Description 经营户导入
	* @Date 2020/10/10 11:13
	* @Author xiaoyl
	* @Param isNewMenu是否从监管对象新菜单进入：可选值：Y，N；默认为N否,
	* @return
	*/
	@RequestMapping("/toImport")
	private ModelAndView toImport(HttpServletRequest request,Integer type, @RequestParam(required = false,defaultValue = "N") String isNewMenu) throws JSONException {
		request.setAttribute("type", type);
		request.setAttribute("isNewMenu",isNewMenu);
		return new ModelAndView("/regulatory/regulatoryBusiness/toImport");
	}
	/**
	 * 1.统一增加字段长度验证，特别是字符串型数据，必须验证数据表的字段长度，防止字段过长导入失败。
	 * 2.必填字段超出长度，该条记录报错，非必填字段超出长度字段截取最大长度。
	 * 3.非必填字段如果数据值错误，可丢弃值，或取默认值，不建议报错(大家可以讨论一下再确定)
	 * 4.尽量做到报错准确，最大程度获取真实的错误提示
	* @Param
	* @return
	*/
	@RequestMapping("/importData")
	public @ResponseBody AjaxJson importData(@RequestParam("xlsx") MultipartFile file, HttpServletRequest request, HttpServletResponse response,HttpSession session,Integer departId,String departNames) {
		AjaxJson jsonObject = new AjaxJson();
		Timestamp stamp = new Timestamp(System.currentTimeMillis());
		String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS") + ".xlsx";
		FileOutputStream fos = null;
		String path = resources + "business/";
		int successCount = 0;
		int failCount = 0;
		List<ImportBaseData> errList = new ArrayList<ImportBaseData>();
		TSUser user = (TSUser)session.getAttribute(WebConstant.SESSION_USER);

		try {
			fos = FileUtils.openOutputStream(new File(path + "/" + fileName));
			IOUtils.copy(file.getInputStream(), fos);
			org.apache.poi.ss.usermodel.Workbook workBook = WorkbookFactory.create(new FileInputStream(new File(path + "/" + fileName)));
			Sheet sheet = workBook.getSheetAt(0);
			Row row = null;
			TSDepart d =departService.getById(departId);
			int totalRow = sheet.getLastRowNum();
			TBImportHistory t = new TBImportHistory();
			String description = getCellValue(sheet.getRow(0).getCell(0));// 获取第一行的备注说明信息
			for (int i = 1; i <= totalRow; i++) {
				row = sheet.getRow(i);
				if(null==row)continue;
				if(isEmptyRow(row))continue;
				String departName       = getCellValue(row.getCell(0));  //机构名称,必填;机构名称只是用于查询机构ID使用，因此可以不用校验机构名称的长度
				String regName          = getCellValue(row.getCell(1));  //监管对象名称，必填；监管对象名称只是用于查询监管对象使用，写入表用的是ID，因此可以不用校验机构名称的长度
				String opeShopCode      = getCellValue(row.getCell(2));  //档口编号,必填
				String opeShopName      = getCellValue(row.getCell(3));  //档口名称
				String opeName          = getCellValue(row.getCell(4));  //经营者
				String opeIdcard        = getCellValue(row.getCell(5));  //经营户身份证号
				String creditCode       = getCellValue(row.getCell(6));  //统一社会信用代码
				String contacts         = getCellValue(row.getCell(7));  //联系人
				String opePhone         = getCellValue(row.getCell(8));  //联系方式
				String creditRatings    = getCellValue(row.getCell(9));  //信用等级
				String monitoringLevels = getCellValue(row.getCell(10)); //监控级别
				String businessCope     = getCellValue(row.getCell(11)); //经营范围
				String type             = getCellValue(row.getCell(12)); //经营户类型,0:经营户;1:车辆
				String checkeds         = getCellValue(row.getCell(13)); //审核状态，必填

				// 统一增加字段长度验证，特别是字符串型数据，必须验证数据表的字段长度，防止字段过长导入失败。
				// 必填字段超出长度，该条记录报错，非必填字段超出长度字段截取最大长度。
				// 非必填字段如果数据值错误，可丢弃值，或取默认值，不建议报错(大家可以讨论一下再确定)
				// 尽量做到报错准确，最大程度获取真实的错误提示

				if(i==1){
					if(!departName.equals("机构名称")||!regName.equals("监管对象名称")||!opeShopCode.equals("档口编号")||!opeShopName.equals("档口名称")||!checkeds.equals("状态")||!opePhone.equals("联系方式")){
						t.setRemark("导入数据的模板不正确");
						jsonObject.setSuccess(false);
						break;
					}
				}else {
					if(StringUtil.isNotEmpty(opePhone)){
						DecimalFormat df = new DecimalFormat("#");
						Object object=df.parseObject(opePhone);
						opePhone = df.format(object);
					}
					if(StringUtil.isNotEmpty(contacts)){
						if(contacts.length()>12){
							addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds, "[联系人]超出长度");
							failCount++;
							continue;
						}
					}
					if (StringUtil.isEmpty(departName)) {
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds, "[机构名称]不能为空");
						failCount++;
						continue;
					}
					if (StringUtil.isEmpty(regName)) {
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds, "[监管对象名称]不能为空");
						failCount++;
						continue;
					}
					/*if (StringUtil.isEmpty(opeShopName)) {
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,checkeds, "档口名称不能为空");
						failCount++;
						continue;
					}*/
					if (StringUtil.isEmpty(opeShopCode)) {
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds,  "[档口编号]不能为空");
						failCount++;
						continue;
					}else if(StringUtil.isNotEmpty(opeShopCode) && opeShopCode.length()>50){
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds,  "[档口编号]超出长度，最大长度为50");
						failCount++;
						continue;
					}
					if (StringUtil.isEmpty(checkeds)) {
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds,  "[状态]不能为空");
						failCount++;
						continue;
					}
					//非必填字段首先检验是否为空，不为空进一步校验长度是否超出数据库设置的长度，如果超出则根据数据库设置的长度截取数据 start
					//档口名称
					if(StringUtil.isNotEmpty(opeShopName) && opeShopName.length()>100){
						opeShopName=opeShopName.substring(0,100);
					}
					//经营者
					if(StringUtil.isNotEmpty(opeName) && opeName.length()>50){
						opeName=opeName.substring(0,50);
					}
					//经营户身份证号
					if(StringUtil.isNotEmpty(opeIdcard) && opeIdcard.length()>20){
						opeIdcard=opeIdcard.substring(0,20);
					}
					//统一社会信用代码
					if(StringUtil.isNotEmpty(creditCode) && creditCode.length()>100){
						creditCode=creditCode.substring(0,100);
					}
					//联系人
					if(StringUtil.isNotEmpty(contacts) && contacts.length()>50){
						contacts=contacts.substring(0,50);
					}
					//联系方式
					if(StringUtil.isNotEmpty(opePhone) && opePhone.length()>50){
						opePhone=opePhone.substring(0,50);
					}
					//经营范围
					if(StringUtil.isNotEmpty(businessCope) && businessCope.length()>300){
						businessCope=businessCope.substring(0,300);
					}
					//非必填字段校验长度是否超出数据库设置的长度，如果超出则根据数据库设置的长度截取数据 end

					BaseRegulatoryObject object1=baseRegulatoryObjectService.selectByDepartCodeAndRegName(d.getDepartCode(),departName,regName,null);
					//增加判断机构是否存在
					List<TSDepart> subDeparts = departService.selectByDepartCodeAndDepartName(d.getDepartCode(), departName);
					if (subDeparts.size() == 0) {
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds, "[" +  departName + "]机构下无[" + departName + "]子机构");
						failCount++;
						continue;
					}else if(null != object1){
						List<BaseRegulatoryBusiness> bus =baseRegulatoryBusinessService.queryByRegIdAndRegUser(object1.getId(), opeShopCode);
						if(bus.size() == 0){
							BaseRegulatoryBusiness business=new BaseRegulatoryBusiness();
							business.setRegId(object1.getId());
							business.setOpeShopName(opeShopName);
							business.setOpeShopCode(opeShopCode);

							business.setOpeName(opeName);
							business.setOpeIdcard(opeIdcard);
							business.setCreditCode(creditCode);
							business.setOpePhone(opePhone);
							business.setBusinessCope(businessCope);
							business.setContacts(contacts);
							Short monitoringLevelss;//监控级别：1 安全，2 轻微，3 警惕，4 严重；没有传入正确的值者传入数据不正确，直接设置为安全
							if(StringUtil.isNotEmpty(monitoringLevels)){
								if(("安全").equals(monitoringLevels)){
									monitoringLevelss=1;
								}else if (("轻微").equals(monitoringLevels)) {
									monitoringLevelss=2;
								}else if (("警惕").equals(monitoringLevels)) {
									monitoringLevelss=3;
								}else if (("严重").equals(monitoringLevels)) {
									monitoringLevelss=4;
								}else{
									monitoringLevelss=1;
								}
							}else{
								monitoringLevelss=1;
							}
							business.setMonitoringLevel(monitoringLevelss);
							Integer type1 = null;//经营户类型：0 经营户，1 车辆；没有传入类型或者传入类型不正确，直接设置类型为经营户
							if(StringUtil.isNotEmpty(type)){
								if(("经营户").equals(type)){
									type1=0;
								}else if (("车辆").equals(type)) {
									type1=1;
								}else {
									type1=0;
								}
							}else {
								type1=0;
							}
							business.setType(type1);
							Short creditRatingss;
							if(StringUtil.isNotEmpty(creditRatings)){
								if(("A").equals(creditRatings)){
									creditRatingss=1;
								}else if (("B").equals(creditRatings)) {
									creditRatingss=2;
								}else if (("C").equals(creditRatings)) {
									creditRatingss=3;
								}else if (("D").equals(creditRatings)) {
									creditRatingss=4;
								}else {
									creditRatingss=1;
								}
							}else{
								creditRatingss=1;
							}
							business.setCreditRating(creditRatingss);
							Short checkedss;//审核状态：未审核、未审核；用户不填写或者填入其他值则默认设置为已审核状态
							if(StringUtil.isNotEmpty(checkeds)){
								if(("未审核").equals(checkeds)){
									checkedss=0;
									business.setChecked(checkedss);
								}else if (("已审核").equals(checkeds)) {
									checkedss=1;
									business.setChecked(checkedss);
								}else {
									checkedss = 1;
									business.setChecked(checkedss);
								}
							}else {
								checkedss=1;
								business.setChecked(checkedss);
							}

							PublicUtil.setCommonForTable(business, true);
							baseRegulatoryBusinessService.insertSelective(business);
							successCount++;
						}else{
							addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds,  "[" + regName + "]的档口编号[" + opeShopCode + "]已存在");
							failCount++;
							continue;
						}
					}else {
						addToErrList(errList,departName,regName,opeShopCode,opeShopName,opeName,opeIdcard,creditCode,contacts,opePhone,creditRatings,monitoringLevels,businessCope,type,checkeds, "[" + departName + "]机构下无[" + regName + "]");
						failCount++;
						continue;
					}
				}
			}
			String errFile = null;
			if (errList.size() > 0) {
				errFile = fileName.substring(0, fileName.indexOf(".")) + "_err.xlsx";
				SXSSFWorkbook wb = new SXSSFWorkbook(100);
				Excel.outputExcelFileForDescription(wb, ImportBaseData.headers, ImportBaseData.fields, errList, path + errFile, "1","",description);
				FileOutputStream fOut = new FileOutputStream(path + "/" + errFile);
				wb.write(fOut);
				fOut.flush();
				fOut.close();
			}
			t.setDepartId(departId);
			t.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
			t.setDepartName(departNames);
			t.setUserId(user.getId());
			t.setUsername(user.getRealname());
			t.setSourceFile("/business/"+fileName);
			t.setErrFile(errFile==null?null:"/business/"+errFile);
			t.setSuccessCount(successCount);
			t.setFailCount(failCount);
			t.setImportDate(stamp);
			t.setImportType(3);
			t.setEndDate(new Date());
			importHistoryService.insertSelective(t);
			jsonObject.setMsg("/business/"+errFile);
			if(jsonObject.isSuccess()){
				jsonObject.setMsg("/business/"+errFile);
			}else{
				jsonObject.setMsg("导入数据的模板不正确");
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("导入失败");
		} finally {
			try {
				fos.close();
			} catch (IOException e) {
				log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			}
		}
		return jsonObject;
	}
	private void addToErrList(List<ImportBaseData> errList,String departName,String regName, String opeShopCode, String opeShopName, String opeName, String opeIdcard,
			String creditCode,String contacts, String opePhone, String creditRatings,String monitoringLevels,String businessCope,String type, String checkeds,String errMsg) {
		ImportBaseData d = new ImportBaseData();
		d.setDepartName(departName);
		d.setRegName(regName);
		d.setOpeShopName(opeShopName);
		d.setOpeShopCode(opeShopCode);
		d.setOpeName(opeName);
		d.setOpeIdcard(opeIdcard);
		d.setCreditCode(creditCode);
		d.setContacts(contacts);
		d.setOpePhone(opePhone);
		d.setCreditRatings(creditRatings);
		d.setMonitoringLevel(monitoringLevels);
		d.setBusinessCope(businessCope);
		d.setType(type);
		d.setCheckeds(checkeds);
		d.setErrMsg(errMsg);
		errList.add(d);
	}
	public static class ImportBaseData {
		public static String[] headers = { "机构名称","监管对象名称","档口编号", "档口名称", "经营者", "经营户身份证号","统一社会信用代码","联系人","联系方式", "信用等级", "监控级别","经营范围","经营户类型","状态", "导入失败原因" };
		public static String[] fields = { "departName","regName","opeShopCode", "opeShopName", "opeName", "opeIdcard","creditCode","contacts","opePhone","creditRatings","monitoringLevels","businessCope","type","checkeds","errMsg"};
		String departName;//机构名称
		String regName;//市场名称
		String opeShopCode;//档口编号
		String opeShopName;//档口名称
		String opeName;//经营者
		String opeIdcard;//经营户身份证号
		String creditCode;//统一社会信用代码
		String contacts;//联系人
		String opePhone;//联系方式
		String creditRatings;//信用等级
		String monitoringLevels;//监控级别
		String businessCope;//经营范围
		String type;//经营户类型
		String checkeds;//状态
		String errMsg;// 导入失败原因

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public void setMonitoringLevels(String monitoringLevels) {
			this.monitoringLevels = monitoringLevels;
		}

		public String getContacts() {
			return contacts;
		}

		public void setContacts(String contacts) {
			this.contacts = contacts;
		}

		public String getBusinessCope() {
			return businessCope;
		}

		public void setBusinessCope(String businessCope) {
			this.businessCope = businessCope;
		}

		public String getCreditCode() {
			return creditCode;
		}

		public void setCreditCode(String creditCode) {
			this.creditCode = creditCode;
		}

		public static String[] getHeaders() {
			return headers;
		}

		public static void setHeaders(String[] headers) {
			ImportBaseData.headers = headers;
		}

		public static String[] getFields() {
			return fields;
		}

		public static void setFields(String[] fields) {
			ImportBaseData.fields = fields;
		}
		public String getDepartName() {
			return departName;
		}

		public void setDepartName(String departName) {
			this.departName = departName;
		}

		public String getRegName() {
			return regName;
		}

		public void setRegName(String regName) {
			this.regName = regName;
		}

		public String getOpeShopName() {
			return opeShopName;
		}

		public void setOpeShopName(String opeShopName) {
			this.opeShopName = opeShopName;
		}

		public String getOpeShopCode() {
			return opeShopCode;
		}

		public void setOpeShopCode(String opeShopCode) {
			this.opeShopCode = opeShopCode;
		}

		public String getOpeName() {
			return opeName;
		}

		public void setOpeName(String opeName) {
			this.opeName = opeName;
		}

		public String getOpeIdcard() {
			return opeIdcard;
		}

		public void setOpeIdcard(String opeIdcard) {
			this.opeIdcard = opeIdcard;
		}

		public String getOpePhone() {
			return opePhone;
		}

		public void setOpePhone(String opePhone) {
			this.opePhone = opePhone;
		}

		public String getCreditRatings() {
			return creditRatings;
		}

		public void setCreditRatings(String creditRatings) {
			this.creditRatings = creditRatings;
		}

		public String getMonitoringLevels() {
			return monitoringLevels;
		}

		public void setMonitoringLevel(String monitoringLevels) {
			this.monitoringLevels = monitoringLevels;
		}

		public String getCheckeds() {
			return checkeds;
		}

		public void setCheckeds(String checkeds) {
			this.checkeds = checkeds;
		}

		public String getErrMsg() {
			return errMsg;
		}

		public void setErrMsg(String errMsg) {
			this.errMsg = errMsg;
		}
	}
}
