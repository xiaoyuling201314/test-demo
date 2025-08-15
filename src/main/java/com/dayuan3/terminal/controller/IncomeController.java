package com.dayuan3.terminal.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.controller.BaseController;
import com.dayuan.controller.statistics.StatisticsController.timeModel;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.StringUtil;
import com.dayuan3.pretreatment.model.TbSamplingModel;
import com.dayuan3.terminal.model.IncomeModel;
import com.dayuan3.terminal.service.IncomeService;

/**
 * 费用管理
 * @author xiaoyl
 * @date   2019年7月30日
 */
@Controller
@RequestMapping("/income")
public class IncomeController extends BaseController {
	private Logger log = Logger.getLogger(IncomeController.class);

	@Autowired
	private TbSamplingService tbSamplingService;
	
	@Autowired
	private IncomeService incomeService;
	  /**
     * 收费明细管理
     * @return
     */
    @RequestMapping("/moneyStatistics")
    public String moneyStatistics(Model model){

        return "/terminal/income/moneyStatistics";
    }
    /**
     * 	收费汇总数据
     * @description
     * @param model
     * @param page
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start 自定义开始时间
     * @param end	自定义结束时间
     * @return
     * @author xiaoyl
     * @date   2019年9月24日
     */
    @RequestMapping(value="/datagrid")
    @ResponseBody
    public AjaxJson datagrid(Page page,String type,String month,String season,String year,String start,String end
//    		,String checkDateStartDateStr,String checkDateEndDateStr
    		){
        AjaxJson jsonObj = new AjaxJson();
        try {
        	IncomeModel model=formatTime(type,month,season,year,start,end);
//        	model.setCheckDateEndDateStr(checkDateStartDateStr);
//        	model.setCheckDateEndDateStr(checkDateEndDateStr);
            page = incomeService.loadDatagrid(page, model, IncomeService.class, "loadDatagridForStatistics", "getRowTotalForStatistics");
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************"+e.getMessage()+e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
    /**
     * 收费明细管理
     * @return
     */
    @RequestMapping("/samplingList")
    public ModelAndView samplingList(String payDate,Model model){
    	Map<String, Object> map=new HashMap<String, Object>();
    	map.put("payDate", payDate);
        return new ModelAndView("/terminal/income/samplingList",map);
    }
    /**
	 * 收费明细数据
	 * @param model
	 * @param page
	 * @return
	 */
    @RequestMapping(value="/samplingDatagrid")
    @ResponseBody
    public AjaxJson samplingDatagrid(TbSamplingModel model, Page page){
        AjaxJson jsonObj = new AjaxJson();
        try {
			/*
			 * if(model.getTbSampling()==null) { model.getTbSampling().setCreateBy("10001");
			 * }
			 */
//            page = tbSamplingService.loadDatagrid(page, model, TbSamplingService.class, "loadDatagridForIncome", "getRowTotalForIncome");
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************"+e.getMessage()+e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 收费明细管理
     * @return
     */
    @RequestMapping("/detailList")
    public ModelAndView list(String samplingId,String payDate){
    	Map<String, Object> map=new HashMap<String, Object>();
    	try {
    		TbSampling bean= tbSamplingService.getById(Integer.valueOf(samplingId));
    		map.put("bean", bean);
    		//map.put("samplingId", samplingId);
    		map.put("payDate", payDate);
		} catch (Exception e) {
			log.info("查询异常"+e.getMessage());
		}
    	
        return new ModelAndView("/terminal/income/detail",map);
    }

	/**
	 * 收费明细数据
	 * @param model
	 * @param page
	 * @return
	 */
    @RequestMapping(value="/detailDatagrid")
    @ResponseBody
    public AjaxJson detailDatagrid(IncomeModel model, Page page){
        AjaxJson jsonObj = new AjaxJson();
        try {
        	page.setOrder("desc");
            page = incomeService.loadDatagrid(page, model, IncomeService.class, "loadDatagridForIncome", "getRowTotalForIncome");
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************"+e.getMessage()+e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

	/**
	 * 查看订单详情
	 * @param id 订单ID
	 * @return
	 */
	@RequestMapping("/details")
	public ModelAndView details(Integer id){
		Map<String,Object> map = new HashMap<String,Object>();
		TbSampling sampling = null;
		try {
			if(StringUtil.isNotEmpty(id)){
				sampling = tbSamplingService.getById(id);
			}
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
		}

		map.put("sampling", sampling);
		return new ModelAndView("/terminal/order/orderDetail",map);
	}
	/**
	 * 拼接时间
	 * @param type
	 * @param month
	 * @param season
	 * @param year
	 * @param start
	 * @param end
	 * @return
	 */
	public IncomeModel formatTime(String type,String month,String season,String year,String start,String end){
		IncomeModel model=new IncomeModel();
		Calendar cal = Calendar.getInstance();
		if(type.equals("month")){
			if(month.length()<2){
				month="0"+month;
			}
			start=year+"-"+month+"-01";
			end=year+"-"+month+"-31 23:59:59";
		}else if (type.equals("season")) {
			if(season.equals("1")){
				start=year+"-01-01";
				end=year+"-03-31 23:59:59";
			}else if (season.equals("2")) {
				start=year+"-04-01";
				end=year+"-06-30 23:59:59";
			}else if (season.equals("3")) {
				start=year+"-07-01";
				end=year+"-09-30 23:59:59";
			}else if (season.equals("4")) {
				start=year+"-10-01";
				end=year+"-12-31 23:59:59";
			}
		}else if (type.equals("year")) {
			start=year+"-01-01";
			end=year+"-12-31 23:59:59";
		}else if (type.equals("diy")) {
			end=end+" 23:59:59";
		}
		
		model.setStartDateStr(start);
		model.setEndDateStr(end);
		return model;
	}
}