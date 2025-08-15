package com.dayuan.controller.data;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.controller.dataCheck.ImportDataCheckController;
import com.dayuan.service.data.BaseFoodItemService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseItemType;
import com.dayuan.bean.data.BaseStandard;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseDetectItemModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.data.BaseItemTypeService;
import com.dayuan.service.data.BaseStandardService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
//import com.dayuan3.terminal.bean.SpecialOffer;
//import com.dayuan3.terminal.bean.SpecialOfferItem;
//import com.dayuan3.terminal.service.SpecialOfferItemService;
//import com.dayuan3.terminal.service.SpecialOfferService;

/**
 * 检测项目管理
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
@Controller
@RequestMapping("/data/detectItem")
public class BaseDetectItemController extends BaseController {
	private final Logger log=Logger.getLogger(BaseDetectItemController.class);
	
	@Autowired
	private BaseDetectItemService baseDetectItemService;
	@Autowired
	private BaseFoodItemService baseFoodItemService;
	@Autowired
	private BaseStandardService baseStandardService;
	@Autowired
	private BaseItemTypeService baseItemTypeService;
//	@Autowired
//	private SpecialOfferService specialService;
//	@Autowired
//	private SpecialOfferItemService specialItemService;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	/**
	 * 进入检测标准表页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ExceptionHandler(IOException.class)
	@RequestMapping(value="/list")
	public ModelAndView  list(HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> map=new HashMap<>();
		List<BaseStandard>  list=baseStandardService.queryAll();
		map.put("standardList", list);
		List<BaseItemType>  itemList=baseItemTypeService.queryAll();
		map.put("itemList", itemList);
		
		return new ModelAndView("/data/detectItem/list",map);
	}
	/**
	 * 数据列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(BaseDetectItemModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("asc");
			page = baseDetectItemService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}


	/**
	 * 添加/修改检测项目
	 * 1.检查检测项目是否已存在
	 * 2.不存在，查询检测项目编号，生成即将要插入的编号，保存数据
	 * 3.检测项目存在，不执行数据库操作并返回提示信息
	 * @param bean
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public  AjaxJson save(BaseDetectItem bean,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		//根据检测项目名称和检测标准进行唯一判断
		BaseDetectItem item = baseDetectItemService.queryByDetectNameAndStandard(bean);
		try {
			if(StringUtils.isBlank(bean.getId())){//新增数据
				if (item == null) {
					bean.setId(UUIDGenerator.generate());
					PublicUtil.setCommonForTable(bean, true);
					baseDetectItemService.save(bean);
					//add by xiaoyl 2020-04-09 添加检测项目时自动加入到优惠活动中
					/*List<SpecialOffer> list=specialService.selectOfferList();
					if(list.size()!=0) {
						for (SpecialOffer specialOffer : list) {
							if(specialOffer.getApplyAllItems()==0) {//优惠活动应用于所有项目，将该项目添加至优惠活动中
								SpecialOfferItem item2 =new SpecialOfferItem();
								item2.setItemId(bean.getId());
								item2.setOfferId(specialOffer.getId());;
								specialItemService.insert(item2);
								if(specialOffer.getStatus()==1 && specialOffer.getTimeEnd().after(new Date())) {//优惠活动进行
									bean.setOfferId(specialOffer.getId());
									bean.setDiscount(specialOffer.getDiscount());
									baseDetectItemService.updateBySelective(bean);
								}
							}
						}
					}*/
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该检测项目已存在，请重新输入.");
				}
			}else{//修改数据
//				if (StringUtils.isBlank(bean.getDetectItemVulgo())) {
//					bean.setDetectItemVulgo("");
//				}
				PublicUtil.setCommonForTable(bean, false);
				if (item == null ) {
					baseDetectItemService.updateById(bean);
				} else {
					if(bean.getId().equals(item.getId())){
						baseDetectItemService.updateById(bean);
					}else{
						jsonObject.setSuccess(false);
						jsonObject.setMsg("该检测项目已存在，请重新输入.");
					}
				}
			}
