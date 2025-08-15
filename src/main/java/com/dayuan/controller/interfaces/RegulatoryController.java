package com.dayuan.controller.interfaces;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryLicense;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.logs.aop.QrcodeScanCount;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryLicenseService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Dz
 * @Description:
 * @Company:食安科技
 * @date 2017年10月20日
 */
@Controller
@RequestMapping("/iRegulatory")
public class RegulatoryController extends BaseInterfaceController {

    @Autowired
    private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
    @Autowired
    private BaseRegulatoryObjectService baseRegulatoryObjectService;
    @Autowired
    private BaseRegulatoryLicenseService baseRegulatoryLicenseService;
    @Autowired
    private BaseRegulatoryTypeService baseRegulatoryTypeService;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 进入经营户移动端页面
     *
     * @param id 经营户ID
     */
    @ResponseBody
    @RequestMapping(value = "/businessApp")
    @QrcodeScanCount(module = "经营户二维码", scanType = 2)
    public ModelAndView businessApp(HttpServletRequest request, HttpServletResponse response, Integer id, Date day) {
        Map<String, Object> map = new HashMap<String, Object>();

        //监管对象数据公示版本
        Integer regQrcodeVersion = 1;
        JSONObject otherConfig = SystemConfigUtil.OTHER_CONFIG;
        if (otherConfig != null && otherConfig.getJSONObject("system_config") != null && StringUtils.hasText(otherConfig.getJSONObject("system_config").getString("reg_qrcode"))) {
            regQrcodeVersion = Integer.parseInt(otherConfig.getJSONObject("system_config").getString("reg_qrcode"));
        }

        int systemFlag = 0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
        JSONObject systemFlagConfig = SystemConfigUtil.SYSTEM_NAME_CONFIG;
        if (systemFlagConfig != null && systemFlagConfig.getInteger("systemFlag") != null) {
            systemFlag = systemFlagConfig.getInteger("systemFlag");
        }

        //第一、二版页面
        if (regQrcodeVersion == 1 || regQrcodeVersion == 2) {
            try {
                if (null != id) {
                    BaseRegulatoryBusiness business = baseRegulatoryBusinessService.queryById(id);
                    if (null != business && business.getChecked() == 1) {
                        map.put("business", business);

                        BaseRegulatoryObject regulatoryObj = baseRegulatoryObjectService.queryById(business.getRegId());
                        if (regulatoryObj != null && regulatoryObj.getChecked() == 1 && !"1".equals(regulatoryObj.getParam3())) {
                            map.put("regulatoryObj", regulatoryObj);
                        } else {
                            map.remove("business");
                        }
                    }
                }

            } catch (Exception e) {
                AjaxJson aj = new AjaxJson();
                setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
            }
            map.put("searchDay", day);
            map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2"));
            map.put("systemFlag", systemFlag);
            return new ModelAndView("/regulatory/regulatoryBusiness/business_app", map);

            //第三、四版页面，根据regQrcodeVersion自动跳转页面
        } else {
            Integer regId = null;
            String regName = "";
            String regAddress = "";
            String regPhoto = "";

            String busCode = "";
            String busName = "";//摊位名称
            String busUserName="";//经营者名称

            try {
                if (id != null) {
                    BaseRegulatoryBusiness business = baseRegulatoryBusinessService.queryById(id);

                    if (null != business && business.getChecked() == 1) {
                        BaseRegulatoryObject regObject = baseRegulatoryObjectService.queryById(business.getRegId());

                        if (null != regObject && regObject.getChecked() == 1 && !"1".equals(regObject.getParam3())) {
                            regId = regObject.getId();
                            regName = regObject.getRegName();
                            regAddress = regObject.getRegAddress();
                            regPhoto = regObject.getParam2();

                            busCode = business.getOpeShopCode();
                            busName = business.getOpeShopName();
                            busUserName=business.getOpeName();
                        } else {
                            id = null;
                        }
                    } else {
                        id = null;
                    }
                }
            } catch (Exception e) {
                setAjaxJson(new AjaxJson(), WebConstant.INTERFACE_CODE11, "操作失败！", e);
            }
            map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2"));
            map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
            map.put("systemFlag", systemFlag);
            map.put("regId", regId);
            map.put("regName", regName);
            map.put("regAddress", regAddress);
            map.put("regPhoto", regPhoto);
            map.put("busId", id);
            map.put("busCode", busCode);
            map.put("busName", busName);
            map.put("busUserName", busUserName);
            return new ModelAndView("/regulatory/regulatoryBusiness/business_app"+regQrcodeVersion, map);
        }
    }

