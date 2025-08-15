package com.dayuan3.common.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan3.common.bean.TakeSamplingPrice;
import com.dayuan3.common.service.TakeSamplingPriceService;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.service.RequesterUnitService;

import groovy.util.logging.Slf4j;

/** 
* @author yzh
* @Date 2020年3月2日 
* 功能描述
*/
@Slf4j
@Controller
@RequestMapping("/dayuan3/common/takeSamplingPrice")
public class TakeSamplingPriceController {
	
	Logger log = LoggerFactory.getLogger(TakeSamplingPriceController.class);
	
	
	@Autowired
	TakeSamplingPriceService servie;
	
	@Autowired
	RequesterUnitService requesterUnitService;
	
	@RequestMapping("/list")
	public String list(){
		return "/TakeSamplingPrice/list";
	}
	
	 /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/data")
    @ResponseBody
    public AjaxJson data(TakeSamplingPrice model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = servie.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
	
	@ResponseBody
	@RequestMapping("save")
	public AjaxJson save(TakeSamplingPrice t) throws Exception {
		AjaxJson jsonObject = new AjaxJson();
        if(t.getRequesterUnitId()==null){
        	t.setRequesterUnitId(0);
        }
		try {
        	if(t.getId()!=null){
        		servie.updateById(t);
        	}else{
        		servie.insert(t);
        	}
        	jsonObject.setSuccess(true);
		} catch (Exception e) {
            log.error("******************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
		}
		
		return jsonObject;
	}
	

	
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
           servie.delete(ids);
        } catch (Exception e) {
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
	
	@ResponseBody
	@RequestMapping("/update")
	public AjaxJson update(@RequestBody TakeSamplingPrice t){
		AjaxJson jsonObject = new AjaxJson();
		try {
			servie.updateById(t);;
		} catch (Exception e) {
            log.error("******************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	

    @RequestMapping(value = "/add")
    public String add(TakeSamplingPrice ins, Model model) throws Exception {
        List<RequesterUnit> list = requesterUnitService.queryAll(null);
        model.addAttribute("model", "add");
        model.addAttribute("unitList", list);
        return "takeSamplingPriceForm";
       }
    
    @RequestMapping(value = "/edit")
    public String edit(TakeSamplingPrice ins, Model model) throws Exception {     
    	TakeSamplingPrice ins2 = servie.queryById(ins.getId());
        model.addAttribute("ins", ins2);
        model.addAttribute("model", "edit");

        List<RequesterUnit> list = requesterUnitService.queryAll(null);

        model.addAttribute("unitList", list);
        return "takeSamplingPriceForm";    }
    
    @RequestMapping(value = "/view")
    public String view(TakeSamplingPrice ins, Model model) throws Exception {     
    	TakeSamplingPrice ins2 = servie.queryById(ins.getId());
        model.addAttribute("ins", ins2);
        model.addAttribute("model", "view");

        List<RequesterUnit> list = requesterUnitService.queryAll(null);


        model.addAttribute("unitList", list);
        return "takeSamplingPriceForm";
        }
	
	

}
