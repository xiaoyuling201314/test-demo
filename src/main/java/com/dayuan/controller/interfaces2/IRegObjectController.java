package com.dayuan.controller.interfaces2;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Cache;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.interfaces.BaseInterfaceController;
import com.dayuan.exception.MyException;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.mapper.regulatory.BaseRegulatoryBusinessMapper;
import com.dayuan.mapper.regulatory.BaseRegulatoryObjectMapper;
import com.dayuan.model.regulatory.BaseRegBusDeviceModel;
import com.dayuan.model.regulatory.BaseRegObjDeviceModel;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.util.CacheManager;
import com.dayuan.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 被检单位接口
 *
 * @author shit
 * @date 2022-03-11
 */
@RestController
@RequestMapping("/iRegulatory/Object")
public class IRegObjectController extends BaseInterfaceController {
    private Logger log = Logger.getLogger(IRegObjectController.class);
    @Autowired
    private BasePointService basePointService;
    @Autowired
    private BaseRegulatoryTypeService baseRegulatoryTypeService;
    @Autowired
    private BaseRegulatoryObjectService baseRegulatoryObjectService;
    @Autowired
    private BaseRegulatoryBusinessService baseRegulatoryBusinessService;

    /**
     * 进入被检单位管理页面
     * @param userToken     用户token
     * @param serialNumber  仪器唯一编码
     * @return
     * @throws Exception
     */
    @RequestMapping("/regList")
    public ModelAndView regList(String userToken, String serialNumber) {
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
        return new ModelAndView("/deviceManage/regObj/reg_list", map);
    }