    /**
     * 进入监管对象移动端页面 - 新版
     *
     * @param id  监管对象ID
     * @param day
     */
    @RequestMapping(value = "/regObjectApp")
    @QrcodeScanCount(module = "被检单位二维码", scanType = 1)
    public ModelAndView regObjectApp(HttpServletRequest request, HttpServletResponse response, Integer id, Date day) {

        Map<String, Object> map = new HashMap<String, Object>();

        //监管对象数据公示版本
        Integer regQrcodeVersion = 1;
        JSONObject otherConfig = SystemConfigUtil.OTHER_CONFIG;
        if (otherConfig != null && otherConfig.getJSONObject("system_config") != null && StringUtils.hasText(otherConfig.getJSONObject("system_config").getString("reg_qrcode"))) {
            regQrcodeVersion = Integer.parseInt(otherConfig.getJSONObject("system_config").getString("reg_qrcode"));
        }

        //系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
        int systemFlag = 0;
        JSONObject systemFlagConfig = SystemConfigUtil.SYSTEM_NAME_CONFIG;
        if (systemFlagConfig != null && systemFlagConfig.getInteger("systemFlag") != null) {
            systemFlag = systemFlagConfig.getInteger("systemFlag");
        }
        //第二版页面
        if (regQrcodeVersion == 2) {
            String regName = "";
            String regAddress = "";
            String regPhoto = "";

            try {
                if (id != null) {
                    BaseRegulatoryObject regObject = baseRegulatoryObjectService.queryById(id);
                    if (null != regObject && regObject.getChecked() == 1 && !"1".equals(regObject.getParam3())) {
                        regName = regObject.getRegName();
                        regAddress = regObject.getRegAddress();
                        regPhoto = regObject.getParam2();
                    } else {
                        id = null;
                    }
                }
            } catch (Exception e) {
                setAjaxJson(new AjaxJson(), WebConstant.INTERFACE_CODE11, "操作失败！", e);
            }
            map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2"));
            map.put("systemFlag", systemFlag);
            map.put("regId", id);
            map.put("regName", regName);
            map.put("regAddress", regAddress);
            map.put("regPhoto", regPhoto);
            return new ModelAndView("/regulatory/regulatoryObject/regObject_app2", map);

            //第三版页面
        } else if (regQrcodeVersion == 3) {
            String regName = "";
            String regAddress = "";
            String regPhoto = "";

            try {
                if (id != null) {
                    BaseRegulatoryObject regObject = baseRegulatoryObjectService.queryById(id);
                    if (null != regObject && regObject.getChecked() == 1 && !"1".equals(regObject.getParam3())) {
                        regName = regObject.getRegName();
                        regAddress = regObject.getRegAddress();
                        regPhoto = regObject.getParam2();
                    } else {
                        id = null;
                    }
                }
            } catch (Exception e) {
                setAjaxJson(new AjaxJson(), WebConstant.INTERFACE_CODE11, "操作失败！", e);
            }
            map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2"));
            map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
            map.put("systemFlag", systemFlag);
            map.put("regId", id);
            map.put("regName", regName);
            map.put("regAddress", regAddress);
            map.put("regPhoto", regPhoto);
            return new ModelAndView("/regulatory/regulatoryObject/regObject_app3", map);
        } else if (regQrcodeVersion == 4) {//第四版页面
            String regName = "";
            String regAddress = "";
            String regPhoto = "";
            Integer businessNumber = 0;
            try {
                if (id != null) {
                    BaseRegulatoryObject regObject = baseRegulatoryObjectService.queryByIdForTemplate4(id);
                    if (null != regObject && regObject.getChecked() == 1 && !"1".equals(regObject.getParam3())) {
                        regName = regObject.getRegName();
                        regAddress = regObject.getRegAddress();
                        regPhoto = regObject.getParam2();
                        businessNumber = regObject.getBusinessNumber();
                    } else {
                        id = null;
                    }
                }
            } catch (Exception e) {
                setAjaxJson(new AjaxJson(), WebConstant.INTERFACE_CODE11, "操作失败！", e);
            }
            map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2"));
            map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
            map.put("systemFlag", systemFlag);
            map.put("regId", id);
            map.put("regName", regName);
            map.put("regAddress", regAddress);
            map.put("regPhoto", regPhoto);
            map.put("businessNumber", businessNumber);
            return new ModelAndView("/regulatory/regulatoryObject/regObject_app4", map);
        } else {//默认为：第一版页面
            map.put("searchDay", day);
            try {
                if (StringUtil.isNotEmpty(id)) {
                    BaseRegulatoryObject regObject = baseRegulatoryObjectService.queryById(id);
                    if (null != regObject && regObject.getChecked() == 1 && !"1".equals(regObject.getParam3())) {
                        map.put("regObject", regObject);
                        BaseRegulatoryType regType = baseRegulatoryTypeService.queryById(regObject.getRegType());
                        map.put("regType", regType);
                    }
                }
            } catch (Exception e) {
                AjaxJson aj = new AjaxJson();
                setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
            }
            map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright2"));
            map.put("systemFlag", systemFlag);
            return new ModelAndView("/regulatory/regulatoryObject/regObject_app", map);
        }
    }

