package com.dayuan3.terminal.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.system.TSUser;
import com.dayuan.mapper.sampling.TbSamplingMapper;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MyException;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.common.bean.InspectionReportPrice;
import com.dayuan3.common.bean.InspectionUnitUserRequester;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionReportPriceService;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.pretreatment.model.TbSamplingModel;
import com.dayuan3.terminal.bean.*;
import com.dayuan3.terminal.service.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


/**
 * 订单管理
 *
 * @author Dz
 * @date 2019年7月2日
 */
@Controller
@RequestMapping("/order")
public class OrderController extends BaseController {
    private Logger log = Logger.getLogger(OrderController.class);
    @Autowired
    private TbSamplingDetailService samplingDetailService;
    @Autowired
    private TbSamplingService tbSamplingService;
    @Autowired
    private IncomeService incomeService;
    @Autowired
    private InspectionUnitService inspectionUnitService;
    @Autowired
    private InspectionUnitUserService inspectionUnitUserService;
    @Autowired
	private InsUnitReqUnitService insUnitReqUnitService;
	
	@Autowired
	private InspectionReportPriceService reportPriceService;
	
    @Autowired
    private CommonLogUtilService logUtil;
    @Autowired
    private OrderStatisticDailyService orderStatisticDailyService;
    @Autowired
    private TbSamplingDetailService tbSamplingDetailService;
    @Value("${sampleBarCode}")
    private String sampleBarCode;

    /**
     * 订单管理
     *
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        return new ModelAndView("/terminal/order/list", map);
    }

    /**
     * 订单管理数据
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping(value = "/orderDatagrid")
    @ResponseBody
    public AjaxJson orderDatagrid(TbSamplingModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            //高级搜索时间范围，覆盖默认时间范围
            Map<String, String> dateMap = page.getDateMap();
            if (null != dateMap) {
                if (StringUtil.isNotEmpty(dateMap.get("samplingStartDate"))) {
                    model.setSamplingStartDate(dateMap.get("samplingStartDate"));
                }
                if (StringUtil.isNotEmpty(dateMap.get("samplingEndDate"))) {
                    model.setSamplingEndDate(dateMap.get("samplingEndDate"));
                }
                if (StringUtil.isNotEmpty(dateMap.get("payDateStartDate"))) {
                    model.setPayDateStartDate(dateMap.get("payDateStartDate"));
                }
                if (StringUtil.isNotEmpty(dateMap.get("payDateEndDate"))) {
                    model.setPayDateEndDate(dateMap.get("payDateEndDate"));
                }
            }
            int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
            model.setCheckNumber(recheckNumber);
//          page = tbSamplingService.loadDatagrid(page, model, TbSamplingMapper.class, "loadDatagridOrder", "getRowTotalOrder");
            page=tbSamplingService.loadDatagrid2(page,model);
            jsonObj.setObj(page);
            //根据当前条件查询所有费用总和 add by xiaoyl 2020/03/13
            page.setObj(model);
            double totalMoney=tbSamplingService.queryTotalMoney2(page);
            jsonObj.setResultCode(totalMoney+"");
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
    
    @RequestMapping("/getOrderById")
    @ResponseBody
    public AjaxJson getOrderById(Integer id) throws Exception{
    	AjaxJson jsonObj = new AjaxJson();
    	TbSampling sampling = tbSamplingService.getById(id);
    	jsonObj.setObj(sampling);
    	 return jsonObj;
    }


    /**
     * 查看订单详情
     *
     * @param id 订单ID
     * @return
     */
    @RequestMapping("/details")
    public ModelAndView details(Integer id) {

        Map<String, Object> map = new HashMap<String, Object>();
        TbSampling sampling = null;
        Income income = null;
        InspectionUnit insUnit = null;
        List<RequesterUnit> reList = new ArrayList<RequesterUnit>();
        try {
            if (id!=null) {
                sampling = tbSamplingService.getById(id);
//                reList =orderStatisticDailyService.getRequesterList(sampling.getSamplingNo(),null);
            }
            if (sampling != null) {
                income = incomeService.queryPaymentOrder(sampling.getId());
//                InspectionUnitUser insUnitUser = inspectionUnitUserService.queryById(Integer.parseInt(sampling.getSamplingUserid()));
//                if (insUnitUser != null){
//                    insUnit = inspectionUnitService.queryById(insUnitUser.getInspectionId());
//                }
            }
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
        }
        map.put("sampling", sampling);
        map.put("income", income);
        map.put("insUnit", insUnit);
        map.put("reList", reList);
        //是否显示进货数量字段
        map.put("showPurchaseNumber",SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));

