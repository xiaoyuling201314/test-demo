package com.dayuan.controller.interfaces;

//import java.io.File;
//import java.math.BigDecimal;
//import java.net.URLDecoder;
//import java.text.SimpleDateFormat;
//import java.util.*;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.dayuan.bean.InterfaceJson;
//import com.dayuan.bean.data.BaseDetectItem;
//import com.dayuan.bean.data.BaseFoodType;
//import com.dayuan.bean.data.TbFile;
//import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
//import com.dayuan.bean.regulatory.BaseRegulatoryObject;
//import com.dayuan.common.PublicUtil;
//import com.dayuan.logs.aop.QrcodeScanCount;
//import com.dayuan.logs.aop.SystemLog;
//import com.dayuan.service.data.*;
//import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
//import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
//import com.dayuan.service.system.TSUserService;
//import com.dayuan.util.*;
//import com.dayuan3.common.util.SystemConfigUtil;
//import org.apache.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.stereotype.Controller;
//import org.springframework.util.StringUtils;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.alibaba.fastjson.JSONObject;
//import com.dayuan.bean.AjaxJson;
//import com.dayuan.bean.data.BasePoint;
//import com.dayuan.bean.ledger.BaseLedgerStock;
//import com.dayuan.bean.sampling.TbSampling;
//import com.dayuan.bean.sampling.TbSamplingDetail;
//import com.dayuan.bean.system.TSUser;
//import com.dayuan.common.WebConstant;
//import com.dayuan.exception.MyException;
//import com.dayuan.model.sampling.TbSamplingDetailReport;
//import com.dayuan.service.ledger.BaseLedgerStockService;
//import com.dayuan.service.sampling.TbSamplingDetailRecevieService;
//import com.dayuan.service.sampling.TbSamplingDetailService;
//import com.dayuan.service.sampling.TbSamplingService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月14日
 */