    /**
     * 进入监管对象移动端页面-检测汇总(第二版)
     *
     * @param id 监管对象ID
     */
    @ResponseBody
    @RequestMapping(value = "/regObjectApp2Statistic")
    public ModelAndView regObjectApp2Statistic(HttpServletRequest request, HttpServletResponse response, Integer id) {
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuffer sql = new StringBuffer("SELECT COUNT(1) zs, SUM(IF(conclusion='不合格', 1, 0)) bhg FROM data_check_recording WHERE delete_flag=0 AND reg_id = ?");
        Map map1 = jdbcTemplate.queryForMap(sql.toString(), new Object[]{id});

        Integer zs = (map1.get("zs") != null && !"".equals(map1.get("zs").toString()) ? Integer.parseInt(map1.get("zs").toString()) : 0);
        Integer bhg = (map1.get("bhg") != null && !"".equals(map1.get("bhg").toString()) ? Integer.parseInt(map1.get("bhg").toString()) : 0);
        Integer hg = zs - bhg;
        Double hgl = 100.00;
        if (zs != 0) {
            hgl = hg.doubleValue() / zs.doubleValue() * 100;
            BigDecimal bg = new BigDecimal(hgl);
            hgl = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }

        map.put("zs", zs);
        map.put("bhg", bhg);
        map.put("hg", hg);
        map.put("hgl", hgl);
        return new ModelAndView("/regulatory/regulatoryObject/regObject_app2_statistics", map);
    }

    /**
     * 进入监管对象数据公示-检测汇总（第三版，第四版共用）
     *
     * @param id    监管对象ID
     * @param busId 经营户ID
     * @param start 开始时间 格式：yyyy-MM-dd HH:mm:ss
     * @param end   结束时间 格式：yyyy-MM-dd HH:mm:ss
     */
    @ResponseBody
    @RequestMapping(value = "/regObjectApp3Statistic")
    public Map regObjectApp3Statistic(Integer id, Integer busId, String start, String end) {
        StringBuffer sql = new StringBuffer("SELECT COUNT(1) jcl, SUM(IF(conclusion = '不合格', 1, 0)) bhg FROM data_check_recording WHERE delete_flag=0 AND reg_id = ? ");
        if (busId != null) {
            sql.append(" AND reg_user_id = " + busId + " ");
        }
        if (start != null && DateUtil.checkDate(start)) {
            sql.append(" AND check_date >= '" + start + "' ");
        }
        if (end != null && DateUtil.checkDate(end)) {
            sql.append(" AND check_date <= '" + end + "' ");
        }
        Map<String, Object> jcltj = jdbcTemplate.queryForMap(sql.toString(), new Object[]{id});
        if (jcltj == null) {
            jcltj = new HashMap<String, Object>(3);
            jcltj.put("jcl", 0);
            jcltj.put("bhg", 0);
        } else if (StringUtils.isEmpty(jcltj.get("bhg"))) {
            jcltj.put("bhg", 0);
        }
        return jcltj;
    }

