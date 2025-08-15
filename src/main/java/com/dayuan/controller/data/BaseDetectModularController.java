package com.dayuan.controller.data;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectMethod;
import com.dayuan.bean.data.BaseDetectModular;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseDetectModularModel;
import com.dayuan.service.data.BaseDetectMethodService;
import com.dayuan.service.data.BaseDetectModularService;
import com.dayuan.util.UUIDGenerator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * 仪器检测项目模块参数管理、对应检测方法管理 Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月17日
 */
@Controller
@RequestMapping("/data/detectModular")
public class BaseDetectModularController extends BaseController {
    private final Logger log = Logger.getLogger(BaseDetectModularController.class);

    @Autowired
    private BaseDetectModularService baseDetectModularService;
    @Autowired
    private BaseDetectMethodService baseDetectMethodService;


    /**
     * 进入检测模块页面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {

        return new ModelAndView("/data/detectModular/list");
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(BaseDetectModularModel model, Page page, HttpServletResponse response) throws Exception {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = baseDetectModularService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     * 查询所有的检测模块
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/queryAllDetectModular")
    @ResponseBody
    public List<BaseDetectModular> queryAllDetectModular(HttpServletRequest request, HttpServletResponse response) {
        List<BaseDetectModular> list = baseDetectModularService.queryAll();
        return list;
    }


    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(BaseDetectModular bean) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        try {
            //在新增和编辑之前先根据检测模块名称去查询校验唯一性
            BaseDetectModular bdm = baseDetectModularService.selectByModular(bean.getDetectModular(), bean.getId());
            if (bdm == null) {
                if (StringUtils.isNotEmpty(bean.getId())) {// 更新
                    PublicUtil.setCommonForTable(bean, false);
                    baseDetectModularService.updateBySelective(bean);
                } else {// 新增
                    bean.setId(UUIDGenerator.generate());
                    PublicUtil.setCommonForTable(bean, true);
                    bean.setDeleteFlag((short) 0);
                    baseDetectModularService.insertSelective(bean);// 新增、更新注册仪器
                }
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("检测模块已存在！");
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       数据记录id
     * @param response
     * @throws Exception
     */

    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(String id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        BaseDetectModular bean = null;
        try {
            bean = baseDetectModularService.queryById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            jsonObject.setObj(bean);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public AjaxJson delete(BaseDetectModular bean, HttpServletRequest request, HttpServletResponse response) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        TSUser user = PublicUtil.getSessionUser();
        BaseDetectMethod method = new BaseDetectMethod();
        try {
            Date now = new Date();
            if (StringUtils.isNotEmpty(bean.getId())) {//删除处理
                bean.setUpdateDate(now);
                bean.setUpdateBy(user.getId());
                bean.setDeleteFlag((short) 1);
                baseDetectModularService.updateBySelective(bean);
                method.setDetectModularId(bean.getId());
                method.setUpdateBy(user.getId());
                method.setUpdateDate(now);
                baseDetectMethodService.deleteByDetectModularId(method);//关联删除检测方法
                jsonObject.setSuccess(true);
                jsonObject.setMsg("删除成功！");
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("删除失败！.");
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 根据检测模块ID查询对应的检测方法
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/queryByModularId")
    @ResponseBody
    public List<BaseDetectMethod> queryByModularId(String id, HttpServletRequest request, HttpServletResponse response) {
        List<BaseDetectMethod> list = null;
        try {
            list = baseDetectMethodService.queryByModularId(id);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        return list;
    }
    /*
     * @RequestMapping("/list")
	 * public ModelAndView list(HttpServletRequest
	 * request,HttpServletResponse response,String id) throws Exception{
	 * Map<String, Object> map=new HashMap<>(); map.put("deviceTypeId", id);
	 * return new ModelAndView("/data/deviceSeries/detectParameter/list"); }
	 *//**
     * 数据列表
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    /*
     * @RequestMapping(value="/datagrid")
	 * 
	 * @ResponseBody public AjaxJson datagrid(BaseDeviceParameterModel
	 * model,Page page,HttpServletResponse response) throws Exception{ AjaxJson
	 * jsonObj = new AjaxJson(); try { page =
	 * baseDeviceParameterService.loadDatagrid(page, model);
	 * jsonObj.setObj(page); } catch (Exception e) { jsonObj.setSuccess(false);
	 * jsonObj.setMsg("操作失败"); } return jsonObj; }
	 * 
	 * 
	 *//**
     * 添加/修改检测标准 1.检查检测标准是否已存在 2.不存在，查询检测标准编号，生成即将要插入的标准编号，保存数据
     * 3.检测标准已存在，不执行数据库操作并返回提示信息
     * @param bean
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    /*
	 * @RequestMapping(value="/save")
	 * 
	 * @ResponseBody public AjaxJson save(BaseDeviceParameter
	 * bean,HttpServletRequest request, HttpServletResponse response) throws
	 * Exception { AjaxJson jsonObject = new AjaxJson(); BaseDetectStandard
	 * baDetectStandard =
	 * baseDetectStandardService.queryByStandardName(bean.getStandardName());
	 * TSUser user=(TSUser)
	 * request.getSession().getAttribute(WebConstant.SESSION_USER); Timestamp
	 * tamp=new Timestamp(System.currentTimeMillis()); try {
	 * if(StringUtils.isBlank(bean.getId())){//新增数据 if (baDetectStandard ==
	 * null) { String lastCode = baseDetectStandardService.queryLastCode();
	 * String code = UUIDGenerator.getNextCode(4, lastCode, "");
	 * bean.setId(UUIDGenerator.generate()); bean.setStandardCode(code);
	 * bean.setDeleteFlag((short) 0); bean.setCreateBy(user.getId());
	 * bean.setCreateDate(tamp); baseDetectStandardService.insert(bean); } else
	 * { jsonObject.setSuccess(false); jsonObject.setMsg("该标准已存在，请重新输入."); }
	 * }else{//修改数据 bean.setUpdateBy(user.getId()); bean.setUpdateDate(tamp); if
	 * (baDetectStandard == null ||
	 * bean.getId().equals(baDetectStandard.getId())) {
	 * baseDetectStandardService.updateBySelective(bean); } else {
	 * jsonObject.setSuccess(false); jsonObject.setMsg("该标准已存在，请重新输入."); } }
	 * 
	 * } catch (Exception e) { jsonObject.setSuccess(false);
	 * jsonObject.setMsg("操作异常."); } return jsonObject; }
	 *//**
     * 查找数据，进入编辑页面
     * @param id 数据记录id
     * @param response
     * @throws Exception
     */
	/*
	 * @RequestMapping("/queryById")
	 * 
	 * @ResponseBody public AjaxJson queryById(String id,HttpServletResponse
	 * response) throws Exception{ AjaxJson jsonObject = new AjaxJson();
	 * BaseDeviceParameter bean = baseDeviceParameterService.queryById(id);
	 * if(bean == null){ jsonObject.setSuccess(false);
	 * jsonObject.setMsg("没有找到对应的记录!"); } jsonObject.setObj(bean); return
	 * jsonObject; }
	 *//**
     * 查找数据，进入编辑页面
     * @param id 数据记录id
     * @param response
     * @throws Exception
     */
	/*
	 * @RequestMapping("/queryById")
	 * 
	 * @ResponseBody public ModelAndView
	 * queryById(@RequestParam(required=false)String id,HttpServletResponse
	 * response) throws Exception{ AjaxJson jsonObject = new AjaxJson();
	 * Map<String, Object> map=new HashMap<>(); BaseDeviceParameter bean =
	 * baseDeviceParameterService.queryById(id); if(bean == null){
	 * jsonObject.setSuccess(false); jsonObject.setMsg("没有找到对应的记录!"); }
	 * jsonObject.setObj(bean); map.put("data", jsonObject); return new
	 * ModelAndView("/data/deviceSeries/detectParameter/edit", map); }
	 *//**
     * 删除数据，单条删除与批量删除通用方法
     * @param request
     * @param response
     * @param ids 要删除的数据记录id集合
     * @return
     *//*
		 * @RequestMapping("/delete")
		 * 
		 * @ResponseBody public AjaxJson delete(HttpServletRequest
		 * request,HttpServletResponse response,String ids){ AjaxJson jsonObj =
		 * new AjaxJson(); try { String[] ida = ids.split(",");
		 * baseDeviceParameterService.delete(ida); } catch (Exception e) {
		 * jsonObj.setSuccess(false); jsonObj.setMsg("操作失败"); } return jsonObj;
		 * }
		 */
}
