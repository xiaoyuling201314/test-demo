package com.dayuan.controller.dataCheck;

import com.alibaba.excel.EasyExcel;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.dataCheck.ImportDataCheckModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.excel.DataCheckListener;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @Description 检测数据导入
* @Date 2021/10/23 15:50
* @Author xiaoyl
* @Param
* @return
*/
@Controller
@RequestMapping("/import")
public class ImportDataCheckController extends BaseController {
    private final Logger log = Logger.getLogger(ImportDataCheckController.class);

    @Autowired
    private DataCheckRecordingService dataCheckRecordingService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private BaseRegulatoryObjectService regulatoryObjectService;
    @Autowired
    private TBImportHistoryService importHistoryService;
    @Autowired
    private BasePointService pointService;
    @Autowired
    private BaseRegulatoryBusinessService businessService;
    @Autowired
    private BaseFoodTypeService foodTypeService;
    @Autowired
    private BaseDetectItemService detectItemService;

    public static  Map<String, Map<String, Object>> foodMap=null;//样品 add by xiaoyuling 2021/10/26
    public static  Map<String, Map<String, Object>> itemMap=null;//样品 add by xiaoyuling 2021/10/26
    @Value("${resources}")
    private String resources;
    @Value("${storageDirectory}")
    private String storageDirectory;

    /**
     * 数据导入 List界面
     *
     * @param request
     * @return
     * @author LuoYX
     * @date 2018年5月12日
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, Integer importType) {
        request.setAttribute("importType", importType);
        return new ModelAndView("/dataCheck/import/list");
    }

    @RequestMapping("/toImport")
    public ModelAndView toImport(HttpServletRequest request, Integer type) {
        request.setAttribute("type", type);
        return new ModelAndView("/dataCheck/import/toImport");
    }

    @RequestMapping("/importData")
    public @ResponseBody
    AjaxJson importData(@RequestParam("file") MultipartFile file, TBImportHistory bean) throws MissSessionExceprtion {
        TSUser user = PublicUtil.getSessionUser();
        AjaxJson json = new AjaxJson();
        Date now = new Date();
        String resources = WebConstant.res.getString("resources");
        FileOutputStream fos = null;
        try {
            log.info("检测数据导入处理，开始时间："+DateUtil.datetimeFormat.format(new Date()));
            String section = resources + "checkdata/";
            String fName = DateUtil.formatDate(now, "yyyyMMddHHmmssSSS") + ".xlsx";
            File f = new File(section + fName);
            if (!f.getParentFile().exists()) {
                f.getParentFile().mkdirs();
            }
            fos = FileUtils.openOutputStream(f);
            IOUtils.copy(file.getInputStream(), fos);
            TSDepart d = departService.getById(bean.getDepartId());
            //1.写入导入记录：不管失败与否都有记录可查
            TBImportHistory t = new TBImportHistory(user.getId(),bean.getDepartId(),PublicUtil.getSessionUserDepart().getDepartCode(),bean.getDepartName(),user.getRealname(),"/checkdata/" + fName,now,1);
            importHistoryService.insert(t);
            //查询出机构下所有的检测点及数量
            List<Map<String, Object>> pointListMap = pointService.queryByDepartCode(d.getDepartCode(), "Y");
            //查询机构下的市场
            List<Map<String, Object>> regListMap = regulatoryObjectService.queryRegMapByDepartCode(d.getDepartCode(), "Y");
            //查询机构下的经营户
            List<Map<String, Object>> busListMap = businessService.queryBusMapByDepartCode(d.getDepartCode(), "Y");
            if(foodMap==null){//查询所有的样品
                foodMap = initAllFood();
            }
            if(itemMap==null){//查询所有检测项目
                itemMap=initAllItem();
            }
            Map<String, Map<String, Object>> pointMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < pointListMap.size(); i++) {
                Map<String, Object> p = pointListMap.get(i);
                String pointKey = (String) p.get("point_name");
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                map.put("departId", p.get("depart_id"));
                map.put("departName", p.get("depart_name"));
                map.put("count", p.get("count"));
                pointMap.put(pointKey, map);
            }
            Map<String, Map<String, Object>> regMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < regListMap.size(); i++) {
                Map<String, Object> p = regListMap.get(i);
                String regKey = (String) p.get("reg_name");
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                map.put("regType", p.get("reg_type"));
                map.put("count", p.get("count"));
                map.put("showBusiness", p.get("show_business"));
                regMap.put(regKey, map);
            }
            Map<String, Map<String, Object>> busMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < busListMap.size(); i++) {
                Map<String, Object> p = busListMap.get(i);
                String busKey = p.get("ope_shop_code") + "";
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                map.put("opeShopCode", p.get("ope_shop_code"));
                map.put("count", p.get("count"));
                busMap.put(busKey, map);
            }
            EasyExcel.read(file.getInputStream(), ImportDataCheckModel.class, new DataCheckListener(importHistoryService,dataCheckRecordingService,bean.getDepartCode(),t.getId(),user.getId(),fName,section,
                pointMap,regMap,busMap,foodMap,itemMap)).sheet().headRowNumber(2).doRead();
            log.info("检测数据导入处理，结束时间："+DateUtil.datetimeFormat.format(new Date())+"");
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("导入失败！" + e.getMessage());
        }
        return json;
    }
     //初始化查询所有的样品信息，并封装成Map对象
    private  Map<String, Map<String, Object>> initAllFood(){
        Map<String, Map<String, Object>> foodMap = new HashMap<String, Map<String, Object>>();
        List<Map<String, Object>> foodListMap = foodTypeService.queryFoodTypeMap();
        for (int i = 0; i < foodListMap.size(); i++) {
            Map<String, Object> p = foodListMap.get(i);
            String foodKey = (String) p.get("food_name");
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("id", p.get("id"));
            map.put("typeId", p.get("parent_id"));
            map.put("typeName", p.get("type_name"));
            map.put("count", p.get("count"));
            foodMap.put(foodKey, map);
        }
        return foodMap;
    }
    //初始化查询所有的样品信息，并封装成Map对象
    private  Map<String, Map<String, Object>> initAllItem(){
        Map<String, Map<String, Object>> itemMap = new HashMap<String, Map<String, Object>>();
        List<Map<String, Object>> itemListMap = detectItemService.queryItemMap();
        for (int i = 0; i < itemListMap.size(); i++) {
            Map<String, Object> p = itemListMap.get(i);
            String itemKey = (String) p.get("detect_item_name");
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("id", p.get("id"));
            map.put("stdId", p.get("std_id"));
            map.put("stdCode", p.get("std_code"));
            map.put("valueUnit", p.get("detect_value_unit"));
            map.put("count", p.get("count"));
            itemMap.put(itemKey, map);
        }
        return itemMap;
    }

}