    /**
     * 进入监管对象移动端页面-检测数据(第二版)
     *
     * @param id 监管对象ID
     */
    @ResponseBody
    @RequestMapping(value = "/regObjectApp2CheckData")
    public ModelAndView regObjectApp2CheckData(Integer id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("regId", id);
        return new ModelAndView("/regulatory/regulatoryObject/regObject_app2_checkdata", map);
    }

    /**
     * 监管对象数据公示（第二、三版）-获取检测数据
     *
     * @param id      监管对象ID
     * @param busId   经营户ID
     * @param start   开始时间
     * @param end     结束时间
     * @param keyword 关键词
     */
    @ResponseBody
    @RequestMapping(value = "/regObjectApp2CheckDataJson")
    public Map regObjectApp2CheckDataJson(Integer id, Integer busId, String start, String end, String keyword) {
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuffer sql = new StringBuffer("SELECT dcr.food_name, dcr.item_name, dcr.reg_user_name, dcr.conclusion, dcr.check_date, brb.ope_shop_name " +
                " FROM data_check_recording dcr " +
                " LEFT JOIN base_regulatory_business brb ON dcr.reg_user_id = brb.id " +
                " WHERE dcr.delete_flag=0  AND dcr.param7 = 1 AND dcr.reg_id = ? ");
        if (busId != null) {
            sql.append(" AND dcr.reg_user_id = " + busId + " ");
        }
        if (start != null && DateUtil.checkDate(start)) {
            sql.append(" AND dcr.check_date >= '" + start + "' ");
        }
        if (end != null && DateUtil.checkDate(end)) {
            sql.append(" AND dcr.check_date <= '" + end + " 23:59:59' ");
        }
        if (keyword != null && !"".equals(keyword.trim())) {
            sql.append(" AND (dcr.food_name LIKE '%" + keyword + "%' OR dcr.item_name LIKE '%" + keyword + "%' OR dcr.conclusion = '" + keyword + "' OR dcr.reg_user_name LIKE '%" + keyword + "%') ");
        }
        sql.append(" ORDER BY dcr.check_date DESC ");
        List<Map<String, Object>> checkData = jdbcTemplate.queryForList(sql.toString(), new Object[]{id});

        map.put("checkData", checkData);
        return map;
    }

