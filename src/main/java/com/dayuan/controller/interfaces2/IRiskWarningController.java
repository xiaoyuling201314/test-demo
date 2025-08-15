package com.dayuan.controller.interfaces2;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 风险预警接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iRiskWarning")
public class IRiskWarningController extends BaseInterfaceController {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 查询风险预警消息
	 * @param userToken	用户token
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/query", method = RequestMethod.POST)
	public InterfaceJson query(HttpServletRequest request,
		@RequestParam(value="userToken") String userToken,
		@RequestParam(value="lastQueryTime",defaultValue="2000-01-01 00:00:01") String lastQueryTime){
		
		InterfaceJson aj = new InterfaceJson();
		try {
			///token验证
			TSUser user = tokenExpired(userToken);
			checkTime(lastQueryTime, WebConstant.INTERFACE_CODE3, "参数lastQueryTime格式不正确，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");


			StringBuffer sbuffer = new StringBuffer("SELECT dcr.rid id, dcr.food_name foodName, " +
					" tsd.origin, tsd.batch_number batchNumber, bro.reg_address regAddress " +
					"FROM data_check_recording dcr " +
					" LEFT JOIN tb_sampling_detail tsd ON dcr.sampling_detail_id = tsd.id " +
					" LEFT JOIN base_regulatory_object bro ON dcr.reg_id = bro.id " +
					"WHERE dcr.delete_flag=0 AND ( dcr.conclusion = '不合格' OR dcr.issend = '1' ) " +
					" AND dcr.check_date >= ? ORDER BY dcr.check_date DESC ");

			List<Map<String, Object>> list1 = jdbcTemplate.queryForList(sbuffer.toString(), lastQueryTime);

			List<Map<String, String>> list2 = new ArrayList<Map<String, String>>(list1.size());
			Iterator<Map<String,Object>> it = list1.iterator();
			while (it.hasNext()) {
				Map<String, Object> map1 = it.next();

				Map<String, String> map2 = new HashMap<String, String>(3);
				map2.put("id", map1.get("id").toString());
				map2.put("title", "高风险产品预警");
				StringBuffer content = new StringBuffer("高风险产品预警：");
				if (null != map1.get("origin") && !"".equals(map1.get("origin").toString())) {
					content.append("产地为").append(map1.get("origin").toString()).append("、");
				}
				if (null != map1.get("batchNumber") && !"".equals(map1.get("batchNumber").toString())) {
					content.append(map1.get("batchNumber").toString()).append("批次、");
				}
				if (null != map1.get("regAddress") && !"".equals(map1.get("regAddress").toString())) {
					content.append("销售区域").append(map1.get("regAddress").toString()).append("的");
				}
				if (null != map1.get("foodName") && !"".equals(map1.get("foodName").toString())) {
					content.append(map1.get("foodName").toString()).append("为食品安全高风险产品，注意再次进行快检或监督抽检");
				}
				map2.put("content", content.toString());
				list2.add(map2);
			}
			aj.setObj(list2);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}

}
