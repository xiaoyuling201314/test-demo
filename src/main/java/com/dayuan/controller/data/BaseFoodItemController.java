package com.dayuan.controller.data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseFoodItemModel;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.data.BaseFoodItemService;
import com.dayuan.service.data.BaseFoodTypeService;

/**
 * 食品分类管理
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月10日
 */
@RestController
@RequestMapping("/data/foodType/detectItem")
public class BaseFoodItemController extends BaseController {
	private final Logger log=Logger.getLogger(BaseFoodItemController.class);
	@Autowired
	private BaseFoodItemService baseFoodItemService;
	@Autowired
	private BaseFoodTypeService baseFoodTypeService;
	@Autowired
	private BaseDetectItemService baseDetectItemService;
	/**
	 * 进入食品分类页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView  list(HttpServletRequest request,HttpServletResponse response,Integer id){
		Map<String, Object> map=new HashMap<>();
		try {
			BaseFoodType bean=baseFoodTypeService.getById(id);
			map.put("foodId", bean);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/data/foodType/detectItem/list",map);
	}
	/**
	 * 数据列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(BaseFoodItemModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("desc");
			page = baseFoodItemService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 添加/修改食品信息
	 * @param bean
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public  AjaxJson save(BaseFoodItem bean,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			PublicUtil.setCommonForTable(bean, false);
			if(bean.getUseDefault()==0){//使用默认值
				bean.setDetectSign("");
				bean.setDetectValue("");
				bean.setDetectValueUnit("");
			}
			baseFoodItemService.updateById(bean);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(String id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			BaseFoodItem bean  = baseFoodItemService.getById(id);
			if(bean  == null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 	删除数据，单条删除与批量删除通用方法
	 *      删除样品种类的检测项目时同时删除子类的配置
	 * @param request
	 * @param response
	 * @param ids 要删除的数据记录id集合
	 * @param isDeleteChild 是否删除该子类的检测项目
	 * @return
	 * @author xiaoyl
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response, String ids,
			@RequestParam(required = false,defaultValue = "false") Boolean isDeleteChild, String foodIds){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = null;
			if (ids == null) {
				ida = new String[]{""};
			} else {
				ida = ids.split(",");
			}
			if(isDeleteChild) {//需要删除子类
				String[] foodIds1 = foodIds.split(",");
				for (String foodId1 : foodIds1) {
					List<Integer> foodIds2 = baseFoodTypeService.querySonFoods(Integer.parseInt(foodId1));
					for (String id : ida) {
						if ("".equals(id.trim())) {
							baseFoodItemService.deleteBatch(null, foodIds2);
						} else {
							BaseFoodItem bean=baseFoodItemService.getById(id);
							baseFoodItemService.deleteBatch(bean.getItemId(), foodIds2);
						}
					}
				}
			}else {//已经是样品名称了，直接删除就可以了
				for (String id : ida) {
					baseFoodItemService.removeById(id);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 新增检测项目
	 * @param request
	 * @param response
	 * @param ids
	 * @return
	 */
	@RequestMapping("/addDetectItem")
	@ResponseBody
	public AjaxJson addDetectItem(String detectItemList,Integer foodId,HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] idList = detectItemList.split(",");
			BaseFoodItem bean=new BaseFoodItem();
			bean.setUseDefault(0);
			bean.setChecked(1);
			PublicUtil.setCommonForTable(bean, true);

			for (String id : idList) {
				BaseDetectItem foodItem=baseDetectItemService.getById(id);
				bean.setItemId(id);
				bean.setDetectSign(foodItem.getDetectSign());
				bean.setDetectValue(foodItem.getDetectValue());
				bean.setDetectValueUnit(foodItem.getDetectValueUnit());
				bean.setRemark(foodItem.getRemark());

				List<Integer> foodIds = baseFoodTypeService.querySonFoods(foodId);
				String[] b = new String[foodIds.size()];
				for (int i=0; i<foodIds.size(); i++) {
					b[i] = foodIds.get(i).toString();
				}

				List<BaseFoodItem> list=baseFoodItemService.queryList(bean, b);
				
				for (int i = 0; i < list.size(); i++) {
					int baseFoodItems=baseFoodItemService.selectByFoodId(list.get(i).getFoodId(),id);
					if(baseFoodItems>0){
						list.remove(i);
						i--;
					}
				}
				baseFoodItemService.insertBean(list);
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	@RequestMapping("/querylength")
	@ResponseBody
	public AjaxJson queryLength(String detectItemList,Integer foodId,HttpServletRequest request,HttpServletResponse response,String ids) {
		AjaxJson jsonObj = new AjaxJson();
		try {

			List<Integer> foodIds = baseFoodTypeService.querySonFoods(foodId);
			jsonObj.setObj(foodIds.size());
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	@RequestMapping("/queryList")
	@ResponseBody
	public AjaxJson queryList(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {

			List<Integer> foodIds = baseFoodTypeService.querySonFoods(15);
			String[] b = new String[foodIds.size()];
			for (int i=0; i<foodIds.size(); i++) {
				b[i] = foodIds.get(i).toString();
			}

			BaseFoodItem bean=new BaseFoodItem();
			bean.setItemId("123");
			bean.setDetectSign("123");
			bean.setUseDefault(0);
			bean.setChecked(1);
			List<BaseFoodItem> list=baseFoodItemService.queryList(bean,b);
			jsonObj.setObj(list);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 查询样品种类的检测项目
	 * @param foodId 样品ID
	 * @return
	 */
	@RequestMapping("/queryListByFoodId")
	@ResponseBody
	public AjaxJson queryListByFoodId(Integer foodId) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<BaseFoodItem> foodItems = baseFoodItemService.queryListByFoodId(foodId);
			jsonObj.setObj(foodItems);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
}