    /**
     * 监管对象数据公示（第四版）-获取检测数据
     * 1.1 根据抽样单ID、经营户ID和样品名称组合分组，同一个抽样单中，样品名称相同的数据合并检测项目并去重，
     * 1.2检测时间：一个样品多个不同检测项目时，获取最早上传那条检测数据的检测时间
     * 1.3对于检测不合格的数据通过“不合格结论”来判断是否合格，conclusion：0 合格，conclusion>0 不合格；
     * 1.4 检测不合格时，获取不合格处置情况，
     *
     * @param id      监管对象ID
     * @param busId   经营户ID
     * @param start   开始时间
     * @param end     结束时间
     * @param keyword 关键词
     */
    @ResponseBody
    @RequestMapping(value = "/regObjectApp4CheckDataJson")
    public Map regObjectApp4CheckDataJson(Integer id, Integer busId, String start, String end, String keyword) {
        Map<String, Object> map = new HashMap<String, Object>();
        //1.公共部分查询sql和查询条件
        StringBuffer conditionSql = new StringBuffer("AND dcr.reg_id = " + id + " ");
        if (busId != null) {
            conditionSql.append(" AND dcr.reg_user_id = " + busId + " ");
        }
        if (start != null && DateUtil.checkDate(start)) {
            conditionSql.append(" AND dcr.check_date >= '" + start + "' ");
        }
        if (end != null && DateUtil.checkDate(end)) {
            conditionSql.append(" AND dcr.check_date <= '" + end + " 23:59:59' ");
        }
        if (keyword != null && !"".equals(keyword.trim())) {
            conditionSql.append(" AND (dcr.food_name LIKE '%" + keyword + "%' OR dcr.item_name LIKE '%" + keyword + "%' OR dcr.conclusion = '" + keyword + "' OR dcr.reg_user_name LIKE '%" + keyword + "%') ");
        }

        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");

        //2.有抽样单的检测数据查询sql，同一个抽样单同一样品合并检测项目
        //备注：同一个样品多个检测项目，检测结果两个合格，一个不合格的时候显示合格，等复检结果出来后只要有一个项目不合格则表示该样品不合格。
        // reload_flag：不合格复检次数，unqual_count：不合格数量：0表示合格，>0表示不合格；sampling_count=check_count：同一个样品全部项目都已经检测完成
        StringBuffer samplingSql=new StringBuffer();
        samplingSql.append("select temp_table.rid,temp_table.sampling_id,temp_table.reg_user_id,temp_table.reg_user_name,temp_table.ope_shop_name,temp_table.ope_name,temp_table.food_name,temp_table.check_date," +
                "GROUP_CONCAT(DISTINCT temp_table.item_name) item_name,temp_table.conclusion, SUM(CASE WHEN temp_table.conclusion = '不合格' AND temp_table.reload_flag >= "+recheckNumber+"   THEN 1 ELSE 0 END ) AS reload_flag," +
                "SUM(CASE WHEN temp_table.conclusion = '不合格' THEN 1 ELSE 0 END ) AS unqual_count," +
                "(select count(*) from tb_sampling_detail tsd where tsd.sampling_id=temp_table.sampling_id and tsd.food_name=temp_table.food_name) sampling_count, " +
                "count(*) check_count,"+
                "GROUP_CONCAT(temp_table.handName SEPARATOR ';')  handName " +
                "from (SELECT dcr.rid,dcr.sampling_id,dcr.reg_user_id,dcr.reg_user_name, dcr.food_name, dcr.item_name,dcr.conclusion, dcr.check_date,brb.ope_shop_name,brb.ope_name,dcr.reload_flag," +
                "GROUP_CONCAT(if (d.dispose_value!='',CAST(CONCAT(config.handle_name,':',d.dispose_value) AS char),CAST(CONCAT(config.handle_name,':',d.dispose_value1,d.dispose_type) AS char)) ) handName " +
                "FROM data_check_recording dcr  " +
                "LEFT JOIN base_regulatory_business brb ON dcr.reg_user_id = brb.id  " +
                "LEFT JOIN data_unqualified_treatment dut on dut.check_recording_id=dcr.rid " +
                "LEFT JOIN data_unqualified_dispose d ON d.unid = dut.id " +
                "LEFT JOIN data_unqualified_config config ON config.id = d.dispose_id " +
                "WHERE dcr.delete_flag=0  AND dcr.param7 = 1 ");
        samplingSql.append(conditionSql);
        samplingSql.append("AND dcr.sampling_id!='' GROUP BY dcr.rid) temp_table ");
        samplingSql.append("GROUP BY temp_table.sampling_id,temp_table.reg_user_id,temp_table.food_name HAVING sampling_count=check_count and (unqual_count=0 or (unqual_count>=1 and reload_flag>=1) ) ");
//        List<Map<String, Object>> checkData = jdbcTemplate.queryForList(samplingSql.toString(), new Object[]{id});
        //3.没有抽样单的检测数据sql，按照原来的方式展示：一个项目一条记录
        StringBuffer noSamplingSql=new StringBuffer("SELECT  dcr.rid,dcr.sampling_id,dcr.reg_user_id,dcr.reg_user_name,brb.ope_shop_name,brb.ope_name,dcr.food_name,dcr.check_date, dcr.item_name," +
                "dcr.conclusion,dcr.reload_flag,SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) AS unqual_count," +
                "'1' as sampling_count,'1' as check_count,"+
                "GROUP_CONCAT(if (d.dispose_value!='',CAST(CONCAT(config.handle_name,':',d.dispose_value) AS char),CAST(CONCAT(config.handle_name,':',d.dispose_value1,d.dispose_type) AS char)) ) handName " +
                "FROM data_check_recording dcr  " +
                "LEFT JOIN base_regulatory_business brb ON dcr.reg_user_id = brb.id " +
                "LEFT JOIN data_unqualified_treatment dut on dut.check_recording_id=dcr.rid " +
                "LEFT JOIN data_unqualified_dispose d ON d.unid = dut.id " +
                "LEFT JOIN data_unqualified_config config ON config.id = d.dispose_id " +
                "WHERE dcr.delete_flag=0  AND dcr.param7 = 1 ");
        noSamplingSql.append(conditionSql);
        noSamplingSql.append("AND dcr.sampling_id is null GROUP BY dcr.rid");
//        List<Map<String, Object>> checkData2 = jdbcTemplate.queryForList(noSamplingSql.toString(), new Object[]{id});
//        checkData.addAll(checkData2);
        //4.合并sql组合查询所有的数据
        String excuteSql=samplingSql.append(" UNION ALL ").append(noSamplingSql.toString()).toString();
        List<Map<String, Object>> checkData = jdbcTemplate.queryForList(excuteSql);
        List<Map<String, Object>> lastCheckData=checkData.stream().sorted((map1,map2)->{
            Date d1=(Date) map1.get("check_date");
            Date d2=(Date)map2.get("check_date");
            return d2.compareTo(d1);
        }).collect(Collectors.toList());
        map.put("checkData", lastCheckData);
        return map;
    }