    /**
     * 被检单位数据列表
     */
    @RequestMapping(value = "/datagrid")
    public AjaxJson datagrid(BaseRegObjDeviceModel model, Page page, String userToken) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser user = tokenExpired(userToken);    //token验证
            if (user.getDepartId() == null) {
                setAjaxJson(aj, WebConstant.INTERFACE_CODE14, "用户未绑定机构，请先绑定机构！");
                return aj;
            }
            //设置机构ID
            model.setDepartId(user.getDepartId());
            //市场用户可查看该市场的被检单位信息
            if (user.getRegId() != null) {
                model.setId(user.getRegId());
                //检测室用户只能查看关联的被检单位
            } else if (user.getPointId() != null) {
                BasePoint bp = basePointService.queryById(user.getPointId());
                if (bp != null && StringUtil.isNotEmpty(bp.getRegulatoryId())) {
                    model.setId(Integer.parseInt(bp.getRegulatoryId().trim()));
                }
            }
            page = baseRegulatoryObjectService.loadDatagrid(page, model, BaseRegulatoryObjectMapper.class, "loadDatagridDevice", "getRowTotalDevice");
            aj.setObj(page);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "查询被检单位失败！", e);
        }
        return aj;
    }
    /**
    * @Description 查询监管对象类型
    * @Date 2022/05/16 14:11
    * @Author xiaoyl
    * @Param
    * @return
    */
    @RequestMapping("/regTypes")
    public AjaxJson getRegTypes(String userToken) {
        AjaxJson aj = new AjaxJson();
        try {
            tokenExpired(userToken);    //token验证
            List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
            aj.setObj(regulatoryTypes);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "查询单位类型失败！", e);
        }
        return aj;
    }

    /**
     * 进入新增和维护被检单位页面
     * @param userToken     用户token
     * @param id  监管对象ID
     * @return
     * @throws Exception
     */
    @RequestMapping("/regAdd")
    public ModelAndView regAdd(String userToken, Integer id) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
            e.printStackTrace();
        }
        map.put("userToken", userToken);
        map.put("id", id);
        return new ModelAndView("/deviceManage/regObj/reg_add", map);
    }
    /**
    * @Description 根据监管对象ID查询数据
    * @Date 2022/05/16 14:28
    * @Author xiaoyl
    * @Param
    * @return
    */
    @GetMapping("/queryById")
    public AjaxJson queryById(Integer id, String userToken) {
        AjaxJson aj = new AjaxJson();
        try {
            tokenExpired(userToken);    //token验证
            BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(id);
            aj.setObj(regObj);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "查询被检单位失败！", e);
        }
        return aj;
    }

    /**
     * 被检单位名称校验重复
     *
     * @return
     */
    @GetMapping("/reqName")
    public boolean reqName(String name, Integer id, String type, String userToken) {
        try {
            TSUser user = tokenExpired(userToken);    //token验证
            BaseRegulatoryObject regObj = baseRegulatoryObjectService.reqName(id, name, type, user.getDepartId());
            if (regObj != null) {
                return false;
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return true;
    }


   /**
   * @Description 新增或修改被检单位
   * @Date 2022/05/16 14:28
   * @Author xiaoyl
   * @Param
   * @return
   */
    @PostMapping("/saveOrUpdate")
    @SystemLog(module = "仪器被检单位管理", methods = "新增与编辑", type = 1, serviceClass = "baseRegulatoryObjectService")
    public AjaxJson saveOrUpdate(String userToken, BaseRegulatoryObject regObj, String serialNumber) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser user = tokenExpired(userToken);    //token验证

            //被检单位查重
            BaseRegulatoryObject ro = baseRegulatoryObjectService.reqName(null, regObj.getRegName(), regObj.getRegType(), user.getDepartId());

            if (regObj.getId() == null) {
                if (ro != null) {
                    aj.setMsg("新增失败，被检单位已存在");
                    aj.setSuccess(false);
                } else {
                    PublicUtil.setCommonForTable(regObj, true, user);
                    regObj.setDepartId(user.getDepartId());
                    baseRegulatoryObjectService.insertSelective(regObj);
                    aj.setMsg("新增成功");
                }

            } else {
                if (ro != null && ro.getId().intValue() != regObj.getId().intValue()) {
                    aj.setMsg("编辑失败，被检单位名称重复");
                    aj.setSuccess(false);
                } else {
                    if (StringUtils.isBlank(regObj.getCreditCode())){regObj.setCreditCode("");}
                    if (StringUtils.isBlank(regObj.getLegalPerson())){regObj.setLegalPerson("");}
                    if (StringUtils.isBlank(regObj.getLinkIdcard())){regObj.setLinkIdcard("");}
                    if (StringUtils.isBlank(regObj.getLinkUser())){regObj.setLinkUser("");}
                    if (StringUtils.isBlank(regObj.getLinkPhone())){regObj.setLinkPhone("");}
                    if (StringUtils.isBlank(regObj.getRegAddress())){regObj.setRegAddress("");}

                    PublicUtil.setCommonForTable(regObj, false, user);
                    regObj.setDepartId(user.getDepartId());
                    baseRegulatoryObjectService.updateBySelective(regObj);
                    aj.setMsg("编辑成功");
                }
            }
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("id", regObj.getId());
        aj.setAttributes(map);
        return aj;
    }

    /***********************************经营户相关***************************************************************/
    /**
     * 进入经营户管理页面
     * @param regId     监管对象ID
     * @param regName     监管对象名称
     * @param userToken     用户token
     * @return
     * @throws Exception
     */
    @RequestMapping("/reg_bus_list")
    public ModelAndView busList(Integer  regId,String regName,String userToken) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
            e.printStackTrace();
        }
        map.put("userToken", userToken);
        map.put("regId", regId);
        map.put("regName", regName);
        return new ModelAndView("/deviceManage/regObj/reg_bus_list", map);
    }


    /**
     * 经营户数据列表
     */
    @GetMapping(value = "/bus")
    public AjaxJson datagridBus(BaseRegBusDeviceModel model, Page page, String userToken) {
        AjaxJson aj = new AjaxJson();
        try {
            tokenExpired(userToken);    //token验证
            page = baseRegulatoryBusinessService.loadDatagrid(page, model, BaseRegulatoryBusinessMapper.class, "loadDatagridDevice", "getRowTotalDevice");
            aj.setObj(page);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "查询被检单位失败！", e);
        }
        return aj;
    }
  /**
  * @Description 进入新增和维护经营单位页面
  * @Date 2022/05/16 11:28
  * @Author xiaoyl
  * @param userToken     用户token
   * @param id     经营户ID
   * @param regId    监管对象ID
   * @param regName     监管对象名称
  * @return
  */
    @RequestMapping("/reg_bus_add")
    public ModelAndView regBusAdd(String userToken, Integer id,Integer regId,String regName) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
            e.printStackTrace();
        }
        map.put("userToken", userToken);
        map.put("id", id);
        map.put("regId", regId);
        map.put("regName", regName);
        return new ModelAndView("/deviceManage/regObj/reg_bus_add", map);
    }

    /**
     * 经营户查询回显
     *
     * @param id        经营户ID
     * @param userToken 用户token
     */
    @GetMapping("/queryBusById")
    public AjaxJson queryBusById(Integer id, String userToken) {
        AjaxJson aj = new AjaxJson();
        try {
            tokenExpired(userToken);    //token验证
            BaseRegulatoryBusiness business = baseRegulatoryBusinessService.queryById(id);
            aj.setObj(business);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "查询经营户失败!", e);
        }
        return aj;
    }

    /**
    * @Description 新增和维护经营户
    * @Date 2022/05/16 14:41
    * @Author xiaoyl
    * @Param
    * @return
    */
    @PostMapping("/saveOrUpdateBus")
    @SystemLog(module = "仪器经营户管理", methods = "新增与编辑", type = 1, serviceClass = "baseRegulatoryBusinessService")
    public AjaxJson saveOrUpdateBus(String userToken, BaseRegulatoryBusiness business, String serialNumber) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser user = tokenExpired(userToken);    //token验证
            if (business.getId() == null) {
                PublicUtil.setCommonForTable(business, true, user);
                baseRegulatoryBusinessService.insertSelective(business);
                aj.setMsg("新增成功");
            } else {
                if (StringUtils.isBlank(business.getOpeShopName())){business.setOpeShopName("");}
                if (StringUtils.isBlank(business.getOpeName())){business.setOpeName("");}
                if (StringUtils.isBlank(business.getOpePhone())){business.setOpePhone("");}
                if (StringUtils.isBlank(business.getOpeIdcard())){business.setOpeIdcard("");}
                if (StringUtils.isBlank(business.getCreditCode())){business.setCreditCode("");}
                if (StringUtils.isBlank(business.getBusinessCope())){business.setBusinessCope("");}
                if (StringUtils.isBlank(business.getRemark())){business.setRemark("");}

                PublicUtil.setCommonForTable(business, false, user);
                baseRegulatoryBusinessService.updateBySelective(business);
                aj.setMsg("编辑成功");
            }
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("id", business.getId());
        aj.setAttributes(map);
        return aj;
    }

    //以下方法暂未使用

    @GetMapping("/auth")
    public AjaxJson auth(String userToken) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser tsUser = tokenExpired(userToken);//token验证
            if (tsUser.getPointId() != null) {
                aj.setObj(false);
            } else {
                aj.setObj(true);
            }
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "token校验失败！", e);
        }
        return aj;
    }


    @GetMapping("/setToken/{userToken}")
    public AjaxJson setToken(@PathVariable String userToken) {
        AjaxJson aj = new AjaxJson();
        try {
            userToken = StringUtil.isEmpty(userToken) ? "xxoo" : userToken;
            TSUser user = PublicUtil.getSessionUser();
            Cache cache = new Cache(userToken, user, System.currentTimeMillis() + Integer.parseInt(WebConstant.res.getString("cache.timeOut")), false);
            CacheManager.putCache(cache.getKey(), cache, user.getUserName());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "设置失败！", e);
        }
        return aj;
    }


