package com.dayuan.controller.data;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.controller.dataCheck.ImportDataCheckController;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.data.BaseFoodTypeModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.data.BaseFoodItemService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.util.GlobalConfig;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.util.ModularConstant;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Controller;
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
 * 食品分类管理 Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月10日
 */
@RestController
@RequestMapping("/data/foodType")
public class BaseFoodTypeController extends BaseController {
	private final Logger log = Logger.getLogger(BaseFoodTypeController.class);
	@Autowired
	private BaseFoodTypeService baseFoodTypeService;
	@Autowired
	private BaseFoodItemService baseFoodItemService;
	@Autowired
	private CommonLogUtilService logUtil;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	/**
	 * 进入食品分类页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list() {
		return new ModelAndView("/data/foodType/list");
	}

	/**
	 * 食品种类维护使用
	 * 获取食品分类树形数据
	 * @param id 父类别ID
	 * @return
	 */
	@RequestMapping("/foodTree")
	public List<TreeNode> foodTree(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(required = false) Integer id) {
		TreeNode node = null;
//		if (StringUtil.isEmpty(id)) {
//			id = "";
//		}
		Boolean isContainSelf=false;
		Boolean isShowFood=false;
		List<TreeNode> departTree = baseFoodTypeService.queryFoodTree(id,isContainSelf,isShowFood,null);
		/*if (null == id) {
			node = new TreeNode();
			node.setId("");
			node.setText("食品种类");
			node.setChildren(departTree);
			List<TreeNode> departTree2 = new ArrayList<>();
			departTree2.add(node);
			return departTree2;
		}*/
		return departTree;
	}
	
	@RequestMapping("/foodTrees")
	public List<TreeNode> foodTrees(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(required = false) Integer id) {
		TreeNode node = null;

		Boolean isContainSelf=null;
		Boolean isShowFood=false;
		List<TreeNode> departTree = baseFoodTypeService.queryFoodTrees(id,isContainSelf,isShowFood,null);
		/*if (StringUtil.isEmpty(id)) {
			node = new TreeNode();
			node.setId("");
			node.setText("食品种类");
			node.setChildren(departTree);
			List<TreeNode> departTree2 = new ArrayList<>();
			departTree2.add(node);
			return departTree2;
		}*/
		return departTree;
	}

	/**
	 * 根据食品类别ID加载食品分类列表信息（包括当前类别）
	 * @param id 类别ID
	 * @return
	 */
	@RequestMapping("/queryFoodType")
	public AjaxJson queryFoodType(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(required = false) Integer id) {
		AjaxJson jsonObj = new AjaxJson();
		if (null==id) {
			// id = "";
		}
		List<BaseFoodType> list = baseFoodTypeService.queryFoodType(id);
		jsonObj.setObj(list);
		return jsonObj;
	}

