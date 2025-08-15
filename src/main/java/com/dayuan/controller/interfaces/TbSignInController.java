package com.dayuan.controller.interfaces;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.app.TbSignIn;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.app.TbSignInService;
import com.dayuan.util.StringUtil;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年10月21日
 */
@Controller
@RequestMapping("/interfaces/tbSignin")
public class TbSignInController extends BaseInterfaceController{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TbSignInService tbSignInService;
	
	/**
	 * 检测结果上传
	 * @param userToken 	 用户token
	 * @param result 传输的json数据
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadData", method = RequestMethod.POST)
	public AjaxJson uploadDataCheck(HttpServletRequest request,HttpServletResponse response,String userToken,String result){
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(result, WebConstant.INTERFACE_CODE1, "参数result不能为空");
			
			result = URLDecoder.decode(result, "utf-8").replaceAll("\"", "\\\"");
			JSONObject jsonObject = JSONObject.parseObject(result);
			TbSignIn bean= JSONObject.parseObject(jsonObject.getString("result"),TbSignIn.class);

			required(bean.getLongitude(), WebConstant.INTERFACE_CODE1, "参数longitude不能为空");
			required(bean.getLatitude(), WebConstant.INTERFACE_CODE1, "参数latitude不能为空");
			required(bean.getSignType(), WebConstant.INTERFACE_CODE1, "参数signType不能为空");

			//打卡地址中的null -> ‘’
			if (null != bean.getAddress() && -1 != bean.getAddress().indexOf("null")) {
				bean.setAddress(bean.getAddress().replaceAll("null",""));
			}
			bean.setParam1(bean.getSignType()+"");

			PublicUtil.setCommonForTable(bean, true, user);
//			tbSignInService.insert(bean);
			bean=tbSignInService.saveSignData(bean, user);
			aj.setObj(bean.getId());
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	/**
	 * 
	 * @param userToken  		用户token
	 * @param lastUpdateTime	最后更新时间
	 * @param pageNumber 页码数
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/download", method = RequestMethod.POST)
	public AjaxJson download(HttpServletRequest request, String userToken,
			@RequestParam(required = true, defaultValue = "2000-1-1 00:00:01") String lastUpdateTime,
			@RequestParam(value="pageNumber",defaultValue="1",required=false)String pageNumber,
			@RequestParam(value="recordNumber",defaultValue="50",required=false)String recordNumber,
			@RequestParam(required = false) Integer signType){
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			checkTime(lastUpdateTime, WebConstant.INTERFACE_CODE3, "参数lastUpdateTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
			
			List<Map<String, Object>> list = null;
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append(" select * from tb_sign_in WHERE create_by=? and update_date>? ");
			if (signType != null) {
				sbuffer.append(" AND sign_type = " + signType + " ");
			}
			limit(sbuffer, pageNumber, recordNumber);
			list = jdbcTemplate.queryForList(sbuffer.toString(), user.getId(),lastUpdateTime);
			aj.setObj(list);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
}
