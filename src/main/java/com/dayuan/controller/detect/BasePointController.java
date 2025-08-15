package com.dayuan.controller.detect;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.logs.aop.SystemLog;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDevice;
import com.dayuan.bean.data.BaseDevicePointRel;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.BasePointType;
import com.dayuan.bean.data.BasePointUser;
import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BasePointModel;
import com.dayuan.service.data.BaseDevicePointRelService;
import com.dayuan.service.data.BaseDeviceService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.BasePointTypeService;
import com.dayuan.service.data.BasePointUserService;
import com.dayuan.service.data.BaseWorkersService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;

/**
 * 检测点管理
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
@Controller
@RequestMapping("/detect/basePoint")
public class BasePointController extends BaseController {
	private final Logger log = Logger.getLogger(BasePointController.class);
	@Autowired
	private BasePointService basePointService;
	@Autowired
	private BaseWorkersService baseWorkersService;
	@Autowired
	private BaseDeviceService baseDeviceService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BasePointUserService basePointUserService;
	@Autowired
	private BasePointTypeService pointTypeService;
	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;
	@Autowired
	private BaseDevicePointRelService baseDevicePointRelService;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Value("${resources}")
	private String resources;
	/**
	 * 进入快检点界面
	 * @param id 组织机构ID
	 * @param returnBtn 显示返回上一级按钮，null不显示，Y显示
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response,Integer id,String returnBtn,String hidePerson){
		List<BasePointType> types = pointTypeService.selectAllType();
		Map<String,Object> map = new HashMap<String, Object>();
		List<Map<String,Object>> pointInfos = new ArrayList<Map<String,Object>>();
		List<BasePoint> points = null;
		List<BaseWorkers> workers = null;
		TSDepart depart = null;
//		List<TSDepart> departOptions = null;
		try {
			//按钮操作权限
			
			
			if(StringUtil.isNotEmpty(id)){
				points = basePointService.selectByDepartid(id,null);
				
				depart = departService.getById(id);
//				if(depart!=null){
//					departOptions = departService.getDepartsByPid(depart.getDepartPid());
//				}
			}else{
				//获取当前用户信息
				TSUser tsUser = PublicUtil.getSessionUser();
				if(null != tsUser){
					if(tsUser.getPointId() != null) {
						//检测点用户只能看到所属检测点信息
						points = new ArrayList<BasePoint>();
						BasePoint uPoint = basePointService.queryById(tsUser.getPointId());
						if(uPoint!=null) {
							points.add(uPoint);
						}
					}else {
						points = basePointService.selectByDepartid(tsUser.getDepartId(),null);
						map.put("pointInfos", pointInfos);
						
						depart = departService.getById(tsUser.getDepartId());
//					if(depart!=null){
//						departOptions = departService.getDepartsByPid(depart.getDepartPid());
//					}
					}
				}
			}
			if(null != points){
				for(BasePoint point : points){
					Map<String,Object> map1 = new HashMap<String, Object>();
					//负责人
					BaseWorkers manager = baseWorkersService.queryById(point.getManagerId());
					//成员
					//List<BaseWorkers> members = baseWorkersService.queryByPointId(point.getId());
					List<BasePointUser> members = basePointUserService.queryByPointId(point.getId());
					//仪器
					List<BaseDevice> devices = baseDeviceService.queryAllDeviceByPointId(point.getId(),null,"仪器设备");
					map1.put("point", point);
					map1.put("manager", manager);
					map1.put("devicesSize", devices.size());
					map1.put("membersSize", members.size());
					pointInfos.add(map1);
				}
			}
			//所有人员
			workers = baseWorkersService.queryAll();
			
			map.put("depart", depart);
//			map.put("departOptions", departOptions);
			map.put("pointInfos", pointInfos);
			map.put("workers", workers);
			map.put("types", types);

			map.put("hidePerson", hidePerson);//是否隐藏督导和人员
			if(StringUtil.isNotEmpty(returnBtn) && "Y".equals(returnBtn)){
				map.put("returnBtn", "Y");
			}else{
				map.put("returnBtn", "N");
			}
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		
		return new ModelAndView("/detect/basePoint/list",map);
	}
	
	/**
	 * 数据列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(BasePointModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSDepart bean= departService.getById(model.getDepartId());
			if(bean!=null) {
				model.setDepart(bean);
			}

			//项目预览，查询检测点当天不合格数据数量
			if (model.getIsQueryUnqualified() == 1) {
				Calendar c = Calendar.getInstance();
				model.setStartDateStr(DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"));
				model.setEndDateStr(DateUtil.formatDate(c.getTime(), "yyyy-MM-dd HH:mm:ss"));
			}

			page = basePointService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 添加/修改
	 * @param point
	 * @param request
	 * @param request
	 * @param overwriteAddress 0:更新地址，1:不更新地址 （用于检测点修改坐标）
	 * @param operator 操作对象：point：新增/修改检测点，position：编辑检测点定位信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
//	@SystemLog(module = "检测点管理",methods = "新增与编辑",type = 1,serviceClass = "basePointService",parameterType = "Integer")
	public  AjaxJson save(HttpServletRequest request, BasePoint point, @RequestParam(value="urlPathFile",required=false) MultipartFile file,
						  @RequestParam(required=false,defaultValue="0")String overwriteAddress,@RequestParam(required=false,defaultValue="point")String operator) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			if (null != point.getPointType()) {
				switch (point.getPointType()) {
					//检测车
					case "1":
						point.setPointType("1");
						point.setPointTypeId("1");
						break;
					//企业检测室
					case "2":
						point.setPointType("0");
						point.setPointTypeId("2");
						break;
					//政府检测室
					default:
						point.setPointType("0");
						point.setPointTypeId("1");
						break;
				}
			}

			if(StringUtil.isNotEmpty(point.getId())){
				PublicUtil.setCommonForTable(point, false);
				BasePoint basePoint=basePointService.queryById(point.getId());
				if(operator.equals("point")){//编辑检测点信息,修改定位信息时不操作其他字段
					//清空督导、车牌、IMEI、电话、地址、备注、序号
					if (point.getManagerId() == null){
						point.setManagerId("");
					}
					if (point.getPhone() == null){
						point.setPhone("");
					}
					if (point.getRemark() == null){
						point.setRemark("");
					}
					if (point.getSorting() == null){
						//查询当前机构下检测点的最大排序
						Short Maxsrot = basePointService.queryMaxSortByDepartId(point.getDepartId());
						point.setSorting(Maxsrot);
					}
					if (point.getLicensePlate() == null){
						point.setLicensePlate("");
					}
					if (point.getImei() == null){
						point.setImei("");
					}
					if (point.getRegulatoryId() == null){
						point.setRegulatoryId("");
					}
					if(file!=null && file.getSize()>0) {//上传自定义电子签章
						String fileName = uploadFile(request, "/signatureFile/", file, UUIDGenerator.generate()+DyFileUtil.getFileExtension(file.getOriginalFilename()));
						point.setSignatureFile(fileName);
					}
				}
				if ("1".equals(overwriteAddress)) {
					//不更新地址
					point.setAddress(basePoint.getAddress());
				} else if (point.getAddress() == null){
					point.setAddress("");
				}
				if(!(basePoint.getDepartId()).equals(point.getDepartId())){//修改所属机构
					//delete by xiaoyl 2020/12/18 修改检测点机构的同时，将检测室类型从企业类下修改为其他类下会提示“该检测点绑定了监管对象,如果需要改变其所属机构,请先解除绑定!”
//					if (StringUtil.isEmpty(basePoint.getRegulatoryId())) {
						basePointService.updateBySelective(point);
						
						List<BaseDevice> baseDevices=baseDeviceService.queryAllDeviceByPointId(point.getId(),null,"仪器设备");
						if (baseDevices.size()>0) {
							for (BaseDevice baseDevice : baseDevices) {
								baseDevice.setDepartId(point.getDepartId());
								baseDeviceService.updateById(baseDevice);
							}
						}
						
						List<BaseDevicePointRel> baseDevicePointRels=baseDevicePointRelService.selectByPointId(point.getId());
						if (baseDevicePointRels.size()>0) {
							for (BaseDevicePointRel baseDevicePointRel : baseDevicePointRels) {
								baseDevicePointRel.setDepartId(point.getDepartId());
								baseDevicePointRelService.updateBySelective(baseDevicePointRel);
							}
						}
						
						List<BasePointUser> basePointUsers=basePointUserService.selectByPointId(point.getId());
						if (basePointUsers.size()>0) {
							for (BasePointUser basePointUser : basePointUsers) {
								basePointUser.setDepartId(point.getDepartId());
								basePointUserService.updateBySelective(basePointUser);
							}
						}
						
						List<BaseWorkers> baseWorkers=baseWorkersService.selectByPointId(point.getId());
						if (baseWorkers.size()>0) {
							for (BaseWorkers baseWorker : baseWorkers) {
								baseWorker.setDepartId(point.getDepartId());
								baseWorkersService.updateBySelective(baseWorker);
							}
						}
						
//					}else {
//						jsonObject.setSuccess(false);
//						jsonObject.setMsg("该检测点绑定了监管对象,如果需要改变其所属机构,请先解除绑定!");
//					}
				}else {
					basePointService.updateBySelective(point);
				}
				
			}else{
//				point.setId(UUIDGenerator.generate());
				if(point.getSorting() == null){
					//查询当前机构下检测点的最大排序
					Short Maxsrot = basePointService.queryMaxSortByDepartId(point.getDepartId());
					point.setSorting(Maxsrot);
				}
				point.setDeleteFlag((short) 0);
				PublicUtil.setCommonForTable(point, true);
				basePointService.insert(point);
			}
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("保存失败");
		}
		Map<String,Object> map=new HashMap<>();
		map.put("id",point.getId());
		jsonObject.setAttributes(map);
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
	public AjaxJson queryById(Integer id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			BasePointModel pointModel = new BasePointModel();
			BasePoint point  = basePointService.queryById(id);
			if(point == null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}else{
				pointModel.setBaseBean(point);
				
				//机构人员
				List<BasePointUser> pointUsers = basePointUserService.queryByPoint(null, point.getId());
				pointModel.setPointUsers(pointUsers);
		
				if(StringUtil.isNotEmpty(point.getDepartId())){
					//所属机构
					TSDepart depart =departService.getById(point.getDepartId());
					pointModel.setDepart(depart);
					if(!StringUtil.isEmpty(point.getPointTypeId())){
						BasePointType pointType = pointTypeService.queryById(Integer.valueOf(point.getPointTypeId()));
						List<BaseRegulatoryObject> regs = baseRegulatoryObjectService.queryRegByDepartId(point.getDepartId(),pointType.getRegualtoryTypeId());
						pointModel.setRegs(regs);
					}
				}
					
				if(StringUtil.isNotEmpty(point.getManagerId())){
					//负责人
					BaseWorkers baseWorker = baseWorkersService.queryById(point.getManagerId());
					pointModel.setBaseWorkers(baseWorker);
				}
			}
			jsonObject.setObj(pointModel);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败");
		}
		return jsonObject;
	}
	
	/**
	 * 删除数据，单条删除与批量删除通用方法
	 * @param request
	 * @param response
	 * @param ids 要删除的数据记录id集合
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	@SystemLog(module = "检测点管理",methods = "删除",type = 3,serviceClass = "basePointService")
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] idArray = ids.split(",");
			basePointService.deletePoints(idArray);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 查找数据，任务下达页面选择接收检测点
	 */
	@RequestMapping("/queryByDepartId")
	@ResponseBody
	public AjaxJson queryByDepartId(HttpServletResponse response,Integer departId,String subset,String pointName,String pointTypes){
		AjaxJson jsonObj = new AjaxJson();
		try {
			if(departId==0) {
				TSUser user = PublicUtil.getSessionUser();
				departId=user.getDepartId();
			}
			Integer[] pts = null;
			if (pointTypes != null && !"".equals(pointTypes.trim())) {
				String[] ptsStrs = pointTypes.split(",");
				pts = new Integer[ptsStrs.length];
				for (int i=0; i<ptsStrs.length; i++) {
					pts[i] = Integer.parseInt(ptsStrs[i]);
				}
			}

			List<BasePoint> points  = basePointService.queryByDepartId(departId,subset,pointName, pts);
			jsonObj.setObj(points);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("查询失败");
		}
		return jsonObj;
	}

	/**
	* @Description 进入快检点-新页面：整合机构和检测点功能，左侧树形展示机构，右侧根据机构查询检测点信息
	* @Date 2020/09/27 16:49
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/list_new")
	public ModelAndView list_new(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/detect/basePoint/list_new");
	}

	/**
	* @Description 根据机构ID查询直属检测点信息
	* @Date 2020/09/28 9:54
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/querySubPoint")
	@ResponseBody
	public AjaxJson querySubPoint(HttpServletResponse response,Integer departId,String pointName){
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSUser user = PublicUtil.getSessionUser();
			if(departId==null || departId==0) {
				departId=user.getDepartId();
			}
			List<BasePoint> points =null;
			//根据关键字查询检测点
			if(StringUtil.isNotEmpty(pointName)){
				TSDepart depart=departService.getById(departId);
				points = basePointService.selectDepartByName(depart.getDepartCode(),user.getPointId(),pointName);
			}else{
				points = basePointService.selectByDepartid(departId,user.getPointId());
			}
			List<Map<String, Object>> pointInfos = new ArrayList<Map<String, Object>>();
			for (BasePoint point : points) {
				Map<String, Object> map1 = new HashMap<String, Object>();
				// 仪器
				List<BaseDevice> devices = baseDeviceService.queryAllDeviceByPointId(point.getId(), null, "仪器设备");
				// 负责人
				BaseWorkers manager = baseWorkersService.queryById(point.getManagerId());
				List<BasePointUser> members = basePointUserService.queryByPointId(point.getId());
				map1.put("manager", manager);
				map1.put("membersSize", members.size());
				map1.put("point", point);
				map1.put("devicesSize", devices.size());
				pointInfos.add(map1);
			}
			jsonObj.setObj(pointInfos);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("查询失败"+e.getMessage());
		}
		return jsonObj;
	}

	/**
	 * select2检测点数据
	 * @param page 页码
	 * @param row 每页数量
	 * @param pointName 检测点名称
	 * @return
	 */
	@RequestMapping("/select2PointData")
	@ResponseBody
	public Map select2PointData(Integer page, Integer row, String pointName) {
		Map map = new HashMap();
		int total = 0;	//总数
		List points = new ArrayList();	//检测点
		try {
			if (pointName != null){
				pointName = pointName.replace("'","");
			}
			//使用浏览器缓存数据，后台不查询
			if (!"本地历史数据".equals(pointName)) {
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT id, " +
						" CONCAT((CASE WHEN point_type_id=1 AND point_type=0 THEN '[政]'  " +
						"  WHEN point_type_id=1 AND point_type=1 THEN '[车]'  " +
						"  WHEN point_type_id!=1 AND point_type=0 THEN '[企]'  " +
						"  ELSE ''  " +
						" END), point_name) name " +
						" FROM base_point " +
						"WHERE delete_flag = 0 ");
				if (StringUtil.isNotEmpty(pointName)) {
					sql.append(" AND point_name = '"+pointName+"' ");
				}

				sql.append(" UNION SELECT id, " +
						" CONCAT((CASE WHEN point_type_id=1 AND point_type=0 THEN '[政]'  " +
						"  WHEN point_type_id=1 AND point_type=1 THEN '[车]'  " +
						"  WHEN point_type_id!=1 AND point_type=0 THEN '[企]'  " +
						"  ELSE ''  " +
						" END), point_name) name " +
						" FROM base_point " +
						"WHERE delete_flag = 0 ");
				if (StringUtil.isNotEmpty(pointName)) {
					sql.append(" AND point_name LIKE '"+pointName+"%' ");
				}

				sql.append(" UNION SELECT id, " +
						" CONCAT((CASE WHEN point_type_id=1 AND point_type=0 THEN '[政]'  " +
						"  WHEN point_type_id=1 AND point_type=1 THEN '[车]'  " +
						"  WHEN point_type_id!=1 AND point_type=0 THEN '[企]'  " +
						"  ELSE ''  " +
						" END), point_name) name " +
						" FROM base_point " +
						"WHERE delete_flag = 0 ");
				if (StringUtil.isNotEmpty(pointName)) {
					sql.append(" AND point_name LIKE '%"+pointName+"%'");
				}
				if (page>0 && row>0) {
					sql.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
				}
				jdbcTemplate.query(sql.toString(), new RowCallbackHandler() {
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						do {
							Map point = new HashMap();
							point.put("id", rs.getInt("id"));	//样品ID
							point.put("name", rs.getString("name"));	//名称+别名
							points.add(point);
						} while (rs.next());
					}
				});

				sql.setLength(0);
				sql.append("SELECT COUNT(1) FROM base_point WHERE delete_flag = 0");
				if (StringUtil.isNotEmpty(pointName)) {
					sql.append(" AND point_name LIKE '%"+pointName+"%' ");
				}
				total = jdbcTemplate.queryForObject(sql.toString(), Integer.class);
			}
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
		}
		map.put("points", points);
		map.put("total", total);
		return map;
	}
}
