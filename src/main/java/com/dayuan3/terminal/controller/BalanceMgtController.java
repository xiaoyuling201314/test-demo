package com.dayuan3.terminal.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MyException;
import com.dayuan3.admin.mapper.InspectionUnitUserMapper;
import com.dayuan3.common.mapper.AccountFlowMapper;
import com.dayuan3.common.service.AccountFlowService;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.model.BalanceModel;
import com.dayuan3.terminal.model.FlowModel;
import com.dayuan3.terminal.service.IncomeService;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.terminal.service.RequesterUnitTypeService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 平台-余额管理
 *
 * @author Dz
 * @date 2019年10月30日
 */
@Controller
@RequestMapping("/balanceMgt")
public class BalanceMgtController extends BaseController {
    private Logger log = Logger.getLogger(BalanceMgtController.class);

    @Autowired
    private InspectionUnitUserService inspectionUnitUserService;
    @Autowired
    private InspectionUserAccountService accountService;
    @Autowired
    private AccountFlowService flowService;
    @Autowired
    private IncomeService incomeService;
    
    @Autowired
    private RequesterUnitTypeService requesterTypeService;

    @RequestMapping("/list")
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response) {
    	 Map<String, Object> map=new HashMap<String, Object>(); 
    	List<RequesterUnitType> list = requesterTypeService.queryAllType();
         map.put("reqListType", list);  //单位类型
        return new ModelAndView("/terminal/balance/management/list",map);
    }

    /**
     * 余额管理数据
     *
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(Page page, BalanceModel model) {
        AjaxJson jsonObj = new AjaxJson();
        try {
//			page = inspectionUnitUserService.loadDatagrid(page, model,
//					InspectionUnitUserMapper.class, "loadDatagrid", "getRowTotal");
            page = accountService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     * 余额流水
     *
     * @param userId   用户ID
     * @return
     */
    @RequestMapping("/flow")
    public ModelAndView flow(Integer userId,Short isok) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("isok", isok);
        return new ModelAndView("/terminal/balance/management/flow", map);
    }

    /**
     * 余额流水数据
     *
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "/flowDatagrid")
    @ResponseBody
    public AjaxJson flowDatagrid(Page page, FlowModel model) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = flowService.loadDatagrid(page, model,
                    AccountFlowMapper.class, "loadDatagridBalance", "getRowTotalBalance");
            jsonObj.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @Autowired
    private CommonLogUtilService logUtil;

    /**
     * 后台操作修改余额
     *
     * @param income 此处的ID为 送检用户余额表 inspection_user_account.id
     * @return
     */
    @RequestMapping({"/addOrUpdateMoney"})
    @ResponseBody
    public AjaxJson addOrUpdateMoney(Income income, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            incomeService.addOrUpdateMoney(income);
            //保存支付日志
            logUtil.savePayLog(income.getNumber(), (short) 2, (short) 2, income.getTransactionType(), Double.valueOf(income.getMoney() + ""), ModularConstant.OPERATION_MODULE_BACKSTAGE, BalanceMgtController.class.toString(), "addOrUpdateMoney",
                    "操作余额", true, "操作成功", request);
            //保存操作日志
            logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_BACKSTAGE, BalanceMgtController.class.toString(), "addOrUpdateMoney", "操作余额",
                    true, "操作成功", request);
        } catch (MyException me) {
            logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_BACKSTAGE, BalanceMgtController.class.toString(), "addOrUpdateMoney", "操作余额",
                    false, me.getMessage(), request);
            me.printStackTrace();
            log.error("******************************" + me.getMessage() + me.getStackTrace());
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg(me.getMessage());
        } catch (Exception e) {
            logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_BACKSTAGE, BalanceMgtController.class.toString(), "addOrUpdateMoney", "操作余额",
                    false, e.getMessage(), request);
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg("操作失败！");
        }
        return ajaxJson;
    }
}
