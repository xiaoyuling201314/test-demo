package com.dayuan.controller.wx.inspection;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.wx.inspection.InspectionUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.model.wx.inspection.PointModel;
import com.dayuan.model.wx.inspection.WxDataCheckRecordingModel;
import com.dayuan.model.wx.inspection.WxTbSamplingDetailModel;
import com.dayuan.model.wx.inspection.WxTbSamplingModel;
import com.dayuan.service.wx.inspection.InspectionInformationService;
import com.dayuan.service.wx.inspection.InspectionUserService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.wx.WeixinUtil;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 你送我检信息Controller
 * Created by dy on 2018/8/7.
 */

@Controller
@RequestMapping("/wx/inspection")
public class InspectionInformationController {
    private static final String appId = WebConstant.res.getString("appId");
    private static final String secret = WebConstant.res.getString("secret");
    public final static String code_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code ";
    public final static String mainUrl = "/wx/inspection/inspection_error";//跳转到二维码界面
    private final Logger log = Logger.getLogger(InspectionInformationController.class);
    @Autowired
    private InspectionInformationService inspectionInformationService;
    @Autowired
    private InspectionUserService inspectionUserService;

    @RequestMapping("/loginQRcode")
    public String loginQRcode() throws Exception {
        return "/wx/inspection/inspection_error";
    }