@Controller
@RequestMapping("/iSampling")
public class SamplingController extends BaseInterfaceController{
//
//	private Logger iErrLog = Logger.getLogger("iERR");
//
//	@Autowired
//	private TbSamplingService tbSamplingService;
//	@Autowired
//	private TbSamplingDetailService tbSamplingDetailService;
//	@Autowired
//	private JdbcTemplate jdbcTemplate;
//	@Autowired
//	private TbSamplingDetailRecevieService tbSamplingDetailRecevieService;
//	@Autowired
//	private BasePointService basePointService;
//	@Autowired
//	private BaseLedgerStockService stockService;
//	@Autowired
//	private BaseLawInstrumentPlaybackService playbackService;
//	@Autowired
//	private TbFileService fileService;
//	@Autowired
//	private TSUserService tsUserService;
//	@Autowired
//	private BaseRegulatoryObjectService regService;
//	@Autowired
//	private BaseRegulatoryBusinessService busService;
//	@Autowired
//	private BaseFoodTypeService foodService;
//	@Autowired
//	private BaseDetectItemService itemService;
//
//	@Value("${defaultSignatureFile}")
//	private String defaultSignatureFile;
//	@Value("${resources}")
//	private String resources;    //项目资源文件夹
//	@Value("${filePath}")
//	private String filePath;
//	@Value("${opeSignaturePath}")
//	private String opeSignaturePath;    //抽样-经营户签名
//	@Value("${shoppingReceipt}")
//	private String shoppingReceipt;    //抽样-购样小票
//	@Value("${resourcesUrl}")
//	private String resourcesUrl;
//	@Value("${samplingQr}")
//	private String samplingQr;
//
//	/**
//	 * 仪器查询本仪器的等待检测的任务数量
//	 * @param userToken 用户token
//	 * @param serialNumber 仪器唯一标识
//	 * @param lastUpdateTime 最后更新时间
//	 * @return 返回检测任务数量
//	 */
//	@ResponseBody
//	@RequestMapping(value = "/samplingNumber", method = RequestMethod.POST)
//	public AjaxJson samplingNumber(HttpServletRequest request, String userToken,String serialNumber,@RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime) {
//
//		AjaxJson aj = new AjaxJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
//
//			StringBuffer sbuffer = new StringBuffer();
//			sbuffer.append("SELECT count(1) from tb_sampling_detail d");
//			sbuffer.append(" INNER JOIN tb_sampling s on d.sampling_id=s.id");
////			sbuffer.append(" LEFT JOIN tb_task_detail td on d.param2=td.id");
////			sbuffer.append(" LEFT JOIN tb_task t on t.id=s.task_id");
//			sbuffer.append(" where d.status=0 and s.delete_flag=0 and d.recevie_device=?");
////			int count= jdbcTemplate.queryForInt(sbuffer.toString(), new Object[]{serialNumber});
//			int count= jdbcTemplate.queryForObject(sbuffer.toString(),Integer.class, serialNumber);
//
////			sbuffer.append(" and s.update_date>?");
////			int count= jdbcTemplate.queryForInt(sbuffer.toString(), new Object[]{serialNumber, lastUpdateTime});
//
//			Map<String, Object> map = new HashMap<String, Object>();
//			map.put("count", count);
//			aj.setObj(map);
//
//		} catch (MyException e) {
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//
//	}
//
//	/**
//	 * 抽样查重
//	 * @author Dz
//	 * @param request
//	 * @param userToken 用户token
//	 * @param opeId	经营户ID
//	 * @param foodId 样品ID
//	 * @param itemId 检测项目ID
//	 * @param batchNumber 批次
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value = "/repeatSampling", method = RequestMethod.POST)
//	public AjaxJson repeatSampling(HttpServletRequest request, String userToken, String opeId, String foodId, String itemId, String batchNumber) {
//
//		AjaxJson aj = new AjaxJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//
//			StringBuffer sbuffer = new StringBuffer();
//
//			if(StringUtil.isNotEmpty(batchNumber) && StringUtil.isNotEmpty(foodId) && StringUtil.isNotEmpty(itemId)){//样品+检测项目+批号 必填
//
//				sbuffer.append("SELECT " +
//						"	COUNT(1) num1 " +	//该批号+样品+检测项目抽样总数
//						"FROM " +
//						"	tb_sampling ts  " +
//						"INNER JOIN tb_sampling_detail tsd ON ts.id = tsd.sampling_id  " +
//						"	WHERE ts.delete_flag = 0 AND tsd.food_id = ? AND tsd.item_id = ? AND tsd.batch_number = ?");
//
//				List<Map<String, Object>> mapList1 = jdbcTemplate.queryForList(sbuffer.toString(), foodId, itemId, batchNumber);
//
//				Map<String, Object> map1 = null;
//				if(mapList1!=null && mapList1.size()>0) {
//					map1 = mapList1.get(0);
//				}
//
//				long num1 = map1==null ? 0 : (long) map1.get("num1");	//该批号+样品+检测项目抽样总数
//				int inum1 = (int) num1;
//
//				if(inum1 > 0){
//					aj.setObj(3);//批号+样品+检测项目  重复
//				}else{
//					aj.setObj(0);//无重复抽样
//				}
//
//			}else if(StringUtil.isNotEmpty(opeId)){
//
//				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//
//				String today = sdf.format(new Date());
//
//				sbuffer.append("SELECT " +
//						"	COUNT(1) num1, " +	//今天该档口抽样总数
//						"	SUM( " +
//						"		IF (tsd.food_id = ? AND tsd.item_id = ?, 1, 0) " +
//						"	) num2 " +		//今天该档口+样品+检测项目抽样总数
//						"FROM " +
//						"	( " +
//						"		SELECT " +
//						"			id " +
//						"		FROM " +
//						"			tb_sampling " +
//						"		WHERE " +
//						"			sampling_date >= CONCAT(?, ' 00:00:00') AND sampling_date <= CONCAT(?, ' 23:59:59') " +
//						"		AND ope_id = ? AND delete_flag = 0 " +
//						"	) ts " +
//						"INNER JOIN tb_sampling_detail tsd ON ts.id = tsd.sampling_id ");
//
//				List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), foodId, itemId, today, today, opeId);
//				Map<String, Object> map2 = null;
//				if(mapList2!=null && mapList2.size()>0) {
//					map2 = mapList2.get(0);
//				}
//
//				long num1 = map2 == null ? 0 : (long) map2.get("num1");	//今天该档口抽样总数
//				BigDecimal num2 = map2 == null ? null : (BigDecimal) map2.get("num2");	//今天该档口+样品+检测项目抽样总数
//
//				int inum1 = (int) num1;
//				int inum2 = num2 == null ? 0 : num2.intValue();
//
//				if(StringUtil.isNotEmpty(foodId) && StringUtil.isNotEmpty(itemId)){//档口+样品+检测项目 必填
//
//					if(inum2 > 0){
//						aj.setObj(2);//档口+样品+检测项目 重复
//					}else{
//						aj.setObj(0);//无重复抽样
//					}
//
//				}else{//档口 必填
//
//					if(inum1 > 0){
//						aj.setObj(1);//档口  重复
//					}else{
//						aj.setObj(0);//无重复抽样
//					}
//
//				}
//			}else{
//				required(null, WebConstant.INTERFACE_CODE1, "必填参数不能为空");
//			}
//
//		} catch (MyException e) {
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//
//	}
//
//	/**
//	 * 上传抽样单
//	 * @param userToken 用户token
//	 * @param result	json对象抽样单数据
//	 * @param file		经营户签名和购样小票的压缩文件
//	 * @return 	返回抽样单号
//	 */
//	@ResponseBody
//	@RequestMapping(value = "/uploadSampling", method = RequestMethod.POST)
//	public AjaxJson uploadSampling(HttpServletRequest request,HttpServletResponse response,String userToken,String result,@RequestParam(required=false)MultipartFile file){
//
//		AjaxJson aj = new AjaxJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//			if(null == user.getRegId() && null == user.getPointId()) {
//				required(null, WebConstant.INTERFACE_CODE14, "机构用户不能新增抽样单");
//			}
//			required(result, WebConstant.INTERFACE_CODE1, "参数result不能为空");
//
//			result = URLDecoder.decode(result, "utf-8").replaceAll("\"", "\\\"");
//			JSONObject jsonObject = JSONObject.parseObject(result);
//			TbSampling bean= JSONObject.parseObject(jsonObject.getString("result"),TbSampling.class);
//
//			required(bean.getSamplingDate(), WebConstant.INTERFACE_CODE1, "参数samplingDate不能为空");
//
//			//设置抽样单单号首字母
//			String samplingNo = WebConstant.SAMPLING_NUM1;
//			if(bean.getPersonal() == null || bean.getPersonal() == 0 ) {
//				//抽样单
//				bean.setPersonal((short) 0);	//默认抽样单
//				required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//			}else if(bean.getPersonal() == 1) {
//				//设置送样单单号首字母
//				samplingNo = WebConstant.SAMPLING_NUM3;
//			}
//			bean.setSamplingNo(samplingNo);
//			bean.setStatus((short) 0);
//
//			if(StringUtil.isNotEmpty(bean.getParam2())) {
//				TbSampling old = tbSamplingService.queryByParam2(bean.getParam2());
//				if(old != null) {
//					setAjaxJson(aj, WebConstant.INTERFACE_CODE15, "保存失败，抽样单已存在");
//					return aj;
//				}
//			}
//
//			bean = tbSamplingService.addSampling(bean, bean.getSamplingDetails(), user, file);
//
//			Map<String, Object> map1 = new HashMap<String, Object>();
//			map1.put("id", bean.getId());	//抽样单ID
//			map1.put("samplingNo", bean.getSamplingNo());	//抽样单号
//			aj.setObj(map1);
//
//			playbackService.saveTask(bean);
//		} catch (MyException e) {
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//
//	}
//
//	/**
//	 * 对外-上传抽样单
//	 * @param userToken 用户token
//	 * @param result	json对象抽样单数据
//	 * @param file		经营户签名和购样小票的压缩文件 不大于300K
//	 * @return 	返回抽样单号
//	 */
//	@ResponseBody
//	@RequestMapping(value = "/USampling", method = RequestMethod.POST)
//	public InterfaceJson USampling(HttpServletRequest request, HttpServletResponse response, String userToken, String result, @RequestParam(required=false)MultipartFile file){
//
//		InterfaceJson aj = new InterfaceJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//			if(null == user.getPointId()) {
//				required(null, WebConstant.INTERFACE_CODE14, "机构用户不能新增抽样单");
//			}
//			required(result, WebConstant.INTERFACE_CODE1, "参数result不能为空");
//
//			result = URLDecoder.decode(result, "utf-8").replaceAll("\"", "\\\"");
////			JSONObject jsonObject = JSONObject.parseObject(result);
////			TbSampling bean= JSONObject.parseObject(jsonObject.getString("result"),TbSampling.class);
//			TbSampling bean= JSONObject.parseObject(result,TbSampling.class);
//
//			required(bean.getSamplingDate(), WebConstant.INTERFACE_CODE1, "参数samplingDate不能为空");
//
//			if (bean.getSamplingDate().getTime() > (System.currentTimeMillis() + (1*1000*60) )) {
//				throw new MyException("samplingDate不能大于当前时间", "samplingDate不能大于当前时间", WebConstant.INTERFACE_CODE2);
//			}
//
//			required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//			//在公共方法校验 Dz 20221024
////			BaseRegulatoryObject reg = regService.queryById(bean.getRegId());
////			if (reg == null || reg.getChecked() == 0 || reg.getDeleteFlag() == 1) {
////				throw new MyException("没有找到regId为"+bean.getRegId()+"的数据", "没有找到regId为"+bean.getRegId()+"的数据", WebConstant.INTERFACE_CODE5);
////			} else if (!reg.getRegName().equals(bean.getRegName())) {
////				throw new MyException("regId与regName不匹配，请更新监管对象数据", "regId与regName不匹配，请更新监管对象数据", WebConstant.INTERFACE_CODE2);
////			}
//
//			if (bean.getOpeId() != null) {
//				BaseRegulatoryBusiness bus = busService.queryById(bean.getOpeId());
//				if (bus == null) {
//					throw new MyException("没有找到opeId为"+bean.getOpeId()+"的数据", "没有找到opeId为"+bean.getOpeId()+"的数据", WebConstant.INTERFACE_CODE5);
//				} else if (!bus.getRegId().equals(bean.getRegId())) {
//					throw new MyException("opeId与regId不匹配，请更新经营户数据", "opeId与regId不匹配，请更新经营户数据", WebConstant.INTERFACE_CODE2);
//				} else if (!bus.getOpeShopCode().equals(bean.getOpeShopCode())) {
//					throw new MyException("opeId与opeShopCode不匹配，请更新经营户数据", "opeId与opeShopCode不匹配，请更新经营户数据", WebConstant.INTERFACE_CODE2);
//				}
//			}
//
//			if (file != null) {
//				if (!".zip.gz".contains(DyFileUtil.getFileExtension(file.getOriginalFilename()))) {
//					throw new MyException("接口参数错误", "压缩文件要求使用zip格式", WebConstant.INTERFACE_CODE18);
//				}
//				Boolean fs = FileUtil.checkFileSize(file.getSize(),300, "K");
//				if (!fs) {
//					throw new MyException("接口参数错误", "压缩文件不能超过300K", WebConstant.INTERFACE_CODE17);
//				}
//			}
//
//			for (TbSamplingDetail s : bean.getSamplingDetails()) {
//				if (s.getSno() == null) {
//					throw new MyException("参数sno不能为空", "参数sno不能为空", WebConstant.INTERFACE_CODE1);
//				}
//				if (s.getSampleNumber() == null) {
//					throw new MyException("参数sampleNumber不能为空", "参数sampleNumber不能为空", WebConstant.INTERFACE_CODE1);
//				}
//
//				required(s.getFoodId(), WebConstant.INTERFACE_CODE1, "参数foodId不能为空");
//				//在公共方法校验 Dz 20221024
////				BaseFoodType food = foodService.queryById(s.getFoodId());
////				if (food == null) {
////					throw new MyException("没有找到foodId为"+s.getFoodId()+"的数据", "没有找到foodId为"+s.getFoodId()+"的数据", WebConstant.INTERFACE_CODE5);
////				} else if (!food.getFoodName().equals(s.getFoodName())) {
////					throw new MyException("foodId与foodName不匹配，请更新食品种类数据", "foodId与foodName不匹配，请更新食品种类数据", WebConstant.INTERFACE_CODE2);
////				}
//
//				required(s.getItemId(), WebConstant.INTERFACE_CODE1, "参数itemId不能为空");
//				//在公共方法校验 Dz 20221024
////				BaseDetectItem item = itemService.queryById(s.getItemId());
////				if (item == null) {
////					throw new MyException("没有找到itemId为"+s.getItemId()+"的数据", "没有找到itemId为"+s.getItemId()+"的数据", WebConstant.INTERFACE_CODE5);
////				} else if (!item.getDetectItemName().equals(s.getItemName())) {
////					throw new MyException("itemId与itemName不匹配，请更新检测项目数据", "itemId与itemName不匹配，请更新检测项目数据", WebConstant.INTERFACE_CODE2);
////				}
//
//			}
//
//			//使用匿名比较器排序
//			Collections.sort(bean.getSamplingDetails(), new Comparator<TbSamplingDetail>() {
//				@Override
//				public int compare(TbSamplingDetail s1, TbSamplingDetail s2) {
//					return s1.getSno() - s2.getSno();
//				}
//			});
//
//			//设置抽样单单号首字母
//			String samplingNo = WebConstant.SAMPLING_NUM7;
//			//抽样单
//			bean.setPersonal((short) 0);
//			bean.setSamplingNo(samplingNo);
//			bean.setStatus((short) 0);
//
//			bean = tbSamplingService.addSampling(bean, bean.getSamplingDetails(), user, file);
//
//			Map<String, Object> map1 = new HashMap<String, Object>();
//			//map1.put("id", bean.getId());	//抽样单ID
//			map1.put("samplingNo", bean.getSamplingNo());	//抽样单号
//			aj.setObj(map1);
//			aj.setMsg("上传成功");
//
//		} catch (MyException e) {
//			aj.setResultCode(e.getCode());
//			aj.setMsg(e.getText());
//
//			Map<String, Object> map1 = new HashMap<String, Object>();
//			map1.put("samplingNo", "");
//			aj.setObj(map1);
//		} catch (Exception e) {
//			iErrLog.error("USampling接口未知异常:"+e.getMessage());
//			aj.setResultCode(WebConstant.INTERFACE_CODE11);
//			aj.setMsg("请确认参数无误");
//
//			Map<String, Object> map1 = new HashMap<String, Object>();
//			map1.put("samplingNo", "");
//			aj.setObj(map1);
//		}
//
//		return aj;
//
//	}
//
//	/**
//	 * 上传抽样单
//	 * @param userToken 用户token
//	 * @param result	json对象抽样单数据
//	 * @param files		经营户签名和购样小票
//	 * @return 	返回抽样单号
//	 */
//	@ResponseBody
//	@RequestMapping(value = "/uploadSampling2", method = RequestMethod.POST)
//	public AjaxJson uploadSampling2(HttpServletRequest request, HttpServletResponse response, String userToken, String result, @RequestParam(required=false)MultipartFile[] files){
//
//		AjaxJson aj = new AjaxJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//			if(null == user.getRegId() && null == user.getPointId()) {
//				required(null, WebConstant.INTERFACE_CODE14, "机构用户不能新增抽样单");
//			}
//			required(result, WebConstant.INTERFACE_CODE1, "参数result不能为空");
//
//			result = URLDecoder.decode(result, "utf-8").replaceAll("\"", "\\\"");
//			JSONObject jsonObject = JSONObject.parseObject(result);
//			TbSampling bean= JSONObject.parseObject(jsonObject.getString("result"),TbSampling.class);
//
//			required(bean.getSamplingDate(), WebConstant.INTERFACE_CODE1, "参数samplingDate不能为空");
//
//			//设置抽样单单号首字母
//			String samplingNo = WebConstant.SAMPLING_NUM1;
//			if(bean.getPersonal() == null || bean.getPersonal() == 0 ) {
//				//抽样单
//				bean.setPersonal((short) 0);	//默认抽样单
//				required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//			}else if(bean.getPersonal() == 1) {
//				//设置送样单单号首字母
//				samplingNo = WebConstant.SAMPLING_NUM3;
//			}
//			bean.setSamplingNo(samplingNo);
//			bean.setStatus((short) 0);
//
//			if(StringUtil.isNotEmpty(bean.getParam2())) {
//				TbSampling old = tbSamplingService.queryByParam2(bean.getParam2());
//				if(old != null) {
//					setAjaxJson(aj, WebConstant.INTERFACE_CODE15, "保存失败，抽样单已存在");
//					return aj;
//				}
//			}
//
//			bean = tbSamplingService.addSampling(bean,bean.getSamplingDetails(),user, null);
//
//			if (files != null && files.length > 0) {//有上传数据
//				for (MultipartFile file : files) {
//					if (file.getOriginalFilename().contains("receipt_")) {    //购样小票
//						String fName = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());
//						String fPath = filePath + shoppingReceipt + fName;
//						DyFileUtil.saveFile(file, resources + fPath);
//
//						TbFile tbFile = new TbFile();
//						tbFile.setSourceId(bean.getId());
//						tbFile.setSourceType("shoppingRec");
//						tbFile.setFileName(fName);
//						tbFile.setFilePath(fPath);
//						tbFile.setSorting((short) 0);
//						tbFile.setDeleteFlag((short) 0);
//						PublicUtil.setCommonForTable(tbFile, true, user);
//						fileService.insert(tbFile);
//
//					} else if (file.getOriginalFilename().contains("sign_")) {    //经营户签名
//						String fName = bean.getSamplingNo() + DyFileUtil.getFileExtension(file.getOriginalFilename());
//						String fPath = opeSignaturePath + fName;
//						DyFileUtil.saveFile(file, resources + fPath);
//						bean.setOpeSignature(fName);
//						tbSamplingService.updateBySelective(bean);
//					}
//				}
//			}
//
//			Map<String, Object> map1 = new HashMap<String, Object>();
//			map1.put("id", bean.getId());	//抽样单ID
//			map1.put("samplingNo", bean.getSamplingNo());	//抽样单号
//			aj.setObj(map1);
//
//			playbackService.saveTask(bean);
//		} catch (MyException e) {
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//	}
//
//	/**
//	 * APP下载抽样单和仪器下载抽样单的检测任务明细
//	 * @param userToken 	 用户token
//	 * @param type			 下载类型
//	 * @param serialNumber	仪器唯一标识
//	 * @param lastUpdateTime 最后更新时间
//	 * @param pageNumber 页码数
//	 * @param personal 	 0：抽样单，1：送样单
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value = "/downloadSampling", method = RequestMethod.POST)
//	public AjaxJson downloadSampling(HttpServletRequest request, String userToken, String type,@RequestParam(required=false)String serialNumber,@RequestParam(required = true, defaultValue = "2000-01-01 00:00:01") String lastUpdateTime,
//			@RequestParam(required = false) String pageNumber, Integer personal){
//		AjaxJson aj = new AjaxJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//			required(type, WebConstant.INTERFACE_CODE1, "参数type不能为空");
//
//			Map<String, Object> map = new HashMap<>();
//			List<Map<String, Object>> list = null;
//			StringBuffer sbuffer = new StringBuffer();
//			switch (type) {
//				case "sampling":// APP下载抽样单列表
//					checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
//					sbuffer.setLength(0);
//					sbuffer.append("select s.*,d.id as d_id,d.sampling_id as d_sampling_id,d.sample_code as d_sample_code,d.food_id as d_food_id,");
//					sbuffer.append(" d.food_name as d_food_name,d.sample_number as d_sample_number,d.purchase_amount as d_purchase_amount,d.sample_date as d_sample_date,");
//					sbuffer.append(" d.purchase_date as d_purchase_date,d.item_id as d_item_id,d.item_name as d_item_name,d.origin as d_origin,d.supplier as d_supplier,");
//					sbuffer.append(" d.supplier_address as d_supplier_address,d.supplier_person as d_supplier_person,d.supplier_phone as d_supplier_phone,");
//					sbuffer.append(" d.batch_number as d_batch_number,d.status as d_status, d.recevie_device as d_recevie_device,d.ope_shop_name as d_ope_shop_name,");
//					sbuffer.append(" d.remark as d_remark,d.param1 as d_param1,d.param2 as d_param2,d.param3 as d_param3 ,(select count(*) from tb_sampling_detail where sampling_id=s.id) as total,");
//					sbuffer.append(" (select count(*) from data_check_recording FORCE INDEX(idx_sampling_id) where sampling_id=s.id AND param7 = 1 ) as completionNum, ");
//					sbuffer.append(" '' as ticket from tb_sampling s ");
//					sbuffer.append(" INNER JOIN tb_sampling_detail d on s.id=d.sampling_id");
//
//					sbuffer.append(" where s.status=0 ");
//
//					if(null != personal) {
//						sbuffer.append(" and s.personal = "+personal+" ");
//					}
//
//					if(null != user.getDepartId()){
//						//根据用户所属检测机构下载抽样单
//						sbuffer.append(" AND s.depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"), '%')) ");
//					}
//					if(null != user.getRegId()){
//						//根据用户所属监管对象下载抽样单
//						sbuffer.append(" AND s.reg_id = "+user.getRegId()+" ");
//
//					}else if(null != user.getPointId()){
//						//根据用户所属检测点下载抽样单
//						sbuffer.append(" AND s.point_id = "+user.getPointId()+" ");
//					}
//
//					sbuffer.append(" and s.update_date>? ");
//					if(StringUtil.isNotEmpty(pageNumber)){
//						int page = Integer.parseInt(pageNumber);
//						sbuffer.append(" order by s.sampling_date desc limit "+ ((page-1)*50 < 0 ? 0 : (page-1)*50) +", 50 ");
//					}
//
//					list = jdbcTemplate.queryForList(sbuffer.toString(), lastUpdateTime);
//
//					if (list!=null && list.size()>0) {
//						StringBuffer samplingIdsStr = new StringBuffer();
//						for(int i=0;i<list.size();i++) {
//							samplingIdsStr.append(list.get(i).get("id")).append(",");
//						}
//						samplingIdsStr.deleteCharAt(samplingIdsStr.length() - 1);
//
//						//查询附件
//						sbuffer.setLength(0);
//						sbuffer.append(" select source_id, GROUP_CONCAT(CONCAT(?, file_path)) ticket from tb_file where delete_flag = 0 AND source_id IN (").append(samplingIdsStr.toString()).append(") and source_type = 'shoppingRec' GROUP BY source_id ");
//						List<Map<String, Object>> files = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] { resourcesUrl});
//
//						for(Map<String, Object> map1 : list) {
//							//附件
//							if (files!=null) {
//								Iterator<Map<String, Object>> filesIt = files.iterator();
//								while (filesIt.hasNext()) {
//									Map<String, Object> filesMap = filesIt.next();
//									if(map1.get("id").toString().equals(filesMap.get("source_id").toString())) {
//										map1.put("ticket", filesMap.get("ticket"));
//										filesIt.remove();
//										break;
//									}
//								}
//							}
//
////							//修改抽样单二维码、经营户签名地址
////							map1.put("qrcode", resourcesUrl + samplingQr + map1.get("qrcode"));
////							map1.put("ope_signature", resourcesUrl + opeSignaturePath + map1.get("ope_signature"));
//						}
//					}
//
//					map.put("result", list);
//					break;
//
//				case "recevieSampling":// 仪器下载抽样单的检测任务明细与samplingNumber接口搭配使用
//					required(serialNumber, WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
//
//					sbuffer.setLength(0);
//					sbuffer.append("select d.*,s.id as s_id,s.sampling_no as s_sampling_no,s.sampling_date as s_sampling_date,s.point_id as s_point_id,s.reg_id as s_reg_id,");
//					sbuffer.append(" s.reg_name as s_reg_name,s.reg_licence as s_reg_licence,s.reg_link_person as s_reg_link_person,s.reg_link_phone as s_reg_link_phone,");
//					sbuffer.append(" s.ope_id as s_ope_id, s.ope_shop_code as s_ope_shop_code,s.ope_shop_name as s_ope_shop_name,s.qrcode as s_qrcode,s.task_id as s_task_id,");
//					sbuffer.append(" s.status as s_status,s.place_x as s_place_x,s.place_y as s_place_y,s.sampling_userid as s_sampling_userid,s.sampling_username as s_sampling_username,");
//					sbuffer.append(" s.ope_signature as s_ope_signature,s.create_by as s_create_by,s.create_date as s_create_date,s.update_by as s_update_by,s.update_date as s_update_date,");
//					sbuffer.append(" s.sheet_address as s_sheet_address,s.param1 as s_param1,s.param2 as s_param2,s.param3 as s_param3, s.personal s_personal,");
//					sbuffer.append(" t.id as t_id,t.task_code as t_task_code,t.task_title as t_task_title,t.task_content as t_task_content,t.task_detail_pId as t_task_detail_pId,t.project_id as t_project_id,");
//					sbuffer.append(" t.task_type as t_task_type,t.task_source as t_task_source,t.task_status as t_task_status,t.task_total as t_task_total,t.sample_number as t_sample_number,t.task_sdate as t_task_sdate,");
//					sbuffer.append(" t.task_edate as t_task_edate,t.task_pdate as t_task_pdate,t.task_fdate as t_task_fdate,t.task_departId as t_task_departId,t.task_announcer as t_task_announcer,t.task_cdate as t_task_cdate,");
//					sbuffer.append(" t.remark as t_remark,t.view_flag as t_view_flag,t.file_path as t_file_path,t.delete_flag as t_delete_flag,");
//					sbuffer.append(" t.create_by as t_create_by, t.create_date as t_create_date,t.update_by as t_update_by,t.update_date as t_update_date,");
//					sbuffer.append(" td.id as td_id,td.task_id as td_task_id,td.detail_code as td_detail_code,td.sample_id as td_sample_id,td.sample as td_sample,td.item_id as td_item_id,td.item as td_item,td.task_fdate as td_task_fdate,");
//					sbuffer.append(" td.receive_pointid as td_receive_pointid,td.receive_point as td_receive_point,td.receive_nodeid as td_receive_nodeid,td.receive_node as td_receive_node,td.receive_userid as td_receive_userid,");
//					sbuffer.append(" td.receive_username as td_receive_username,td.receive_status as td_receive_status,td.task_total as td_task_total,td.sample_number as td_sample_number,td.remark as td_remark");
//					sbuffer.append(" from tb_sampling_detail d");
//					sbuffer.append(" INNER JOIN tb_sampling s on d.sampling_id=s.id");
//					sbuffer.append(" LEFT JOIN tb_task_detail td on d.param2=td.id");
//					sbuffer.append(" LEFT JOIN tb_task t on t.id=s.task_id");
//					sbuffer.append(" where d.status=0 and s.delete_flag=0 and d.recevie_device=?");
////					sbuffer.append(" and s.update_date>?");
//					if(StringUtil.isNotEmpty(pageNumber)){
//						int page = Integer.parseInt(pageNumber);
//						sbuffer.append(" limit "+ ((page-1)*50 < 0 ? 0 : (page-1)*50) +", 50");
//					}
//					list = jdbcTemplate.queryForList(sbuffer.toString(), serialNumber);
////					list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {serialNumber,lastUpdateTime});
//
//					//修改抽样单二维码、经营户签名地址
//					for(Map<String, Object> map1 : list) {
//						map1.put("qrcode", WebConstant.res.getString("resourcesUrl") + WebConstant.res.getString("samplingQr") + map1.get("qrcode"));
//						map1.put("ope_signature", WebConstant.res.getString("resourcesUrl") + WebConstant.res.getString("opeSignaturePath") + map1.get("ope_signature"));
//					}
//
//					map.put("result", list);
//					break;
//
//				default:
//					throw new MyException("下载类型未定义", "下载类型未定义", WebConstant.INTERFACE_CODE5);
//				}
//				aj.setObj(map);
//
//		} catch (MyException e) {
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//
//	}
//	/**
//	 * 扫描二维码查看抽样单详情，sampeQrcodeVersion：抽样单号二维码版本，默认为1,可选值有：2,4 4对应监管对象的第4个版本
//	 * @param request
//	 * @param samplingNo 抽样单号
//	 * @return
//	 */
//	@QrcodeScanCount(module = "抽样单二维码",scanType = 0)
//	@RequestMapping(value = "/samplingDetail", method = RequestMethod.GET)
//	public ModelAndView samplingDetail(HttpServletRequest request,String samplingNo){
//		Map<String, Object> map=new HashMap<>();
//		TbSampling sampling=tbSamplingService.queryBySamplingNo(samplingNo);
//		if(sampling==null){
//			map.put("success", false);
//			map.put("msg", "抽样单号不存在");
//		}else{
//			String souce = WebConstant.res.getString("toSource");
//			List<TbSamplingDetailReport> details=tbSamplingDetailService.queryBySamplingIdForApp(sampling.getId());
//			List<BaseLedgerStock> list = new ArrayList<BaseLedgerStock>();
//			if(souce.equals("1")){//获取台账管理信息
//				map.put("souce", souce);
//				for (int i = 0; i < details.size(); i++) {
//					String date=null;
//					if(sampling.getSamplingDate()!=null){
//						date=DateUtil.formatDate(sampling.getSamplingDate(), "yyyy-MM-dd");
//					}else if(details.get(i).getCheckDate()!=null){
//						date=DateUtil.formatDate(details.get(i).getCheckDate(), "yyyy-MM-dd");
//					}else{
//						date=DateUtil.formatDate(new Date(), "yyyy-MM-dd");
//					}
//					BaseLedgerStock ledgerStock = stockService.queryByBatchNumber(sampling.getRegId(), sampling.getOpeId(), details.get(i).getFoodName(), details.get(i).getBatchNumber(),  date);//根据经营户  市场id 查询
//					list.add(i,ledgerStock);
//				}
//			}
//			BasePoint point = null;
//			try {
//				point = basePointService.queryById(sampling.getPointId());
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//
//			map.put("sampling", sampling);
//			map.put("list", list);
//			map.put("details", details);
//			map.put("point", point);
//			map.put("success", true);
//		}
//		map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2"));
//		// add by xiaoyl 2020/10/30 武陵系统标识,进入主页面的时候写入session中
//		int systemFlag=0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
//		JSONObject systemFlagConfig = SystemConfigUtil.SYSTEM_NAME_CONFIG;
//		if (systemFlagConfig != null &&  systemFlagConfig.getInteger("systemFlag") != null) {
//			systemFlag = systemFlagConfig.getInteger("systemFlag");
//		}
//		map.put("systemFlag",systemFlag);
//		//add by xiaoyl 2022/03/22 扫描抽样单二维码版本配置，根据不同的版本号访问不同的页面
//		//默认为：/sampling/sampling_app，根据系统参数配置sampling_qrcode访问对应的页面
//		String sampeQrcodeVersion = "1";//抽样单号二维码版本，默认为1,可选值有：2,4 4对应监管对象的第4个版本
//		String viewName="/sampling/sampling_app";//默认访问页面
//		JSONObject otherConfig = SystemConfigUtil.OTHER_CONFIG;
//		if (otherConfig != null && otherConfig.getJSONObject("system_config") != null && StringUtils.hasText(otherConfig.getJSONObject("system_config").getString("sampling_qrcode"))) {
//			sampeQrcodeVersion =otherConfig.getJSONObject("system_config").getString("sampling_qrcode");
//		}
//		if(!sampeQrcodeVersion.equals("1")){
//			//拼接跳转页面，例如：/sampling/sampling_app_2
//			viewName=viewName+"_"+sampeQrcodeVersion;
//		}
//		return new ModelAndView(viewName, map);
//	}
//
//	/**
//	 * 仪器更新仪器接收检测任务的状态
//	 * @param userToken
//	 * @param sdId 抽样单明细ID
//	 * @param recevieSerialNumber 设备唯一标识
//	 * @param recevieStatus 接收状态：0未接收，1接收，2拒绝
//	 * @return
//	 */
//	@ResponseBody
//	@RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
//	public AjaxJson updateStatus(HttpServletRequest request, String userToken,Integer sdId,String recevieSerialNumber,Short recevieStatus) {
//
//		AjaxJson aj = new AjaxJson();
//		try {
//			//必填验证
//			TSUser user = tokenExpired(userToken);	//token验证
//			required(sdId, WebConstant.INTERFACE_CODE1, "参数sdId不能为空");
//			required(recevieSerialNumber, WebConstant.INTERFACE_CODE1, "参数recevieSerialNumber不能为空");
//			required(recevieStatus, WebConstant.INTERFACE_CODE1, "参数recevieStatus不能为空");
//
////			TbSamplingDetail samplingDetail=tbSamplingDetailService.queryById(sdId);
////			if(samplingDetail!=null){
////				PublicUtil.setCommonForTable(samplingDetail, false, user);
////				samplingDetail.setUpdateDate(new Date());
////				if(recevieStatus==1){//仪器接收任务
////					samplingDetail.setStatus(recevieStatus);
////					tbSamplingDetailService.updateBySelective(samplingDetail);
////					//删除临时表中关于该明细的分配记录
////					tbSamplingDetailRecevieService.deleteBySdId(sdId);
////				}else if(recevieStatus==2){//仪器拒绝了任务
////					TbSamplingDetailRecevie recevie=new TbSamplingDetailRecevie();
////					recevie.setSdId(sdId);
////					recevie.setRecevieSerialNumber(recevieSerialNumber);
////					recevie.setRecevieStatus(recevieStatus);
////					tbSamplingDetailRecevieService.updateByRejectStatus(recevie);//修改拒绝状态
////					recevie=tbSamplingDetailRecevieService.queryNextDeviceBySdid(sdId);
////
////					samplingDetail.setStatus((short) 0);	//修改任务未接收状态
////
////					if(recevie!=null){
////						samplingDetail.setRecevieDevice(recevie.getRecevieSerialNumber());
////						tbSamplingDetailService.updateBySelective(samplingDetail);
////					}else{//所有仪器都拒绝了任务，重置仪器领取状态，
////						tbSamplingDetailRecevieService.updateResetRecevieStatusBySdId(sdId);// 所有仪器都拒绝了任务，重置仪器领取状态，
////						recevie = tbSamplingDetailRecevieService.queryNextDeviceBySdid(sdId);
////						if(recevie!=null){
////							samplingDetail.setRecevieDevice(recevie.getRecevieSerialNumber());
////						}
////						tbSamplingDetailService.updateBySelective(samplingDetail);//重新发给第一个 领取的仪器
////					}
////				}else{
////					throw new MyException("参数:recevieStatus："+recevieStatus+"未定义", "参数:recevieStatus："+recevieStatus+"未定义", WebConstant.INTERFACE_CODE5);
////				}
////			}else{
////				throw new MyException("抽样任务明细："+sdId+"不存在", "抽样任务明细："+sdId+"不存在", WebConstant.INTERFACE_CODE5);
////			}
//
//			boolean resend = true;
//			for(String pperationCode : user.getOperationCode()) {
//				if("321-13".equals(pperationCode) ) {//禁止自动分配检测任务
//					resend = false;
//					break;
//				}
//			}
//
//			//接收/拒绝检测任务
//			tbSamplingDetailRecevieService.updateStatus(user, sdId, recevieSerialNumber, recevieStatus, resend);
//
//		} catch (MyException e) {
//			setAjaxJson(aj, e.getCode(), e.getText());
//		} catch (Exception e) {
//			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//		}
//
//		return aj;
//
//	}
//	/**
//	 * App查看抽样单
//	 * @param request
//	 * @param response
//	 * @param samplingNo
//	 * @return
//	 */
//	@RequestMapping("/toWord")
//	public ModelAndView toWord(HttpServletRequest request, HttpServletResponse response, String samplingNo) {
//		Map<String,Object> dataMap = new HashMap<String,Object>();
//		try {
//			TbSampling sampling = tbSamplingService.queryBySamplingNo(samplingNo);//根据抽样单号查询抽样单
//			if(StringUtil.isNotEmpty(sampling)){
//				if(StringUtil.isNotEmpty(sampling.getOpeSignature())){
//					sampling.setOpeSignature(WebConstant.res.getString("opeSignaturePath")+sampling.getOpeSignature());
//				}
//				//查询抽样人员是否有电子签名，有的话直接在抽样单中显示签名，没有则显示名称 add by xiaoyl 2022-01-23
//				TSUser samplUser=tsUserService.queryById(sampling.getSamplingUserid());
//				if(StringUtil.isNotEmpty(samplUser.getSignatureFile())){
//					dataMap.put("samplSignatureFile",samplUser.getSignatureFile());
//				}
//				dataMap.put("sampling", sampling);
//				List<TbSamplingDetail> samplingDetailList = tbSamplingDetailService.queryBySamplingIdUnionItems(sampling.getId());//根据抽样单id查询抽样单的详情,合并检测项目
//				dataMap.put("signaturePath",sampling.getOpeSignature());
//				dataMap.put("samplingDetailList", samplingDetailList);
//				String rootPath=WebConstant.res.getString("resources")+WebConstant.res.getString("samplingQr");
//				DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
//				String samplingQrPath=WebConstant.res.getString("samplingQrPath");
//				File qrFile =new File(rootPath+sampling.getQrcode());
//				if(!qrFile.exists()){
//					QrcodeUtil.generateSamplingQrcode(request,sampling.getQrcode(), samplingQrPath + sampling.getSamplingNo(),rootPath);
//				}
//				dataMap.put("samplingQr",WebConstant.res.getString("samplingQr")+sampling.getQrcode());
//				//根据抽样单所属检测ID配置正确的电子章 add by xiaoyl2020-07-18 武陵区项目不同检测点电子章不一样
//				String signatureFile="";
//				BasePoint point=basePointService.queryById( sampling.getPointId());
//				if(point != null && point.getSignatureType()==1 && StringUtil.isNotEmpty(point.getSignatureFile())) {//自定义电子签章
//					signatureFile="/resources/signatureFile/" +point.getSignatureFile();
//				}else if(point != null && point.getSignatureType()==2){
//					signatureFile="";
//				}else {
//					signatureFile=defaultSignatureFile;
//				}
//				dataMap.put("signatureFilePicture", signatureFile);
//			}else{
//				dataMap.put("msg", "抽样单号:"+samplingNo+"不存在");
//			}
//		} catch (Exception e) {
//			dataMap.put("msg", "抽样单号:"+samplingNo+"不存在");
//		}
//		// add by xiaoyl 2020/10/30 武陵系统标识,进入主页面的时候写入session中
//		int systemFlag=0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
//		JSONObject systemFlagConfig = SystemConfigUtil.SYSTEM_NAME_CONFIG;
//		if (systemFlagConfig != null &&  systemFlagConfig.getInteger("systemFlag") != null) {
//			systemFlag = systemFlagConfig.getInteger("systemFlag");
//		}
//		dataMap.put("systemFlag",systemFlag);
//		//增加报告打印份数限制
//		if(SystemConfigUtil.REPORT_TEMPLATE!=null) {
//			String view=SystemConfigUtil.REPORT_TEMPLATE.getString("app_sheet");
//			if(StringUtil.isEmpty(view)){
//				view="/sampling/app_sheet";
//			}
//			return new ModelAndView(view,dataMap);
//		}else {
//			return new ModelAndView("/sampling/app_sheet",dataMap);
//		}
//	}
//
//	@RequestMapping("/queryById")
//	public @ResponseBody TbSampling queryById(Integer id) throws Exception{
//		TbSampling s = tbSamplingService.getById(id);
//		return s;
//	}
}
