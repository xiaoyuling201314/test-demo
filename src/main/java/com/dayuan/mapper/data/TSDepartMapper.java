package com.dayuan.mapper.data;

import java.util.List;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.model.data.DepartTreeModel;
import org.apache.ibatis.annotations.Param;

public interface TSDepartMapper extends BaseMapper<TSDepart> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<TSDepart> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);
    
    /**
     * 根据机构ID，获取子机构及检测点
     * @param departid
     * @return
     */
    DepartTreeModel getDepartPoint(Integer departid);

    /**
     * 根据父ID获取机构
     * @param pid
     * @return
     */
    List<TSDepart> getDepartsByPid(Integer pid);

    /**
     * 根据父ID获取机构（含删除机构）
     * @param pid
     * @return
     */
    List<TSDepart> getAllDepartsByPid(Integer pid);
    
    /**
     * 根据父ID获取机构
     * 包括本身
     * @param pid
     * @return
     * @author wtt
     * @date 2018年8月24日
     */
    List<TSDepart> getDepartsByPids(Integer pid);
    
    /**
     * 根据机构名称获取机构
     * @param departName
     * @return
     */
    List<TSDepart> queryByDepartName(String departName);
    
    /**
     * 逻辑删除当前机构及其下级机构 
     * @author Dz
     * @param userId
     */
    void deleteDeparts(@Param("departId")Integer departId, @Param("userId") String userId);

    /**
	 * 查询机构下的所有子机构
	 * @param departCode
	 * @return
	 * @author LuoYX
	 * @date 2018年4月19日
	 */
    List<Integer> querySubDeparts(String departCode);
    
    List<Integer> querySonDeparts(@Param("id")Integer id);
	
	/**
	 * 查询机构下所有子机构的集合
	 * @param departArr
	 * @return
	 */
	List<TSDepart> getSonDepartsByIds(@Param("departArr")List<Integer> departArr,@Param("departName")String departName);
	
	List<TSDepart> getSonDepartsById(@Param("departCode")String departCode);

	/**
	 * 根据region_id查询 这个行政机构下的 部门
	 * @param regionId
	 * @return
	 * @author LuoYX
	 * @date 2018年4月25日
	 */
	List<TSDepart> queryDepartsByRegionId(String regionId);

	/**
	 * 查询机构下的最大departCode
	 * @param departCode
	 * @return
	 * @author LuoYX
	 * @date 2018年5月16日
	 */
	String getLastDepartCode(String departCode);

	/**
	 * 根据departCode查询所有子机构
	 * @param departCode
	 * @return
	 * @author LuoYX
	 * @date 2018年5月22日
	 */
	List<TSDepart> queryByDepartCode(String departCode);

	/**
	 * 根据departId查询departCode
	 * @param departId
	 * @return
	 * @author Y
	 * @date 2025年6月20日
	 */
	String queryByDepartId(Integer departId);
	
	/**
	 * 查询选中机构下 有没有 机构
	 * @param departCode 选中机构的departCode
	 * @param departName 机构名称
	 * @return
	 * @author LuoYX
	 * @date 2018年5月25日
	 */
	List<TSDepart> selectByDepartCodeAndDepartName(@Param("departCode")String departCode,@Param("departName")String departName);

	/**
	 * 查询系统名称和版权
	 * @param departCodes
	 * @return
	 */
	TSDepart selectSystemName(@Param("departCodes")List<String> departCodes);

	/**
	 * 根据机构ID，查询该机构的所有上级
	 * @param id
	 * @return
	 * @author wtt
	 * @date 2019年3月5日
	 */
	String getParentDepartList(Integer id);
	/**
	 * 根据父ID获取机构和检测点数量
	 * @param pid
	 * @return
	 */
	List<TSDepart> getDepartsByPidForPoint(Integer pid);

	/**
	 * 根据父级ID查询其下机构的最大排序号
	 *
	 * @param departPid
	 * @return
	 */
    short queryMaxSortByPid(Integer departPid);
	/**
	 * @Description 根据机构ID查询所有的二级机构和所有的子类ID
	 * @Date 2022/03/22 11:09
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	List<TSDepart> getSecondDepartsByPids(Integer departId);

	List<Integer> querySecondChild(Integer departId);

	void deleteByPrimaryKey(Integer[] ids);
}