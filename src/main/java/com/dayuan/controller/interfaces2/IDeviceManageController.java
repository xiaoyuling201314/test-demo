package com.dayuan.controller.interfaces2;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.exception.MyException;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.data.BaseFoodItemService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.service.CommonLogUtilService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 仪器(食品种类)管理接口
 *
 * @author Dz
 * @date 2022-03-15
 */
@RestController
@RequestMapping("/iDeviceManage")
public class IDeviceManageController extends BaseInterfaceController {
    private Logger log = Logger.getLogger(IRegObjectController.class);
    @Autowired
    private BaseFoodTypeService foodTypeService;
    @Autowired
    private BaseFoodItemService foodItemService;
    @Autowired
    private CommonLogUtilService logUtil;

    /**
     * 进入食品分类页面
     * @param userToken     用户token
     * @param serialNumber  仪器唯一编码
     * @return
     * @throws Exception
     */
    @RequestMapping("/foodList")
    public ModelAndView foodList(String userToken, String serialNumber) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
            e.printStackTrace();
        }
        map.put("userToken", userToken);
        map.put("serialNumber", serialNumber);
        return new ModelAndView("/deviceManage/food/foodList", map);
    }

    /**
     * 获取食品分类树形数据
     * @param userToken     用户token
     * @param id            食品父类ID
     * @return
     */
    @RequestMapping("/foodTree")
    public List<TreeNode> foodTree(String userToken, Integer id) {
        List<TreeNode> departTree = new ArrayList<TreeNode>();
        try {
            TSUser user = tokenExpired(userToken);
            if (user != null) {
                departTree = foodTypeService.queryFoodTree(id,false,false,null);
            }
        } catch (MyException e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return departTree;
    }

    /**
     * 查询食品名称
     * @param userToken     用户token
     * @param foodName            食品名称
     * @return
     */
    @RequestMapping("/queryFoodName")
    public List<BaseFoodType> queryFoodName(String userToken, String foodName) {
        List<BaseFoodType> foods = new ArrayList<BaseFoodType>();
        try {
            TSUser user = tokenExpired(userToken);
            if(null==foodName){
                foodName="";
            }
            if (user != null) {
                foods = foodTypeService.queryByFName(foodName,  1);
            }
        } catch (MyException e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return foods;
    }

    /**
     * 获取种类下食品名称和食品类型数量，根据是否有样品类型来控制新增按钮的禁用与启用
     * @param userToken     用户token
     * @param id            食品类别ID
     * @return
     */
    @RequestMapping("/getFoods")
    public AjaxJson getFoods(String userToken, Integer id) {
        AjaxJson jsonObject = new AjaxJson();
        Map<String,Object> map=new HashMap<>();
        try {
            TSUser user = tokenExpired(userToken);
            if (user != null) {
                List<BaseFoodType> foods = foodTypeService.selectByParentId(id, 1);
                map.put("foods",foods);
            }
            //查询当前样品下是否存在样品类型,根据是否有样品类型来控制新增按钮的禁用与启用
            int foodTypeCounts=foodTypeService.queryFoodTypeByID(id);
            map.put("foodTypeCounts",foodTypeCounts);
            jsonObject.setObj(map);
        } catch (MyException e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return jsonObject;
    }

    /**
     * 获取食品关联检测项目
     * @param userToken     用户token
     * @param id            食品ID
     * @return
     */
    @RequestMapping("/getFoodItem")
    public List<BaseFoodItem> getFoodItem(String userToken, Integer id) {
        List<BaseFoodItem> foodItems = new ArrayList<BaseFoodItem>();
        try {
            TSUser user = tokenExpired(userToken);
            if (user != null) {
                foodItems = foodItemService.queryListByFoodId(id);
            }
        } catch (MyException e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return foodItems;
    }

    /**
     * 添加/修改食品信息
     * @param bean          食品
     * @param serialNumber  仪器唯一编码
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    @SystemLog(module = "仪器样品管理",methods = "新增与编辑",type = 1,serviceClass = "baseFoodTypeService")
    public AjaxJson save(String userToken, BaseFoodType bean, String serialNumber) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            TSUser user = tokenExpired(userToken);
            jsonObject = foodTypeService.saveOrUpdateFood(bean, "1",user);
        } catch (MyException e) {
            jsonObject.setSuccess(false);
            jsonObject.setMsg(e.getMessage());

        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常"+e.getMessage());
        }
        return jsonObject;
    }

}