	/**
	 * 数据列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/datagrid")
	public AjaxJson datagrid(BaseFoodTypeModel model, Page page, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			//没有样品名称关键词
			if (StringUtils.isBlank(model.getKeyWords())) {

				//前端没传入查询样品父类ID
				if (model.getBaseBean()==null ) {
					//获取根节点样品种类
					List<BaseFoodType> f0 = baseFoodTypeService.selectByParentId(null, 0);
					if (f0 != null && f0.size()>0) {
						BaseFoodType f = new BaseFoodType();
						f.setParentId(f0.get(0).getId());
						model.setBaseBean(f);
					}
				} else if (model.getBaseBean().getParentId()==null) {
					//获取根节点样品种类
					List<BaseFoodType> f0 = baseFoodTypeService.selectByParentId(null, 0);
					BaseFoodType f = model.getBaseBean();
					if (f0 != null && f0.size()>0) {
						f.setParentId(f0.get(0).getId());
						model.setBaseBean(f);
					}
				}

			}

			page = baseFoodTypeService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 添加/修改食品信息
	 * @param bean
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	@SystemLog(module = "样品管理",methods = "新增与编辑",type = 1,serviceClass = "baseFoodTypeServiceImpl",parameterType = "Serializable",queryMethod = "getById")
	public AjaxJson save(BaseFoodType bean, HttpServletRequest request, String isExtends) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			//已存在食品
			BaseFoodType food = baseFoodTypeService.queryByFoodName(bean.getFoodName(), bean.getParentId());
			//新增食品父类
			BaseFoodType pfood = baseFoodTypeService.getById(bean.getParentId());

			//新增数据
			if (null == bean.getId()) {
				//样品编码；食品种类生成新编码，食品名称使用上级编码；修改后，食品名称不再有数量限制 -Dz 20220228
				String code = "";
				//同级数据，新增样品查询同级种类，新增种类查询同级样品
				List<BaseFoodType> list = null;

				switch (bean.getIsfood()) {
					//0是食品种类,生成新编码
					case 0:
						String lastCode = baseFoodTypeService.getLastFoodCode(pfood.getFoodCode());
						code = GlobalConfig.getInstance().getNextCode(4, lastCode, pfood.getFoodCode());
						if(code.equals("0")){
							jsonObject.setSuccess(false);
							jsonObject.setMsg("该类别的下的食品种类已超过一万,无法继续添加,请联系管理员处理！");
							logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品新增", jsonObject.isSuccess(), jsonObject.getMsg(),null,bean,request);
							return jsonObject;
						}
						//新增种类查询同级样品
						list = baseFoodTypeService.queryFoodMap(bean.getParentId());
						break;

					//1是食品名称,使用上级编码
					case 1:
						code = pfood.getFoodCode();
						//新增样品查询同级种类
						list = baseFoodTypeService.queryFoodTypeMap(bean.getParentId());
						break;

					default:
						jsonObject.setSuccess(false);
						jsonObject.setMsg("请选择样品种类类型！");
						logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品新增", jsonObject.isSuccess(), jsonObject.getMsg(),null,bean,request);
						return jsonObject;
				}

				if(list != null && list.size()>0){
					jsonObject.setSuccess(false);
					if (bean.getIsfood() == 0) {
						jsonObject.setMsg("该类别存在食品名称，不允许添加下级类别！");
					} else {
						jsonObject.setMsg("该类别存在下级类别，不允许添加食品名称，请在它的下级类别添加！");
					}
				}else{
					if (food == null) {
						bean.setFoodCode(code);

						//获取父类下最大序号
						Integer nextSorting = baseFoodTypeService.queryMaxSorting(bean.getParentId());
						//设置序号+1
						bean.setSorting(++nextSorting);

						PublicUtil.setCommonForTable(bean, true);
						baseFoodTypeService.save(bean);

						Integer FoodId= bean.getId();
						if(isExtends!=null&&isExtends!=""&&bean.getParentId()!=null){
							if(isExtends.equals("1")){
								List<BaseFoodItem> lists=baseFoodItemService.queryListByFoodId(bean.getParentId());
								if (lists.size()>0) {
									for (BaseFoodItem baseFoodItem : lists) {
										baseFoodItem.setFoodId(FoodId);
										PublicUtil.setCommonForTable(baseFoodItem, true);
									}
									baseFoodItemService.insertBean(lists);
								}
							}
						}
					} else {
						jsonObject.setSuccess(false);
						jsonObject.setMsg("该食品已存在，请重新输入");
					}
				}
				logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品新增", jsonObject.isSuccess(), jsonObject.getMsg(),null,bean,request);

			// 修改数据
			} else {

				BaseFoodType oldFood = baseFoodTypeService.getById(bean.getId());

				if (oldFood == null) {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("找不到样品数据！");
					logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
					return jsonObject;

				//食品移组
				} else if (oldFood.getParentId().intValue() != bean.getParentId().intValue()){
					if(bean.getIsfood()==1){
						//获取新父类下的食品种类
						List<BaseFoodType> list = baseFoodTypeService.queryFoodTypeMap(bean.getParentId());
						if (list.size()>0) {
							jsonObject.setSuccess(false);
							jsonObject.setMsg("该食品类别存在下级类别，不允许添加食品名称，请在它的下级类别添加！");
							logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
							return jsonObject;
						}

					}else if (bean.getIsfood()==0) {
						//获取新父类下的食品名称
						List<BaseFoodType> list2 = baseFoodTypeService.queryFoodMap(bean.getParentId());
						if (list2.size()>0) {
							jsonObject.setSuccess(false);
							jsonObject.setMsg("该食品类别下面存在食品名称，不允许添加食品类别！");
							logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
							return jsonObject;
						}
					}
				}

				// 获取当前食品类别和其下级食品类别ID
				List<BaseFoodType> sFoods = baseFoodTypeService.getAllSonFoodsByID(bean.getId());
				List<Integer> sfoodIds = new ArrayList<Integer>();
				if(sFoods !=null && sFoods.size()>0) {
					for(BaseFoodType sDepart : sFoods) {
						sfoodIds.add(sDepart.getId());
					}
				}
				if (bean.getIsfood()==0 && sfoodIds.contains(bean.getParentId())) {
					// 所属食品类别为当前类别或其下级食品类别
					jsonObject.setSuccess(false);
					jsonObject.setMsg("所属食品类别不能为当前类别或其下级食品类别");
					logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
					return jsonObject;

				} else {
					if (food == null || bean.getId().intValue() == food.getId().intValue()) {

						//样品编码；食品种类生成新编码，食品名称使用上级编码；修改后，食品名称不再有数量限制 -Dz 20220228
						String code = oldFood.getFoodCode();
						switch (bean.getIsfood()) {
							//0是食品种类,生成新编码
							case 0:
								if (oldFood.getParentId().intValue() != bean.getParentId().intValue()) {
									String lastCode = baseFoodTypeService.getLastFoodCode(pfood.getFoodCode());
									code = GlobalConfig.getInstance().getNextCode(4, lastCode, pfood.getFoodCode());
									if(code.equals("0")){
										jsonObject.setSuccess(false);
										jsonObject.setMsg("该类别的下的食品种类已超过一万,无法继续添加,请联系管理员处理！");
										logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
										return jsonObject;
									}
								}
								break;

							//1是食品名称,使用上级编码
							case 1:
								code = pfood.getFoodCode();
								break;

							default:
								jsonObject.setSuccess(false);
								jsonObject.setMsg("请选择样品种类类型！");
								logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
								return jsonObject;
						}

						bean.setFoodCode(code);
						PublicUtil.setCommonForTable(bean, false);
						baseFoodTypeService.updateById(bean);

						//刷新食品编码
						if (oldFood.getParentId().intValue() != bean.getParentId().intValue()) {
							baseFoodTypeService.resetFoodTypeCode(new String[]{bean.getParentId().toString()}, true);
						}

						//继承上级检测项目
						if (isExtends!=null&&isExtends!=""&&bean.getParentId()!=null) {
							if(isExtends.equals("1")){
								List<BaseFoodItem> lists=baseFoodItemService.queryListByFoodId(bean.getParentId());
								if (lists.size()>0) {
									for (BaseFoodItem baseFoodItem : lists) {
										int baseFoodItems=baseFoodItemService.selectByFoodId(bean.getId(),baseFoodItem.getItemId());
										if(baseFoodItems==0){
											baseFoodItem.setFoodId(bean.getId());
											PublicUtil.setCommonForTable(baseFoodItem, true);
											baseFoodItemService.save(baseFoodItem);
										}
									}
								}
							}
						}

					} else {
						jsonObject.setSuccess(false);
						jsonObject.setMsg("该食品已存在，请重新输入");
					}
				}
				logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
			}

		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常");
		}
		Map<String,Object> map=new HashMap<>();
		map.put("id",bean.getId());
		jsonObject.setAttributes(map);
		//更新样品库的时候，重置内存中的样品集合
		ImportDataCheckController.foodMap=null;
		return jsonObject;
	}

	@RequestMapping(value = "/changExtends")
	public AjaxJson changExtends(BaseFoodType bean,HttpSession session, HttpServletRequest request, HttpServletResponse response,String flag) {
		AjaxJson jsonObject = new AjaxJson();
		try {
				//根据所选食品的id查询该食品的信息
				bean = baseFoodTypeService.getById(bean.getId());
				if(null == bean.getParentId()){
					bean.setParentId(null);
				}

				//flag标识，1 继承上级，0 下级继承
				if("1".equals(flag)){
					//如果所选食品有上一级
					 if (bean.getParentId()!=null) {
						 	//则根据父级的id，查询该父级所有的关联的检测项目
							List<BaseFoodItem> lists=baseFoodItemService.queryListByFoodId(bean.getParentId());
							if (lists.size()>0) {
								//循环遍历父级所有的关联的检测项目
								for (BaseFoodItem baseFoodItem : lists) {
									//根据所选食品的id和父级所有的关联的检测项目id，查选食品检测项目关联表中是否已存在该关联
									int baseFoodItems=baseFoodItemService.selectByFoodId(bean.getId(),baseFoodItem.getItemId());
									//如果没有关联，则让所选的食品配置该检测项目
									if(baseFoodItems==0){
										BaseFoodItem baseFoodItem1 = new BaseFoodItem();
										baseFoodItem1.setFoodId(bean.getId());
										baseFoodItem1.setItemId(baseFoodItem.getItemId());
										baseFoodItem1.setDetectSign(baseFoodItem.getDetectSign());
										baseFoodItem1.setDetectValue(baseFoodItem.getDetectValue());
										baseFoodItem1.setDetectValueUnit(baseFoodItem.getDetectValueUnit());
										baseFoodItem1.setChecked(baseFoodItem.getChecked());
										baseFoodItem1.setUseDefault(baseFoodItem.getUseDefault());
										PublicUtil.setCommonForTable(baseFoodItem1, true);
										baseFoodItemService.save(baseFoodItem1);
									}
								}
							}
							bean.setIsextends(1);
							baseFoodTypeService.updateById(bean);
						}
					}else if ("0".equals(flag)) {
						//根据所选食品的id，查询该食品所有的关联的检测项目
						List<BaseFoodItem> lists=baseFoodItemService.queryListByFoodId(bean.getId());
						//查询所选食品的所有下级
						List<Integer> ids=baseFoodTypeService.querySonFoods(bean.getId());

						//循环让所选食品的下级食品添加检测项目
						for (int i = 0; i < ids.size(); i++) {
							for (BaseFoodItem baseFoodItem : lists) {
								int baseFoodItems=baseFoodItemService.selectByFoodId(ids.get(i),baseFoodItem.getItemId());
								if(baseFoodItems==0){
									BaseFoodItem baseFoodItem2 = new BaseFoodItem();
									baseFoodItem2.setFoodId(ids.get(i));
									baseFoodItem2.setItemId(baseFoodItem.getItemId());
									baseFoodItem2.setDetectSign(baseFoodItem.getDetectSign());
									baseFoodItem2.setDetectValue(baseFoodItem.getDetectValue());
									baseFoodItem2.setDetectValueUnit(baseFoodItem.getDetectValueUnit());
									baseFoodItem2.setChecked(baseFoodItem.getChecked());
									baseFoodItem2.setUseDefault(baseFoodItem.getUseDefault());
									PublicUtil.setCommonForTable(baseFoodItem2, true);
									baseFoodItemService.save(baseFoodItem2);
								}
							}
						}
					}
					
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	public AjaxJson queryById(Integer id) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			BaseFoodType bean = baseFoodTypeService.queryFoodById(id);
			if (bean == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}else if(bean.getParentName()==null){
				bean.setParentName("食品种类");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
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
	@SystemLog(module = "样品管理",methods = "删除",type = 3,serviceClass = "baseFoodTypeServiceImpl")
	public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			int count = 0;
			String[] ida = ids.split(",");
			for (String id : ida) {
				count = baseFoodTypeService.queryCount(id);
				if (count > 0) {
					jsonObj.setSuccess(false);
					jsonObj.setMsg("该样品类别下存在相关的子样品，请先将其删除!");
					break;
				} else {
				    //删除样品
					BaseFoodType oldFood= baseFoodTypeService.getById(Integer.parseInt(id));
					BaseFoodType newFood=baseFoodTypeService.delete(Integer.parseInt(id));
					logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "delete", "样品删除", jsonObj.isSuccess(), jsonObj.getMsg(),oldFood,newFood,request);
				}
			}

		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			e.printStackTrace();
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		//更新样品库的时候，重置内存中的样品集合
		ImportDataCheckController.foodMap=null;
		return jsonObj;
	}
	/**
	 * 获取食品类别树形数据（显示样品信息）
	 * @param id 父类别ID
	 * @return
	 */
	@RequestMapping("/queryFoodTree")
	public List<TreeNode> queryFoodTree(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(required = false) Integer id, String topNode,@RequestParam(required = false, defaultValue="1") String showFood) {
		TreeNode node = null;
		Boolean isContainSelf=false;//是否包括当前节点
		Boolean isShowFood=true;//是否显示样品信息
		if("0".equals(showFood)) {	//只显示种类
			isShowFood = false;
		}
		
		List<String> attributes=new ArrayList<>();//给树形菜单增加自定义属性
		attributes.add("isFood");//是否是类别
		List<TreeNode> departTree = baseFoodTypeService.queryFoodTree(id,isContainSelf,isShowFood,attributes);
		
		if("hide".equals(topNode)){
			return departTree;
		}
		
		//设置父节点
		/*if (null ==id) {
			node = new TreeNode();
			node.setId("");
			node.setText("食品种类");
			node.setChildren(departTree);
			List<TreeNode> departTree2 = new ArrayList<>();
			departTree2.add(node);
			return departTree2;
		}*/
		return departTree;
	}
	/**
	 * 查询所有样品种类
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/queryAll")
	public AjaxJson queryAll(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<BaseFoodType> foodTypes = baseFoodTypeService.queryAllFood();
			jsonObj.setObj(foodTypes);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * select2样品数据
	 * @param request
	 * @param response
	 * @param page 页码
	 * @param row 每页数量
	 * @param foodName 样品名称
	 * @return
	 */
	@RequestMapping("/select2FoodData")
	public Map select2FoodData(HttpServletRequest request, HttpServletResponse response,
		Integer page, Integer row, String foodName, Integer isFood) {
		Map map = new HashMap();
		int total = 0;	//总数
		List foods = new ArrayList();	//样品
		try {
			if (foodName != null){
				foodName = foodName.replace("'","");
			}
			//使用浏览器缓存数据，后台不查询
			if (!"本地历史数据".equals(foodName)) {
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT id, IF(food_name_other IS NOT NULL AND food_name_other != '', CONCAT(food_name,'(',food_name_other,')'), food_name) name " +
						" FROM base_food_type  " +
						"WHERE delete_flag = 0 " +
						" AND checked = 1 ");
				if (isFood != null) {
					sql.append(" AND isFood = "+isFood);
				}
				if (StringUtil.isNotEmpty(foodName)) {
					sql.append(" AND food_name = '"+foodName+"' ");
				}

				sql.append(" UNION SELECT id, IF(food_name_other IS NOT NULL AND food_name_other != '', CONCAT(food_name,'(',food_name_other,')'), food_name) name " +
						" FROM base_food_type  " +
						"WHERE delete_flag = 0 " +
						" AND checked = 1 ");
				if (isFood != null) {
					sql.append(" AND isFood = "+isFood);
				}
				if (StringUtil.isNotEmpty(foodName)) {
					sql.append(" AND food_name LIKE '"+foodName+"%' ");
				}

				sql.append(" UNION SELECT id, IF(food_name_other IS NOT NULL AND food_name_other != '', CONCAT(food_name,'(',food_name_other,')'), food_name) name " +
						" FROM base_food_type  " +
						"WHERE delete_flag = 0 " +
						" AND checked = 1 ");
				if (isFood != null) {
					sql.append(" AND isFood = "+isFood);
				}
				if (StringUtil.isNotEmpty(foodName)) {
					sql.append(" AND (food_name LIKE '%"+foodName+"%' OR food_name_other LIKE '%"+foodName+"%') ");
				}
				if (page>0 && row>0) {
					sql.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
				}
				jdbcTemplate.query(sql.toString(), new RowCallbackHandler() {
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						do {
							Map food = new HashMap();
							food.put("id", rs.getInt("id"));	//样品ID
							food.put("name", rs.getString("name"));	//名称+别名
							foods.add(food);
						} while (rs.next());
					}
				});

				sql.setLength(0);
				sql.append("SELECT COUNT(1) FROM base_food_type WHERE delete_flag = 0 AND checked = 1 AND isFood = 1 ");
				if (StringUtil.isNotEmpty(foodName)) {
					sql.append(" AND (food_name LIKE '%"+foodName+"%' OR food_name_other LIKE '%"+foodName+"%') ");
				}
				total = jdbcTemplate.queryForObject(sql.toString(), Integer.class);
			}
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		map.put("foods", foods);
		map.put("total", total);
		return map;
	}

	/**
	 * 移组数据，单条移组与批量移组通用方法
	 * @param request
	 * @param response
	 * @param id 要移组的数据记录id集合
	 * @return
	 */
	@RequestMapping("/changeGroup")
	@SystemLog(module = "样品管理",methods = "移组",type = 0,serviceClass = "baseFoodTypeServiceImpl")
	public AjaxJson changeGroup(HttpServletRequest request, HttpServletResponse response, String id,Integer parentId) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ids = id.split(",");
			BaseFoodType pfood = baseFoodTypeService.getById(parentId);
			if (pfood == null) {
				jsonObj.setSuccess(false);
				jsonObj.setMsg("移组失败，未找到样品种类[ID:"+parentId+"]！");

			} else if (ids != null && ids.length > 0){

				for (int i = 0; i < ids.length; i++) {
					//移组食品
					BaseFoodType food = baseFoodTypeService.getById(Integer.parseInt(ids[i]));

					//判断食品移组是否符合规则
					if (i == 0) {
						List<BaseFoodType> list = baseFoodTypeService.queryFoodTypeMap(parentId);
						if(food.getIsfood()==1 && list.size()>0){
							jsonObj.setSuccess(false);
							jsonObj.setMsg("该类别存在下级类别，不允许有食品名称，请移组到它的下级类别！");
							return jsonObj;
						}
					}

					//样品编码；食品种类生成新编码，食品名称使用上级编码；修改后，食品名称不再有数量限制 -Dz 20220228
					String code = "";
					switch (food.getIsfood()) {
						//0是食品种类,生成新编码
						case 0:
							String lastCode = baseFoodTypeService.getLastFoodCode(pfood.getFoodCode());
							code = GlobalConfig.getInstance().getNextCode(4, lastCode, pfood.getFoodCode());

						//1是食品名称,使用上级编码
						case 1:
							code = pfood.getFoodCode();
							break;
					}

					BaseFoodType foodType = new BaseFoodType();
					foodType.setId(Integer.parseInt(ids[i]));
					foodType.setParentId(parentId);
					foodType.setFoodCode(code);
					PublicUtil.setCommonForTable(foodType,false);
					baseFoodTypeService.updateById(foodType);
				}

				//刷新样品编号
				baseFoodTypeService.recursionResetFoodType(parentId,true);
				jsonObj.setMsg("移组成功");

			} else {
				jsonObj.setSuccess(false);
				jsonObj.setMsg("请选择移组食品");
			}

		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}

		//更新样品库的时候，重置内存中的样品集合
		ImportDataCheckController.foodMap=null;
		return jsonObj;
	}
	
	@RequestMapping("/selectByParentId")
	public AjaxJson selectByParentId(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			//查询排序第一的二级样品种类
			BaseFoodType food=baseFoodTypeService.querySecondFoodType();
			List<BaseFoodType> foodTypes = baseFoodTypeService.selectByParentId(food.getId(), null);
			jsonObj.setObj(foodTypes);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

    /**
     * 刷新样品编码
     * @param foodId
     * @return
     * @throws Exception
     */
	@RequestMapping("/resetFoodCode")
	public AjaxJson resetFoodCode(Integer foodId, String foodCode) throws Exception {
		AjaxJson json = new AjaxJson();
		if (foodId == null) {
		    //重置所有样品编码
            jdbcTemplate.update(" UPDATE base_food_type SET food_code='0001' where id = 3 ");
            baseFoodTypeService.recursionResetFoodType(3, true);

        } else {
			if (!StringUtils.isBlank(foodCode)) {
				jdbcTemplate.update(" UPDATE base_food_type SET food_code=? where id = ? ", foodCode, foodId);
			}

			//刷新该样品下的样品编号
            baseFoodTypeService.recursionResetFoodType(foodId, true);
        }

		return json;
	}

	/**
	 * 通过检测项目ID获取样品信息(食品类型)
	 * @param itemId 检测项目ID
	 * @return
	 */
	@RequestMapping("/queryFoodByItemId")
	public AjaxJson queryFoodByItemId(String itemId) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<BaseFoodType> foodTypes = baseFoodTypeService.queryFoodByItemId(itemId);
			jsonObj.setObj(foodTypes);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	* @Description 校验样品名称是否重复
	* @Date 2020/12/18 9:58
	* @Author xiaoyl
	* @Param  bean{foodName：样品名称，parentId：食品类别ID}
	* @return
	*/
	@RequestMapping(value = "/checkUniqueFoodName")
	public AjaxJson checkUniqueFoodName(BaseFoodType bean,HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			TSUser tsUser = (TSUser)request.getSession().getAttribute(WebConstant.SESSION_USER);
			BaseFoodType food = baseFoodTypeService.queryByFoodName(bean.getFoodName(), bean.getParentId());
			if (food != null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("该食品已存在，请重新输入");
			}
		} catch (Exception e) {
			jsonObject.setSuccess(false);
			jsonObject.setMsg("数据查询失败！");
		}

		return jsonObject;
	}
}