    /**
     * 你送我检总界面
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, String departId) throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        HttpSession session = request.getSession();
        String openid = (String) session.getAttribute("openid2");
        InspectionUser inspectionUser = inspectionUserService.selectByOpenid(openid);
        if (inspectionUser != null) {//如果当前用户已经登录,且用户已经绑定
            request.getSession().setAttribute("inspection_user", inspectionUser);
            mapData.put("openid", inspectionUser.getOpenid());
            mapData.put("userId", inspectionUser.getId());//通过id去查询
            mapData.put("departId", inspectionUser.getDepartId());//通过id去查询
            mapData.put("mobilePhone", inspectionUser.getMobilePhone());//通过手机号码去查询
            return new ModelAndView("/wx/inspection/inspection_list2", mapData);
        } else {
            JSONObject jsonObject = null;
            if (StringUtils.isEmpty(openid)) {
                String code = request.getParameter("code");// 用来获取网页授权
                if (code != null) {
                    String requestUrl = code_url.replace("CODE", code).replace("APPID", appId).replace("APPSECRET", secret);
                    jsonObject = WeixinUtil.httpRequest(requestUrl, "GET", null);
                }
                if (null != jsonObject) {
                    try {
                        if (jsonObject.getString("access_token") == null) {// 获取用户信息失败
                            return new ModelAndView(mainUrl);
                        } else {
                            openid = jsonObject.getString("openid");
                            if (!StringUtils.isEmpty(openid) && StringUtil.isNotEmpty(departId)) {
                                mapData.put("openid2", openid);
                                InspectionUser inuser = new InspectionUser();
                                inuser.setOpenid(openid);
                                inuser.setAppId(appId);
                                inuser.setDepartId(departId);
                                mapData.put("inspectionUser", inuser);
                                request.getSession().setAttribute("openid2", openid);
                                InspectionUser inspection_user = inspectionUserService.selectByOpenid(openid);
                                if (inspection_user != null) {// 用户已绑定
                                    request.getSession().setAttribute("inspection_user", inspection_user);
                                    mapData.put("userId", inspection_user.getId());//通过id去查询
                                    mapData.put("departId", inspection_user.getDepartId());//通过id去查询
                                    mapData.put("mobilePhone", inspection_user.getMobilePhone());//通过手机号码去查询
                                    return new ModelAndView("/wx/inspection/inspection_list2", mapData);
                                } else {// 用户未绑定
                                    return new ModelAndView("/wx/inspection/login2", mapData);
                                }
                            }
                        }
                    } catch (Exception e) {
                        return new ModelAndView(mainUrl);
                    }
                }
            }
            return new ModelAndView(mainUrl);
        }
    }


    /**
     * 送样信息界面:第一次登陆进入
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("/list2")
    public ModelAndView list2(HttpServletRequest request, InspectionUser inspectionUser) throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        HttpSession session = request.getSession();
        String openid = inspectionUser.getOpenid();
        String departId = inspectionUser.getDepartId();
        if (StringUtil.isNotEmpty(openid) && StringUtil.isNotEmpty(departId)) {
            session.setAttribute("openid2", openid);
            session.setAttribute("departId2", departId);
            mapData.put("inspectionUser", inspectionUser);
            inspectionUser = inspectionUserService.selectByOpenid(openid);
            if (inspectionUser != null) {//如果当前用户已经登录,且用户已经绑定
                session.setAttribute("inspection_user", inspectionUser);
                mapData.put("departId", departId);
                mapData.put("openid", openid);
                mapData.put("userId", inspectionUser.getId());//通过id去查询
                mapData.put("mobilePhone", inspectionUser.getMobilePhone());//通过手机号码去查询
                return new ModelAndView("/wx/inspection/inspection_list1", mapData);
            } else {
                return new ModelAndView("/wx/inspection/login2", mapData);//本是login3
            }
        } else {//openid和departId为空就跳转到二维码介绍界面
            return new ModelAndView(mainUrl);
        }
    }


    /**
     * 送样信息界面:后面点击链接进入
     *
     * @throws Exception
     */
    @RequestMapping("/sampling_information{openid}")
    public ModelAndView samplingInformation(@PathVariable String openid) throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        if (StringUtil.isNotEmpty(openid)) {
            mapData.put("openid", openid);
            InspectionUser inspectionUser = inspectionUserService.selectByOpenid(openid);
            if (inspectionUser != null) {//如果当前用户已经登录,且用户已经绑定
                mapData.put("userId", inspectionUser.getId());//通过id去查询
                mapData.put("mobilePhone", inspectionUser.getMobilePhone());//通过手机号码去查询
                mapData.put("departId", inspectionUser.getDepartId());//通过手机号码去查询
                return new ModelAndView("/wx/inspection/inspection_list1", mapData);
            } else {
                //说明该用户分享该页面后又解除绑定了,进入一个界面说明该用户已经解除绑定
                mapData.put("msg", "未找到该用户相关信息");
                return new ModelAndView(mainUrl, mapData);
            }
        } else {
            //openid为空 进入登陆界面,给个二维码
            return new ModelAndView(mainUrl);
        }
    }

    /**
     * 检测结果:后面点击链接进入
     *
     * @throws Exception
     */
    @RequestMapping("/inspection_result{openid}")
    public ModelAndView inspectionResult(@PathVariable String openid) throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        if (StringUtil.isNotEmpty(openid)) {
            mapData.put("openid", openid);
            InspectionUser inspectionUser = inspectionUserService.selectByOpenid(openid);
            if (inspectionUser != null) {//如果当前用户已经登录,且用户已经绑定
                mapData.put("userId", inspectionUser.getId());//通过id去查询
                mapData.put("mobilePhone", inspectionUser.getMobilePhone());//通过手机号码去查询
                mapData.put("departId", inspectionUser.getDepartId());//通过手机号码去查询
                return new ModelAndView("/wx/inspection/inspection_list2", mapData);
            } else {
                //说明该用户分享该页面后又解除绑定了,进入一个界面说明该用户已经解除绑定
                mapData.put("msg", "未找到该用户相关信息");
                return new ModelAndView(mainUrl, mapData);
            }
        } else {
            //openid为空 shit:进入登陆界面,给个二维码
            return new ModelAndView(mainUrl);
        }
    }


    /**
     * 人你送我检总界面数据获取
     *
     * @return
     */
    @RequestMapping("/list_datagrid")
    @ResponseBody
    public AjaxJson listDatagrid(String mobilePhone, Integer index, String keyword) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            if (index == 0) {//查询送检信息
                List<WxTbSamplingModel> wxTbSamplingModels = inspectionInformationService.selectInspection(mobilePhone, keyword);
                ajaxJson.setObj(wxTbSamplingModels);
            }
            if (index == 1) {//查询检测结果
                List<WxDataCheckRecordingModel> wxDataCheckRecordingModels = inspectionInformationService.selectInspectionResult(mobilePhone, keyword);
                ajaxJson.setObj(wxDataCheckRecordingModels);
            }
        } catch (Exception e) {
            ajaxJson.setSuccess(false);
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return ajaxJson;
    }


    /**
     * 人你送我检总界面数据获取
     *
     * @return
     */
    @RequestMapping(value = "/list_datagrid2", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson listDatagrid2(HttpServletRequest request, String departId, String mobilePhone, Integer index, String keyword, String date) {
        AjaxJson ajaxJson = new AjaxJson();
        List<Integer> departs = new ArrayList<>();
        try {
            if (StringUtil.isEmpty(departId)) {//如果传入的为空就去session中获取
                departId = (String) request.getSession().getAttribute("departId2");
            }
            if (StringUtil.isNotEmpty(departId)) {
                //下面两个查询还需传入机构id去过滤
                departs = inspectionInformationService.selectSonDepartIdById(departId);//根据机构id查询该机构下的所有子机构
            } else {
                throw new MyException("机构ID不能为空");
            }
            if (departs.size() > 0) {
                if (index == 0) {//查询送检信息
                    List<WxTbSamplingModel> wxTbSamplingModels = inspectionInformationService.selectInspection2(mobilePhone, keyword, departs, date);
                    ajaxJson.setObj(wxTbSamplingModels);
                }
                if (index == 1) {//查询检测结果
                    List<WxDataCheckRecordingModel> wxDataCheckRecordingModels = inspectionInformationService.selectInspectionResult2(mobilePhone, keyword, departs, date);
                    ajaxJson.setObj(wxDataCheckRecordingModels);
                }
            } else {
                ajaxJson.setSuccess(false);
                ajaxJson.setMsg("不存在该机构");
                throw new MyException("不存在该机构");
            }
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            ajaxJson.setMsg("操作失败");
            ajaxJson.setSuccess(false);
            e.printStackTrace();
        }
        return ajaxJson;
    }


    /**
     * 页面点击送检进入其送样详情界面
     *
     * @param model
     * @return
     */
    @RequestMapping("/sampling_detail")
    public String samplingDetail(HttpServletRequest request, Model model, Integer id) {
        //判断是否登陆的拦截方法
        InspectionUser inspection_user = (InspectionUser) request.getSession().getAttribute("inspection_user");
        if (inspection_user == null) {//获取不到用户
            return mainUrl;
        }
        //id = 17644;
        WxTbSamplingModel tbSamplingModel;
        try {
            //根据送检单id查询其抽样信息
            tbSamplingModel = inspectionInformationService.selectSamplingDetail(id);
            //根据送检单id查询其抽样信息明细
            List<WxTbSamplingDetailModel> tbSamplingModels = inspectionInformationService.selectSamplingDetails(id);
            model.addAttribute("tsdm", tbSamplingModel);
            model.addAttribute("tsdms", tbSamplingModels);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/wx/inspection/sampling_details";
    }


    /**
     * 页面点击送检进入其检测结果详情界面
     *
     * @param model
     * @return
     */
    @RequestMapping("/inspection_result_detail")
    public String inspectionResultDetail(HttpServletRequest request, Model model, Integer id) {
        //判断是否登陆的拦截方法
        InspectionUser inspection_user = (InspectionUser) request.getSession().getAttribute("inspection_user");
        if (inspection_user == null) {//获取不到用户
            return mainUrl;
        }
        WxDataCheckRecordingModel wxDataCheckRecordingModel;
        try {
            //根据检测结果数据id查询其检测结果详情信息(data_check_recording.rid)
            wxDataCheckRecordingModel = inspectionInformationService.selectInspectionResultDetail(id);
            model.addAttribute("wxdcrm", wxDataCheckRecordingModel);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/wx/inspection/inspection_result_details";
    }

    /**
     * 送样地图:后面点击链接进入
     *
     * @throws Exception
     */
    @RequestMapping("/inspection_map{openid}.do{departId}")
    public String inspectionMap(Model model, @PathVariable String openid, @PathVariable String departId) throws Exception {
        model.addAttribute("openid", openid);
        model.addAttribute("departId", departId);
        return "/wx/inspection/inspection_list3";
    }

    /**
     * 送样地图:界面检测点的数据加载
     *
     * @return
     */
    @RequestMapping("/getPoints")
    @ResponseBody
    public AjaxJson inspectionMapDatagrid(String departId, String keyword) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(departId)) {
                //下面两个查询还需传入机构id去过滤
                List<Integer> departs = inspectionInformationService.selectSonDepartIdById(departId);//根据机构id查询该机构下的所有子机构
                List<PointModel> points = inspectionInformationService.selectPointByType("0", departs, keyword);    //查询检测点
                ajaxJson.setObj(points);
            } else {
                throw new MyException("机构ID不能为空");
            }
        } catch (MyException e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setSuccess(false);
        } catch (Exception e) {
            ajaxJson.setSuccess(false);
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return ajaxJson;
    }

}
