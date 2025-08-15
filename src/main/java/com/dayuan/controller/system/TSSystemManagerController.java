package com.dayuan.controller.system;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.bean.system.TSSystemManager;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MyException;
import com.dayuan.service.data.BaseDeviceTypeService;
import com.dayuan.service.system.TSSystemManagerService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.QrcodeUtil;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统软件版本管理
 *
 * @author Dz
 */
@Controller
@RequestMapping("/systemManager")
public class TSSystemManagerController extends BaseController {
    Logger log = Logger.getLogger(TSSystemManagerController.class);
    @Autowired
    private TSSystemManagerService tsSystemManagerService;
    @Autowired
    private BaseDeviceTypeService baseDeviceTypeService;
    @Value("${resources}")//引入上传路径
    private String resources;
    @Value("${softwarePath}")
    private String softwarePath;

    /**
     * 主界面
     */
    @RequestMapping("/appQrcode")
    public String appQrcode(Model model, String appType) {
        //全部软件最新版本信息
        try {
            //查询出类型
            List<String> appTypes = tsSystemManagerService.selectAppType();
            model.addAttribute("appTypes", appTypes);
            model.addAttribute("appType", appType);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return "/system/systemManager/software_download";
    }

    /**
     * 模态框新增编辑界面
     */
    @RequestMapping("/addModal")
    public String addModal(Model model, String appType, Integer id) {
        model.addAttribute("appType", appType);
        try {
            if (id != null) {
                TSSystemManager tsSystemManager = tsSystemManagerService.queryById(id);
                model.addAttribute("tsSystemManager", tsSystemManager);
            } else {
                //如果有id就不显示 是否平台上传，通过一个参数来控制它是否展示
                model.addAttribute("show", 1);
                //查询出类型
                List<Map<String, Object>> appTypes = baseDeviceTypeService.selectAppType();
                Map<String, Object> map = new HashMap();
                map.put("device_name", "APP");
                map.put("device_series", "APP");
                appTypes.add(map);
                //查询出所有简介,迭代依次放入appTypes中
                List<Map<String, Object>> Introduces = tsSystemManagerService.selectIntroduce();
                for (Map<String, Object> type : appTypes) {
                    for (Map<String, Object> introduce : Introduces) {
                        if (introduce.get("appType").equals(type.get("device_series"))) {
                            type.put("introduce", introduce.get("introduce"));
                        }
                    }
                }
                model.addAttribute("appTypes", appTypes);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return "/system/systemManager/add_modal";
    }

    /**
     * 软件下载二维码图片
     */
    @RequestMapping("/appQrcodeImg")
    public void appQrcodeImg(HttpServletResponse response, String url, String urlPath) {
        try {
            url = url + "?urlPath=" + urlPath;
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/jpeg");

            // 定义图像buffer
            if (StringUtil.isNotEmpty(url)) {
                BufferedImage buffImg = QrcodeUtil.generateQrcode(url, WebConstant.APP_QRCODE_WIDTH, WebConstant.APP_QRCODE_HEIGHT);
                // 将图像输出到Servlet输出流中
                ServletOutputStream sos = response.getOutputStream();
                ImageIO.write(buffImg, "jpeg", sos);
                sos.close();
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
    }

    /**
     * 相关下载主界面
     *
     * @param model            传递参数到界面的模型对象
     * @param appType          仪器类型
     * @param editPermission   编辑权限
     * @param deletePermission 删除权限
     * @return
     */
    @RequestMapping("/index")
    public String list(Model model, String appType, Integer editPermission, Integer deletePermission) {
        List<TSSystemManager> softwares = null;
        try {
            appType = StringUtil.isEmpty(appType) ? "APP" : appType;
            //查询出历史版本
            softwares = tsSystemManagerService.selectListAllHistorySoftware(DateUtil.datetimeFormat.format(new Date()), appType);
            //查询出当前使用的版本
            TSSystemManager tsSystemManager = tsSystemManagerService.selectInUse(DateUtil.datetimeFormat.format(new Date()), appType);
            //查询出所有未启用的软件
            List<TSSystemManager> notEnabledSystemManagers = tsSystemManagerService.selectNotEnabled(DateUtil.datetimeFormat.format(new Date()), appType);
            //查询出类型和图片
            List<BaseDeviceType> appTypeImgs = baseDeviceTypeService.selectAppTypeAndImg();
            //软件名称
            if (tsSystemManager != null) {
                model.addAttribute("appName", tsSystemManager.getAppName());
            } else if (notEnabledSystemManagers.size() > 0) {
                model.addAttribute("appName", notEnabledSystemManagers.get(0).getAppName());
            } else if (softwares.size() > 0) {
                model.addAttribute("appName", softwares.get(0).getAppName());
            }
            //查询出该软件是否有补丁包
            Integer patchNumber = tsSystemManagerService.selectPatchByType(appType);
            //软件简介
            model.addAttribute("appTypeImgs", appTypeImgs);
            model.addAttribute("appType", appType);
            model.addAttribute("softwares", softwares);
            model.addAttribute("tsSystemManager", tsSystemManager);
            model.addAttribute("notEnableds", notEnabledSystemManagers);
            //权限
            model.addAttribute("editPermission", editPermission);//编辑
            model.addAttribute("deletePermission", deletePermission);//删除
            //补丁包数量
            model.addAttribute("patchNumber", patchNumber);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return "/system/systemManager/index";
    }

    /**
     * 添加
     *
     * @param packageFile  安装包
     * @param documentFile 操作说明
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public AjaxJson saveCK(TSSystemManager tsSystemManager, @RequestParam(value = "file", required = false) MultipartFile packageFile, @RequestParam(value = "file2", required = false) MultipartFile documentFile) {
        AjaxJson json = new AjaxJson();
        try {
            String packageNewName = tsSystemManager.getFullName();//后台上传文件真实名称(包括后缀名) 赋值给 安装包文件的新名称
            String documentNewName = "";//操作说明文件的新名称
            Short uploadState = tsSystemManager.getUploadState();//是否平台上传(0:否 1:是)
            String path = TSSystemManager.getPath(tsSystemManager.getAppType());//根据软件类型获取其指定存储路径
            String url = resources + softwarePath + path;//拼接完整的安装包存放路径

            //创建目录:如果不存在存储文件的目录就创建该目录
            File fp = new File(url);
            if (!fp.exists()) {
                boolean result = fp.mkdirs();
                if (!result) {
                    throw new MyException("创建文件目录失败!");
                }
            }

            if (tsSystemManager.getId() == null) {//新增
                if (packageFile != null && !packageFile.isEmpty()) {
                    if (uploadState == null || uploadState == 1) { //如果是平台上传
                        String fileName = packageFile.getOriginalFilename();//获取文件名
                        String extName = fileName.substring(fileName.lastIndexOf(".")); //文件扩展名
                        packageNewName = tsSystemManager.getAppName() + "_" + tsSystemManager.getVersions() + "_" + DateUtil.yyyyMMdd.format(tsSystemManager.getImpDate()) + extName;//拼接一个新的名字保存如数据库
                    }
                    packageFile.transferTo(new File(url + packageNewName));//文件上传-转存文件（安装包）
                    // tsSystemManager.setUrlPath(softwarePath + path + packageNewName);//设置安装包文件路径
                }
                if (StringUtil.isNotEmpty(packageNewName)) {
                    tsSystemManager.setUrlPath(softwarePath + path + packageNewName);//设置安装包文件路径
                }
                if (documentFile != null && !documentFile.isEmpty()) {
                    String fileName = documentFile.getOriginalFilename();//获取文件名
                    String extName = fileName.substring(fileName.lastIndexOf(".")); //文件扩展名
                    documentNewName = tsSystemManager.getAppName() + "操作说明_" + tsSystemManager.getVersions() + "_" + DateUtil.yyyyMMdd.format(tsSystemManager.getImpDate()) + extName;//拼接一个新的名字保存如数据库
                    documentFile.transferTo(new File(url + documentNewName));//文件上传-转存文件（安装包）
                    tsSystemManager.setParam3(softwarePath + path + documentNewName);//设置安装包文件路径
                }
                PublicUtil.setCommonForTable(tsSystemManager, true);
                tsSystemManagerService.insert(tsSystemManager);//新增
                json.setMsg("上传成功");
            } else {//编辑
                //查询一次旧文件路径（不通过前台传递过来了），删除旧文件
                TSSystemManager tsmger = tsSystemManagerService.queryById(tsSystemManager.getId());
                String oldDocumentPath = tsmger.getParam3();//旧文档路径
                String oldPackgePath = tsmger.getUrlPath();//旧安装包路径

                //1.判断是否需要删除旧文件(存在新文件就删除旧文件)
                if (packageFile != null && !packageFile.isEmpty()) {
                    deleteFile(oldPackgePath);
                    //if (uploadState == null || uploadState == 1) { //如果是平台上传
                    String fileName = packageFile.getOriginalFilename();//获取文件名
                    String extName = fileName.substring(fileName.lastIndexOf(".")); //文件扩展名
                    packageNewName = tsSystemManager.getAppName() + "_" + tsSystemManager.getVersions() + "_" + DateUtil.yyyyMMdd.format(tsSystemManager.getImpDate()) + extName;//拼接一个新的名字保存如数据库
                    //}
                    packageFile.transferTo(new File(url + packageNewName));//文件上传-转存文件（安装包）
                    tsSystemManager.setUrlPath(softwarePath + path + packageNewName);//设置安装包文件路径
                } else {
                    if (StringUtil.isNotEmpty(tsmger.getUrlPath()) && StringUtil.isEmpty(tsSystemManager.getUrlPath())) {
                        deleteFile(oldPackgePath);
                    }

                }

                if (documentFile != null && !documentFile.isEmpty()) {
                    deleteFile(oldDocumentPath);
                    String fileName = documentFile.getOriginalFilename();//获取文件名
                    String extName = fileName.substring(fileName.lastIndexOf(".")); //文件扩展名
                    documentNewName = tsSystemManager.getAppName() + "操作说明" + DateUtil.yyyyMMdd.format(tsSystemManager.getImpDate()) + extName;//拼接一个新的名字保存如数据库
                    documentFile.transferTo(new File(url + documentNewName));//文件上传-转存文件（安装包）
                    tsSystemManager.setParam3(softwarePath + path + documentNewName);//设置安装包文件路径
                } else {
                    if (StringUtil.isNotEmpty(tsmger.getParam3()) && StringUtil.isEmpty(tsSystemManager.getParam3())) {
                        deleteFile(oldDocumentPath);
                    }
                }

                PublicUtil.setCommonForTable(tsSystemManager, false);
                tsSystemManagerService.updateById(tsSystemManager);//编辑
                json.setMsg("上传成功");
            }
        } catch (MyException e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            json.setSuccess(false);
            json.setMsg(e.getMessage());
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }

    private void deleteFile(String path) {
        if (StringUtil.isNotEmpty(path)) {
            File file2 = new File(resources + path);
            if (!file2.isDirectory()) {//如果文件没有被销毁，则销毁该文件
                boolean delete = file2.delete();
                if (!delete) {
                    System.out.println("*****************删除相关下载旧文件失败******************");
                }
            }
        }
    }


    /**
     * 编辑数据回显
     *
     * @param id
     * @return
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(Integer id) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            TSSystemManager tsSystemManager = tsSystemManagerService.queryById(id);
            jsonObject.setObj(tsSystemManager);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }


    /**
     * 删除和批量删除方法
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson trainDelete(Integer id) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            TSSystemManager tsm = tsSystemManagerService.queryById(id);
            deleteFile(tsm.getParam3());
            deleteFile(tsm.getUrlPath());
            tsSystemManagerService.delete(id);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("删除失败");
        }
        return jsonObject;
    }


    /**
     * 补丁包下载界面
     */
    @RequestMapping("/patchDownload")
    public String patchDownload(Model model, String type, Integer editPermission, Integer deletePermission) {
        List<TSSystemManager> softwares = null;
        try {
            //查询出当前使用的版本（补丁包）
            TSSystemManager tsSystemManager = tsSystemManagerService.selectInUse2(DateUtil.datetimeFormat.format(new Date()), type);
            //查询出历史版本（补丁包）
            softwares = tsSystemManagerService.selectListAllHistorySoftware2(DateUtil.datetimeFormat.format(new Date()), type);
            //查询出所有未启用的软件（补丁包）
            List<TSSystemManager> notEnabledSystemManagers = tsSystemManagerService.selectNotEnabled2(DateUtil.datetimeFormat.format(new Date()), type);
            //查询出类型和图片
            List<BaseDeviceType> appTypeImgs = baseDeviceTypeService.selectAppTypeAndImg();
            //查询出类型
            model.addAttribute("appTypeImgs", appTypeImgs);
            model.addAttribute("tsSystemManager", tsSystemManager);
            model.addAttribute("softwares", softwares);
            model.addAttribute("notEnableds", notEnabledSystemManagers);
            //权限
            model.addAttribute("editPermission", editPermission);//编辑
            model.addAttribute("deletePermission", deletePermission);//删除
            //软件类型
            model.addAttribute("appType", type);//删除
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/system/systemManager/patchDownload";
    }


    /**
     * 模态框新增编辑界面(补丁包)
     */
    @RequestMapping("/patchAddModal")
    public String patchAddModal(Model model, String appType, Integer id, Integer editPermission, Integer deletePermission) {
        model.addAttribute("appType", appType);
        try {
            if (id != null) {
                TSSystemManager tsSystemManager = tsSystemManagerService.queryById(id);
                model.addAttribute("tsSystemManager", tsSystemManager);
                //权限
                model.addAttribute("editPermission", editPermission);//编辑
                model.addAttribute("deletePermission", deletePermission);//删除
            } else {
                //如果有id就不显示 是否平台上传，通过一个参数来控制它是否展示
                model.addAttribute("show", 1);
                //查询出类型
                List<Map<String, Object>> appTypes = baseDeviceTypeService.selectAppType();
                Map<String, Object> map = new HashMap();
                map.put("device_name", "APP");
                map.put("device_series", "APP");
                appTypes.add(map);
                model.addAttribute("appTypes", appTypes);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return "/system/systemManager/patch_add_modal";
    }


    /**
     * 扫描二维码软件下载界面
     */
    @RequestMapping("/download")
    public String download(Model model, String urlPath) {
        model.addAttribute("urlPath", urlPath);
        return "/system/systemManager/download";
    }
}
