package com.dayuan.controller.data;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.BasePointVideoSurveillance;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.model.data.BasePointVideoSurveillanceModel;
import com.dayuan.model.system.TSDepartMapModel;
import com.dayuan.service.DataCheck.DataUnqualifiedTreatmentService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.BasePointVideoSurveillanceService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.system.TSDepartMapService;
import com.dayuan.util.HttpClient4Util;
import com.dayuan.util.StringUtil;
import com.dayuan.util.YingShiYun;
import com.dayuan.util.imouPlayer.HttpSend;
import com.dayuan.util.imouPlayer.LeChengMonitorUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import net.jodah.expiringmap.ExpirationPolicy;
import net.jodah.expiringmap.ExpiringMap;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * 视频监控Controller
 *
 * @author LuoYX
 * @date 2018年5月16日
 */
@Controller
@RequestMapping("/video/surveillance")
public class BasePointVideoSurveillanceController extends BaseController {
    // kitToken有效期为2小时，建议开发者在自身服务中针对kitToken缓存一小时处理，而不用每次调用开放平台接口获取
    private static final ExpiringMap<String, Object> kitTokenMap = ExpiringMap.builder().variableExpiration().expirationPolicy(ExpirationPolicy.CREATED).build();
    private final Logger log = Logger.getLogger(BasePointVideoSurveillanceController.class);
    @Autowired
    private BasePointVideoSurveillanceService service;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private BasePointService pointService;
    @Autowired
    private BasePointService basePointService;
    @Autowired
    private DataUnqualifiedTreatmentService treatmentService;
    @Autowired
    private TSDepartMapService departMapService;

