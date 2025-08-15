package com.dayuan.controller.detect;

import com.aspose.cells.License;
import com.aspose.cells.SaveFormat;
import com.aspose.cells.Workbook;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.*;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.data.DepartModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.data.*;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Timestamp;
import java.util.*;

/**
 * 检测机构管理
 *
 * @author Dz
 */
@RestController
@RequestMapping("/detect/depart")
public class DepartController extends BaseController {
    private final Logger log = Logger.getLogger(DepartController.class);

    @Autowired
    private TSDepartService departService;
    @Autowired
    private BasePointService basePointService;
    @Autowired
    private BaseWorkersService baseWorkersService;
    @Autowired
    private BasePointUserService basePointUserService;
    @Autowired
    private BaseRegionService regionService;
    @Autowired
    private BaseDeviceService baseDeviceService;
//    @Autowired
//    private BaseEnvironmentManageService manageService;
    @Autowired
    private TBImportHistoryService importHistoryService;
    @Autowired
    private BasePointTypeService pointTypeService;

    @Value("${resources}")
    private String resources;    //项目资源文件夹
    @Value("${filePath}")
    private String filePath;

    /**
     * 获取机构树数据
     *
     * @param id  查询机构ID
     * @param pid 自定义机构ID
     * @return
     * @throws MissSessionExceprtion
     */
    @RequestMapping("/getDepartTree")
    public List<TreeNode> getDepartTree(Integer id, Integer pid,@RequestParam(required = false,defaultValue = "false")Boolean isJoinId) throws MissSessionExceprtion {
        List<TreeNode> departTree = null;
        if (StringUtil.isNotEmpty(id)) {
            // 机构节点ID，延迟加载数据
            departTree = departService.getDapartTree(id, true, isJoinId);
        } else {
            if (StringUtil.isNotEmpty(pid)) {
                // 首次查询机构ID，扩展查询自定义机构树
                departTree = departService.getDapartTree(pid, true, isJoinId);
            } else {
                // 当前用户所属机构
                departTree = departService.getDapartTree(null, true, isJoinId);
            }
        }
        return departTree;
    }

//    /**
//     * 获取机构完整树数据
//     *
//     * @param id  查询机构ID
//     * @return
//     */
//    @RequestMapping("/getDepartsTree")
//    public List<TreeNode> getDepartsTree(Integer id, @RequestParam(required = false,defaultValue = "false")Boolean isJoinId) {
//        List<TreeNode> departTree = null;
//        try {
//            if (id == null) {
//                // 当前用户所属机构
//                id = PublicUtil.getSessionUser().getDepartId();
//            }
//            departTree = departService.getDapartsTree(id, true, isJoinId);
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//        }
//        return departTree;
//    }

    /**
     * 新建项目，关联机构时加载的树
     *
     * @param request
     * @param response
     * @param id
     * @param pid
     * @return
     * @throws MissSessionExceprtion
     * @author wtt
     */
    @RequestMapping("/getDepartTrees")
    public List<TreeNode> getDepartTrees(HttpServletRequest request, HttpServletResponse response, Integer id, Integer pid,@RequestParam(required = false,defaultValue = "false")Boolean isJoinId) throws MissSessionExceprtion {
        List<TreeNode> departTree = null;
        if (StringUtil.isNotEmpty(id)) {
            // 机构节点ID，延迟加载数据
            departTree = departService.getDapartTree(id, true,isJoinId);
        } else {
            if (StringUtil.isNotEmpty(pid)) {
                // 首次查询机构ID，扩展查询自定义机构树
                departTree = departService.getDapartTree(pid, true,isJoinId);
            } else {
                // 当前用户所属机构
                departTree = departService.getDapartTree(null, true,isJoinId);
            }
        }
        return departTree;
    }

