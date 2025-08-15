package com.dayuan3.common.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.controller.BaseController;
import com.dayuan3.common.bean.InspectionReportPrice;
import com.dayuan3.common.service.InspectionReportPriceService;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.terminal.model.InspectionUnitModel;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.terminal.service.RequesterUnitService;

/** 
* @author yzh
* @Date 2020年1月8日 
* 报告费单价
*/

@Controller
@RequestMapping("/InspectionReportPrice")
public class InspectionReportPriceController extends BaseController{

	private Logger log = Logger.getLogger(InspectionReportPriceController.class);
	
	@Autowired
	InspectionReportPriceService inspectionReportPriceService;
    @Autowired
    private RequesterUnitService requesterUnitService;
	@Autowired
	private InspectionUnitService inspectionUnitService;
	
	@RequestMapping("/list")
	public String list(){
		return "/InspectionReportPrice/list";
	}
	
	 /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/data")
    @ResponseBody
    public AjaxJson data(InspectionReportPrice model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = inspectionReportPriceService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
    
    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(InspectionReportPrice ins) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        if(ins.getInspectionUnitId()==null){
        	ins.setInspectionUnitId(0);
        }
        try { 
        	if(ins.getId()!=null){
        		inspectionReportPriceService.updateById(ins);
        	}else{
        	inspectionReportPriceService.insert(ins);
        	}
        	jsonObject.setSuccess(true);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }
    
    @RequestMapping(value = "/add")
    public String add(InspectionReportPrice ins, Model model) throws Exception {
        List<InspectionUnit> list = inspectionUnitService.getReqInsUtil(new InspectionUnitModel());
        model.addAttribute("model", "add");
        model.addAttribute("unitList", list);
        return "/InspectionReportPrice/inspectionReportPriceForm";
    }
    
    @RequestMapping(value = "/edit")
    public String edit(InspectionReportPrice ins, Model model) throws Exception {     
        InspectionReportPrice ins2 = inspectionReportPriceService.queryById(ins.getId());
        model.addAttribute("ins", ins2);
        model.addAttribute("model", "edit");
        InspectionUnitModel insmodel =new InspectionUnitModel();
        insmodel.setId(ins.getId());
        List<InspectionUnit> list = inspectionUnitService.getReqInsUtil(insmodel);

        model.addAttribute("unitList", list);
        return "/InspectionReportPrice/inspectionReportPriceForm";
    }
    
    @RequestMapping(value = "/view")
    public String view(InspectionReportPrice ins, Model model) throws Exception {     
        InspectionReportPrice ins2 = inspectionReportPriceService.queryById(ins.getId());
        model.addAttribute("ins", ins2);
        model.addAttribute("model", "view");
        InspectionUnitModel insmodel =new InspectionUnitModel();
        insmodel.setId(ins.getId());
        List<InspectionUnit> list = inspectionUnitService.getReqInsUtil(insmodel);

        model.addAttribute("unitList", list);
        return "/InspectionReportPrice/inspectionReportPriceForm";
    }
    
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
        	inspectionReportPriceService.delete(ids);
        } catch (Exception e) {
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
}