/*********************************************************** app被检单位管理相关代码-开始 ***********************************************************/
    /**
     * 进入被检单位管理页面(app终端版)
     * @param userToken     用户token
     * @param serialNumber  仪器唯一编码
     * @return
     * @throws Exception
     */
    @RequestMapping("/regListApp")
    public ModelAndView regListApp(String userToken, String serialNumber) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
        }
        map.put("userToken", userToken);
        map.put("serialNumber", serialNumber);
        return new ModelAndView("/deviceManage/regObj/app_reg_list", map);
    }

    /**
     * 进入新增和维护被检单位页面(app终端版)
     * @param userToken     用户token
     * @param id  监管对象ID
     * @return
     * @throws Exception
     */
    @RequestMapping("/regAddApp")
    public ModelAndView regAddApp(String userToken, Integer id) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
        }
        map.put("userToken", userToken);
        map.put("id", id);
        return new ModelAndView("/deviceManage/regObj/app_reg_add", map);
    }

    /**
     * 进入经营户管理页面(app终端版)
     * @param regId     监管对象ID
     * @param regName     监管对象名称
     * @param userToken     用户token
     * @return
     * @throws Exception
     */
    @RequestMapping("/busListApp")
    public ModelAndView busListApp(Integer regId, String regName, String userToken) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
        }
        map.put("userToken", userToken);
        map.put("regId", regId);
        map.put("regName", regName);
        return new ModelAndView("/deviceManage/regObj/app_bus_list", map);
    }

    /**
     * @Description 进入新增和维护经营单位页面(app终端版)
     * @param userToken     用户token
     * @param id     经营户ID
     * @param regId    监管对象ID
     * @param regName     监管对象名称
     * @return
     */
    @RequestMapping("/busAddApp")
    public ModelAndView busAddApp(String userToken, Integer id, Integer regId, String regName) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSUser user = tokenExpired(userToken);
        } catch (MyException e) {
            //用户token已失效
            userToken = "";
        }
        map.put("userToken", userToken);
        map.put("id", id);
        map.put("regId", regId);
        map.put("regName", regName);
        return new ModelAndView("/deviceManage/regObj/app_bus_add", map);
    }

/*********************************************************** app被检单位管理相关代码-结束 ***********************************************************/

}