    /**
     * 新增/编辑经营户（有附件）
     */
    @ResponseBody
    @RequestMapping(value = "/saveOrUpdateBusinessF", method = RequestMethod.POST)
    public AjaxJson saveOrUpdateBusinessF(HttpServletRequest request, HttpServletResponse response, String userToken,
                                          @RequestParam(required = false) MultipartFile file, BaseRegulatoryBusiness business) {

        AjaxJson aj = new AjaxJson();
        try {
            //必填验证
            TSUser user = tokenExpired(userToken);    //token验证
            required(business, WebConstant.INTERFACE_CODE1, "参数business不能为空");
            required(business.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");

            if (StringUtil.isNotEmpty(business.getId())) {
                //更新经营户
                PublicUtil.setCommonForTable(business, false, user);
                if (null == business.getOpeShopName()) {
                    business.setOpeShopName("");
                }
                if (null == business.getOpeName()) {
                    business.setOpeName("");
                }
                if (null == business.getOpeIdcard()) {
                    business.setOpeIdcard("");
                }
                if (null == business.getOpePhone()) {
                    business.setOpePhone("");
                }
                if (null == business.getRemark()) {
                    business.setRemark("");
                }
                baseRegulatoryBusinessService.updateBySelective(business);

                //更新营业执照
                if (null != file) {
                    BaseRegulatoryLicense license = baseRegulatoryLicenseService.queryByBusinessId(business.getId());
                    String fileName = uploadFile(request, WebConstant.res.getString("licenseImage"), file, null);
                    license.setLicenseImage(WebConstant.res.getString("licenseImage") + fileName);
                    PublicUtil.setCommonForTable(license, false, user);
                    baseRegulatoryLicenseService.updateBySelective(license);
                }
            } else {
                //新增经营户
//				business.setId(UUIDGenerator.generate());
                PublicUtil.setCommonForTable(business, true, user);
                baseRegulatoryBusinessService.insertSelective(business);

                //新增营业执照
                if (null != file) {
                    BaseRegulatoryLicense license = new BaseRegulatoryLicense();
                    String fileName = uploadFile(request, WebConstant.res.getString("licenseImage"), file, null);
//					license.setId(UUIDGenerator.generate());
                    license.setSourceId(business.getId());
                    license.setSourceType("1");
                    license.setLicenseType((short) 0);
                    license.setLicenseImage(WebConstant.res.getString("licenseImage") + fileName);
                    license.setChecked((short) 1);
                    license.setDeleteFlag((short) 0);
                    license.setSorting((short) 1);
                    PublicUtil.setCommonForTable(license, true, user);
                    baseRegulatoryLicenseService.insertSelective(license);
                }
            }

        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }

        return aj;

    }

    /**
     * 新增/编辑经营户（无附件）
     */
    @ResponseBody
    @RequestMapping(value = "/saveOrUpdateBusiness", method = RequestMethod.POST)
    public AjaxJson saveOrUpdateBusiness(HttpServletRequest request, HttpServletResponse response, String userToken, BaseRegulatoryBusiness business) {

        AjaxJson aj = new AjaxJson();
        try {
            //必填验证
            TSUser user = tokenExpired(userToken);    //token验证
            required(business, WebConstant.INTERFACE_CODE1, "参数business不能为空");
            required(business.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");

            if (StringUtil.isNotEmpty(business.getId())) {
                //更新经营户
                PublicUtil.setCommonForTable(business, false, user);
                if (null == business.getOpeShopName()) {
                    business.setOpeShopName("");
                }
                if (null == business.getOpeName()) {
                    business.setOpeName("");
                }
                if (null == business.getOpeIdcard()) {
                    business.setOpeIdcard("");
                }
                if (null == business.getOpePhone()) {
                    business.setOpePhone("");
                }
                if (null == business.getRemark()) {
                    business.setRemark("");
                }
                baseRegulatoryBusinessService.updateBySelective(business);
            } else {
                //新增经营户
                PublicUtil.setCommonForTable(business, true, user);
                baseRegulatoryBusinessService.insertSelective(business);
            }

        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }

        return aj;
    }

    /**
     * 通过市场ID推荐档口
     */
    @ResponseBody
    @RequestMapping(value = "/recommend", method = RequestMethod.POST)
    public AjaxJson recommend(String userToken, Integer regId, @RequestParam(defaultValue = "20", required = false) int number) {
        AjaxJson aj = new AjaxJson();
        try {
            //必填验证
            TSUser user = tokenExpired(userToken);    //token验证
            required(regId, WebConstant.INTERFACE_CODE1, "参数regId不能为空");

            BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(regId);
            Map<String, Object> reg = null;
            if (regObj != null) {
                reg = new HashMap<String, Object>();
                reg.put("regId", regObj.getId());
                reg.put("regName", regObj.getRegName());
            }

            //当月开始时间、结束时间
            Calendar calendar = Calendar.getInstance();
            String startTime = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-01 00:00:00");
            String lastTime = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd 23:59:59");
            StringBuffer sbuffer = new StringBuffer();
            sbuffer.append("SELECT " +
                    "	brb.id opeId, brb.ope_shop_name opeShopName, brb.ope_shop_code opeShopCode, " +
                    "	IF(dcr.checkNum IS NULL, 0, dcr.checkNum) checkNum " +
                    "FROM base_regulatory_business brb  " +
                    "LEFT JOIN ( " +
                    "	SELECT reg_user_id, COUNT(1) checkNum " +
                    "	FROM data_check_recording WHERE delete_flag = 0 " +
                    "		AND check_date BETWEEN ? AND ? " +
                    "		AND reg_id = ? " +
                    "	GROUP BY reg_user_id " +
                    ") dcr ON dcr.reg_user_id = brb.id " +
                    "WHERE brb.delete_flag = 0 " +
                    "AND brb.reg_id = ? ORDER BY dcr.checkNum ASC ");

            if (number > 0) {
                sbuffer.append(" LIMIT 0, " + number + " ");
            }

            List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[]{startTime, lastTime, regId, regId});

            Map<String, Object> result = new HashMap<String, Object>();
            result.put("reg", reg);
            result.put("opes", list);

            aj.setObj(result);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }

        return aj;

    }

    /**
     * 通过市场ID推荐三天内不合格档口
     */
    @ResponseBody
    @RequestMapping(value = "/recommendUq", method = RequestMethod.POST)
    public AjaxJson recommendUq(String userToken, Integer regId, @RequestParam(defaultValue = "20", required = false) int number) {
        AjaxJson aj = new AjaxJson();
        try {
            //必填验证
            TSUser user = tokenExpired(userToken);    //token验证
            required(regId, WebConstant.INTERFACE_CODE1, "参数regId不能为空");

            Calendar calendar = Calendar.getInstance();
            String lastTime = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd 23:59:59");
            //3天前
            calendar.add(Calendar.DAY_OF_YEAR, -3);
            String startTime = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd 00:00:00");

            BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(regId);
            Map<String, Object> reg = null;
            if (regObj != null) {
                reg = new HashMap<String, Object>();
                reg.put("regId", regObj.getId());
                reg.put("regName", regObj.getRegName());
            }

            StringBuffer sbuffer = new StringBuffer();
            sbuffer.append("SELECT " +
                    "	dcr.opeId opeId, brb.ope_shop_name opeShopName, " +
                    "	brb.ope_shop_code opeShopCode, dcr.uqNum uqNum " +
                    "FROM " +
                    "	( " +
                    "		SELECT " +
                    "			reg_user_id opeId, COUNT(1) uqNum " +
                    "		FROM " +
                    "			data_check_recording " +
                    "		WHERE " +
                    "			delete_flag = 0  AND  param7 = 1" +
                    "		AND check_date BETWEEN ? AND ? " +
                    "		AND reg_user_id IS NOT NULL AND conclusion = '不合格' AND reg_id = ? " +
                    "		GROUP BY reg_user_id ORDER BY uqNum DESC ");
            if (number > 0) {
                sbuffer.append(" LIMIT 0, " + number + " ");
            }
            sbuffer.append("	) dcr " +
                    "INNER JOIN base_regulatory_business brb ON dcr.opeId = brb.id " +
                    "WHERE brb.delete_flag = 0 AND brb.reg_id = ? ORDER BY uqNum DESC ");

            List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(), new Object[]{startTime, lastTime, regId, regId});

            Map<String, Object> result = new HashMap<String, Object>();
            result.put("reg", reg);
            result.put("opes", list);

            aj.setObj(result);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }

        return aj;
    }

