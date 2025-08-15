package com.dayuan.service.data;

import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.mapper.data.BasePointMapper;
import com.dayuan.mapper.data.BasePointUserMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * Description: 检测点
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月8日
 */
@Service
public class BasePointService extends BaseService<BasePoint, Integer> {

	@Autowired
	private BasePointMapper mapper;
	@Autowired
	private BasePointUserMapper basePointUserMapper;

	public BasePointMapper getMapper() {
		return mapper;
	}
	/**
	 * 通过组织ID查询检测点集合
	 */
	public List<BasePoint> selectByDepartid(Integer departId, Integer pointId){
		return mapper.selectByDepartid(departId,pointId);
	}

	/**
	 * 删除检测点
	 * @param ids 检测点ID
	 * @throws MissSessionExceprtion
	 */
	public void deletePoints(String[] ids) throws MissSessionExceprtion {
		if(null != ids && ids.length>0){
			TSUser user = PublicUtil.getSessionUser();
			String userId = user == null ? null : user.getId();
			Map<String,Object> map = new HashMap<String,Object>();
			mapper.deletePoints(ids, userId);

			basePointUserMapper.deletePointUsers(ids);
		}
	}

	/**
	 * 通过机构ID查询检测点
	 * @param departId	机构ID
	 * @param subset	是否包含下级检测点 Y是/N否
	 * @param pointName 检测点名称
	 * @param pointTypes 检测点类型 0_政府检测室，1_企业检测室，2_快检车
	 * @return
	 */
	public List<BasePoint> queryByDepartId(Integer departId, String subset, String pointName, Integer[] pointTypes) throws Exception {
		List<BasePoint> points = mapper.queryByDepartId(departId, subset, pointName, pointTypes);
		return points;
	}
	/**
	 * 通过定位设备imei查询检测车信息
	 * @param imei
	 * @return
	 */
	public BasePoint queryByUniqueIMEI(String imei) {
		return mapper.queryByUniqueIMEI(imei);
	}

	/**
	 * 通过检测点类型和机构ID获取检测站或检测车
	 * @param pointType	检测点类型
	 * @param departArr	机构ID
	 * @return
	 */
	public List<BasePoint> queryByPointType(String pointType, String[] departArr) {
		List<BasePoint> points = mapper.queryByPointType(pointType, departArr);
		return points;
	}

	/**
	 * 查询有视频监控检测室
	 * @param pointArr
	 * @param id
	 * @param pointName
	 * @param flag
	 * @param videoType 监控类型
	 * @return
	 */
	public List<BasePoint> selectByPointArr(Integer[] pointArr, Integer id, String pointName, Integer flag, Integer videoType,String queryType){
		List<BasePoint> points =mapper.selectByPointArr(pointArr,id,pointName,flag,videoType,queryType);
		return points;
	}
	/**
	 * 查询出机构下所有的检测点及数量
	 * @param departCode 部门Code
	 * @param subset 是否查询下级
	 * @return
	 * @author LuoYX
	 * @date 2018年5月29日
	 */
	public List<Map<String,Object>> queryByDepartCode(String departCode, String subset) {
		return mapper.queryByDepartCode(departCode,subset);
	}

	/**
	 * 查询当前机构下检测点的最大排序
	 * @param departId
	 * @return
	 */
	public Short queryMaxSortByDepartId(Integer departId) {
		return mapper.queryMaxSortByDepartId(departId);
	}

	/**
	 * 查询机构下面的所有子机构的检测点
	 * @author shit
	 * @param departId
	 * @return
	 */
	public List<Map<String, Object>> selectByDepartId(Integer departId,Integer pointId) {
		return mapper.selectByDepartId(departId,pointId);
	}

	/**
	 * @Description 查询机构下有多少个检测点
	 * @Date 2021/11/23 15:38
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	public Integer queryPointSize(Integer departId) {
		return mapper.queryPointSize(departId);
	}

	public BasePoint queryRegByPointID(Integer pointId) {
		return mapper.queryRegByPointID(pointId);
	}
	/**
	* @Description 根据关键字查询当前用户所属机构下的检测点信息
	* @Date 2022/07/29 11:07
	* @Author xiaoyl
	* @Param
	* @return
	*/
	public List<BasePoint> selectDepartByName(String departCode, Integer pointId, String pointName) {
		return mapper.selectDepartByName(departCode,pointId,pointName);
	}
	/**
	* @Description 根据检测点ID查询检测点和机构名称信息
	* @Date 2022/09/23 10:18
	* @Author xiaoyl
	* @Param
	* @return
	*/
	public BasePoint queryForVisual(Integer pointId) {
		return mapper.queryForVisual(pointId);
	}
	/**
	* @Description 根据机构ID查询配置了乐橙摄像头的检测点信息
	* @Date 2022/09/28 17:25
	* @Author xiaoyl
	* @Param
	* @return
	*/
	public List<BasePoint> selectConfigVideoPoint(Integer departId) {
		return mapper.selectConfigVideoPoint(departId);
	}
}