        return new ModelAndView("/terminal/order/orderDetail", map);

    }


    /**
     * 查看委托单位
     *
     * @param id 订单ID
     * @return
     * @throws Exception 
     */
    @RequestMapping("/regUtil")
    public String  regUtil(Integer id,Model model) throws Exception {  
    	TbSampling sampling = tbSamplingService.getById(id);
//    	delete by xiaoyl 2020-02-29
//    	List<RequesterUnit> reList =orderStatisticDailyService.getRequesterList(sampling.getSamplingNo(),null);
//        model.addAttribute("reList", reList);
        model.addAttribute("sampling", sampling);
        model.addAttribute("id", id);
    	return "/terminal/order/regUtil";
    }
    
    @RequestMapping(value = "/regData")
    @ResponseBody
    public AjaxJson regData(RequesterUnit model, Page page) throws Exception {
    	TbSampling sampling = tbSamplingService.getById(model.getId());
//    	model.setSamplingNo(sampling.getSamplingNo());
    	AjaxJson jsonObj = new AjaxJson();
    	 try {

             page = orderStatisticDailyService.loadDatagrid(page, model);
             jsonObj.setObj(page);
         } catch (Exception e) {
             log.error("*************************" + e.getMessage() + e.getStackTrace());
             e.printStackTrace();
             jsonObj.setSuccess(false);
             jsonObj.setMsg("操作失败");
         }
         return jsonObj;
    }
    /**
     * 激活订单
     * @param id 订单ID
     * @return
     */
    @RequestMapping(value = "/activateOrder")
    @ResponseBody
    public AjaxJson activateOrder(HttpServletRequest request, Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        try {

            if (StringUtil.isNotEmpty(id)) {
                TbSampling sampling = tbSamplingService.getById(id);
                sampling.setOrderStatus(2);
                PublicUtil.setCommonForTable(sampling,false);
                tbSamplingService.updateById(sampling);
                Income income = incomeService.selectBySamplingId(id,"",(short)0);
                if(null!=income &&  income.getStatus()==0){
                    income.setStatus((short)1);
                    income.setUpdateDate(new Date());
                    income.setPayNumber(GeneratorOrder.generate(01));
                    income.setPayDate(new Date());
                    incomeService.updateById(income);
                }
                //日志
//                logUtil.saveOperatorLog((short)2, ModularConstant.OPERATION_MODULE_ORDER,
//                        OrderController.class.toString(), "activateOrder", "激活订单，订单号："+sampling.getSamplingNo(),
//                        jsonObj.isSuccess(), jsonObj.getMsg(), request);

            } else {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("操作失败");
            }

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 手动取样
     * @param id 订单ID
     * @return
     */
    @RequestMapping(value = "/sampleFood")
    @ResponseBody
    public AjaxJson sampleFood(Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSUser user = PublicUtil.getSessionUser();
            if (StringUtil.isNotEmpty(id)) {
                TbSampling order = tbSamplingService.getById(id);
                order.setSamplingUsername(user.getRealname());
                order.setSamplingTime(new Date());
                order.setIsSampling(2);
                PublicUtil.setCommonForTable(order,false);
                tbSamplingService.updateById(order);
            } else {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("操作失败");
            }

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
    /**
     * 取消订单
     * @param id 订单ID
     * @return
     */
    @RequestMapping(value = "/cancelOrder")
    @ResponseBody
    public AjaxJson cancelOrder(HttpServletRequest request, Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(id)) {
                TbSampling sampling = tbSamplingService.getById(id);
                sampling.setOrderStatus(4);
                PublicUtil.setCommonForTable(sampling,false);
                tbSamplingService.updateById(sampling);
                Income income = incomeService.selectBySamplingId(id,"",(short)0);
                if(null!=income &&  income.getStatus()==0){
                    income.setStatus((short)3);
                    income.setUpdateDate(new Date());
                    income.setPayNumber(GeneratorOrder.generate(01));
                    income.setPayDate(new Date());
                    incomeService.updateById(income);
                }
            } else {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("操作失败");
            }

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
    /**
     * 订单明细数据
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping(value = "/detailsDatagrid")
    @ResponseBody
    public AjaxJson detailsDatagrid(TbSamplingModel model, Page page,@RequestParam("tbSampling.id") Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
            model.setCheckNumber(recheckNumber);    //不合格样品检测次数

            model.setId(id);
            //page = samplingDetailService.loadDatagrid(page, model, TbSamplingDetailService.class, "loadDatagridOrderDetails", "getRowTotalOrderDetails");

            page= samplingDetailService.loadDatagridOrderDetails2(page,model);
            jsonObj.setObj(page);

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 终端下单
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/terminalOrder")
    public ModelAndView terminalOrder(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sampleBarCode", sampleBarCode);
        map.put("sampleWeight", SystemConfigUtil.SAMPLE_WEIGHT_CONFIG.getString("detail"));
        //是否显示进货数量字段
        map.put("showPurchaseNumber",SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
       return new ModelAndView("/terminal/order/terminalOrder", map);
    }

    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(TbSampling bean, String details, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
            if (null == user) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("请重新登录！");
                return jsonObject;
            }
//            bean.setParam3(user.getPhone());//add by xiaoyl 2019-08-22 将送检人联系电话写入抽样单主表 param3字段，用于收样时根据电话号码查找
//            bean.setSamplingNo(WebConstant.SAMPLING_NUM5);
//            bean.setSamplingDate(new Date());
//            bean.setSamplingUserid(user.getId() + "");
//            bean.setSamplingUsername(user.getRealName());
//            bean.setStatus((short) 0);
//            bean.setPersonal((short) 2);
//            bean.setCheckMoney(bean.getInspectionFee());
//            bean.setOrderPlatform((short) 0);
//            bean.setOrderStatus((short) 1);
//            if(user.getUserType()==0) {
//            	bean.setInspectionCompany(user.getRealName());
//            }else {
//            	bean.setInspectionId(user.getId());
//            	bean.setInspectionCompany(user.getInspectionName());
//            }
        	List<TbSamplingDetail> listDetail = bean.getSamplingDetails();
            bean = tbSamplingService.addSampling3(bean, listDetail, user,null);
            Date now = new Date();
//            Income income = new Income(GeneratorOrder.generate(user.getId()), bean.getId(), (short) 0, (short) 0,
//                    bean.getInspectionFee(), user.getId().toString(), now, user.getId().toString(), now);
//            income.setCheckMoney(bean.getInspectionFee());
//            incomeService.insertSelective(income);
//            jsonObject.setObj(income);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("samplingId", bean.getId());
//            map.put("samplingNo", bean.getSamplingNo());
            jsonObject.setAttributes(map);
        } catch (MyException e) {
            log.error("**************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            log.error("**************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("结算失败，请联系工作人员。");

        }
        logUtil.saveOperatorLog((short) 0, ModularConstant.OPERATION_MODULE_ORDER, OrderController.class.toString(), "save", "生成订单", jsonObject.isSuccess(), jsonObject.getMsg(), request);
        return jsonObject;
    }

    /**
     * 校验样品袋条形码是否重复
     *
     * @param sampleTubeCode
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月10日
     */
    @RequestMapping("/queryByCheck")
    @ResponseBody
    public AjaxJson queryByCheck(String sampleTubeCode, HttpServletResponse response) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            List<TbSamplingDetail> tsd = samplingDetailService.queryByBarCode(sampleTubeCode);
            if (tsd.size() > 0) {
                ajaxJson.setSuccess(false);
                ajaxJson.setMsg(sampleTubeCode + "已被占用，请更换样品码扫描");
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return ajaxJson;
    }
    /**************************游客模式*************************************/
    /**
     * 游客模式进入下单页面
     *
     * @return
     */
    @RequestMapping("/visitorlist")
    public ModelAndView visitorlist(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        return new ModelAndView("/terminal/order/visitorlist", map);
    }
    /***************************交易单号查询订单信息*******************************************/
    /**
     * 	订单管理
     *
     * @return
     */
    @RequestMapping("/queryList")
    public ModelAndView queryList(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        return new ModelAndView("/terminal/order/queryList", map);
    }
    /**
     * 订单管理数据
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping(value = "/queryOrderDatagrid")
    @ResponseBody
    public AjaxJson queryOrderDatagrid(TbSamplingModel model, Page page,  @RequestParam(required = false) Short checkStatus,
                                       @RequestParam(required = false) Short checkProgress,
                                       @RequestParam(required = false) String beginDate,
                                       @RequestParam(required = false) String endDate,
                                       @RequestParam(required = false) String keyWords) {
        AjaxJson jsonObj = new AjaxJson();
        try {

            model.setCheckStatus(checkStatus);
            model.setCheckProgress(checkProgress);
            model.setSamplingStartDate(beginDate);
            model.setSamplingEndDate(endDate);
            model.setKeyWords(keyWords);

            //高级搜索时间范围，覆盖默认时间范围
            Map<String, String> dateMap = page.getDateMap();
            if (null != dateMap) {
                if (StringUtil.isNotEmpty(dateMap.get("samplingStartDate"))) {
                    model.setSamplingStartDate(dateMap.get("samplingStartDate"));
                }
                if (StringUtil.isNotEmpty(dateMap.get("samplingEndDate"))) {
                    model.setSamplingEndDate(dateMap.get("samplingEndDate"));
                }
            }
//          page = tbSamplingService.loadDatagrid(page, model, TbSamplingMapper.class, "loadDatagridQueryOrder", "getRowTotalQueryOrder");

            page=tbSamplingService.loadDatagrid2(page,model);
            jsonObj.setObj(page);
            page.setObj(model);
            double totalMoney=tbSamplingService.queryTotalMoney2(page);
            jsonObj.setResultCode(totalMoney+"");
            //System.out.println("totalmoney"+totalMoney);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

  /***************************************************一单多用下单开始************************************************************/
    /**
     * 终端下单
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/terminalOrderMultipurpose")
    public ModelAndView terminalOrderMultipurpose(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sampleWeight", SystemConfigUtil.SAMPLE_WEIGHT_CONFIG.getString("detail"));
        //是否显示进货数量字段
        map.put("showPurchaseNumber",SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        InspectionUnitUser userInfo = (InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
        int isConfig=0;//是否为送检单位配置委托单位，0未配置，1已配置
       	if(userInfo==null) {
       		return new ModelAndView("/terminal/index", map);
       	}else {
       		if(null!=userInfo.getInspectionId()) {//查询是否有配置委托单位
       			List<InsUnitReqUnit> list=insUnitReqUnitService.loadInspectionUnit(userInfo.getInspectionId(), null, null);
       			if(list!=null && list.size()>0) {
       				isConfig=1;
       			}
       			map.put("isConfig", isConfig);
       		}
       		//根据送检单位查询报告费单价
       		InspectionReportPrice bean=reportPriceService.queryByInspectionUnitId(userInfo.getInspectionId());
       		map.put("bean", bean);
       	}
        return new ModelAndView("/terminal/order/terminalOrderMultipurpose", map);
    }
    
    @RequestMapping(value = "/saveMulti")
    @ResponseBody
    public AjaxJson saveMulti(TbSampling bean, String details,String requestList,Double reportPrice, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
           if (null == user) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("请重新登录！");
                return jsonObject;
            }
            List<InspectionUnitUserRequester> requestLists=JSONArray.parseArray(requestList, InspectionUnitUserRequester.class);
            int number=requestLists.size()-1;//委托单位数量
//            Double checkMoney=bean.getInspectionFee();//检测费用
//            double reportFee=number*reportPrice;//报告费用
//        	bean.setInspectionFee(checkMoney+reportFee);
//            bean.setParam3(user.getPhone());//add by xiaoyl 2019-08-22 将送检人联系电话写入抽样单主表 param3字段，用于收样时根据电话号码查找
//            bean.setSamplingNo(WebConstant.SAMPLING_NUM5);
//            bean.setSamplingDate(new Date());
//            bean.setSamplingUserid(user.getId() + "");
//            bean.setSamplingUsername(user.getRealName());
//            bean.setStatus((short) 0);
//            bean.setPersonal((short) 2);
//            bean.setOrderPlatform((short) 0);
//            bean.setOrderStatus((short) 1);
//            bean.setCheckMoney(checkMoney);
//            if(user.getUserType()==0) {
//            	bean.setInspectionCompany(user.getRealName());
//            }else {
//            	bean.setInspectionId(user.getId());
//            	bean.setInspectionCompany(user.getInspectionName());
//            }
        	List<TbSamplingDetail> listDetail = bean.getSamplingDetails();
            bean = tbSamplingService.addSampling3(bean, listDetail, user,requestLists);
            Date now = new Date();
//            Income income = new Income(GeneratorOrder.generate(user.getId()), bean.getId(), (short) 0, (short) 0,
//            		bean.getInspectionFee(), reportFee,checkMoney,user.getId().toString(), now, user.getId().toString(), now,number+"份报告，报告单价："+reportPrice+",报告费合计："+(number*reportPrice));
//            incomeService.insertSelective(income);
//            jsonObject.setObj(income);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("samplingId", bean.getId());
//            map.put("samplingNo", bean.getSamplingNo());
            jsonObject.setAttributes(map);
        } catch (MyException e) {
            log.error("**************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg(e.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            log.error("**************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("结算失败，请联系工作人员。");

        }
        logUtil.saveOperatorLog((short) 0, ModularConstant.OPERATION_MODULE_ORDER, OrderController.class.toString(), "save", "生成订单", jsonObject.isSuccess(), jsonObject.getMsg(), request);
        return jsonObject;
    }

  /***************************************************一单多用下单结束************************************************************/
}
