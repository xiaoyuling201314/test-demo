package com.dayuan3.terminal.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.CheckReportData;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.sampling.TbSamplingDetailReport;
import com.dayuan.service.DataCheck.CheckReportDataService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.service.IncomeService;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.terminal.service.OrderStatisticDailyService;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import sun.misc.BASE64Decoder;
/**
 * 送检账号
 *
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Controller
@RequestMapping("/reportPrint")
public class ReportPrintController extends BaseController {
    private Logger log = Logger.getLogger(ReportPrintController.class);
    @Autowired
    private InspectionUnitUserService insUnitUserService;

    @Autowired
    private InspectionUnitService inspectionUnitService;

    @Autowired
    private TbSamplingService tbSamplingService;
    @Autowired
    private TbSamplingDetailService tbSamplingDetailService;
    @Autowired
    private IncomeService incomeService;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private InspectionUserAccountService accountService;
    @Autowired
    private CommonLogUtilService logUtil;
    @Autowired
    private OrderStatisticDailyService orderStatisticDailyService;
    
	@Autowired
	private TbSamplingRequesterService requesterService;
	
	@Autowired
	private CheckReportDataService checkReportService;

    @RequestMapping("/list")
    public ModelAndView list(Page page, HttpServletRequest request, HttpServletResponse response) {
        /*
		 * delete by xiaoyl 2019-08-13
		 * Map<String, Object> map=new HashMap<String, Object>(); InspectionUnitUser
		 * user=(InspectionUnitUser)
		 * request.getSession().getAttribute("session_user_terminal"); if (null == user)
		 * { return new ModelAndView("/terminal/index"); } List<TbSampling>
		 * list=tbSamplingService.queryByInspectionUnit(user.getId(),null,2,null,null);
		 * map.put("list", list);
		 */
        Map<String, Object> map = new HashMap<String, Object>();
        InspectionUnitUser user = (InspectionUnitUser) request.getSession().getAttribute("session_user_terminal");
        if (null == user) {
            return new ModelAndView("/terminal/index");
        }
        request.getSession().setAttribute("weChatImg", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("weChatImg"));
        request.getSession().setAttribute("outPrint", 0);
        return new ModelAndView("/terminal/report/list", map);
    }

    /**
     * 查询订单列表信息
     *
     * @param createDate
     * @param status     打印状态: 0未打印，1已打印
     * @param request
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月13日
     */
    @ResponseBody
    @RequestMapping("/queryOrderList")
    public AjaxJson queryOrderList(String createDate, Integer orderType, Page page, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson ajaxJson = new AjaxJson();
        InspectionUnitUser user = (InspectionUnitUser) request.getSession().getAttribute("session_user_terminal");
        List<TbSampling> list = tbSamplingService.queryByInspectionUnit(user.getId(), createDate, orderType, 2, page.getRowOffset(), page.getPageSize(), null, null);
        int rowTotal = tbSamplingService.queryByInspectionUnitCount(user.getId(), createDate, orderType, 2);
        page.setRowTotal(rowTotal);
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
        page.setResults(list);
        ajaxJson.setObj(page);
        return ajaxJson;
    }

    /**
     * 查看订单明细信息
     *
     * @param samplingId
     * @param request
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月13日
     */
    @RequestMapping({"/orderDetail"})
    public ModelAndView orderDetail(Integer samplingId, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        TbSampling bean = null;
        try {
            //1.查询主订单信息
            bean = tbSamplingService.selectById(samplingId);
            InspectionUnitUser user = (InspectionUnitUser) request.getSession().getAttribute("session_user_terminal");
            if (user == null) {//非用户登录打印 add by xiaoyl
                user = insUnitUserService.queryById(Integer.valueOf(bean.getCreateBy()));
            }
            //2.查询送检样品明细 loadDatagridOrderDetails
            List<TbSamplingDetailReport> list = tbSamplingDetailService.queryOrderDetailBySamplingId(samplingId, null, null);
			/*//3.查询送检单位信息
			InspectionUnit unit=inspectionUnitService.queryById(user.getInspectionId());
			map.put("unit", unit);*/
            Income income = incomeService.queryPaymentOrder(bean.getId());
            map.put("income", income);
            map.put("bean", bean);
            map.put("list", list);
            map.put("isChoose", false);
            //是否显示进货数量字段
            map.put("showPurchaseNumber",SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
        }
        return new ModelAndView("/terminal/report/orderDetail", map);
    }
    /**
     * 根据订单号查询委托单位列表
     * @description
     * @param id
     * @param keyWords 委托单位查询
     * @return
     * @author xiaoyl
     * @date   2020年1月14日
     */
     @RequestMapping("/queryUnitsBySamplingId")
     @ResponseBody
     public AjaxJson  queryUnitsBySamplingId(Integer id,String keyWords){  
     	 AjaxJson jsonObject = new AjaxJson();
     	 List<TbSamplingRequester> reList =requesterService.queryBySamplingId(id,keyWords);
     	jsonObject.setObj(reList);
     	return jsonObject;
     }
    /********************************打印报告相关代码*****************************************/
    /**
     * 根据抽样单ID进入打印页面
     * @description
     * @param samplingId
     * @param request
     * @param response
     * @return
     * @author xiaoyl
     * @date 2019年8月13日
     */
	/*@RequestMapping({ "/printAll" })
	public ModelAndView printAll(Integer samplingId,HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			TbSampling bean=tbSamplingService.getById(samplingId);
			map.put("bean", bean);
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
			e.printStackTrace();
		}
		return new ModelAndView("/terminal/report/printAll",map);
	}*/
    /**
     * 获取打印列表数据
     * @description
     * @param samplingId 抽样单ID
     * @param status 是否已打印过： 0 未打印过，1已打印
     * @param request
     * @param response
     * @return
     * @author xiaoyl
     * @date 2019年8月13日
     */
	/*@ResponseBody
	@RequestMapping("/printAllData")
	public AjaxJson printAllData(Integer samplingId,Integer status,HttpServletRequest request, HttpServletResponse response) {
		AjaxJson ajaxJson=new AjaxJson();
		Map<String, Object> map=new HashMap<String, Object>();
		TbSampling bean=null;
		try {
			//1.查询主订单信息
			bean=tbSamplingService.getById(samplingId);
			InspectionUnitUser user=(InspectionUnitUser) request.getSession().getAttribute("session_user_terminal");
			if(user==null){//非用户登录打印 add by xiaoyl
				user=insUnitUserService.queryById(Integer.valueOf(bean.getCreateBy()));
			}
			//2.查询送检样品明细
			List<TbSamplingDetail> list= tbSamplingDetailService.queryOrderDetailBySamplingId(samplingId,status);//.queryBySamplingId(samplingId);
			//3.生成二维码
			 String rootPath=WebConstant.res.getString("resources")+WebConstant.res.getString("samplingQr");
			    DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
				String samplingQrPath=WebConstant.res.getString("samplingQrPath");
				File qrFile =new File(rootPath+bean.getQrcode());
				if(!qrFile.exists()){
					QrcodeUtil.generateSamplingQrcode(request,bean.getQrcode(), samplingQrPath + bean.getSamplingNo(),rootPath);
				}
				//4.查询送检单位信息
				InspectionUnit unit=inspectionUnitService.queryById(user.getInspectionId());
				map.put("unit", unit);
				//5. 检测人员、时间
				String sql1 = "SELECT check_username checkUsername, upload_date uploadDate FROM data_check_recording where sampling_id=? group by check_userid order by upload_date desc";
				List<Map<String, Object>> recordings = jdbcTemplate.queryForList(sql1, new Object[]{samplingId});
				map.put("recordings", recordings);
				map.put("samplingQr",WebConstant.res.getString("samplingQr")+bean.getQrcode());
				map.put("list", list);
				ajaxJson.setAttributes(map);
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("数据查询异常"+e.getMessage());
			e.printStackTrace();
		}
		return ajaxJson;
	}*/
    /**
     * 根据抽样单ID和打印类型进行跳转
     * @description
     * @param samplingId 抽样单ID
     * @param printType 打印类型：0合并打印，1 分开打印
     * @param request
     * @param response
     * @return
     * @author xiaoyl
     * @date 2019年7月3日
     */
	/*@RequestMapping({ "/printAll" })
	public ModelAndView printAll(Integer samplingId ,HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map=new HashMap<String, Object>();
		TbSampling bean=null;
		try {
			//1.查询主订单信息
			bean=tbSamplingService.getById(samplingId);
			InspectionUnitUser user=(InspectionUnitUser) request.getSession().getAttribute("session_user_terminal");
			if(user==null){//非用户登录打印 add by xiaoyl
				user=insUnitUserService.queryById(Integer.valueOf(bean.getCreateBy()));
			}
			//2.查询送检样品明细
			List<TbSamplingDetailReport> list= tbSamplingDetailService.queryOrderDetailBySamplingId(samplingId,null,null);
			List<TbSamplingDetailReport> firstPrint=new ArrayList<TbSamplingDetailReport>();//未打印
			List<TbSamplingDetailReport> secodePrinted=new ArrayList<TbSamplingDetailReport>();//已打印
			List<TbSamplingDetailReport> checkList=new ArrayList<TbSamplingDetailReport>();//检测中
			List<TbSamplingDetailReport> unReceiveList=new ArrayList<TbSamplingDetailReport>();//待收样
			for (TbSamplingDetailReport beans : list) {
				if(null==beans.getReportNumber() && StringUtil.isNotEmpty(beans.getConclusion())) {//待打印
					firstPrint.add(beans);
				}else if(StringUtil.isNotEmpty(beans.getReportNumber())) {
					secodePrinted.add(beans);
				}else if(StringUtil.isNotEmpty(beans.getCollectCode())){
					checkList.add(beans);
				}else {
					unReceiveList.add(beans);
				}
			}
			//3.生成二维码  
//			 String rootPath=WebConstant.res.getString("resources")+WebConstant.res.getString("samplingQr");
//			    DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
//				String samplingQrPath=WebConstant.res.getString("samplingQrPath");
//				File qrFile =new File(rootPath+bean.getQrcode());
//				if(!qrFile.exists()){
//					QrcodeUtil.generateSamplingQrcode(request,bean.getQrcode(), samplingQrPath + bean.getSamplingNo(),rootPath);
//				}
			//4.查询送检单位信息
			InspectionUnit unit=inspectionUnitService.queryById(user.getInspectionId());
			//5.处理重打报告信息
			List<Map<String,Object>> reportNumbers=null;
			if(secodePrinted.size()>0) {
				 reportNumbers= tbSamplingDetailService.queryReportNumberBySamplingId(samplingId);
			}
			//6.根据订单ID查询送检批次
			List<Map<String,Object>> receiverNumbers=tbSamplingDetailService.queryCollectCodeBySamplingId(samplingId);
			
			map.put("reportNumbers", reportNumbers);
			map.put("receiverNumbers", receiverNumbers);
			map.put("unit", unit);
			map.put("firstPrint", firstPrint);
			map.put("secodePrinted", secodePrinted);
			map.put("checkList", checkList);
			map.put("unReceiveList", unReceiveList);
			map.put("bean", bean);
			map.put("samplingQrPath", WebConstant.res.getString("reportPath")+bean.getId());
			if(firstPrint.size()>0) {//有待打印的数据，生成对应的报告打印码
				Random random=new Random();
				int reportNumber=random.nextInt(9999);
				map.put("samplingQr",reportNumber );
			}
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
			e.printStackTrace();
		}
		return new ModelAndView("/terminal/report/printAll",map);
	}*/

    /**
     * @param samplingId  抽样单ID
     * @param collectCode 取报告码
     * @param request
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月26日
     */
    @RequestMapping({"/printAll"})
    public ModelAndView printAll(Integer samplingId, String collectCode, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        TbSampling bean = null;
        try {
            //1.查询主订单信息
            bean = tbSamplingService.selectById(samplingId);
            InspectionUnitUser user = (InspectionUnitUser) request.getSession().getAttribute("session_user_terminal");
            if (user == null) {//非用户登录打印 add by xiaoyl
                user = insUnitUserService.queryById(Integer.valueOf(bean.getCreateBy()));
            }
            //2.查询送检样品明细
            List<TbSamplingDetailReport> list = tbSamplingDetailService.queryOrderDetailBySamplingId(samplingId, null, collectCode);
            //4.查询送检单位信息
		/*	InspectionUnit unit =null;
			if(user.getUserType()==0 || user.getInspectionId()==null) {
				unit = new InspectionUnit();
				unit.setCompanyName(user.getRealName());
			}else {
				 unit = inspectionUnitService.queryById(user.getInspectionId());
			}
			unit.setLinkPhone(user.getPhone());*/
            //5.处理重打报告信息
            List<Map<String, Object>> reportNumbers = tbSamplingDetailService.queryReportNumberBySamplingId(samplingId, collectCode);
            //6.根据订单ID查询送检批次
            List<Map<String, Object>> receiverNumbers = tbSamplingDetailService.queryCollectCodeBySamplingId(samplingId, collectCode);
            if (receiverNumbers.size() > 0) {
            	int receiveCount=0;
//            	int pageNo=1;
                for (Map<String, Object> map2 : receiverNumbers) {
                    map2.put("reportNumber", Math.round(Math.random() * 10000));
                    receiveCount=Integer.parseInt(map2.get("receiveCount").toString());
//                    if(receiveCount>10) {
//                    	pageNo=receiveCount%10==0 ? receiveCount/10 : (receiveCount/10)+1;
//                    }
//                    map2.put("pageNo", pageNo);
                }
            }
            map.put("reportNumbers", reportNumbers);
            map.put("receiverNumbers", receiverNumbers);
//			map.put("unit", unit);
            map.put("list", list);
            map.put("bean", bean);//
            map.put("reportConfig", SystemConfigUtil.REPORT_CONFIG);
            map.put("samplingQrPath", WebConstant.res.getString("reportPath") + bean.getId());
            //是否显示进货数量字段
            map.put("showPurchaseNumber",SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
        }
        return new ModelAndView("/terminal/report/printAll", map);
    }
    @RequestMapping(value = "/GeneratorImage")
    @ResponseBody
    public AjaxJson GeneratorImage(Integer rdataId) {
    	AjaxJson ajaxJson=new AjaxJson();
        try {
        	CheckReportData bean=checkReportService.queryById(rdataId);
        	String projectPath = ReportPrintController.class.getResource("/").getPath().replaceFirst("/", "").replaceAll("WEB-INF/classes/", "")+"/img/report/";
        	File file=new File(projectPath);
        	 byte[] bytes1;
        	 FileOutputStream os=null;
        	if(!file.exists()) {
        		file.mkdir();
        	}else {//是否考虑先清空旧文件，避免没有签名的用户读取上一个打印用户的签名
        		 String[] childrens = file.list();
        		// 递归删除目录中的子目录下
    	        for (String child : childrens) {
    	             System.out.println(child);
    	             File file1 = new File(file, child);
    	             file1.delete();
    	        }
        	}
        	BASE64Decoder decoder=new BASE64Decoder();
        	//1.写入审核签名图片
        	if(StringUtil.isNotEmpty(bean.getReviewImage())) {
        		bytes1 = decoder.decodeBuffer(bean.getReviewImage());
        		os=new FileOutputStream(projectPath+"reviewImage.png");
        		os.write(bytes1);
        	}
            //2.写入批准签名图片
        	if(StringUtil.isNotEmpty(bean.getApproveImage())) {
	            bytes1 = decoder.decodeBuffer(bean.getApproveImage());
	            os=new FileOutputStream(projectPath+"approveImage.png");
	            os.write(bytes1);
        	}
            //3.写入电子签章图片
        	if(StringUtil.isNotEmpty(bean.getSignatureImage())) {
	            bytes1 = decoder.decodeBuffer(bean.getSignatureImage());
	            os=new FileOutputStream(projectPath+"signatureImage.png");
	            os.write(bytes1);
        	}
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg("生成签名图片失败");
        } catch (Exception e) {
			e.printStackTrace();
		}
        return ajaxJson;
    }
    @RequestMapping({"/print"})
    public ModelAndView print(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        return new ModelAndView("/terminal/report/print", map);
    }

    /**
     * 打印成功，更新打印次数、费用
     *
     * @param id                订单ID
     * @param printType         打印类型：0首次打印，1 重打
     * @param samplingDetailIds 分开打印-需要打印的样品ID
     * @return
     */
    @RequestMapping({"/printSuccess"})
    public ModelAndView printSuccess(Integer id, Short printType, String samplingDetailIds, Integer reportNumber, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        boolean success = true;
        String message = "";
        try {
            TbSampling tbSampling = tbSamplingService.getById(id);
//        	Integer printNumber = tbSampling.getPrintNum() == null ? 1 : tbSampling.getPrintNum() + 1;
            int[] detailIds = null;
            if (printType == 0) {//首次打印,记录报告码
                String[] strArray = samplingDetailIds.split(",");
                detailIds = Arrays.stream(strArray).mapToInt(Integer::parseInt).toArray();
                tbSamplingDetailService.updateReportNumberByDetailIds(reportNumber, detailIds);
                //更新主订单信息
//              tbSampling.setPrintNum(printNumber.shortValue());
              tbSampling.setUpdateDate(new Date());
              tbSamplingService.updateById(tbSampling);
            } else {//二次打印，更新打印次数和费用
                //查询需要更新的订单明细
                List<TbSamplingDetailReport> list = tbSamplingDetailService.queryOrderDetailBySamplingId(id, reportNumber, null);
                if (list.size() > 0) {
                    detailIds = new int[list.size()];
                    for (int i = 0; i < list.size(); i++) {
                        detailIds[i] = list.get(i).getId();
                    }
                }
//                double printingFee =tbSampling.getPrintingFee() + Double.valueOf(SystemConfigUtil.PRINT_CONFIG.getString("printingFee"));
//                tbSampling.setPrintingFee(printingFee);
                //更新打印次数
                tbSamplingDetailService.updateByDetailIds(detailIds);
            }
            //更新主订单信息
//            tbSampling.setPrintNum(printNumber.shortValue());
//            tbSampling.setUpdateDate(new Date());
//            tbSamplingService.updateBySelective(tbSampling);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            success = false;
            message = e.getMessage();
        }
        logUtil.savePrintLog((short) 0, ModularConstant.OPERATION_MODULE_PRINT, ReportPrintController.class.toString(), "printSuccess", "检测报告打印成功", success, message, request);
        return new ModelAndView("/terminal/report/printSuccess", map);
    }

    /**
     * 打印成功，更新打印次数、费用
     * @param id    订单ID
     * @param printType    打印类型：0合并打印，1 分开打印
     * @param samplingDetailIds    分开打印-需要打印的样品ID
     * @return
     */
	/*@RequestMapping({ "/printSuccess" })
	public ModelAndView printSuccess(Integer id, Short printType, String samplingDetailIds) {
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			TbSampling tbSampling = tbSamplingService.getById(id);

			//首次打印
			if (tbSampling.getPrintType() == null){
				tbSampling.setPrintType(printType);
				tbSampling.setPrintNum((short) 1);

				//二次打印
			}else{
				tbSampling.setPrintNum((short) (tbSampling.getPrintNum()+1));
			}

			//打印费用
			double printingFee = tbSampling.getPrintingFee() == null ? 0.0 : tbSampling.getPrintingFee();

			//合并打印
			if(tbSampling.getPrintType() == 0){

				if(tbSampling.getPrintNum() > 0){
					printingFee += 1;
				}

				//更新样品打印次数
				String sql1 = "UPDATE tb_sampling_detail tsd1,   " +
						" (SELECT id, print_num FROM tb_sampling_detail WHERE sampling_id = "+tbSampling.getId()+") tsd2  " +
						"SET tsd1.print_num = (IF(tsd2.print_num IS NULL, 0, tsd2.print_num)+1), tsd1.update_date = NOW()  " +
						" WHERE tsd1.id = tsd2.id ";
				int sqlStatus = jdbcTemplate.update(sql1);

			//分开打印
			}else {
				//重打样品数量
				String sql0 = "SELECT COUNT(1) FROM tb_sampling_detail WHERE id IN ("+samplingDetailIds+") AND print_num > 0 ";
				int printNumber = jdbcTemplate.queryForObject(sql0, Integer.class);

				//更新样品打印次数
				String sql1 = "UPDATE tb_sampling_detail tsd1,  " +
						" (SELECT id, print_num FROM tb_sampling_detail WHERE id IN ("+samplingDetailIds+")) tsd2 " +
						"SET tsd1.print_num = (IF(tsd2.print_num IS NULL, 0, tsd2.print_num)+1), tsd1.update_date = NOW() " +
						" WHERE tsd1.id = tsd2.id ";
				int sqlStatus = jdbcTemplate.update(sql1);

				printingFee += printNumber;

			}
			tbSampling.setPrintingFee(printingFee);
			tbSampling.setUpdateDate(new Date());

			tbSamplingService.updateBySelective(tbSampling);


		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
		}

		return new ModelAndView("/terminal/report/printSuccess",map);
	}*/


    /**
     * 	重打报告收款页面
     *
     * @param id 订单ID
     * @return
     */
    @RequestMapping(value = "/payForPrinting")
    public ModelAndView payForPrinting(Integer id) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TbSampling tbSampling = tbSamplingService.getById(id);
            Integer printingFee = Integer.valueOf(SystemConfigUtil.PRINT_CONFIG.getString("printingFee"));
            Date date = new Date();
            Income income = null;
            AccountFlow flow = null;
            HttpSession session = ContextHolderUtils.getSession();
            InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
            if (user == null) {
                //不登录打印报告，使用随机数代替用户号生成交易流水
                income = new Income(GeneratorOrder.generate(Integer.parseInt(RandomStringUtils.random(5, false, true))), tbSampling.getId(), (short) 0, (short) 1, printingFee,
                        "", date, "", date);
            } else {
                income = new Income(GeneratorOrder.generate(user.getId()), tbSampling.getId(), (short) 0, (short) 1, printingFee,
                        user.getId() + "", date, user.getId() + "", date);
            }
            //查询当前用户余额
            if (SystemConfigUtil.PAYTYPE_CONFIG.getString("balance").equals("0") && user != null) {
                InspectionUserAccount account = accountService.queryAccountByUserId(user.getId());
                if (account != null && account.getTotalMoney()> 0) {//余额足够支付，生成余额交易记录
                    flow = new AccountFlow(null, printingFee, (short) 0, (short) 0, user.getId().toString(), new Date());
                    map.put("account", account);
                }
                map.put("balance", SystemConfigUtil.PAYTYPE_CONFIG.getString("balance"));
            } else {
                map.put("balance", 1);
            }
            map.put("weiPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("weiPay"));
            map.put("aliPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("aliPay"));
            incomeService.saveIncomeAndFlow(income, flow, user);
            map.put("bean", income);
            map.put("sampleBean", tbSampling);
        } catch (Exception e) {
            e.getStackTrace();
            System.out.println("*********************" + e.getMessage());
        }
        return new ModelAndView("/terminal/report/pay", map);
    }

    /**
     * 打印是否收费
     *
     * @param id                订单ID
     * @param samplingDetailIds 打印样品ID
     * @return
     */
    @RequestMapping({"/isCharge"})
    @ResponseBody
    public AjaxJson isCharge(Integer id, String samplingDetailIds) {
        AjaxJson aj = new AjaxJson();
        try {
            TbSampling tbSampling = tbSamplingService.getById(id);

//            //首次打印
//            if (tbSampling.getPrintType() == null) {
//                //无需收费
//                aj.setObj(0);
//
//                //二次打印
//            } else {
//                //合并打印
//                if (tbSampling.getPrintType() == 0) {
//                    //收费
//                    aj.setObj(1);
//
//                    //分开打印
//                } else {
//                    //重打样品数量
//                    String sql0 = "SELECT COUNT(1) FROM tb_sampling_detail WHERE id IN (" + samplingDetailIds + ") AND print_num > 0 ";
//                    int printNumber = jdbcTemplate.queryForObject(sql0, Integer.class);
//
//                    //printNumber>0收费
//                    aj.setObj(printNumber);
//                }
//            }

        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            aj.setSuccess(false);
        }
        return aj;
    }

//	/**
//	 * 打印成功，更新打印次数、费用
//	 * @param id	订单ID
//	 * @param printType	打印类型：0合并打印，1 分开打印
//	 * @param samplingDetailIds	分开打印-需要打印的样品ID
//	 * @return
//	 */
//	@RequestMapping({"/updatePrintRecord"})
//	@ResponseBody
//	public AjaxJson updatePrintRecord(Integer id, Short printType, String samplingDetailIds) {
//		AjaxJson ajaxJson = new AjaxJson();
//		try {
//			TbSampling tbSampling = tbSamplingService.getById(id);
//
//			//首次打印
//			if (tbSampling.getPrintType() == null){
//				tbSampling.setPrintType(printType);
//				tbSampling.setPrintNum((short) 1);
//
//			//二次打印
//			}else{
//				tbSampling.setPrintNum((short) (tbSampling.getPrintNum()+1));
//			}
//
//			//打印费用
//			double printingFee = tbSampling.getPrintingFee() == null ? 0.0 : tbSampling.getPrintingFee();
//
//			//合并打印
//			if(tbSampling.getPrintType() == 0){
//
//				if(tbSampling.getPrintNum() > 0){
//					printingFee += 1;
//				}
//
//				//更新样品打印次数
//				String sql1 = "UPDATE tb_sampling_detail tsd1,   " +
//						" (SELECT id, print_num FROM tb_sampling_detail WHERE sampling_id = "+tbSampling.getId()+") tsd2  " +
//						"SET tsd1.print_num = (IF(tsd2.print_num IS NULL, 0, tsd2.print_num)+1), tsd1.update_date = NOW()  " +
//						" WHERE tsd1.id = tsd2.id ";
//				int sqlStatus = jdbcTemplate.update(sql1);
//
//			//分开打印
//			}else {
//				//重打样品数量
//				String sql0 = "SELECT COUNT(1) FROM tb_sampling_detail WHERE id IN ("+samplingDetailIds+") AND print_num > 0 ";
//				int printNumber = jdbcTemplate.queryForObject(sql0, Integer.class);
//
//				//更新样品打印次数
//				String sql1 = "UPDATE tb_sampling_detail tsd1,  " +
//						" (SELECT id, print_num FROM tb_sampling_detail WHERE id IN ("+samplingDetailIds+")) tsd2 " +
//						"SET tsd1.print_num = (IF(tsd2.print_num IS NULL, 0, tsd2.print_num)+1), tsd1.update_date = NOW() " +
//						" WHERE tsd1.id = tsd2.id ";
//				int sqlStatus = jdbcTemplate.update(sql1);
//
//				printingFee += printNumber;
//
//			}
//			tbSampling.setPrintingFee(printingFee);
//			tbSampling.setUpdateDate(new Date());
//
//			tbSamplingService.updateBySelective(tbSampling);
//
//
//		} catch (Exception e) {
//			log.error("*************************"+e.getMessage()+e.getStackTrace());
//			ajaxJson.setSuccess(false);
//		}
//		return ajaxJson;
//	}

    /**
     * 订单管理详情首次打印，生成报告码
     *
     * @param samplingDetailIds 样品ID
     * @return
     */
    @RequestMapping({"/generateReportNumber"})
    @ResponseBody
    public AjaxJson generateReportNumber(String samplingDetailIds) {
        AjaxJson aj = new AjaxJson();
        try {
            Integer reportNumber = Math.toIntExact(Math.round(Math.random() * 10000));
            String[] strArray = samplingDetailIds.split(",");
            int[] detailIds = Arrays.stream(strArray).mapToInt(Integer::parseInt).toArray();
            tbSamplingDetailService.updateReportNumberByDetailIds(reportNumber, detailIds);
            aj.setObj(reportNumber);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            aj.setSuccess(false);
        }
        return aj;
    }


    /**
     * 根据抽样单号和收样批次码查看报告
     *
     * @param requestId   委托单位ID
     * @param samplingId  抽样单ID
     * @param rN          取报告码
     * @param collectCode 收样编号
     * @param print       打印报告(订单管理详情专用) 1:打印
     * @param scan        查看报告方式 1:扫二维码查看报告
     * @return
     * @author xiaoyl
     * @date 2019年8月21日
     */
    @RequestMapping({"/report"})
    public ModelAndView report(Integer[] requestId, Integer samplingId, Integer rN, String collectCode, String print, String scan, HttpServletRequest request, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        boolean success = true;
        String message = "";
        requestId = requestId != null && requestId.length == 0 ? null : requestId;
        List<RequesterUnit> reList = new ArrayList<RequesterUnit>();
        try {

            //1.查询主订单信息
            TbSampling bean = tbSamplingService.getById(samplingId);
            //1.查询主订单信息 shit更改,根据委托单位ID查询委托单位信息
            //TbSampling bean = null ==requestId ?tbSamplingService.getById(samplingId):tbSamplingService.selectByReqestId(requestId,samplingId);
            //订单对应的委托单位列表
//            reList = orderStatisticDailyService.getRequesterList(bean.getSamplingNo(), requestId);


            //InspectionUnitUser user = insUnitUserService.queryById(Integer.valueOf(bean.getCreateBy()));
            //2.查询送检样品明细
            List<TbSamplingDetailReport> list = tbSamplingDetailService.queryOrderDetailBySamplingId(samplingId, rN, collectCode);
			/*//3.查询送检单位信息
			InspectionUnit unit =null;
			if(user.getUserType()==0 || user.getInspectionId()==null) {
				unit = new InspectionUnit();
				unit.setCompanyName(user.getRealName());
			}else {
				 unit = inspectionUnitService.queryById(user.getInspectionId());
			}
			unit.setLinkPhone(user.getPhone());*/
            if ("1".equals(scan)) {
                Iterator it = list.iterator();
                while (it.hasNext()) {
                    //更新扫描次数
                    TbSamplingDetailReport report = (TbSamplingDetailReport) it.next();
                    if (report.getScanNum() == null) {
                        report.setScanNum((short) 1);
                    } else {
                        report.setScanNum((short) (report.getScanNum() + 1));
                    }
                    map.put("scanNum", report.getScanNum());
                    tbSamplingDetailService.updateById(report);

                    //删除未检测样品
                    if (StringUtil.isEmpty(report.getConclusion())) {
                        it.remove();
                    }
                }
            } else {
                //删除未检测样品
                Iterator it = list.iterator();
                while (it.hasNext()) {
                    TbSamplingDetailReport report = (TbSamplingDetailReport) it.next();
                    if (StringUtil.isEmpty(report.getConclusion())) {
                        it.remove();
                    }
                }
            }
            // add by xiaoyl 2020-03-23 计算报告页数，每10条数据一页 
            int pageNo=list.size();
            pageNo=pageNo%10==0 ? pageNo/10 : (pageNo/10)+1;
            map.put("pageNo", pageNo);
            
            map.put("bean", bean);
            map.put("list", list);
//			map.put("unit", unit);
            map.put("samplingQrPath", WebConstant.res.getString("reportPath") + bean.getId());
            map.put("reportNumber", rN);
//            map.put("collectCode", collectCode==null ? list.get(0).getCollectCode() : collectCode);
            map.put("print", print);
            map.put("reportConfig", SystemConfigUtil.REPORT_CONFIG);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            success = false;
            message = e.getMessage();
        }
        map.put("reList", reList);
        //是否显示进货数量字段
        map.put("showPurchaseNumber",SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        logUtil.savePrintLog((short) 0, ModularConstant.OPERATION_MODULE_PRINT, ReportPrintController.class.toString(), "report", "电子报告查看", success, message, request);
        return new ModelAndView("/terminal/report/report", map);
    }

    /***********************************一单多用报告打印 start**************************************************/
    /**
     * 一单多用打印报告
     * @param samplingId  抽样单ID
     * @param collectCode 取报告码
     * @param request
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月26日
     */
    @RequestMapping({"/printAllMutl"})
    public ModelAndView printAllMutl(Integer samplingId, String collectCode, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        TbSampling bean = null;
        try {
            //1.查询主订单信息
            bean = tbSamplingService.selectById(samplingId);
            InspectionUnitUser user = (InspectionUnitUser) request.getSession().getAttribute("session_user_terminal");
            if (user == null) {//非用户登录打印 add by xiaoyl
                user = insUnitUserService.queryById(Integer.valueOf(bean.getCreateBy()));
            }
            //2.查询送检样品明细
            List<TbSamplingDetailReport> list = tbSamplingDetailService.queryOrderDetailBySamplingId(samplingId, null, collectCode);
            //4.查询送检单位信息
            //5.处理重打报告信息
           // List<Map<String, Object>> reportNumbers = tbSamplingDetailService.queryReportNumberBySamplingId(samplingId, collectCode);
            //map.put("reportNumbers", reportNumbers);
            //6.根据订单ID查询送检批次
            List<Map<String, Object>> receiverNumbers = tbSamplingDetailService.queryCollectCodeBySamplingId(samplingId, collectCode);
            if (receiverNumbers.size() > 0) {
                for (Map<String, Object> map2 : receiverNumbers) {
                	int count=0;
                    for (TbSamplingDetailReport report : list) {
//                    	if(map2.get("collectCode").toString().equals(report.getCollectCode()) && StringUtil.isNotEmpty(report.getConclusion())) {
//                    		count+=1;
//                    	}
					}
                    
                    if(Integer.parseInt(map2.get("receiveCount").toString())==count) {//该收样批次检测完成
                    	map2.put("isFinished", true);
                    }else {
                    	map2.put("isFinished", false);
                    }
                }
            }
            map.put("receiverNumbers", receiverNumbers);
            map.put("list", list);
            map.put("bean", bean);//
            map.put("reportConfig", SystemConfigUtil.REPORT_CONFIG);
            map.put("samplingQrPath", WebConstant.res.getString("reportPath") + bean.getId());
            //是否显示进货数量字段
            map.put("showPurchaseNumber",SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
        }
        	return new ModelAndView("/terminal/report/printAllMutl", map);
    }
    /**
     * 打印报告页面选择委托单位数据查询：根据订单号、收样批次查询待打印/已打印委托单位列表
     * @description
     * @param id 订单ID
     * @param printType 打印类型: 0待打印，1已打印
     * @param collectCode 收样编号
     * @param keyWords 关键字查询：预留参数
     * @return
     * @author xiaoyl
     * @date   2020年1月15日
     */
     @RequestMapping("/queryUnitsForPrint")
     @ResponseBody
     public AjaxJson  queryUnitsForPrint(Integer id,int printType,String collectCode,@RequestParam(required = false)String keyWords){  
     	 AjaxJson jsonObject = new AjaxJson();
     	 List<TbSamplingRequester> reList =requesterService.queryUnitsForPrint(id,printType,collectCode,keyWords);
     	jsonObject.setObj(reList);
     	return jsonObject;
     }
     
//    /**
//     * 	一单多用： 打印成功，更新打印次数、费用
//     * @description
//     * @param id
//     * @param printType 0:首次打印，1重打
//     * @param collectCode 收样编号
//     * @param detailIds 委托单位集合
//     * @param request
//     * @return
//     * @author xiaoyl
//     * @date   2020年1月17日
//     */
//     @RequestMapping({"/printMutliSuccess"})
//     public ModelAndView printMutliSuccess(Integer id, Short printType, String collectCode,String detailIds, HttpServletRequest request) {
//         Map<String, Object> map = new HashMap<String, Object>();
//         boolean success = true;
//         String message = "";
//         try {
//             TbSampling tbSampling = tbSamplingService.getById(id);
////             Integer printNumber = tbSampling.getPrintNum() == null ? 1 : tbSampling.getPrintNum() + 1;
//             String[] strArray = detailIds.split(",");
//             TbSamplingReportPrintlog plog=null;
//             Date d=new Date();
//             if (printType == 0) {//首次打印
//            	 List<TbSamplingReportPrintlog> logList=new ArrayList<TbSamplingReportPrintlog>();
//            	 for (String requestId : strArray) {
//            		 plog=tbSamplingReportPrintlogService.selectByIdAndCode(id,Integer.valueOf(requestId),collectCode);
//            		 if(plog!=null) {
//            			 tbSamplingReportPrintlogService.updatePrintLog(plog);
//            		 }else {
//            			 plog=new TbSamplingReportPrintlog(id,collectCode,Integer.valueOf(requestId),1,"",d,"",d);
//            			 logList.add(plog);
//            		 }
//				}
//            	 if(logList.size()>0) {
//            		 tbSamplingReportPrintlogService.saveBatch(logList);
//            	 }
//                 //更新主订单信息
////                 tbSampling.setPrintNum(printNumber.shortValue());
//                 tbSampling.setUpdateDate(new Date());
//                 tbSamplingService.updateById(tbSampling);
//             } else {//重复打印,传入打印记录的ID,用于更新打印次数
//            	 for (String requestId : strArray) {
//            		 plog=tbSamplingReportPrintlogService.queryById(Integer.valueOf(requestId));
//            		 tbSamplingReportPrintlogService.updatePrintLog(plog);
//				}
////            	  double printingFee = tbSampling.getPrintingFee() + Double.valueOf(SystemConfigUtil.PRINT_CONFIG.getString("printingFee"));
////                  tbSampling.setPrintingFee(printingFee);
//             }
//             //更新主订单信息
////             tbSampling.setPrintNum(printNumber.shortValue());
////             tbSampling.setUpdateDate(new Date());
////             tbSamplingService.updateBySelective(tbSampling);
//         } catch (Exception e) {
//             log.error("*************************" + e.getMessage() + e.getStackTrace());
//             success = false;
//             message = e.getMessage();
//         }
//         logUtil.savePrintLog((short) 0, ModularConstant.OPERATION_MODULE_PRINT, ReportPrintController.class.toString(), "printSuccess", "检测报告打印成功", success, message, request);
//         return new ModelAndView("/terminal/report/printSuccess", map);
//     }
//     /**
//      * 	后台打印： 打印成功，更新打印次数、费用
//      * @description
//      * @param id
//      * @param printType 0:首次打印，1重打
//      * @param collectCode 收样编号
//      * @param detailIds 委托单位集合
//      * @param request
//      * @return
//      * @author xiaoyl
//      * @date   2020年1月17日
//      */
//      @RequestMapping({"/printMutliForManager"})
//      @ResponseBody
//      public AjaxJson printMutliForManager(Integer id, Short printType, String collectCode,String detailIds, HttpServletRequest request) {
//          AjaxJson json=new AjaxJson();
//     	 Map<String, Object> map = new HashMap<String, Object>();
//          boolean success = true;
//          String message = "";
//          try {
//              TbSampling tbSampling = tbSamplingService.getById(id);
////              Integer printNumber = tbSampling.getPrintNum() == null ? 1 : tbSampling.getPrintNum() + 1;
//              String[] strArray = detailIds.split(",");
//              TbSamplingReportPrintlog plog=null;
//              Date d=new Date();
//              if (printType == 0) {//首次打印
//             	 List<TbSamplingReportPrintlog> logList=new ArrayList<TbSamplingReportPrintlog>();
//             	 for (String requestId : strArray) {
//             		 plog=tbSamplingReportPrintlogService.selectByIdAndCode(id,Integer.valueOf(requestId),collectCode);
//             		 if(plog!=null) {
//             			 tbSamplingReportPrintlogService.updatePrintLog(plog);
//             		 }else {
//             			 plog=new TbSamplingReportPrintlog(id,collectCode,Integer.valueOf(requestId),1,"",d,"",d);
//             			 logList.add(plog);
//             		 }
// 				}
//             	 if(logList.size()>0) {
//             		 tbSamplingReportPrintlogService.saveBatch(logList);
//             	 }
//              } else {//重复打印,传入打印记录的ID,用于更新打印次数
//             	 for (String requestId : strArray) {
//             		 plog=tbSamplingReportPrintlogService.queryById(Integer.valueOf(requestId));
//             		 tbSamplingReportPrintlogService.updatePrintLog(plog);
// 				}
//              }
//              //更新主订单信息
////              tbSampling.setPrintNum(printNumber.shortValue());
//              tbSampling.setUpdateDate(new Date());
//              tbSamplingService.updateById(tbSampling);
//          } catch (Exception e) {
//              log.error("*************************" + e.getMessage() + e.getStackTrace());
//              success = false;
//              message = e.getMessage();
//              json.setSuccess(false);
//              json.setMsg("更新打印状态失败");
//          }
//          logUtil.savePrintLog((short) 0, ModularConstant.OPERATION_MODULE_PRINT, ReportPrintController.class.toString(), "printSuccess", "检测报告打印成功", success, message, request);
//          return json;
//      }
     /**
      * 	重打报告收款页面
      *
      * @param id 订单ID
      * @param requestCount 委托单位数量
      * @return
      */
     @RequestMapping(value = "/payForPrintingMutl")
     public ModelAndView payForPrintingMutl(Integer id,int requestCount) {
         Map<String, Object> map = new HashMap<String, Object>();
         try {
             TbSampling tbSampling = tbSamplingService.getById(id);
             Integer printingFee = Integer.valueOf(SystemConfigUtil.PRINT_CONFIG.getString("printingFee"));
             printingFee=printingFee*requestCount;
             String remark=requestCount+"份报告";
             Date date = new Date();
             Income income = null;
             AccountFlow flow = null;
             HttpSession session = ContextHolderUtils.getSession();
             InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
             if (user == null) {
                 //不登录打印报告，使用随机数代替用户号生成交易流水
                 income = new Income(GeneratorOrder.generate(Integer.parseInt(RandomStringUtils.random(5, false, true))), tbSampling.getId(), (short) 0, (short) 1, printingFee,0,0D,
                         "", date, "", date,remark);
             } else {
                 income = new Income(GeneratorOrder.generate(user.getId()), tbSampling.getId(), (short) 0, (short) 1, printingFee,0,0D,
                         user.getId() + "", date, user.getId() + "", date,remark);
             }
             //查询当前用户余额
             if (SystemConfigUtil.PAYTYPE_CONFIG.getString("balance").equals("0") && user != null) {
                 InspectionUserAccount account = accountService.queryAccountByUserId(user.getId());
                 if (account != null && account.getTotalMoney()>printingFee) {//余额足够支付，生成余额交易记录
                     flow = new AccountFlow(null, printingFee, (short) 0, (short) 0, user.getId().toString(), new Date());
                     map.put("account", account);
                 }
                 map.put("balance", SystemConfigUtil.PAYTYPE_CONFIG.getString("balance"));
             } else {
                 map.put("balance", 1);
             }
             map.put("weiPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("weiPay"));
             map.put("aliPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("aliPay"));
             incomeService.saveIncomeAndFlow(income, flow, user);
             map.put("bean", income);
             map.put("sampleBean", tbSampling);
         } catch (Exception e) {
             e.getStackTrace();
             System.out.println("*********************" + e.getMessage());
         }
         return new ModelAndView("/terminal/report/pay", map);
     }
    /***********************************一单多用报告打印 end**************************************************/
}
