package com.dayuan.controller.data;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.data.TbCheckPlan;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.controller.dataCheck.ImportDataCheckController;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.BaseFoodTypeModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.model.system.TSOperationModel;
import com.dayuan.service.data.BaseFoodItemService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.data.TbCheckPlanService;
import com.dayuan.util.GlobalConfig;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.util.ModularConstant;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Description 检测计划管理
 * @Author xiaoyl
 * @Date 2025/7/25 10:32
 */
@RestController
@RequestMapping("/checkPlan")
public class TbCheckPlanController extends BaseController {
	private final Logger log = Logger.getLogger(TbCheckPlanController.class);
	@Autowired
	private TbCheckPlanService checkPlanService;
	/**
	 * 列表
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(){
		Map<String, Object> map=new HashMap<>();
		return new ModelAndView("/data/checkPlan/list",map);
	}

	/**
	 * 数据列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/datagrid")
	public AjaxJson datagrid(BaseModel model, Page page) throws Exception{
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("desc");
			page = checkPlanService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * @return
	 */
	@RequestMapping("/add")
	public ModelAndView add(@RequestParam(required = false)Integer id,Integer foodId,String foodName){
		Map<String, Object> map=new HashMap<>();
		map.put("id",id);
		map.put("foodId",foodId);
		map.put("foodName",foodName);
		return new ModelAndView("/data/checkPlan/add",map);
	}

	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	public AjaxJson queryById(Integer id){
		AjaxJson jsonObject = new AjaxJson();
		TbCheckPlan bean;
		try {
			bean = checkPlanService.queryById(id);
			if (bean == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
		}
		return jsonObject;
	}
	/**
	 * 新增/修改方法
	 * @param bean
	 * @return
	 */
	@RequestMapping(value="/save")
	public  AjaxJson save(TbCheckPlan bean){
		AjaxJson jsonObject = new AjaxJson();
		try {
			int result = checkPlanService.mySaveOrUpdate(bean);
			if (result == -1) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("保存失败,样品配置重复!");
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}

	/**
	 * 删除数据，单条删除与批量删除通用方法
	 * @param ids 要删除的数据记录id集合
	 * @return
	 */
	@RequestMapping("/delete")
	public AjaxJson delete(String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			if (StringUtil.isNotEmpty(ids)) {
				String[] ida = ids.split(",");
				Integer[] idas = new Integer[ida.length];
				for (int i = 0; i < ida.length; i++) {
					idas[i] = Integer.parseInt(ida[i]);
				}
				checkPlanService.deleteData(PublicUtil.getSessionUser().getId(), idas);
			} else {
				jsonObj.setSuccess(false);
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
}