    /**
     * 通过市场ID推荐样品
     * (样品库 = 上月检测样品 + 当月检测样品)
     */
    @ResponseBody
    @RequestMapping(value = "/recommendFood", method = RequestMethod.POST)
    public AjaxJson recommendFood(String userToken, Integer regId, @RequestParam(defaultValue = "20", required = false) int number) {
        AjaxJson aj = new AjaxJson();
        try {
            //必填验证
            TSUser user = tokenExpired(userToken);    //token验证
            required(regId, WebConstant.INTERFACE_CODE1, "参数regId不能为空");

            BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(regId);
            Map<String, Object> reg = null;
            if (regObj != null) {
                reg = new HashMap<String, Object>();
                reg.put("regId", regObj.getId());
                reg.put("regName", regObj.getRegName());
            }

            Calendar calendar = Calendar.getInstance();
            //结束时间
            String lastTime = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd 23:59:59");
            //当月开始时间
            String startTime1 = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-01 00:00:00");
            //上月开始时间
            calendar.add(Calendar.MONTH, -1);
            String startTime2 = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-01 00:00:00");

            StringBuffer sbuffer = new StringBuffer();
            sbuffer.append("SELECT " +
                    "	dcr.foodId, dcr.foodName, dcr.checkNum " +
                    "FROM " +
                    "	( " +
                    "		SELECT " +
                    "			food_id foodId, " +
                    "			food_name foodName, " +
                    "			SUM(IF(check_date BETWEEN ? AND ?, 1, 0)) checkNum " +
                    "		FROM " +
                    "			data_check_recording " +
                    "		WHERE " +
                    "			delete_flag = 0  AND param7 = 1 AND food_id IS NOT NULL " +
                    "		AND check_date BETWEEN ? AND ? " +
                    "		AND reg_id = ? " +
                    "		GROUP BY food_id " +
                    "	) dcr " +
                    "	INNER JOIN base_food_type bft ON dcr.foodId = bft.id AND bft.delete_flag = 0 " +
                    "ORDER BY dcr.checkNum ASC ");

            if (number > 0) {
                sbuffer.append(" LIMIT 0, " + number + " ");
            }

            List<Map<String, Object>> list = jdbcTemplate.queryForList(sbuffer.toString(),
                    new Object[]{startTime1, lastTime, startTime2, lastTime, regId});

            Map<String, Object> result = new HashMap<String, Object>();
            result.put("reg", reg);
            result.put("foods", list);

            aj.setObj(result);
        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }

        return aj;
    }

    /**
     * 上传监管对象照片
     * 平台和APP通用
     */
    @RequestMapping("/uploadRegImage")
    @ResponseBody
    public AjaxJson uploadRegImage(String userToken, Integer id, MultipartFile regImage) {
        AjaxJson aj = new AjaxJson();
        try {

            required(id, WebConstant.INTERFACE_CODE1, "参数id不能为空");
            TSUser user = PublicUtil.getSessionUser();
            if (user == null) {
                //接口用户验证
                user = tokenExpired(userToken);
            }

            //上传监管对象照片
            if (regImage != null && regImage.getSize() > 0) {
                BaseRegulatoryObject reg = new BaseRegulatoryObject();
                String fileName = uploadFile(null, "/regObjectImages/", regImage, id + DyFileUtil.getFileExtension(regImage.getOriginalFilename()));

                reg.setId(id);
                reg.setParam2("/regObjectImages/" + fileName);
                PublicUtil.setCommonForTable(reg, false, user);
                baseRegulatoryObjectService.updateBySelective(reg);

                aj.setObj(reg);
            }

        } catch (MyException e) {
            setAjaxJson(aj, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }
        return aj;
    }

}
