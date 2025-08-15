package com.dayuan.controller.interfaces2;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.service.data.BaseDeviceTypeService;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.data.BaseDevice;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.data.BaseDeviceService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;

/**
 * 仪器相关接口
 *
 * @author Dz
 */
@RestController
@RequestMapping("/iDevices")
public class IDevicesController extends BaseInterfaceController {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private BaseDeviceService baseDeviceService;
    @Autowired
    private BaseDeviceTypeService baseDeviceTypeService;

    /**
     * 仪器注册：根据系统参数配置进行仪器注册，任何模式下有空闲仪器时优先使用空闲仪器，没有空闲仪器时再根据对应的注册模式进行注册
     * 仪器注册模式：1 新增仪器后注册，2 无限自动注册，3 有限自动注册（首次注册该系列仪器自动完成，后续需先新增仪器后注册）；默认为1
     * @param userToken   用户Token
     * @param series      仪器系列，仪器系列device_series，例如LZ-7000；仪器系列（如：DY-3500Plus和DY3500Plus）中的杠自动适配，自动适配有杠和没杠的系列
     * @param mac         仪器mac地址
     * @param machineCode 机身码
     * @return
     */
    @RequestMapping(value = "/registerDevice", method = RequestMethod.POST)
    public InterfaceJson registerDevice(HttpServletRequest request, String userToken, String series, String mac, String machineCode) {
        InterfaceJson aj = new InterfaceJson();
        try {
            //必填验证
            TSUser user = tokenExpired(userToken);    //token验证
            required(series, WebConstant.INTERFACE_CODE1, "参数series不能为空");
            required(mac, WebConstant.INTERFACE_CODE1, "参数mac不能为空");
            //仪器注册模式：1 新增仪器后注册，2 无限自动注册，3 有限自动注册（首次注册该系列仪器自动完成，后续需先新增仪器后注册）；默认为1,
            Integer registrationMode = SystemConfigUtil.SYSTEM_NAME_CONFIG.getInteger("registrationMode") != null ? SystemConfigUtil.SYSTEM_NAME_CONFIG.getInteger("registrationMode") : 1;
            //1.根据检测点ID，仪器系列以及mac地址（出厂编号）查询仪器是否存在
            StringBuffer subffer = new StringBuffer();
            BaseDevice bean = null;
            String dealSeries=series.replace("-","");//替换横杠，匹配有杠和没杠的类型
            subffer.append("SELECT  d.id, d.device_code, d.device_name, d.device_type_id, " +
                    "	d.depart_id, d.point_id, d.base_user_id, d.use_date, " +
                    "	d.month, d.warranty_period, d.description, d.status, " +
                    "	d.remark, d.mac_address, d.serial_number, NULL AS param1, " +
                    "	NULL AS param2, NULL AS param3 " +
                    "FROM base_device d " +
                    "INNER JOIN base_device_type t ON d.device_type_id = t.id " +
                    "WHERE d.delete_flag = 0 AND d.mac_address = ? " +
                    "AND d.point_id = ? AND REPLACE(t.device_series,'-','') = ?");
            List<Map<String, Object>> map = jdbcTemplate.queryForList(subffer.toString(), new Object[]{mac, user.getPointId(), dealSeries});
            if (map.size() == 0) {//该仪器暂未注册过
                //2.根据检测点ID和仪器系列查询可用仪器信息
                subffer.delete(0, subffer.length());
                subffer.append("SELECT  d.id, d.device_code, d.device_name, d.device_type_id, " +
                        "	d.depart_id, d.point_id, d.base_user_id, d.use_date,  " +
                        "	d.month, d.warranty_period, d.description, d.status,  " +
                        "	d.remark, d.mac_address, d.serial_number, NULL AS param1, " +
                        "	NULL AS param2, NULL AS param3 " +
                        "FROM base_device d " +
                        "INNER JOIN base_device_type t ON d.device_type_id = t.id " +
                        "WHERE d.point_id = ? AND REPLACE(t.device_series,'-','') =? AND d.delete_flag = 0 AND d.status = 0  " +
                        "AND (d.serial_number IS NULL OR d.serial_number = '') " +
                        "ORDER BY d.update_date LIMIT 0, 1");
                map = jdbcTemplate.queryForList(subffer.toString(), new Object[]{user.getPointId(), dealSeries});
                //3.生成仪器唯一编号:仪器类型_yyyyMMddHHmmss  //+4位随机数  +RandomStringUtils.randomNumeric(4)
                String serialNumber = series + "_" + DateUtil.formatDate(new Date(), "yyyyMMddHHmmss") + RandomStringUtils.randomNumeric(4);
                //4.查询仪器系列相关信息，用于自动注册仪器时使用
                BaseDeviceType deviceType = baseDeviceTypeService.queryDeviceBySeries(dealSeries);
                Date date=new Date();
                if(deviceType==null){
                    throw new MyException("平台没有该系列仪器", "平台没有【"+series+"】系列仪器,请先在平台【仪器类别】中添加仪器系列", WebConstant.INTERFACE_CODE12);
                }else if (map.size() > 0) {//有空闲仪器
                    for (int i = 0; i < map.size(); i++) {
                        Map<String, Object> mapBean = map.get(0);
                        //5.更新仪器信息，保存唯一编号和mac地址
                        bean = new BaseDevice();
                        bean.setId((String) mapBean.get("id"));
                        bean.setMacAddress(mac);
                        bean.setSerialNumber(serialNumber);
                        bean.setRegisterDate(date);
                        bean.setLastUploadDate(date);
                        PublicUtil.setCommonForTable(bean, false, user);
                        baseDeviceService.updateById(bean);
                        break;
                    }
                } else if (registrationMode.equals(2)) {
                    //注册模式2:无限自动注册，自动添加仪器并完成注册
                    //仪器出厂编号：如果mac地址是传出厂编号则设置为出厂编号，否则直接设置仪器系列为出厂编号
                    String deviceCode=mac.indexOf(series)!=-1 ?  mac : series;
//                    bean = new BaseDevice(deviceCode, deviceType.getDeviceName(), "仪器设备", deviceType.getId(), user.getDepartId(), user.getPointId(), (short) 0, mac, serialNumber, date,date);
                    baseDeviceService.saveBaseDevice2AutoRegister(bean, user);
                } else if (registrationMode.equals(3)) {
                    //注册模式3:有限自动注册（根据检测点ID、仪器系列查询该系列是否首次注册,首次注册该系列仪器自动完成，非首次需先新增仪器后注册）
                    subffer.delete(0, subffer.length());
                    subffer.append("SELECT   count(*) FROM base_device d " +
                            " INNER JOIN base_device_type t ON d.device_type_id = t.id " +
                            " WHERE d.delete_flag = 0 AND d.point_id = ? AND REPLACE(t.device_series,'-','') = ? ");
                    int deviceCount = jdbcTemplate.queryForObject(subffer.toString(), Integer.class,new Object[]{user.getPointId(), dealSeries});
                    if (deviceCount == 0) {//该系列首次注册，自动新增仪器完成注册
                        //仪器出厂编号：如果mac地址是传出厂编号则设置为出厂编号，否则直接设置仪器系列为出厂编号
                        String deviceCode=mac.indexOf(series)!=-1 ?  mac : series;
//                        bean = new BaseDevice(deviceCode, deviceType.getDeviceName(), "仪器设备", deviceType.getId(), user.getDepartId(), user.getPointId(), (short) 0, mac, serialNumber,date,date);
                        PublicUtil.setCommonForTable(bean, false, user);
                        baseDeviceService.saveBaseDevice2AutoRegister(bean, user);
                    } else {
                        throw new MyException("检测点下该系列仪器均已注册", "检测点下没有【"+series+"】系列仪器或均已注册,请先在平台添加仪器", WebConstant.INTERFACE_CODE12);
                    }
                } else {//注册模式1 新增仪器后注册,该检测点下没有该系列仪器
                    throw new MyException("检测点下该系列仪器均已注册", "检测点下没有【"+series+"】系列仪器或均已注册,请先在平台添加仪器", WebConstant.INTERFACE_CODE12);
                }
                //根据仪器ID查询要返回的仪器信息
                StringBuffer subffer2 = new StringBuffer("SELECT d.id, d.device_code, d.device_name, d.device_type_id,  " +
                        " d.depart_id, d.point_id, d.base_user_id, d.use_date,   " +
                        " d.month, d.warranty_period, d.description, d.status,   " +
                        " d.remark, d.mac_address, d.serial_number, NULL AS param1,  " +
                        " NULL AS param2, NULL AS param3  " +
                        " FROM base_device d WHERE d.delete_flag = 0 AND d.id=?");
                List<Map<String, Object>> mapBean = jdbcTemplate.queryForList(subffer2.toString(), new Object[]{bean.getId()});
                aj.setObj(mapBean.get(0));
            } else {//该仪器曾注册过，直接返回
                aj.setObj(map.get(0));
                if ("1".equals(map.get(0).get("status"))) {
                    aj.setMsg("仪器已停用");
                } else {
                    aj.setMsg("仪器已注册");
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
     * 仪器注册
     * @param userToken    用户Token
     * @param series    仪器系列，仪器系列device_series，例如LZ-7000
     * @param mac    仪器mac地址
     * @param machineCode    机身码
     * @return
     */
	/*@RequestMapping(value = "/registerDevice", method = RequestMethod.POST)
	public InterfaceJson registerDevice(HttpServletRequest request, String userToken, String series, String mac, String machineCode){

		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(series, WebConstant.INTERFACE_CODE1, "参数series不能为空");
			required(mac, WebConstant.INTERFACE_CODE1, "参数mac不能为空");

			StringBuffer subffer=new StringBuffer();
			subffer.append("SELECT " +
					"	d.id, d.device_code, d.device_name, d.device_type_id, " +
					"	d.depart_id, d.point_id, d.base_user_id, d.use_date, " +
					"	d.month, d.warranty_period, d.description, d.status, " +
					"	d.remark, d.mac_address, d.serial_number, NULL AS param1, " +
					"	NULL AS param2, NULL AS param3 " +
					"FROM base_device d " +
					"INNER JOIN base_device_type t ON d.device_type_id = t.id " +
					"WHERE d.delete_flag = 0 AND d.mac_address = ? " +
					"AND d.point_id = ? AND t.device_series = ?");
			//根据mac地址查询仪器信息
			List<Map<String, Object>> map=jdbcTemplate.queryForList(subffer.toString(), mac,user.getPointId(),series);
			if(map.size()==0){//该仪器暂未注册过
				//根据用户ID和仪器系列查询可用仪器信息
				subffer.delete(0, subffer.length());
				subffer.append("SELECT " +
						"	d.id, d.device_code, d.device_name, d.device_type_id, " +
						"	d.depart_id, d.point_id, d.base_user_id, d.use_date,  " +
						"	d.month, d.warranty_period, d.description, d.status,  " +
						"	d.remark, d.mac_address, d.serial_number, NULL AS param1, " +
						"	NULL AS param2, NULL AS param3 " +
						"FROM base_device d " +
						"INNER JOIN base_device_type t ON d.device_type_id = t.id " +
						"WHERE d.point_id = ? AND t.device_series =? AND d.delete_flag = 0 AND d.status = 0  " +
						"AND (d.serial_number IS NULL OR d.serial_number = '') " +
						"ORDER BY d.update_date LIMIT 0, 1");
				map=jdbcTemplate.queryForList(subffer.toString(), user.getPointId(), series);
				if(map.size()>0){
					for(int i=0; i<map.size(); i++) {
						Map<String, Object> mapBean = map.get(0);

						if(!StringUtil.isNotEmpty(mapBean.get("serial_number"))) {	//有未注册仪器
							//1.生成仪器唯一编号:仪器类型_yyyyMMddHHmmss  //+4位随机数  +RandomStringUtils.randomNumeric(4)
							String serialNumber=series+"_"+DateUtil.formatDate(new Date(), "yyyyMMddHHmmss") + RandomStringUtils.randomNumeric(4);

							//2.更新仪器信息，保存唯一编号和mac地址
							BaseDevice bean = new BaseDevice();
							bean.setId((String) mapBean.get("id"));
							bean.setMacAddress(mac);
							bean.setSerialNumber(serialNumber);
							PublicUtil.setCommonForTable(bean, false, user);
							baseDeviceService.updateBySelective(bean);

							//3.设置返回仪器信息
							mapBean.put("mac_address", mac);
							mapBean.put("serial_number", serialNumber);

							aj.setObj(mapBean);
							break;
						}

						if(i == map.size()-1) {
							throw new MyException("检测点下该系列仪器均已注册", "检测点下该系列仪器均已注册", WebConstant.INTERFACE_CODE13);
						}

					}

				}else{//该检测点下没有该系列仪器
					throw new MyException("检测点下没有该系列仪器", "检测点下没有该系列仪器", WebConstant.INTERFACE_CODE12);
				}
			}else{//该仪器曾注册过，直接返回
				aj.setObj(map.get(0));
				if ("1".equals(map.get(0).get("status"))) {
					aj.setMsg("仪器已停用");
				} else {
					aj.setMsg("仪器已注册");
				}
			}

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
	}*/

}