//			//add by xiaoyl 2020-04-09 添加检测项目时自动加入到优惠活动中 start
//			List<SpecialOffer> list=specialService.selectOfferList();
//			if(list.size()!=0) {
//				for (SpecialOffer specialOffer : list) {
//					if(specialOffer.getApplyAllItems()==0) {//优惠活动应用于所有项目，将该项目添加至优惠活动中
//						SpecialOfferItem item2=specialItemService.queryByItemId(bean.getId(),specialOffer.getId());
//						if(item2==null && bean.getChecked()==1) {
//							item2 =new SpecialOfferItem();
//							item2.setItemId(bean.getId());
//							item2.setOfferId(specialOffer.getId());;
//							specialItemService.insert(item2);
//						}
//						if(specialOffer.getStatus()==1 && specialOffer.getTimeEnd().after(new Date()) && bean.getChecked()==1) {//优惠活动进行
//							bean.setOfferId(specialOffer.getId());
//							bean.setDiscount(specialOffer.getDiscount());
//							baseDetectItemService.updateBySelective(bean);
//						}
//					}
//				}
//			}
//			//add by xiaoyl 2020-04-09 添加检测项目时自动加入到优惠活动中 end
			//更新检测项目的时候，重置内存中的检测项目集合
			ImportDataCheckController.itemMap=null;
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 查找数据，进入编辑页面
	 * @param id 检测项目ID
	 * @param foodId 样品ID
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(String id, Integer foodId){
		AjaxJson jsonObject = new AjaxJson();
		BaseDetectItem bean=null;
		try {
			bean = baseDetectItemService.queryItemById(id);
			//样品检测标准
			if (foodId != null) {
				BaseFoodItem foodItem = baseFoodItemService.queryByFoodItem(foodId, id);
				if (foodItem != null && foodItem.getUseDefault() == 1) {
					bean.setDetectSign(foodItem.getDetectSign());
					bean.setDetectValue(foodItem.getDetectValue());
					bean.setDetectValueUnit(foodItem.getDetectValueUnit());
				}
			}
			if(bean  == null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
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
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			baseDetectItemService.removeByIds(Arrays.asList(ids.split(",")));
			//更新检测项目的时候，重置内存中的检测项目集合
			ImportDataCheckController.itemMap=null;
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 获取检测项目树数据
	 * @param request
	 * @param response
	 * @param id 检测项目类型
	 * @param foodId 样品ID/样品类型ID
	 * @return
	 */
	@RequestMapping("/getDetectItemTree")
	@ResponseBody
	public List<TreeNode> detectItemTree(HttpServletRequest request,HttpServletResponse response,String id,String foodId){
		List<TreeNode> trees = new ArrayList<TreeNode>();
		try {
			//通过样品ID查询检测模块、检测项目(只查询当前样品的检测模块、检测项目，不再向上或向下查询)
			if(StringUtil.isNotEmpty(foodId)){
				if(StringUtil.isEmpty(id)){
					//检测项目树第一层数据（检测模块）
					List<BaseItemType> items = baseItemTypeService.queryByFoodId(foodId);
					for(BaseItemType item : items){
						TreeNode tree = new TreeNode();
						tree.setId(item.getId());
						tree.setText(item.getItemName());
						tree.setState("closed");
						trees.add(tree);
					}
				}else{
					//检测项目树第二层数据（检测项目）
					List<BaseDetectItem> detectItems = baseDetectItemService.queryByItemType(foodId,id);
					for(BaseDetectItem detectItem : detectItems){
						TreeNode tree = new TreeNode();
						tree.setId(detectItem.getId());
						tree.setText(detectItem.getDetectItemName());
						trees.add(tree);
					}
				}
			}else {
				//所有检测项目
				if(StringUtil.isEmpty(id)){
					//检测项目树第一层数据（检测模块）
					List<BaseItemType> items = baseItemTypeService.queryByFoodId(null);
					for(BaseItemType item : items){
						TreeNode tree = new TreeNode();
						tree.setId(item.getId());
						tree.setText(item.getItemName());
						tree.setState("closed");
						trees.add(tree);
					}
				}else{
					//检测项目树第二层数据（检测项目）
					List<BaseDetectItem> detectItems = baseDetectItemService.queryByItemType(null,id);
					for(BaseDetectItem detectItem : detectItems){
						TreeNode tree = new TreeNode();
						tree.setId(detectItem.getId());
						tree.setText(detectItem.getDetectItemName());
						trees.add(tree);
					}
				}

			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		return trees;
	}

	/**
	 * 获取检测项目树数据
	 * @param request
	 * @param response
	 * @param foodId 样品ID/样品类型ID
	 * @return
	 */
	@RequestMapping("/getDetectItemTree2")
	@ResponseBody
	public List<TreeNode> detectItemTree2(HttpServletRequest request,HttpServletResponse response, String foodId){
		List<TreeNode> trees = new ArrayList<TreeNode>();
		try {
			//通过样品ID查询检测项目(只查询当前样品的检测项目，不再向上或向下查询)
			if(StringUtil.isNotEmpty(foodId)){
				List<BaseDetectItem> items = baseDetectItemService.queryByFoodId2(Integer.parseInt(foodId));
				for(BaseDetectItem item : items){
					TreeNode tree = new TreeNode();
					tree.setId(item.getId());
					tree.setText(item.getDetectItemName());
//					tree.setState("closed");
					trees.add(tree);
				}
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		return trees;
	}

	/**
	 * //通过样品ID查询检测项目(只查询当前样品的检测项目，不再向上或向下查询)
	 * @param request
	 * @param response
	 * @param foodId	样品ID
	 * @return
	 */
	@RequestMapping("/queryItemsByFoodId")
	@ResponseBody
	public AjaxJson queryItemsByFoodId(HttpServletRequest request,HttpServletResponse response,String foodId){
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<BaseDetectItem> detectItems = null;
			if(StringUtil.isNotEmpty(foodId)) {
				detectItems = baseDetectItemService.queryByFoodId(new String[] {foodId});
			}else {
				detectItems = baseDetectItemService.queryByFoodId(null);
			}
			jsonObj.setObj(detectItems);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 根据样品ID递归向上查询所有关联的检测项目列表
	 * （查询当前样品及所有父类样品的检测项目并去重）
	 * @param request
	 * @param response
	 * @param foodId 样品ID
	 * @return
	 * @author xyl 2017-09-13
	 */
	@RequestMapping("/queryByFoodId")
	@ResponseBody
	public List<BaseDetectItem> queryByFoodId(HttpServletRequest request,HttpServletResponse response,String foodId){
		List<BaseDetectItem> list=null;
		try {
//			//1.默认采用向下查找方法
//			String foodIds = baseFoodTypeService.queryChildFoodById(foodId);
//			String [] ids=foodIds.split(",");
//			list=baseDetectItemService.queryByFoodId(ids);
//			//2.向下查找失败则向上查找
//			if(list==null || list.size()==0){
//				foodIds = baseFoodTypeService.queryParentFoodById(foodId);
//				ids=foodIds.split(",");
//				list=baseDetectItemService.queryByFoodId(ids);
//			}

			//通过样品ID查询检测项目(只查询当前样品的检测项目，不再向上或向下查询)
			list=baseDetectItemService.queryByFoodId(new String[] {foodId});
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		return list;
	}
	/**
	 * select2检测项目数据
	 * itemName为空，按foodId查询检测项目，否则按itemName模糊查询
	 * @param request
	 * @param response
	 * @param page 页码
	 * @param row 每页数量
	 * @param foodId 样品ID
	 * @param itemName 检测项目名称
	 * @return
	 */
	@RequestMapping("/select2ItemData")
	@ResponseBody
	public Map select2ItemData(HttpServletRequest request, HttpServletResponse response,
			Integer page, Integer row, Integer foodId, String itemName) {
		Map map = new HashMap();
		//总数
		int total = 0;
		//检测项目
		List items = new ArrayList();
		try {
			StringBuffer sql1 = new StringBuffer();
			StringBuffer sql2 = new StringBuffer();
			if (itemName != null && !"".equals(itemName.trim())) {
                //样品
                sql1.append("SELECT bdi.id, bdi.detect_item_name name FROM base_detect_item bdi " +
						"WHERE bdi.delete_flag = 0 " +
						" AND bdi.detect_item_name LIKE '%"+itemName+"%' ");
				if (page>0 && row>0) {
                    sql1.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
				}

                //样品总数
                sql2.append("SELECT COUNT(1) FROM base_detect_item bdi  " +
                        "WHERE bdi.delete_flag = 0 " +
                        " AND bdi.detect_item_name LIKE '%"+itemName+"%' ");

			} else if (foodId != null) {
			    //样品
                sql1.append("SELECT bdi.id, bdi.detect_item_name name FROM base_detect_item bdi  " +
						"INNER JOIN base_food_item bfi ON bdi.id = bfi.item_id " +
						"INNER JOIN base_food_type bft ON bft.id = bfi.food_id " +
						"WHERE bdi.delete_flag = 0 " +
						"AND bfi.delete_flag = 0 " +
						"AND bft.id = "+foodId);
				if (page>0 && row>0) {
                    sql1.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
				}

				//样品总数
                sql2.append("SELECT COUNT(1) FROM base_detect_item bdi  " +
						" INNER JOIN base_food_item bfi ON bdi.id = bfi.item_id " +
						" INNER JOIN base_food_type bft ON bft.id = bfi.food_id " +
						"WHERE bdi.delete_flag = 0 " +
						" AND bfi.delete_flag = 0 " +
						" AND bft.id = "+foodId);
			}

			if (StringUtils.isNotBlank(sql1.toString())) {
				jdbcTemplate.query(sql1.toString(), new RowCallbackHandler() {
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						do {
							Map item = new HashMap();
							//检测项目ID
							item.put("id", rs.getString("id"));
							//检测项目名称
							item.put("name", rs.getString("name"));
							items.add(item);
						} while (rs.next());
					}
				});
			}

			if (StringUtils.isNotBlank(sql2.toString())) {
				total = jdbcTemplate.queryForObject(sql2.toString(), Integer.class);
			}

		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
		}
		map.put("items", items);
		map.put("total", total);
		return map;
	}
	/**
	 * 获取检测项目树数据,用于仪器类型新增检测项目使用
	 * @param request
	 * @param response
	 * @param id 检测项目类型
	 * @return
	 */
	@RequestMapping("/queryAllDetectItemTree")
	@ResponseBody
	public List<TreeNode> queryAllDetectItemTree(HttpServletRequest request,HttpServletResponse response,String id){
		List<TreeNode> trees = new ArrayList<TreeNode>();
			if(StringUtil.isEmpty(id)){
				//检测项目树第一层数据（检测模块）
				List<BaseItemType> items = baseItemTypeService.queryAll();
				for(BaseItemType item : items){
					TreeNode tree = new TreeNode();
					tree.setId(item.getId());
					tree.setText(item.getItemName());
					tree.setState("closed");
					trees.add(tree);
				}
			}else{
				//检测项目树第二层数据（检测项目）
				List<BaseDetectItem> detectItems = baseDetectItemService.queryByTypeid(id);
				for(BaseDetectItem detectItem : detectItems){
					TreeNode tree = new TreeNode();
					tree.setId(detectItem.getId());
					tree.setText(detectItem.getDetectItemName());
					trees.add(tree);
				}
			}
			return trees;
	}
	/**
	 * 快检新模式-订单复检：select2检测项目数据
	 * itemName为空，按foodId查询检测项目，否则按itemName模糊查询
	 * @param page 页码
	 * @param row 每页数量
	 * @param itemName 检测项目名称
	 * @return
	 */
	@RequestMapping("/select2ItemDataForOrder")
	@ResponseBody
	public Map select2ItemDataForOrder(Integer page, Integer row, String itemName) {
		Map map = new HashMap();
		//总数
		int total = 0;
		//检测项目
		List items = new ArrayList();
		try {
			StringBuffer sql1 = new StringBuffer();
			StringBuffer sql2 = new StringBuffer();
			sql1.append("SELECT bdi.id, bdi.detect_item_name name FROM base_detect_item bdi " +
					"WHERE bdi.delete_flag = 0 ");
			if (itemName != null && !"".equals(itemName.trim())) {
				sql1.append(" AND bdi.detect_item_name LIKE '%"+itemName+"%' ");
			}
			if (page>0 && row>0) {
				sql1.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
			}

			//总数
			sql2.append("SELECT COUNT(1) FROM base_detect_item bdi  " +
					"WHERE bdi.delete_flag = 0 " );
			if (itemName != null && !"".equals(itemName.trim())) {
				sql2.append(" AND bdi.detect_item_name LIKE '%"+itemName+"%' ");
			}
			if (StringUtils.isNotBlank(sql1.toString())) {
				jdbcTemplate.query(sql1.toString(), new RowCallbackHandler() {
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						do {
							Map item = new HashMap();
							//检测项目ID
							item.put("id", rs.getString("id"));
							//检测项目名称
							item.put("name", rs.getString("name"));
							items.add(item);
						} while (rs.next());
					}
				});
			}

			if (StringUtils.isNotBlank(sql2.toString())) {
				total = jdbcTemplate.queryForObject(sql2.toString(), Integer.class);
			}

		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
		}
		map.put("items", items);
		map.put("total", total);
		return map;
	}
}