    /**
     * 监控管理页面
     *
     * @param request
     * @return
     * @author LuoYX
     * @date 2018年5月8日
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, String refrel, String pointName) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<BasePoint> points = null;
        refrel = "/video/surveillance/list";
        int flag = 0;
        try {
            Map map1 = treatmentService.dataPermission(refrel);
            //获取当前用户信息
            TSUser tsUser = PublicUtil.getSessionUser();
            if (null != tsUser) {
                //获取菜单权限
                String json = request.getSession().getAttribute("btnList").toString();
                JSONArray jsonArr = JSONArray.fromObject(json);
                Iterator<Object> ja = jsonArr.iterator();
                while (ja.hasNext()) {
                    JSONObject job = (JSONObject) ja.next();
                    //获取操作名称(operationCode不唯一,不作为判断条件)
                    String operationName = job.get("operationName").toString();
                    if (operationName.contains("查看全部")) {
                        flag = 1;
                    }
                }
                if (tsUser.getPointId() != null) {
                    //检测点用户只能看到所属检测点信息
                    //points = new ArrayList<BasePoint>();
                    points = basePointService.selectByPointArr(null, tsUser.getPointId(), null, flag, null, null);
					/*if(uPoint!=null) {
						points.add(uPoint);
					}*/
                    map.put("points", points);
                } else {
                    points = basePointService.selectByPointArr((Integer[]) map1.get("pointArr"), null, null, flag, null, null);
                    map.put("points", points);
                }
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        map.put("systemVideoBg", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemVideoBg"));
        return new ModelAndView("/data/video/list", map);
    }

    @RequestMapping("/queryPointArr")
    @ResponseBody
    public AjaxJson queryPointArr(HttpServletRequest request, String trainType, HttpServletResponse response, String refrel, String pointName) {
        AjaxJson jsonObject = new AjaxJson();
        List<BasePoint> points = null;
        refrel = "/video/surveillance/list";
        int flag = 0;
        try {
            Map map1 = treatmentService.dataPermission(refrel);
            //获取当前用户信息
            TSUser tsUser = PublicUtil.getSessionUser();
            if (null != tsUser) {
                //获取菜单权限
                String json = request.getSession().getAttribute("btnList").toString();
                JSONArray jsonArr = JSONArray.fromObject(json);
                Iterator<Object> ja = jsonArr.iterator();
                while (ja.hasNext()) {
                    JSONObject job = (JSONObject) ja.next();
                    //获取操作名称(operationCode不唯一,不作为判断条件)
                    String operationName = job.get("operationName").toString();
                    if (operationName.contains("查看全部")) {
                        flag = 1;
                    }
                }
                if (tsUser.getPointId() != null) {
                    //检测点用户只能看到所属检测点信息
                    //points = new ArrayList<BasePoint>();
                    points = basePointService.selectByPointArr(null, tsUser.getPointId(), pointName, flag, null, null);
					/*if(uPoint!=null) {
						points.add(uPoint);
					}*/
                } else {
                    points = basePointService.selectByPointArr((Integer[]) map1.get("pointArr"), null, pointName, flag, null, null);
                }
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        jsonObject.setObj(points);
        return jsonObject;
    }

    /**
     * 视频回放
     *
     * @param request
     * @return
     */
    @RequestMapping("/playback")
    public ModelAndView playback(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSDepart depart = PublicUtil.getSessionUserDepart();
            TSDepartMapModel report = departMapService.selectReportByDepartid(depart.getId());
            map.put("report", report);
            com.alibaba.fastjson.JSONObject monitorObj = SystemConfigUtil.MONITOR_CONFIG;
            Map<String, Object> monitorConfig = JSON.parseObject(monitorObj.getString("account"));
            map.put("monitorConfig", monitorConfig);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        map.put("systemVideoBg", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemVideoBg"));
        return new ModelAndView("/data/video/playback", map);
    }

    @RequestMapping("/datagrid")
    public @ResponseBody
    AjaxJson dataList(BasePointVideoSurveillanceModel model, Page page) throws Exception {
        AjaxJson json = new AjaxJson();
		/*TSUser user = PublicUtil.getSessionUser();
		Integer departId = user.getDepartId();
		if (null != model.getDepartId()) {
			departId = model.getDepartId();
		}
		TSDepart t = departService.queryById(departId);
		List<Integer> departIds = departService.querySubDeparts(t.getDepartCode());
		model.setDepartIds(departIds);*/
        page = service.loadDatagrid(page, model);
        json.setObj(page);
        return json;
    }

    @RequestMapping("/saveVideo")
    public @ResponseBody
    AjaxJson saveVideo(BasePointVideoSurveillance video) throws MissSessionExceprtion {
        AjaxJson json = new AjaxJson();
        TSUser user = PublicUtil.getSessionUser();
        try {
//			video.setDepartId(video.getDepartPid());
//			video.setPointName(pointService.queryById(video.getPointId()).getPointName());
            video.setDeleteFlag((short) 0);
            if (video.getId() == null) {
                video.setRegisterDate(new Date());
                PublicUtil.setCommonForTable(video, true, user);
                service.insertSelective(video);
            } else {
                PublicUtil.setCommonForTable(video, false, user);
                service.updateBySelective(video);
            }
            //add by xiaoyl 2022/07/19 乐橙API监控类型，新增或编辑的时候根据设备号更新摄像头的在线状态
            if (0 == video.getVideoType()) {
                service.syncVideoStatus(video.getDev());
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("保存失败");
        }
        return json;
    }

    @RequestMapping("/edit")
    public @ResponseBody
    AjaxJson edit(Integer id) {
        AjaxJson json = new AjaxJson();
        BasePointVideoSurveillance video;
        try {
            video = service.queryById(id);
            if (video == null) {
                json.setSuccess(false);
                json.setMsg("没有找到对应的记录!");
            } else {
                json.setObj(video);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }

    @RequestMapping("/viewMonitor")
    public ModelAndView viewMonitor(Integer id, HttpServletRequest request) throws Exception {
        BasePointVideoSurveillance video = service.queryById(id);
        request.setAttribute("video", video);
        return new ModelAndView("/data/video/monitor");
    }

    @RequestMapping("/delete")
    public @ResponseBody
    AjaxJson delete(String ids) {
        AjaxJson json = new AjaxJson();
        String[] idArr = ids.split(",");
        try {
            Integer[] idss = new Integer[idArr.length];
            for (int i = 0; i < idArr.length; i++) {
                idss[i] = Integer.parseInt(idArr[i]);
            }
            service.delete(idss);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }

    @RequestMapping("/selectByPointId")
    @ResponseBody
    public AjaxJson selectByPointId(Integer pointId) {
        AjaxJson json = new AjaxJson();
        try {
            List<BasePointVideoSurveillance> surveillances = service.selectByPointId(pointId);
            json.setObj(surveillances);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }
    /***********************************乐橙开放平台轻应用套件,JS端播放视频*********************************************/
    /**
     * 监控管理页面
     *
     * @param request
     * @param refrel
     * @param pointName
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年4月21日
     */
    @RequestMapping("/list_new")
    public ModelAndView list_new(HttpServletRequest request, String refrel, String pointName) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSDepart depart = PublicUtil.getSessionUserDepart();
            TSDepartMapModel report = departMapService.selectReportByDepartid(depart.getId());
            map.put("report", report);
            com.alibaba.fastjson.JSONObject monitorObj = SystemConfigUtil.MONITOR_CONFIG;
            Map<String, Object> monitorConfig = JSON.parseObject(monitorObj.getString("account"));
            map.put("monitorConfig", monitorConfig);
        } catch (Exception e) {
            log.error("*****实时视频监控异常：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        map.put("systemVideoBg", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemVideoBg"));
        return new ModelAndView("/data/video/list_new", map);
    }

    @RequestMapping("/selectPointByDepartId")
    @ResponseBody
    public AjaxJson selectPointByDepartId(@RequestParam(required = false) Integer departId, @RequestParam(required = false) String pointName,
                                          Integer videoType, String queryType) {
        AjaxJson json = new AjaxJson();
        List<BasePoint> points = null;
        String refrel = "/video/surveillance/list_new";
        int flag = 1;
        try {
            //获取当前用户信息
            TSUser tsUser = PublicUtil.getSessionUser();
            if (departId == null) {
                departId = tsUser.getDepartId();
            }
            Map map1 = treatmentService.dataPermissionForVedio(refrel, departId);
            if (null != tsUser) {
                if (tsUser.getPointId() != null) {
                    //检测点用户只能看到所属检测点信息
                    points = basePointService.selectByPointArr(null, tsUser.getPointId(), pointName, flag, videoType, queryType);
                } else {
                    if (null != map1.get("pointArr")) {
                        points = basePointService.selectByPointArr((Integer[]) map1.get("pointArr"), null, pointName, flag, videoType, queryType);
                    }
                }
                json.setObj(points);
            } else {
                json.setSuccess(false);
                json.setMsg("用户会话失效，请重新登录！");
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }

    /**
     * 监控管理页面
     *
     * @param request
     * @param refrel
     * @param pointName
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年4月21日
     *//*
	@RequestMapping("/list_new")
	public ModelAndView list_new(HttpServletRequest request,String refrel,String pointName) {
		Map<String,Object> map = new HashMap<String, Object>();
		List<BasePoint> points = null;
		refrel="/video/surveillance/list";
		int flag = 0;
		try {
			Map map1 = treatmentService.dataPermission(refrel);
			//获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			if(null != tsUser){
				//获取菜单权限
	            String json = request.getSession().getAttribute("btnList").toString();
	            JSONArray jsonArr = JSONArray.fromObject(json);
	            Iterator<Object> ja = jsonArr.iterator();
	            while (ja.hasNext()) {
	                JSONObject job = (JSONObject) ja.next();
	                //获取操作名称(operationCode不唯一,不作为判断条件)
	                String operationName = job.get("operationName").toString();
	                if (operationName.contains("查看全部")){
	                	flag=1;
	                }
	            }
				if(tsUser.getPointId() != null) {
					//检测点用户只能看到所属检测点信息
					//points = new ArrayList<BasePoint>();
					points = basePointService.selectByPointArr(null,tsUser.getPointId(),null,flag);
					*//*if(uPoint!=null) {
						points.add(uPoint);
					}*//*
					map.put("points", points);
				}else {
					points = basePointService.selectByPointArr((Integer[])map1.get("pointArr"),null,null,flag);
					map.put("points", points);
				}
			}
		com.alibaba.fastjson.JSONObject monitorObj=SystemConfigUtil.MONITOR_CONFIG;
		Map<String, Object> monitorConfig=JSON.parseObject(monitorObj.getString("account"));
		map.put("monitorConfig", monitorConfig);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(LocalDate.now()+"实时视频监控异常："+e.getMessage());
		}
		map.put("systemVideoBg", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemVideoBg"));
		return new ModelAndView("/data/video/list_new",map);
	}*/
    @RequestMapping("/selectDeviceForImouPlayer")
    @ResponseBody
    public AjaxJson selectDeviceForImouPlayer(Integer pointId) {
        AjaxJson json = new AjaxJson();
        try {
            List<BasePointVideoSurveillance> surveillances = service.selectByPointId(pointId);
            for (BasePointVideoSurveillance videoSurveillance : surveillances) {
                if (3 == videoSurveillance.getVideoType() && StringUtil.isNotEmpty(videoSurveillance.getUserName())
                        && StringUtil.isNotEmpty(videoSurveillance.getPwd())) {
                    String token = YingShiYun.getToken(videoSurveillance.getUserName(), videoSurveillance.getPwd());

                    //获取播放地址
                    StringBuffer urls = new StringBuffer();
                    Map params = new HashMap(2);
                    params.put("accessToken", token);
                    String dataStr = HttpClient4Util.doPost("https://open.ys7.com/api/lapp/live/video/list", params);
                    com.alibaba.fastjson.JSONObject dataJson = com.alibaba.fastjson.JSONObject.parseObject(dataStr);
                    com.alibaba.fastjson.JSONArray dataJson1 = dataJson.getJSONArray("data");
                    Iterator it = dataJson1.iterator();
                    while (it.hasNext()) {
                        com.alibaba.fastjson.JSONObject jo = (com.alibaba.fastjson.JSONObject) it.next();
                        urls.append(jo.getString("liveAddress")).append(",");
                    }
                    if (urls.length() > 0) {
                        urls.deleteCharAt(urls.length() - 1);
                    }
                    videoSurveillance.setVideoUrl(urls.toString());
                    videoSurveillance.setToken(token);
                }
            }
            json.setObj(surveillances);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }

    /**
     * @return
     * @Description 根据设备序列号+通道号获取kitToken
     * @Date 2021/05/19 15:46
     * @Author xiaoyl
     * @Param accountPhone 手机号码
     * @Param dev 设备序列号
     * @Param channelId 通道号
     */
    @RequestMapping("/getKitToken")
    @ResponseBody
    public AjaxJson getKitToken(String accountPhone, String dev, String channelId) {
        AjaxJson json = new AjaxJson();
        try {
            String kitToken = "";
            String token = LeChengMonitorUtil.getToken(accountPhone,dev);//获取用户token
            String kitTokenKey = "kitToken_" + accountPhone + "_" + dev + "_" + channelId;
            if (kitTokenMap.get(kitTokenKey) == null) {
                HashMap<String, Object> paramsMap = new HashMap<String, Object>();
                paramsMap.put("token", token);
                paramsMap.put("deviceId", dev);
                paramsMap.put("channelId", channelId);
//                paramsMap.put("type", "1");
                paramsMap.put("type", "0");//type: 0：所有权限；1：实时预览；2：录像回放（云录像+本地录像）
                com.alibaba.fastjson.JSONObject returnJson = HttpSend.execute(paramsMap, "getKitToken", accountPhone);
                if (returnJson == null || !returnJson.getJSONObject("result").getString("code").equals("0")) {
                    json.setSuccess(false);
                    json.setMsg("获取kitToken失败");
                } else {
                    //注：每个通道都有自己的kittoken:传入设备序列号+通道号获取
                    kitToken = returnJson.getJSONObject("result").getJSONObject("data").getString("kitToken");
                    kitTokenMap.put(kitTokenKey, kitToken, 3600,TimeUnit.SECONDS);//kittoken有效期2个小时，缓存一个小时
                }
            } else {
                kitToken = kitTokenMap.get(kitTokenKey).toString();
            }
            json.setObj(kitToken);
        } catch (MyException e) {
            json.setSuccess(false);
            json.setMsg(e.getText());
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败" + e.getMessage());
        }
        return json;
    }

    /**
     * @return
     * @Description 校准设备UTC时间
     * @Date 2021/05/19 15:46
     * @Author xiaoyl
	 * @Param id 摄像头配置记录ID
     * @Param phone 手机号码
     * @Param dev 设备序列号
     */
    @RequestMapping("/resetDeviceTime")
    @ResponseBody
    public AjaxJson resetDeviceTime(Integer id,String phone, String dev) {
        AjaxJson json = new AjaxJson();
        try {
        	//优先匹配ID进行重置，没有传入ID则根据传入的手机号码和设备号进行重置
        	if(id!=null){
        		BasePointVideoSurveillance videoSurveillance=service.queryById(id);
				phone=videoSurveillance.getAccountPhone();
				dev=videoSurveillance.getDev();
			}else if(StringUtil.isEmpty(phone) || StringUtil.isEmpty(dev)){
				json.setSuccess(false);
				json.setMsg("请传入乐橙手机号码和设备号码！");
			}
            String token = LeChengMonitorUtil.getToken(phone,dev);//获取用户token
            HashMap<String, Object> paramsMap = new HashMap<String, Object>();
            paramsMap.put("token", token);
            paramsMap.put("deviceId", dev);
            com.alibaba.fastjson.JSONObject returnJson = HttpSend.execute(paramsMap, "calibrationDeviceTime", phone);
            if (returnJson == null || !returnJson.getJSONObject("result").getString("code").equals("0")) {
                json.setSuccess(false);
                json.setMsg("校准设备UTC时间失败");
            }
            json.setObj(returnJson);
        } catch (MyException e) {
            json.setSuccess(false);
            json.setMsg(e.getText());
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败" + e.getMessage());
        }
        return json;
    }
    /**
     *视频回放
     * @param request
     * @param id
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年4月21日
     */
    @RequestMapping("/replayBack")
    public ModelAndView replayBack(HttpServletRequest request,Integer id) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            //获取当前用户信息
            TSUser tsUser = PublicUtil.getSessionUser();
           BasePointVideoSurveillance bean=service.queryById(id);
            map.put("bean",bean);
        } catch (Exception e) {
            log.error("*****查看数据异常：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return new ModelAndView("/data/video/replayBack", map);
    }
   /**
   * @Description 乐橙云摄像头视频回放，需要插入SD内存卡或者开通云存储才能进行回放
   * @Date 2022/07/22 14:18
   * @Author xiaoyl
   * @Param
   * @return
   */
    @RequestMapping("/replayBackForLC")
    public ModelAndView replayBackForLC(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSDepart depart = PublicUtil.getSessionUserDepart();
            TSDepartMapModel report = departMapService.selectReportByDepartid(depart.getId());
            map.put("report", report);
            com.alibaba.fastjson.JSONObject monitorObj = SystemConfigUtil.MONITOR_CONFIG;
            Map<String, Object> monitorConfig = JSON.parseObject(monitorObj.getString("account"));
            map.put("monitorConfig", monitorConfig);
        } catch (Exception e) {
            log.error("*****视频回放异常：" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return new ModelAndView("/data/video/replayBackForLC", map);
    }
    /**
     * 轻应用实时查看视频：旧版本，暂停使用
     * @description
     * @param pointId 检测点ID
     * @return
     * @author xiaoyl
     * @date 2020年4月22日
     */
/*	@RequestMapping("/selectDeviceForImouPlayer")
	@ResponseBody
	public AjaxJson selectDeviceForImouPlayer(Integer pointId){
		AjaxJson json = new AjaxJson();
		try {
			List<BasePointVideoSurveillance> surveillances=service.selectByPointId(pointId);
			json.setObj(surveillances);
			for (BasePointVideoSurveillance videoSurveillance : surveillances) {
				HashMap<String, Object> paramsMap = new HashMap<String, Object>();
				if(StringUtil.isNotEmpty(videoSurveillance.getDev()) &&  map.get("account_"+videoSurveillance.getAccountPhone())==null) {//根据手机号码获取appID和app_secret，用于获取轻应用KitToken使用
					com.alibaba.fastjson.JSONObject returnJson =HttpSend.execute(paramsMap, "accessToken",videoSurveillance.getAccountPhone());
					if(returnJson==null) {
						json.setSuccess(false);
						json.setMsg("操作失败,系统参数中未配置:"+videoSurveillance.getAccountPhone()+"相关的乐橙账号信息");
					}else {
						returnJson= returnJson.getJSONObject("result").getJSONObject("data");
					    String token = returnJson.getString("accessToken");
					    paramsMap.put("token",token);
				        paramsMap.put("deviceId", videoSurveillance.getDev());//   5J08DB7PAZC80A9  4L021E5PAJ62F72
				        paramsMap.put("channelId","0");
				        paramsMap.put("type", "1");
				        returnJson = HttpSend.execute(paramsMap, "getKitToken",videoSurveillance.getAccountPhone());
				        System.out.println(returnJson.getJSONObject("result").getJSONObject("data").getString("kitToken"));//获取kitToken
				        //注：kitToken在乐橙开放平台2小时有效，为提升用户体验，建议开发者在自身服务中针对kitToken缓存一小时处理，而不用每次调用开放平台接口获取。
				        map.put("account_"+videoSurveillance.getAccountPhone(), returnJson.getJSONObject("result").getJSONObject("data"),3600,TimeUnit.SECONDS);//,60,TimeUnit.SECONDS
				       System.out.println(returnJson);
					}
				} else if (3 == videoSurveillance.getVideoType() && StringUtil.isNotEmpty(videoSurveillance.getUserName())
						&& StringUtil.isNotEmpty(videoSurveillance.getPwd()) ) {
					String token = YingShiYun.getToken(videoSurveillance.getUserName(), videoSurveillance.getPwd());

					//获取播放地址
					StringBuffer urls = new StringBuffer();
					Map params = new HashMap(2);
					params.put("accessToken", token);
					String dataStr = HttpClient4Util.doPost("https://open.ys7.com/api/lapp/live/video/list", params);
					com.alibaba.fastjson.JSONObject dataJson = com.alibaba.fastjson.JSONObject.parseObject(dataStr);
					com.alibaba.fastjson.JSONArray dataJson1 = dataJson.getJSONArray("data");
					Iterator it = dataJson1.iterator();
					while (it.hasNext()){
						com.alibaba.fastjson.JSONObject jo = (com.alibaba.fastjson.JSONObject) it.next();
						urls.append(jo.getString("liveAddress")).append(",");
					}
					if (urls.length()>0){
						urls.deleteCharAt(urls.length()-1);
					}
					videoSurveillance.setVideoUrl(urls.toString());
					videoSurveillance.setToken(token);
				}
			}
			json.setAttributes(map);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return json;
	}*/

    /**
     * 轻应用实时查看视频
     * 返回数据格式
     * {"id":"f6acb070-2dca-4559-a818-245ccec92339","result":{"code":"0","data":{"count":34,"deviceList":[{"aplist":[],"bindId":14390478,"channels":[{"channelId":"0","channelName":"盛大农贸市场"}],"deviceId":"4G075C9PAJDB9AB"},{"aplist":[],"bindId":14387125,"channels":[{"channelId":"0","channelName":"金水农贸市场"}],"deviceId":"4G075C9PAJ2B9C5"},{"aplist":[],"bindId":14387111,"channels":[{"channelId":"0","channelName":"乐安城市广场"}],"deviceId":"4G075C9PAJ27490"},{"aplist":[],"bindId":14383837,"channels":[{"channelId":"0","channelName":"明月市场"}],"deviceId":"4G075C9PAJFC8BF"},{"aplist":[],"bindId":14383832,"channels":[{"channelId":"0","channelName":"银座超市东三路店"}],"deviceId":"4G075C9PAJ4D5DE"},{"aplist":[],"bindId":14383265,"channels":[{"channelId":"0","channelName":"胜大超市河口中心店"}],"deviceId":"4G075C9PAJ1EC84"},{"aplist":[],"bindId":14383260,"channels":[{"channelId":"0","channelName":"三义和蔬菜批发市场"}],"deviceId":"4G075C9PAJ74824"},{"aplist":[],"bindId":14377402,"channels":[{"channelId":"0","channelName":"市直机关食堂"}],"deviceId":"4G075C9PAJBF8F6"},{"aplist":[],"bindId":14377391,"channels":[{"channelId":"0","channelName":"胜大超市孤岛店"}],"deviceId":"4G075C9PAJ739DB"},{"aplist":[],"bindId":14375670,"channels":[{"channelId":"0","channelName":"金龙蔬菜批发市场"}],"deviceId":"4G075C9PAJ84098"},{"aplist":[],"bindId":14375662,"channels":[{"channelId":"0","channelName":"金岛中心超市"}],"deviceId":"4G075C9PAJ4E941"},{"aplist":[],"bindId":14369208,"channels":[{"channelId":"0","channelName":"东营市二中"}],"deviceId":"5K00D78PAJA8E09"},{"aplist":[],"bindId":14369205,"channels":[{"channelId":"0","channelName":"市一中"}],"deviceId":"4G075C9PAJ757F9"},{"aplist":[],"bindId":14338650,"channels":[{"channelId":"0","channelName":"河盛农贸市场"}],"deviceId":"4G075C9PAJ6DE0A"},{"aplist":[],"bindId":14338644,"channels":[{"channelId":"0","channelName":"新世纪平价超市"}],"deviceId":"4G075C9PAJ18F28"},{"aplist":[],"bindId":14327133,"channels":[{"channelId":"0","channelName":"民建购物广场"}],"deviceId":"4G075C9PAJ801DD"},{"aplist":[],"bindId":14327126,"channels":[{"channelId":"0","channelName":"科达市场"}],"deviceId":"4G075C9PAJ73A7B"},{"aplist":[],"bindId":14307081,"channels":[{"channelId":"0","channelName":"银座超市东凯店"}],"deviceId":"5K00D78PAJ5CF3E"},{"aplist":[],"bindId":14307077,"channels":[{"channelId":"0","channelName":"银座超市东二路店"}],"deviceId":"4G075C9PAJ82299"},{"aplist":[],"bindId":14225206,"channels":[{"channelId":"0","channelName":"东营技师学院"}],"deviceId":"5K00D78PAJ097B7"},{"aplist":[],"bindId":14225187,"channels":[{"channelId":"0","channelName":"辽河市场"}],"deviceId":"4G075C9PAJ37174"},{"aplist":[],"bindId":14207874,"channels":[{"channelId":"0","channelName":"东城万达利群超市"}],"deviceId":"5E01E71PAJD62EB"},{"aplist":[],"bindId":14207851,"channels":[{"channelId":"0","channelName":"百大超市胶州路店"}],"deviceId":"5K00D78PAJA0003"},{"aplist":[],"bindId":13970507,"channels":[{"channelId":"0","channelName":"恒利市场一楼检测室"}],"deviceId":"6C02592FAC3D827"},{"aplist":[],"bindId":13970435,"channels":[{"channelId":"0","channelName":"上虞水果批发市场"}],"deviceId":"6C02592FACFA297"},{"aplist":[],"bindId":13348655,"channels":[{"channelId":"0","channelName":"禅城_华远检测室"}],"deviceId":"5G0193CPAJ34D61"},{"aplist":[],"bindId":13348629,"channels":[{"channelId":"0","channelName":"2_1_实验室右"},{"channelId":"1","channelName":"1_3_实验室右"},{"channelId":"2","channelName":"1_1_前门"},{"channelId":"3","channelName":"1_3_实验室左"},{"channelId":"4","channelName":"2_2_仓库"},{"channelId":"5","channelName":"2_1_实验室左"},{"channelId":"6","channelName":"1_2_收样窗口"},{"channelId":"7","channelName":"2_3_楼梯走廊"}],"deviceId":"5D00893PBQD7DAF"},{"aplist":[],"bindId":13213694,"channels":[{"channelId":"0","channelName":"蓝天办公室"}],"deviceId":"4L021E5PAJ62F72"},{"aplist":[],"bindId":13213687,"channels":[{"channelId":"0","channelName":"农批_新农检测室"}],"deviceId":"4L021E5PAJCD636"},{"aplist":[],"bindId":13037868,"channels":[{"channelId":"0","channelName":"马山检测室"}],"deviceId":"5J065AAPAJC8C28"},{"aplist":[],"bindId":13013621,"channels":[{"channelId":"0","channelName":"昌安检测室"}],"deviceId":"5J065AAPAJC8D1D"},{"aplist":[],"bindId":13013595,"channels":[{"channelId":"0","channelName":"中兴检测室"}],"deviceId":"5J065AAPAJ4048A"},{"aplist":[],"bindId":13013472,"channels":[{"channelId":"0","channelName":"浙江绍兴_中兴"}],"deviceId":"5J039C1PAZ681DE"},{"aplist":[],"bindId":12586636,"channels":[{"channelId":"0","channelName":"NVR-80A9-1"},{"channelId":"1","channelName":"NVR-80A9-2"},{"channelId":"2","channelName":"NVR-80A9-3"}],"deviceId":"5J08DB7PAZC80A9"}]},"msg":"操作成功。"}}
     * @description
     * @return
     * @author xiaoyl
     * @date 2020年4月22日
     */
/*	@RequestMapping("/selectDeviceByPhone")
	@ResponseBody
	public AjaxJson selectDeviceByPhone(String  phone){
		AjaxJson json = new AjaxJson();
		try {
			HashMap<String, Object> paramsMap = new HashMap<String, Object>();
			com.alibaba.fastjson.JSONObject returnJson =HttpSend.execute(paramsMap, "accessToken",phone);
			if(returnJson==null) {
				json.setSuccess(false);
				json.setMsg("操作失败,系统参数中未配置:"+phone+"相关的乐橙账号信息");
			}else {
				returnJson= returnJson.getJSONObject("result").getJSONObject("data");
				if(returnJson!=null) {
					String token = returnJson.getString("accessToken");
					paramsMap = new HashMap<String, Object>();
					paramsMap.put("token",token);
					paramsMap.put("bindId",-1);//   5J08DB7PAZC80A9  4L021E5PAJ62F72
					paramsMap.put("limit",128);
					paramsMap.put("type", "bind");
					paramsMap.put("needApInfo", false);
					returnJson = HttpSend.execute(paramsMap, "deviceBaseList",phone);
					List<Map<String, Object>> list=Tools.jsonObj2List(returnJson);
					json.setObj(list);
					list.forEach((m)->{
						log.info(m.get("channelName")+"--"+m.get("deviceId")+"--"+m.get("channelId"));
					});
				}else {
					json.setSuccess(false);
					json.setMsg("操作失败,请配置:"+phone+"正确的APPID和秘钥，如果不知道appsecret，请登录open.lechange.com，开发者服务模块中创建应用");
				}
			}

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return json;
	}*/

    /**
     * 轻应用实时查看视频
     * 返回数据格式
     * {"id":"dcd44a51-bf94-4719-b15a-950fcf7b9f20","result":{"code":"0","data":{"devices":[{"channels":[{"channelId":"0","channelName":"NVR-80A9-1","status":"online"},{"channelId":"1","channelName":"NVR-80A9-2","status":"online"},{"channelId":"2","channelName":"NVR-80A9-3","status":"online"}],"deviceId":"5J08DB7PAZC80A9","status":"online"}]},"msg":"操作成功。"}}
     *
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年4月22日
     */
    @RequestMapping("/selectDeviceNo")
    @ResponseBody
    public AjaxJson selectDeviceNo(String phone, String dev) {
        AjaxJson json = new AjaxJson();
        try {
            String token = LeChengMonitorUtil.getToken(phone,dev);//获取用户token
            HashMap<String, Object> paramsMap = new HashMap<String, Object>();
            paramsMap.put("token", token);
            paramsMap.put("deviceIds", dev);
            com.alibaba.fastjson.JSONObject returnJson = HttpSend.execute(paramsMap, "queryBaseDeviceChannelInfo", phone);
            if (returnJson.getJSONObject("result").getString("code").equals("0")) {
                json.setObj(returnJson);
            } else {
                json.setSuccess(false);
                json.setMsg(returnJson.getJSONObject("result").getString("msg"));
            }
        } catch (MyException e) {
            json.setSuccess(false);
            json.setMsg(e.getText());
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败," + e.getMessage());
        }
        return json;
    }
}
