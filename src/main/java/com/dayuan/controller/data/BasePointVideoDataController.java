package com.dayuan.controller.data;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePouintVideoData;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.data.BasePointVideoDataModel;
import com.dayuan.service.data.BasePointVideoDataService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Date;

/**
 * @author shit
 * @project 视屏上传
 * @date 2018年5月9日
 */
@Controller
@RequestMapping("/video")
public class BasePointVideoDataController extends BaseController {

    private final Logger log = Logger.getLogger(BasePointVideoDataController.class);

    @Autowired
    private BasePointVideoDataService videoDataService;
    @Value("${resources}")//引入上传路径
    private String videoPath;
    @Value("${videoPath}")
    private String videoPath2;

    @RequestMapping("/videos")
    public String personal_train_all(Model model, HttpServletRequest request) throws Exception {
        model.addAttribute("videoPath", "/resources/");
        return "/data/video/video_data";
    }

    /**
     * 列表
     *
     * @param model
     * @param page
     * @return
     * @author dy
     * @throws MissSessionExceprtion 
     * @date 2018年4月11日
     */
    @RequestMapping("/datagrid")
    public @ResponseBody
    AjaxJson trainListDate(BasePointVideoDataModel model, Page page) throws MissSessionExceprtion {
        AjaxJson jsonObj = new AjaxJson();
        TSUser tsUser = PublicUtil.getSessionUser();
        page.setOrder("desc");
        try {
            page = videoDataService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return jsonObj;
    }

    /**
     * 添加
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveUP")
    @ResponseBody
    public AjaxJson saveCK(BasePouintVideoData videoData) throws Exception {
        AjaxJson json = new AjaxJson();
        MultipartFile file = videoData.getFile();
        TSUser tsUser = PublicUtil.getSessionUser();
        try {
            if (!file.isEmpty()) {
                String url = videoPath + videoPath2;//视频存放的路径
                String fileName = file.getOriginalFilename();//获取文件名
                String extName = fileName.substring(fileName.lastIndexOf(".")); //文件扩展名
                String newName = System.currentTimeMillis() + extName;//拼接一个新的名字保存如数据库

                //创建目录
                String path = url + newName;
                File createPathFile = new File(path);
                if (!createPathFile.getParentFile().exists()) {
                    boolean result = createPathFile.getParentFile().mkdirs();
                    if (!result) {
                        System.out.println("创建失败");
                    }
                }
                // 判断文件是否为空
                //String filePath = request.getSession().getServletContext().getRealPath("E:/upload") + url + newName;
                String filePath = url + newName;
                videoData.setSrc(videoPath2 + newName);
                if (!StringUtils.hasLength(videoData.getTitle())) {
                    videoData.setTitle(fileName.substring(0, file.getOriginalFilename().lastIndexOf(".")));
                }
                if (videoData.getId() != null) {
                    //把该行对应的视屏文件路径查询出来,根据路径删除该视屏文件
                    String src = videoDataService.selectSrcById(videoData.getId());
                    File file2 = new File(src);
                    if (!file2.isDirectory()) {//如果文件没有被销毁，则删除
                        file2.delete();
                    }
                    videoData.setUpdateDate(new Date());
                    videoData.setUpdateBy(tsUser.getId());
                    videoDataService.updateById(videoData);//编辑
                } else {
                    videoData.setUptime(new Date());
                    videoData.setUserId(tsUser.getId());
                    videoDataService.insert(videoData);//新增
                }
                // 转存文件
                file.transferTo(new File(filePath));
            }
            //如果文件为空,就只是编辑别的信息,视屏信息不动他
            if (file.isEmpty() && videoData.getId() != null) {
                videoData.setUpdateDate(new Date());
                videoData.setUpdateBy(tsUser.getId());
                videoDataService.updateBySelective(videoData);//编辑
            }

        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }


    /**
     * 删除和批量删除方法
     *
     * @param ids
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson trainDelete(HttpServletRequest request, String ids) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            String[] ida = ids.split(",");
            for (String s : ida) {
                //把该行对应的视屏文件路径查询出来,根据路径删除该视屏文件
                String src = videoDataService.selectSrcById(Integer.valueOf(s));
                File file = new File(videoPath + src);
                if (!file.isDirectory()) {//如果文件没有被销毁，则删除
                    file.delete();
                }
            }
            videoDataService.delete(ida);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("删除失败");
        }
        return jsonObject;
    }


    /**
     * 编辑数据回显
     *
     * @param id
     * @return
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(String id) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            BasePouintVideoData videoData = videoDataService.queryById(id);
            jsonObject.setObj(videoData);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }


    @RequestMapping("/download")
    public HttpServletResponse download(String path, Integer id, HttpServletResponse response) {
        try {
            // path是指欲下载的文件的路径。
            path = videoPath + path;
            File file = new File(path);
            // 取得文件名。
            String filename = file.getName();
            // 取得文件的后缀名。
            String ext = filename.substring(filename.lastIndexOf(".") + 1);
            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空responseE:/OpenSources/apache-tomcat-7.0.77/webapps/ROOT
            response.reset();
            // 设置response的Header System.out.println(new String(filename.getBytes())+"-------------------------");
            //查询出名字拼接上去此处保存原因: https://blog.csdn.net/linwei_1029/article/details/7010573
            String title = videoDataService.selectTitleById(id);
            title = new String(title.getBytes(StandardCharsets.UTF_8), "ISO8859-1");
            response.addHeader("Content-Disposition", "attachment;filename=" + title + "." + ext);
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
            return null;
        } catch (Exception ex) {
            log.error("******************************" + ex.getMessage() + ex.getStackTrace());
        }
        return response;
    }
}

