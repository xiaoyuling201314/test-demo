package com.dayuan.controller.data;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.*;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseDeviceModel;
import com.dayuan.service.data.*;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月20日
 */
@Controller
@RequestMapping("/data/devices")
public class BaseDeviceController extends BaseController {
	private final Logger log=Logger.getLogger(BaseDeviceController.class);
	@Autowired
	private BaseDeviceService baseDeviceService;
	@Autowired
	private BasePointService basePointService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BaseWorkersService baseWorkersService;
	@Autowired
	private BaseDeviceTypeService baseDeviceTypeService;
	@Autowired
	private BasePointUserService basePointUserService;
	@Autowired
	private TbSamplingDetailService samplingDetailService;

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
//	/**
//	 * 进入检测标准表页面
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping("/list")
//	public ModelAndView  list(Integer id,String type,HttpServletRequest request,HttpServletResponse response) throws Exception{
//		Map<String, Object> map=new HashMap<>();
//		int flag=0;//查询标识，是查询检测点还是检测机构下的设备信息
//		BaseBean2 bean=null;
//		if(type.equals("point")){//查询检测点信息
//			bean=basePointService.queryById(id);
//			flag=1;
//		}else{//查询检测机构信息
//			bean=departService.queryById(id);
//			flag=2;
//		}
//		map.put("pointId", bean.getId());
//		map.put("flag", flag);
//		return new ModelAndView("/data/devices/list",map);
//	}
	
	/**
	 * 数据列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(BaseDeviceModel model,Page page,HttpServletResponse response) throws Exception{
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseDeviceService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	
	/**
	 * 新增/编辑仪器
	 * @param bean
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public  AjaxJson save(BaseDevice bean,HttpServletRequest request, HttpServletResponse response) throws Exception {
		AjaxJson jsonObject = new AjaxJson();
		try {
			//清空出厂日期、修期、描述说明
			if(StringUtil.isNotEmpty(bean.getId())){
				BaseDevice old = baseDeviceService.getById(bean.getId());
				if (old != null && (bean.getUseDate() == null || bean.getWarrantyPeriod() == null || bean.getDescription() == null)){
					old.setUseDate(bean.getUseDate());
					old.setWarrantyPeriod(bean.getWarrantyPeriod());
					old.setDescription("");
					baseDeviceService.updateById(old);
				}
			}

			baseDeviceService.saveOrUpdateBaseDevice(bean);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(String id,HttpServletResponse response) throws Exception{
		AjaxJson jsonObject = new AjaxJson();
		BaseDevice bean  = baseDeviceService.getById(id);
		if(bean  == null){
			jsonObject.setSuccess(false);
			jsonObject.setMsg("没有找到对应的记录!");
		}
		jsonObject.setObj(bean);
		return jsonObject;
	}
	/**
	 * 1.删除数据，单条删除与批量删除通用方法
	 * 2.删除仪器的检测项目关联关系数据
	 * @param request
	 * @param response
	 * @param ids 要删除的数据记录id集合
	 * 
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			baseDeviceService.removeByIds(Arrays.asList(ida));
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 注册设备列表
	 * @param request
	 * @param id
	 * @param type
	 * @return
	 */
	@RequestMapping("/devicesList")
	public ModelAndView devicesList(HttpServletRequest request,Integer id,String type,@RequestParam(required = false,defaultValue = "Y") String showDudao, @RequestParam(required = false,defaultValue = "N") String openIframe) throws Exception{
		Map<String, Object> map=new HashMap<>();
		TSDepart depart = null;
		BasePoint point = null;
		BaseWorkers manager = null;
		//List<PPersonnelBaseWorkers> members = null;
		List<BaseDevice> devices = null;
		List<BasePointUser> users = null;
		
		if(type.equals("point")){
			//查询检测点信息
			point = basePointService.queryById(id);
			if(null != point){
				manager = baseWorkersService.queryById(point.getManagerId());
				//members = baseWorkersService.queryByPointId(point.getId());
				devices = baseDeviceService.queryAllDeviceByPointId(point.getId(),null,"仪器设备");
				users = basePointUserService.queryByPoint(null, point.getId());
			}
		}else{
			//查询检测机构信息
			depart = departService.getById(id);
			if(null != depart){
				manager = baseWorkersService.queryById(depart.getPrincipalId());
				//members = baseWorkersService.queryByDepartId(depart.getId());
				users = basePointUserService.queryByPoint(depart.getId(), null);
			}
		}
		//仪器类型
		List<BaseDeviceType> deviceTypes = baseDeviceTypeService.queryAll();
		
		map.put("point", point);	//检测点
		map.put("depart", depart);	//检测机构
		map.put("manager", manager);	//负责人
		//map.put("members", members);	//成员
		map.put("users", users);	//成员
		map.put("devices", devices);	//注册仪器
		map.put("deviceTypes", deviceTypes);	//仪器类型
		map.put("showDudao", showDudao);	//是否展示督导和人员名单信息
		map.put("openIframe", openIframe);	//是否以子窗口形式打开页面
		return new ModelAndView("/data/devices/devicesList",map);
	}
	
