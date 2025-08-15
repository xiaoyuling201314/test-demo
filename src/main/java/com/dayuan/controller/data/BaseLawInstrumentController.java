package com.dayuan.controller.data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.bean.data.TSDepart;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.system.TSDepartMapModel;
import com.dayuan.service.system.TSDepartMapService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseLawInstrument;
import com.dayuan.bean.data.BaseLawInstrumentPlayback;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseLawInstrumentModel;
import com.dayuan.model.data.BaseLawInstrumentPlaybackModel;
import com.dayuan.service.data.BaseLawInstrumentPlaybackService;
import com.dayuan.service.data.BaseLawInstrumentService;
/**
 * 执法仪Controller
 * @author LuoYX
 * @date 2018年8月13日
 */
@RestController
@RequestMapping("/data/lawInstrument")
public class BaseLawInstrumentController extends BaseController {
	private final Logger log=Logger.getLogger(BaseLawInstrumentController.class);

	@Autowired
	private BaseLawInstrumentService service;
	@Autowired
	private BaseLawInstrumentPlaybackService playbackService;

	@Autowired
	private TSDepartMapService departMapService;

	@RequestMapping("/list")
	public ModelAndView list(){
		return new ModelAndView("/data/lawInstrument/list");
	}
	
	@RequestMapping("/list2")
	public ModelAndView list2(){
		return new ModelAndView("/data/lawInstrument/list2");
	}
	
	
	@RequestMapping(value="/save")
	@ResponseBody
	public  AjaxJson save(BaseLawInstrument bean,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			BaseLawInstrument lawInstrument=	service.queryById(bean.getId());
			if(bean.getDevIdno()==null||bean.getDevIdno()==""){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("设备号不能为空");	
				return jsonObject;
			}
			List<BaseLawInstrument> list=	service.selectByDevIdno(bean.getDevIdno());
			if(lawInstrument!=null){
				if(list.size()>1||(list.size()==1&&bean.getId()!=list.get(0).getId())){
					jsonObject.setSuccess(false);
					jsonObject.setMsg("设备号已存在");	
					return jsonObject;	
				}
				PublicUtil.setCommonForTable(bean, false);
				service.updateBySelective(bean);
			}else{
				if(list.size()>0){
					jsonObject.setSuccess(false);
					jsonObject.setMsg("设备号已存在");	
					return jsonObject;	
				}
				PublicUtil.setCommonForTable(bean, true);
				bean.setOnline((short) 0);
				service.insert(bean);	
			}
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	
	/**
	 * 查询当前设备信息
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	public AjaxJson queryById(Integer id) throws Exception{
		AjaxJson json = new AjaxJson();
		BaseLawInstrument bean = service.queryById(id);
		json.setObj(bean);
		return json;
	}
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
				String[] ida = ids.split(",");
			Integer[] idas = new Integer[ida.length];
			for (int i = 0; i < ida.length; i++) {
				idas[i] = Integer.parseInt(ida[i]);
			}
			service.delete(idas);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	@RequestMapping("/datagrid")
	public AjaxJson datagrid(BaseLawInstrumentModel model,Page page) throws Exception{
		AjaxJson json = new AjaxJson();
		page = service.loadDatagrid(page, model);
		json.setObj(page);
		return json;
	}
	/**
	 * 查看执法仪 实时视频
	 * @param id
	 * @param request
	 * @return
	 * @throws Exception
	 * @author LuoYX
	 * @date 2018年8月13日
	 */
	@RequestMapping("/viewMonitor")
	public BaseLawInstrument viewMonitor(Integer id,HttpServletRequest request) throws Exception{
		BaseLawInstrument instrument = service.queryById(id);
		return instrument;
	}
	/**
	 * 查看执法仪回放
	 * @param id
	 * @param request
	 * @return
	 * @throws Exception
	 * @author LuoYX
	 * @date 2018年8月20日
	 */
	@RequestMapping("/viewPlayBack")
	public ModelAndView viewPlayBack(Integer id,Integer type,HttpServletRequest request) throws Exception{
		request.setAttribute("instrumentId", id);
		request.setAttribute("type", type);
		return new ModelAndView("/data/lawInstrument/playback");
	}
	
	/**
	 * 执法仪 回放录像数据
	 * @return
	 * @author LuoYX
	 * @date 2018年8月20日
	 */
	@RequestMapping("/playbackDatagrid")
	public AjaxJson playbackDatagrid(Page page,BaseLawInstrumentPlaybackModel model){
		AjaxJson json = new AjaxJson();
		try {
			page = playbackService.loadDatagrid(page,model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		json.setObj(page);
		return json;
	}
	/**
	 * 查看执法仪 实时视频
	 * @param id
	 * @param request
	 * @return
	 * @throws Exception
	 * @author LuoYX
	 * @date 2018年8月13日
	 */
	@RequestMapping("/viewPlayback")
	public BaseLawInstrumentPlayback viewPlayback(Integer id,HttpServletRequest request) throws Exception{
		BaseLawInstrumentPlayback playback = playbackService.queryById(id);
		return playback;
	}
	/**
	* @Description 2022年上虞投标项目：视频回放功能
	* @Date 2022/04/28 15:19
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/replayBackForSY")
	public ModelAndView replayBackSY() throws MissSessionExceprtion {
		Map<String,Object> map = new HashMap<String, Object>();
		TSDepart depart = PublicUtil.getSessionUserDepart();
		TSDepartMapModel report=departMapService.selectReportByDepartid(depart.getId());
		map.put("report", report);
		return new ModelAndView("/data/lawInstrument/replayBackSY",map);
	}
}