    /**
     * 获取子机构数据
     *
     * @param id 查询机构ID
     * @return
     * @throws MissSessionExceprtion
     */
    @RequestMapping("/getSubDepart")
    @ResponseBody
    public List<TreeNode> getSubDepart(HttpServletRequest request, HttpServletResponse response, Integer id,@RequestParam(required = false,defaultValue = "false")Boolean isJoinId) throws MissSessionExceprtion {
        List<TreeNode> departTree = null;
        if (StringUtil.isNotEmpty(id)) {
            // 机构节点ID，延迟加载数据
            departTree = departService.getDapartTree(id, false,isJoinId);
        } else {
            // 默认当前用户所属机构ID
            departTree = departService.getDapartTree(PublicUtil.getSessionUserDepart().getId(), false,isJoinId);
        }
        return departTree;
    }

    /**
     * 打开快检机构界面
     *
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
        // 按钮操作权限
        List<BasePointType> types = pointTypeService.selectAllType();
        request.setAttribute("types", types);
        return new ModelAndView("/detect/depart/list");
    }

    @RequestMapping("/departManagementList")
    public ModelAndView departManagementList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        TSDepart depart = PublicUtil.getSessionUserDepart();
        // 按钮操作权限

        // 所有人员
        // List<BaseWorkers> workers = baseWorkersService.queryAll();

        map.put("depart", depart);
        // map.put("workers", workers);
        BaseRegion country = regionService.queryById(1);
        List<BaseRegion> provinces = regionService.querySubRegionById(country.getRegionId());
        request.setAttribute("country", country);
        request.setAttribute("provinces", provinces);
        return new ModelAndView("/detect/depart/departManagementList", map);
    }

    /**
     * 获取下级机构和下级检测点
     *
     * @param departId       机构ID
     * @param dataType 1:下级机构和下级检测点;2:下级机构;3:下级检测点
     * @return
     */
    @RequestMapping("/queryByDepartId")
    public AjaxJson queryByDepartId(HttpServletRequest request, HttpServletResponse response, Integer departId, String dataType) {
        AjaxJson aj = new AjaxJson();
        Map<String, Object> map = new HashMap<String, Object>();

        try {

            if ("1".equals(dataType)) {// 下级机构和下级检测点

                // 获取下级检测点
                List<BasePoint> points = basePointService.selectByDepartid(departId,null);
                List<Map<String, Object>> pointInfos = new ArrayList<Map<String, Object>>();
                for (BasePoint point : points) {
                    Map<String, Object> map1 = new HashMap<String, Object>();
                    // 负责人
                    BaseWorkers manager = baseWorkersService.queryById(point.getManagerId());
                    List<BasePointUser> members = basePointUserService.queryByPointId(point.getId());
                    // 仪器
                    List<BaseDevice> devices = baseDeviceService.queryAllDeviceByPointId(point.getId(), null, "仪器设备");
                    // 温湿度数据
//                    BaseEnvironmentManage manage = manageService.queryByLastTime(point.getId());
//
//                    map1.put("manage", manage);
                    map1.put("point", point);
                    map1.put("manager", manager);
                    map1.put("devicesSize", devices.size());
                    map1.put("membersSize", members.size());
                    pointInfos.add(map1);
                }
                map.put("pointInfos", pointInfos);

                // 获取下级机构
                List<TSDepart> departs = departService.getDepartsByPid(departId);// 下级检测机构
                List<Map<String, Object>> departInfos = new ArrayList<Map<String, Object>>();
                for (TSDepart depart : departs) {
                    Map<String, Object> map1 = new HashMap<String, Object>();
                    // 直管检测点
                    List<BasePoint> points1 = basePointService.selectByDepartid(depart.getId(),null);
                    // 直管检测点成员
                    List<BasePointUser> members = basePointUserService.getSubPointUsers(depart.getId());
                    // 下级检测机构
                    List<TSDepart> departs1 = departService.getDepartsByPid(depart.getId());

                    map1.put("depart", depart);
                    map1.put("subDepartSize", departs1.size());
                    map1.put("subPointSize", points1.size());
                    map1.put("membersSize", members.size());
                    departInfos.add(map1);
                }
                map.put("departInfos", departInfos);

            } else if ("2".equals(dataType)) {// 下级机构

                // 获取下级机构
                List<TSDepart> departs = departService.getDepartsByPid(departId);// 下级检测机构
                List<Map<String, Object>> departInfos = new ArrayList<Map<String, Object>>();
                for (TSDepart depart : departs) {
                    Map<String, Object> map1 = new HashMap<String, Object>();
                    // 直管检测点
                    List<BasePoint> points1 = basePointService.selectByDepartid(depart.getId(),null);
                    // 直管检测点成员
                    List<BasePointUser> members = basePointUserService.getSubPointUsers(depart.getId());
                    // 下级检测机构
                    List<TSDepart> departs1 = departService.getDepartsByPid(depart.getId());

                    map1.put("depart", depart);
                    map1.put("subDepartSize", departs1.size());
                    map1.put("subPointSize", points1.size());
                    map1.put("membersSize", members.size());
                    departInfos.add(map1);
                }
                map.put("departInfos", departInfos);

            } else if ("3".equals(dataType)) {// 下级检测点

                // 获取下级检测点
                List<BasePoint> points = basePointService.selectByDepartid(departId,null);
                List<Map<String, Object>> pointInfos = new ArrayList<Map<String, Object>>();
                for (BasePoint point : points) {
                    Map<String, Object> map1 = new HashMap<String, Object>();
                    // 负责人
                    BaseWorkers manager = baseWorkersService.queryById(point.getManagerId());
                    List<BasePointUser> members = basePointUserService.queryByPointId(point.getId());
                    // 仪器
                    List<BaseDevice> devices = baseDeviceService.queryAllDeviceByPointId(point.getId(), null, "仪器设备");
                    // 温湿度数据
//                    BaseEnvironmentManage manage = manageService.queryByLastTime(point.getId());
//
//                    map1.put("manage", manage);
                    map1.put("point", point);
                    map1.put("manager", manager);
                    map1.put("devicesSize", devices.size());
                    map1.put("membersSize", members.size());
                    pointInfos.add(map1);
                }
                map.put("pointInfos", pointInfos);
            }

            aj.setObj(map);

        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
        }

        return aj;
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    public AjaxJson datagrid(DepartModel model, Page page, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            // 获取当前用户信息
            TSDepart userDepart = PublicUtil.getSessionUserDepart();
            if (null == model.getDepart()) {
                TSDepart depart = new TSDepart();
                depart.setDepartPid(userDepart.getId());
                model.setDepart(depart);
            }
            /*else if (null == model.getDepart()&&null!=model.getDepart().getDepartName()) {

			} */
            else if (null == model.getDepart().getDepartPid() && null == model.getDepart().getDepartName()) {
                model.getDepart().setDepartPid(userDepart.getId());
            }

            page = departService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 添加/修改
     *
     * @param depart
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    @SystemLog(module = "机构管理",methods = "新增与编辑",type = 1,serviceClass = "TSDepartServiceImpl",parameterType = "Serializable",queryMethod = "getById")
    public AjaxJson save(TSDepart depart, @RequestParam(value="systemLogoImg",required=false) MultipartFile file) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            List<TSDepart> sames = departService.queryByDepartName(depart.getDepartName());
            if (sames.size() > 0 && !sames.get(0).getId().equals(depart.getId())) {
                // 机构是否存在
                jsonObject.setSuccess(false);
                jsonObject.setMsg("新增失败，机构名称已存在！");
                return jsonObject;

            //修改机构信息
            } else if (StringUtil.isNotEmpty(depart.getId())) {
                // 获取当前机构和其下属机构ID
                List<TSDepart> sDeparts = departService.getAllSonDepartsByID(depart.getId());
                List<Integer> sdepartIds = new ArrayList<Integer>();
                if (sDeparts != null && sDeparts.size() > 0) {
                    for (TSDepart sDepart : sDeparts) {
                        sdepartIds.add(sDepart.getId());
                    }
                }

                TSDepart odepart =departService.getById(depart.getId());
                //顶级机构的所属机构可以选择其本身，后台不更新
                if (odepart.getDepartPid() == null && depart.getId().equals(depart.getDepartPid())) {
                    depart.setDepartPid(null);
                }

                if (!sdepartIds.contains(depart.getDepartPid())) {
                    //不是顶级机构，刷新depart_code
                    if (depart.getDepartPid() != null){
                        TSDepart pdepart = departService.getById(depart.getDepartPid());
                        String lastCode = departService.getLastDepartCode(pdepart.getDepartCode());
                        String code = GlobalConfig.getInstance().getNextCode(2, lastCode, pdepart.getDepartCode());

                        if (depart.getDepartCode() == null) {
                            depart.setDepartCode(code);
                        } else {
                            String pre1 = "";
                            if (StringUtil.isNotEmpty(depart.getDepartCode())) {
                                pre1 = depart.getDepartCode().substring(0, depart.getDepartCode().length() - 2);
                            }
                            String pre2 = code.substring(0, code.length() - 2);
                            if (depart.getDepartCode().length() != code.length() || !pre1.equals(pre2)) {
                                depart.setDepartCode(code);
                            }
                        }
                    }
                    if (null == depart.getDescription()) {
                        depart.setDescription("");
                    }
                    if (null == depart.getMobilePhone()) {
                        depart.setMobilePhone("");
                    }
                    if (null == depart.getAddress()) {
                        depart.setAddress("");
                    }
                    if (null == depart.getSorting()) {
                        depart.setSorting((short) 1);
                    }
                    if (null == depart.getSystemLogo()) {
                        depart.setSystemLogo("");
                    }
                    if (null == depart.getSystemName()) {
                        depart.setSystemName("");
                    }
                    if (null == depart.getSystemCopyright()) {
                        depart.setSystemCopyright("");
                    }

                    //保存系统LOGO
                    if (file != null) {
                        //文件目录
                        String fPath1 = filePath + "systemLogoImg" + "/";
                        //文件名
                        String fName1 = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());
                        //保存附件
                        String fileName1 = uploadFile(null, fPath1, file, fName1);
                        depart.setSystemLogo(fPath1 + fileName1);
                    }

                    PublicUtil.setCommonForTable(depart, false);
                    departService.saveOrUpdate(depart);

                    if (odepart.getSorting() != depart.getSorting()) {
                        //刷新上级机构下的所有机构编号
                        TSDepart pDepart = departService.getById(depart.getDepartPid());
                        recursionResetDepartCode(pDepart);
                    }

                } else {
                    // 所属机构为当前机构或其下属机构
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("所属机构不能为当前机构或其下属机构");
                    return jsonObject;
                }

            } else {
                TSDepart pdepart = departService.getById(depart.getDepartPid());
                String lastCode = departService.getLastDepartCode(pdepart.getDepartCode());
                String code = GlobalConfig.getInstance().getNextCode(2, lastCode, pdepart.getDepartCode());
                depart.setDepartCode(code);
                depart.setDeleteFlag((short) 0);

                //保存系统LOGO
                if (file != null) {
                    //文件目录
                    String fPath1 = filePath + "systemLogoImg" + "/";
                    //文件名
                    String fName1 = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());
                    //保存附件
                    String fileName1 = uploadFile(null, fPath1, file, fName1);
                    depart.setSystemLogo(fPath1 + fileName1);
                }

                PublicUtil.setCommonForTable(depart, true);
                departService.saveOrUpdate(depart);

                //刷新上级机构下的所有机构编号
                TSDepart pDepart = departService.getById(depart.getDepartPid());
                recursionResetDepartCode(pDepart);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("保存失败");
        }
        Map<String,Object> map=new HashMap<>();
        map.put("id",depart.getId());
        jsonObject.setAttributes(map);
        return jsonObject;
    }

    /**
     * 批量新增
     *
     * @param departPid 父机构ID
     * @param departNames   机构名称（多个以,隔开）
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/batchAdd")
    @SystemLog(module = "机构管理",methods = "批量新增",type = 1,serviceClass = "TSDepartServiceImpl")
    public AjaxJson batchAdd(Integer departPid, String departNames) {
        AjaxJson aj = new AjaxJson();
        try {
            TSDepart pDepart = departService.getById(departPid);
            String[] names = departNames.split(",");

            //判断新增机构名称是否重复
            List<String> stringList=new ArrayList<>(Arrays.asList(names));
            Set<String> stringSet=new HashSet<>(stringList);
            if (stringList.size() != stringSet.size()) {
                aj.setSuccess(false);
                aj.setMsg("新增失败，新增机构名称重复！");
                return aj;
            }

            Short maxSorting = departService.queryMaxSortByPid(departPid);

            //已存在机构名称
            StringBuffer existNames = new StringBuffer();
            //判断新增机构名称是否已存在
            for (String name : names) {
                if (!StringUtils.isBlank(name)) {
                    List<TSDepart> sames = departService.queryByDepartName(name);
                    if (sames.size() > 0) {
                        // 机构已存在
                        aj.setSuccess(false);
                        existNames.append(name).append(",");
                    }
                }
            }

            //批量新增
            if (aj.isSuccess()) {
                for (String name : names) {
                    if (!StringUtils.isBlank(name)) {
                        TSDepart depart = new TSDepart();
                        depart.setDepartPid(departPid);
                        depart.setDepartName(name);
                        depart.setSorting(++maxSorting);
                        depart.setDeleteFlag((short) 0);
                        PublicUtil.setCommonForTable(depart,true);
                        departService.saveOrUpdate(depart);
                    }
                }

            } else {
                existNames.deleteCharAt(existNames.length()-1);
                aj.setSuccess(false);
                aj.setMsg("新增失败，机构名称["+existNames.toString()+"]已存在！");
                return aj;
            }

            //刷新上级机构下的所有机构编号
            recursionResetDepartCode(pDepart);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("保存失败");
        }
        return aj;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       检测机构id
     * @param response
     * @throws Exception
     */
    @RequestMapping("/queryById")
    public AjaxJson queryById(Integer id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            TSDepart depart = departService.getById(id);
            if (depart == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            } else {
                DepartModel departModel = new DepartModel();
                TSDepart superior = departService.getById(depart.getDepartPid());
                BaseWorkers worker = baseWorkersService.queryById(depart.getPrincipalId());
                departModel.setRegionIds(depart.getRegionId().split(","));
                departModel.setDepart(depart);
                departModel.setSuperior(superior);
                departModel.setPrincipal(worker);
                jsonObject.setObj(departModel);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }

    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param request
     * @param response
     * @param ids      要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    @SystemLog(module = "机构管理",methods = "删除",type = 3,serviceClass = "TSDepartServiceImpl")
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            String[] idArray = ids.split(",");
            Integer[] idArr = new Integer[idArray.length];
            for (int i = 0; i < idArray.length; i++) {
                idArr[i] = Integer.parseInt(idArray[i]);
            }
            departService.deleteDeparts(idArr);
        } catch (MyException e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg(e.getMessage());
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping(value = "/exportFile")
    public ResponseEntity<byte[]> exportFile(HttpServletRequest request, HttpServletResponse response, HttpSession session, String types, Integer departId) {
        ResponseEntity<byte[]> responseEntity = null;
        String rootPath = WebConstant.res.getString("resources") + WebConstant.res.getString("storageDirectory") + "depart/";
        File logoSaveFile = new File(rootPath);
        if (!logoSaveFile.exists()) {
            logoSaveFile.mkdirs();
        }
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
        try {
			/* XSSFWorkbook workbook = null; */
            SXSSFWorkbook ssbook = null;
            TSDepart t = departService.getById(departId);
            // String subIdsStr = departService.querySubDeparts(departId);
            // String [] subIds = subIdsStr.split(",");
            // List<TSDepart> list =
            // departService.getSonDepartsByIds(subIds,null);
            List<TSDepart> list = departService.getSonDepartsById(t.getDepartCode());
            //departService.queryByDepartCode(t.getDepartCode());
            //list.remove(list.size() - 1);
            //list.remove(0);

            if ("word".equals(types)) {
                String docName = fileName + ".doc";
                ItextTools.createDepartWordDocument(rootPath, rootPath + docName, Excel.DEPART_MONTH_HEADERS, list, null, request);
                responseEntity = DyFileUtil.download(request, response, rootPath, docName);
                return responseEntity;
            }

            String xlsName = fileName + ".xlsx";
            ssbook = new SXSSFWorkbook(100);
            Excel.outputExcelFile(ssbook, Excel.DEPART_MONTH_HEADERS, Excel.DEPART_MONTH_FIELDS, list, rootPath + xlsName, "1","");
            FileOutputStream fOut = new FileOutputStream(rootPath + xlsName);
            ssbook.write(fOut);
            fOut.flush();
            fOut.close();
            if ("excel".equals(types)) {
                responseEntity = DyFileUtil.download(request, response, rootPath, xlsName);
            } else if ("pdf".equals(types)) {
                if (!getLicense()) {
                    return null;
                }
                Workbook wb = new Workbook(rootPath + xlsName);
                String pdfName = fileName + ".pdf";
                wb.removeExternalLinks();
                wb.save(new FileOutputStream(new File(rootPath + pdfName)), SaveFormat.PDF);
                responseEntity = DyFileUtil.download(request, response, rootPath, pdfName);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }

        return responseEntity;
    }

    public static boolean getLicense() {
        boolean result = false;
        try {
            InputStream is = BaseController.class.getClassLoader().getResourceAsStream("\\license.xml");
            License aposeLic = new License();
            aposeLic.setLicense(is);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/toImport")
    private ModelAndView toImport(HttpServletRequest request) throws JSONException {
        return new ModelAndView("/detect/depart/toImport");
    }

    @RequestMapping("/importData")
    public AjaxJson importData(@RequestParam("xlsx") MultipartFile file, HttpServletRequest request, HttpServletResponse response, HttpSession session, Integer departId, String departNames) {
        AjaxJson jsonObject = new AjaxJson();
        Timestamp stamp = new Timestamp(System.currentTimeMillis());
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS") + ".xlsx";
        FileOutputStream fos = null;
        String path = WebConstant.res.getString("resources") + "depart/";
        int successCount = 0;
        int failCount = 0;
        List<ImportBaseData> errList = new ArrayList<ImportBaseData>();
        TSUser user = (TSUser) session.getAttribute(WebConstant.SESSION_USER);

        try {
            fos = FileUtils.openOutputStream(new File(path + "/" + fileName));
            IOUtils.copy(file.getInputStream(), fos);
            org.apache.poi.ss.usermodel.Workbook workBook = WorkbookFactory.create(new FileInputStream(new File(path + "/" + fileName)));
            Sheet sheet = workBook.getSheetAt(0);
            Row row = null;
            TSDepart d = departService.getById(departId);
            int totalRow = sheet.getLastRowNum();
            for (int i = 2; i <= totalRow; i++) {
                row = sheet.getRow(i);
                if (null == row) continue;
                if (isEmptyRow(row)) {
                    continue;
                }
                String departName = getCellValue(row.getCell(0));// 机构名称,必填
                String departPName = getCellValue(row.getCell(1));// 上级机构,必填
                String address = getCellValue(row.getCell(2));// 地址
                String description = getCellValue(row.getCell(3));// 描述

                if (StringUtil.isEmpty(departName)) {
                    addToErrList(errList, departName, departPName, address, description, "机构名称不能为空");
                    failCount++;
                    continue;
                }
                if (StringUtil.isEmpty(departPName)) {
                    addToErrList(errList, departName, departPName, address, description, "上级机构不能为空");
                    failCount++;
                    continue;
                }

                List<TSDepart> subDeparts = departService.selectByDepartCodeAndDepartName(d.getDepartCode(), departName);
                if (subDeparts.size() == 0) {
                    List<TSDepart> pDeparts = departService.selectByDepartCodeAndDepartName(d.getDepartCode(), departPName);
                    if (pDeparts.size() == 0) {
                        addToErrList(errList, departName, departPName, address, description, "上机机构：[" + departPName + "]不存在");
                        failCount++;
                        continue;
                    }
                    TSDepart tsDepart = new TSDepart();
                    tsDepart.setDepartName(departName);
                    tsDepart.setDepartPid(pDeparts.get(0).getId());
                    tsDepart.setAddress(address);
                    tsDepart.setDescription(description);

                    String lastcode = departService.getLastDepartCode(pDeparts.get(0).getDepartCode());
                    String code = GlobalConfig.getInstance().getNextCode(2, lastcode, pDeparts.get(0).getDepartCode());
                    tsDepart.setDepartCode(code);

                    PublicUtil.setCommonForTable(tsDepart, true);
                    departService.saveOrUpdate(tsDepart);
                    successCount++;
                } else {
                    addToErrList(errList, departName, departPName, address, description, d.getDepartName() + "机构下已存在相同名称为：[" + departName + "]的机构");
                    failCount++;
                    continue;
                }
            }
            String errFile = null;
            if (errList.size() > 0) {
                errFile = fileName.substring(0, fileName.indexOf(".")) + "_err.xlsx";
                SXSSFWorkbook wb = new SXSSFWorkbook(100);
                Excel.outputExcelFile(wb, ImportBaseData.headers, ImportBaseData.fields, errList, path + errFile, "1","");
                FileOutputStream fOut = new FileOutputStream(path + "/" + errFile);
                wb.write(fOut);
                fOut.flush();
                fOut.close();
            }
            TBImportHistory t = new TBImportHistory();
            t.setDepartId(departId);
            t.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
            t.setDepartName(departNames);
            t.setUserId(user.getId());
            t.setUsername(user.getRealname());
            t.setSourceFile("/depart/" + fileName);
            t.setErrFile(errFile == null ? null : "/depart/" + errFile);
            t.setSuccessCount(successCount);
            t.setFailCount(failCount);
            t.setImportDate(stamp);
            t.setImportType(5);
            t.setEndDate(new Date());
            importHistoryService.insertSelective(t);
            jsonObject.setMsg(errFile);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("导入失败");
        } finally {
            try {
                fos.close();
            } catch (IOException e) {
                log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            }
        }
        return jsonObject;
    }

    private void addToErrList(List<ImportBaseData> errList, String departName, String departPName, String address, String description, String errMsg) {
        ImportBaseData d = new ImportBaseData();
        d.setDepartName(departName);
        d.setDepartPName(departPName);
        d.setAddress(address);
        d.setDescription(description);
        d.setErrMsg(errMsg);
        errList.add(d);
    }

    public static class ImportBaseData {
        public static String[] headers = {"机构名称", "上级机构", "地址", "描述", "导入失败原因"};
        public static String[] fields = {"departName", "departPName", "address", "description", "errMsg"};
        String departName;// 机构名称
        String departPName;// 上级机构
        String address;// 地址
        String description;// 描述
        String errMsg;// 导入失败原因

        public static String[] getHeaders() {
            return headers;
        }

        public static void setHeaders(String[] headers) {
            ImportBaseData.headers = headers;
        }

        public static String[] getFields() {
            return fields;
        }

        public static void setFields(String[] fields) {
            ImportBaseData.fields = fields;
        }

        public String getDepartName() {
            return departName;
        }

        public void setDepartName(String departName) {
            this.departName = departName;
        }

        public String getDepartPName() {
            return departPName;
        }

        public void setDepartPName(String departPName) {
            this.departPName = departPName;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getErrMsg() {
            return errMsg;
        }

        public void setErrMsg(String errMsg) {
            this.errMsg = errMsg;
        }
    }

    @RequestMapping("/resetDepartCode")
    public AjaxJson resetDepartCode(@RequestParam(defaultValue = "1") Integer topDepartId) throws Exception {
        AjaxJson json = new AjaxJson();
        //传顶级机构的id，查询该机构信息
        TSDepart depart = departService.getById(topDepartId);
        depart.setDepartCode("01");
        departService.saveOrUpdate(depart);
        recursionResetDepartCode(depart);
        return json;
    }

    /**
     * 更新当前机构的下级机构编码
     * @param depart
     * @throws Exception
     */
    private void recursionResetDepartCode(TSDepart depart) throws Exception {
        if (null == depart) {
            return;
        }
//        List<TSDepart> subDeparts = departService.getDepartsByPid(depart.getId());
//        for (int i = 0; i < subDeparts.size(); i++) {
//            String lastCode = departService.getLastDepartCode(depart.getDepartCode());
//            //2，代表生成三位数的code
//            String code = GlobalConfig.getInstance().getNextCode(2, lastCode, depart.getDepartCode());
//            TSDepart d = subDeparts.get(i);
//            if (d.getDepartCode() == null) {
//                d.setDepartCode(code);
//                departService.updateBySelective(d);
//            } else {
//                String pre1 = "";
//                String pre2 = code.substring(0, code.length() - 2);
//                if (StringUtil.isNotEmpty(d.getDepartCode())) {
//                    pre1 = d.getDepartCode().substring(0, d.getDepartCode().length() - 2);
//                }
//                if (d.getDepartCode().length() != code.length() || !pre1.equals(pre2)) {
//                    d.setDepartCode(code);
//                    departService.updateBySelective(d);
//                }
//            }
//            recursionResetDepartCode(d);
//        }

        List<TSDepart> subDeparts = departService.getAllDepartsByPid(depart.getId());
        for (int i=1; i<=subDeparts.size(); i++) {
            TSDepart sd = subDeparts.get((i-1));
            String sdDepartCode = i < 10 ? "0"+i : ""+i;
            sd.setDepartCode(depart.getDepartCode()+sdDepartCode);
            departService.saveOrUpdate(sd);
            recursionResetDepartCode(sd);
        }
    }
    /****************************新检测点管理功能中查询树形机构：显示机构名称+（检测点数量）***********************************************/
    /**
     * 新检测点管理中获取机构列表：展示文斌为机构名称+（检测点数量）
     *
     * @param id  查询机构ID
     * @param pid 自定义机构ID
     * @return
     * @throws MissSessionExceprtion
     */
    @RequestMapping("/getDepartTreeForPoint")
    public List<TreeNode> getDepartTreeForPoint(HttpServletRequest request, HttpServletResponse response, Integer id, Integer pid,@RequestParam(required = false,defaultValue = "false") boolean isQueryPoint) throws Exception {
        List<TreeNode> departTree = null;
        if (StringUtil.isNotEmpty(id)) {
            // 机构节点ID，延迟加载数据
            departTree = departService.getDepartTreeForPoint(id, true,isQueryPoint);
        } else {
            if (StringUtil.isNotEmpty(pid)) {
                // 首次查询机构ID，扩展查询自定义机构树
                departTree = departService.getDepartTreeForPoint(pid, true,isQueryPoint);
            } else {
                // 当前用户所属机构
                departTree = departService.getDepartTreeForPoint(null, true,isQueryPoint);
            }
        }
        return departTree;
    }
}