	/**
	 * 注册设备项目管理列表
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("/devicesItemsList")
	public ModelAndView devicesItemsList(HttpServletRequest request,String id){
		Map<String, Object> map=new HashMap<>();
		map.put("deviceId", id);
		return new ModelAndView("/data/devices/devicesItemsList",map);
	}
	
	/**
	 * 查找仪器
	 * @author Dz
	 * 2019年3月7日 下午5:27:29
	 * @param deviceSeriesId	仪器系列ID
	 * @param deviceCode	出厂编码
	 * @return
	 */
	@RequestMapping("/queryBySeriesAndCode")
	@ResponseBody
	public AjaxJson queryBySeriesAndCode(String deviceSeriesId,String deviceCode){
		AjaxJson json = new AjaxJson();
		try {
			List<BaseDevice> devices = baseDeviceService.queryBySeriesAndCode(deviceSeriesId, deviceCode);
			if(null != devices && devices.size()>0) {
				json.setObj(devices.get(0));
			}else {
				json.setObj(null);
			}
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return json;
	}
	
//	/**
//	 * 添加检测点仪器，查询仪器出厂编码是否被占用
//	 * @author Dz
//	 * @param deviceCode 出厂编码
//	 * @return 
//	 */
//	@RequestMapping("/queryByDeviceCode")
//	@ResponseBody
//	public ValidformJson queryByDeviceCode(HttpServletRequest request,HttpServletResponse response,String deviceCode,String deviceId){
//		ValidformJson json = new ValidformJson();
//		try {
//			BaseDevice device = baseDeviceService.queryByDeviceCode(deviceCode);
//			if(StringUtil.isEmpty(deviceId)){	//新增仪器
//				if(device!=null && StringUtil.isNotEmpty(device.getDepartId())){	//仪器已存在,并已被其他检测点使用
//					json.setStatus("n");
//					json.setInfo("该仪器已被使用");
//				}
//			}else{	//编辑仪器,防止修改后出厂编码重复
//				if(device!=null && !deviceId.equals(device.getId()) && StringUtil.isNotEmpty(device.getDepartId()) ){
//					json.setStatus("n");
//					json.setInfo("该仪器已被使用");
//				}
//			}
//		} catch (Exception e) {
//			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber();
//			json.setStatus("n");
//			json.setInfo("验证失败");
//		}
//		return json;
//	}
	
	/**
	 * 查看仪器检测任务页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/deviceTasks")
	public ModelAndView deviceTasks(HttpServletRequest request, HttpServletResponse response, String id){
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			BaseDevice device = baseDeviceService.getById(id);
			map.put("deviceId", id);
			map.put("serialNumber", device.getSerialNumber());
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/data/devices/deviceTasks",map);
	}
	
	/**
	 * 重置检测任务接收状态
	 * @param request
	 * @param response
	 * @param detailId	抽样明细ID
	 * @return
	 */
	@RequestMapping("/resetCheckTask")
	@ResponseBody
	public AjaxJson resetCheckTask(HttpServletRequest request,HttpServletResponse response,Integer detailId){
		AjaxJson jsonObj = new AjaxJson();
		try {
			samplingDetailService.resetStatus(detailId);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	
	@RequestMapping("/monitor")
	public ModelAndView monitor(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			TSUser user = PublicUtil.getSessionUser();
			
			List<Map<String, Object>> devices = null;
			List<Map<String, Object>> points = null;
			StringBuffer sbuffer = new StringBuffer();
			if(null != user.getPointId()) {
				sbuffer.append("SELECT bd.id, bd.device_code, bd.device_name,  " + 
						"		bp.id point_id, bp.point_name, " + 
						"		bp.place_x, bp.place_y, bd.status " + 
						"	FROM base_device bd " + 
						"	INNER JOIN base_point bp ON bd.point_id = bp.id " + 
						"WHERE bd.delete_flag = 0 AND bd.device_style = '仪器设备' " + 
						"	AND bp.delete_flag = 0  " + 
						"	AND bp.place_x IS NOT NULL AND bp.place_x != ''  " + 
						"	AND bp.place_y IS NOT NULL AND bp.place_y != ''  " + 
						"	AND bp.id = ? ");
				devices = jdbcTemplate.queryForList(sbuffer.toString(), user.getPointId());
				
				sbuffer.setLength(0);
				sbuffer.append("SELECT id, point_name, place_x, place_y FROM base_point WHERE id = ? ");
				points = jdbcTemplate.queryForList(sbuffer.toString(), user.getPointId());
				
			}else if(null != user.getDepartId()) {
				sbuffer.append("SELECT bd.device_code, bd.device_name,  " + 
						"		bp.id point_id, bp.point_name, " + 
						"		bp.place_x, bp.place_y, bd.status " + 
						"	FROM base_device bd " + 
						"	INNER JOIN base_point bp ON bd.point_id = bp.id " + 
						"WHERE bd.delete_flag = 0 AND bd.device_style = '仪器设备' " + 
						"	AND bp.delete_flag = 0  " + 
						"	AND bp.place_x IS NOT NULL AND bp.place_x != ''  " + 
						"	AND bp.place_y IS NOT NULL AND bp.place_y != ''  " + 
						"	AND bp.depart_id IN ( " + 
						"		SELECT id FROM t_s_depart  " + 
						"			WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?),'%') " + 
						"	)");
				devices = jdbcTemplate.queryForList(sbuffer.toString(), user.getDepartId());
				
				if(devices != null && devices.size() > 0) {
					sbuffer.setLength(0);
					sbuffer.append("SELECT id, point_name, place_x, place_y FROM base_point WHERE id IN (");
					for (Map<String, Object> device : devices) {
						sbuffer.append(device.get("point_id")+",");
					}
					sbuffer.deleteCharAt(sbuffer.length() - 1);
					sbuffer.append(")");
					points = jdbcTemplate.queryForList(sbuffer.toString());
				}
			}
			
			map.put("devices", devices);
			map.put("points", points);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/data/devices/devicesMonitor",map);
	}
	
	@RequestMapping("/monitorData")
	@ResponseBody
	public Object monitorData(HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			TSUser user = PublicUtil.getSessionUser();
			
			List<Map<String, Object>> devices = null;
			List<Map<String, Object>> points = null;
			StringBuffer sbuffer = new StringBuffer();
			if(null != user.getPointId()) {
				sbuffer.append("SELECT bd.id, bd.device_code, bd.device_name,  " + 
						"		bp.id point_id, bp.point_name, " + 
						"		bp.place_x, bp.place_y, bd.status " + 
						"	FROM base_device bd " + 
						"	INNER JOIN base_point bp ON bd.point_id = bp.id " + 
						"WHERE bd.delete_flag = 0 AND bd.device_style = '仪器设备' " + 
						"	AND bp.delete_flag = 0  " + 
						"	AND bp.place_x IS NOT NULL AND bp.place_x != ''  " + 
						"	AND bp.place_y IS NOT NULL AND bp.place_y != ''  " + 
						"	AND bp.id = ? ");
				devices = jdbcTemplate.queryForList(sbuffer.toString(), user.getPointId());
				
				sbuffer.setLength(0);
				sbuffer.append("SELECT bp.id point_id, bp.point_name, " + 
						"		bp.place_x, bp.place_y, COUNT(1) device_num, GROUP_CONCAT(bd.device_code) point_devices_code " + 
						"	FROM base_device bd " + 
						"	INNER JOIN base_point bp ON bd.point_id = bp.id " + 
						"WHERE bd.delete_flag = 0 AND bd.device_style = '仪器设备' " + 
						"	AND bp.delete_flag = 0  " + 
						"	AND bp.place_x IS NOT NULL AND bp.place_x != ''  " + 
						"	AND bp.place_y IS NOT NULL AND bp.place_y != ''  " + 
						"	AND bp.id = ? ");
				points = jdbcTemplate.queryForList(sbuffer.toString(), user.getPointId());
				
			}else if(null != user.getDepartId()) {
				sbuffer.append("SELECT bd.device_code, bd.device_name,  " + 
						"		bp.id point_id, bp.point_name, " + 
						"		bp.place_x, bp.place_y, bd.status " + 
						"	FROM base_device bd " + 
						"	INNER JOIN base_point bp ON bd.point_id = bp.id " + 
						"WHERE bd.delete_flag = 0 AND bd.device_style = '仪器设备' " + 
						"	AND bp.delete_flag = 0  " + 
						"	AND bp.place_x IS NOT NULL AND bp.place_x != ''  " + 
						"	AND bp.place_y IS NOT NULL AND bp.place_y != ''  " + 
						"	AND bp.depart_id IN ( " + 
						"		SELECT id FROM t_s_depart  " + 
						"			WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?),'%') " + 
						"	)");
				devices = jdbcTemplate.queryForList(sbuffer.toString(), user.getDepartId());
				
				if(devices != null && devices.size() > 0) {
					sbuffer.setLength(0);
					sbuffer.append("SELECT bp.id point_id, bp.point_name, " + 
							"		bp.place_x, bp.place_y, COUNT(1) device_num, GROUP_CONCAT(bd.device_code) point_devices_code " + 
							"	FROM base_device bd " + 
							"	INNER JOIN base_point bp ON bd.point_id = bp.id " + 
							"WHERE bd.delete_flag = 0 AND bd.device_style = '仪器设备' " + 
							"	AND bp.delete_flag = 0  " + 
							"	AND bp.place_x IS NOT NULL AND bp.place_x != ''  " + 
							"	AND bp.place_y IS NOT NULL AND bp.place_y != ''  " + 
							"	AND bp.depart_id IN ( " + 
							"		SELECT id FROM t_s_depart  " + 
							"			WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?),'%') " + 
							"	) GROUP BY bp.id");
					points = jdbcTemplate.queryForList(sbuffer.toString(), user.getDepartId());
				}
			}
			
			map.put("devices", devices);
			map.put("points", points);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return map;
	}

	/**
	* @Description 仪器解绑:在对仪器进行解绑时，同时清空“注册时间”、“累计上传数量”以及“最后使用时间”等字段的数据，并记录解绑时间
	* @Date 2023/01/04 10:04
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping(value="/unbindDevice")
	@ResponseBody
	public  AjaxJson unbindDevice(String deviceId){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(deviceId)){
				BaseDevice bean = baseDeviceService.getById(deviceId);
				bean.setMacAddress("");
				bean.setSerialNumber("");
				bean.setRegisterDate(null);
				bean.setLastUploadDate(null);
				bean.setUploadNumbers(0);
				bean.setUnbindingDate(new Date());
				PublicUtil.setCommonForTable(bean, false);
				baseDeviceService.updateById(bean);
			}
		} catch (Exception e) {
			log.error("******************************" + e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("解绑失败，"+e.getMessage());
		}
		return jsonObject;
	}
}
