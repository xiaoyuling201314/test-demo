package com.dayuan.service.detect;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.DepartTreeModel;
import com.dayuan.model.data.TreeNode;

import java.util.List;

/**
 * 组织机构
 *
 * @author Dz
 */
public interface TSDepartService extends IService<TSDepart> {

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception;


    /**
     * 获取机构树形数据
     *
     * @param id
     * @param state    设置节点状态
     * @param isJoinId 是否拼接机构ID add by xiaoyl 2020-10-16
     * @return
     * @throws MissSessionExceprtion
     */
    public List<TreeNode> getDapartTree(Integer id, Boolean state, Boolean isJoinId) throws MissSessionExceprtion;

    /**
     * 根据父ID获取机构集合
     *
     * @param pid
     * @return
     */
    public List<TSDepart> getDepartsByPid(Integer pid);

    /**
     * 根据父ID获取机构（不含删除机构）
     *
     * @param pid
     * @return
     */
    public List<TSDepart> getAllDepartsByPid(Integer pid);

    /**
     * 根据父ID获取机构集合
     * 包括本身
     *
     * @param pid
     * @return
     * @author wtt
     * @date 2018年8月24日
     */
    public List<TSDepart> getDepartsByPids(Integer pid);

    /**
     * 根据ID获取所有下级机构
     *
     * @param id
     * @return
     */
    public List<TSDepart> getAllSonDepartsByID(Integer id);

    /**
     * 根据机构ID，获取子机构及检测点集合
     *
     * @param departid
     * @return
     */
    public DepartTreeModel getDepartPoint(Integer departid);

    /**
     * 删除检测机构
     *
     * @param ids 检测机构ID
     * @throws Exception
     */
    public void deleteDeparts(Integer[] ids) throws Exception;

    /**
     * 根据机构名称获取机构
     *
     * @param departName
     * @return
     */
    public List<TSDepart> queryByDepartName(String departName);

    public List<TSDepart> getSonDepartsByIds(List<Integer> departArr, String departName);

    public List<TSDepart> getSonDepartsById(String departCode);

    /**
     * 查询机构下的所有子机构
     *
     * @param departCode
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public List<Integer> querySubDeparts(String departCode);

    /**
     * 查询机构下的所有子机构
     *
     * @param id
     * @return
     */
    public List<Integer> querySonDeparts(Integer id);

    /**
     * 根据region_id查询 这个行政机构下的 部门
     *
     * @param regionId
     * @return
     * @author LuoYX
     * @date 2018年4月25日
     */
    public List<TSDepart> queryDepartsByRegionId(String regionId);

    /**
     * 查询机构下的最大departCode
     *
     * @param departCode
     * @return
     * @author LuoYX
     * @date 2018年5月16日
     */
    public String getLastDepartCode(String departCode);

    /**
     * 根据departCode查询所有子机构
     *
     * @param departCode
     * @return
     * @author LuoYX
     * @date 2018年5月22日
     */
    public List<TSDepart> queryByDepartCode(String departCode);

    /**
     * 根据departId查询departCode
     *
     * @param departId
     * @return
     * @author Y
     * @date 2025年6月20日
     */
    public String queryByDepartId(Integer departId);


    /**
     * 查询选中机构下 有没有 机构
     *
     * @param departCode 选中机构的departCode
     * @param departName 机构名称
     * @return
     * @author LuoYX
     * @date 2018年5月25日
     */
    public List<TSDepart> selectByDepartCodeAndDepartName(String departCode, String departName);

    /**
     * 查询系统名称和版权
     * @param departCode
     * @return
     */
    public TSDepart selectSystemName(String departCode);

    public String getParentDepartList(Integer id);

    /**
     * 获取机构树形数据
     *
     * @param id
     * @param state 设置节点状态
     * @return
     * @throws MissSessionExceprtion
     */
    public List<TreeNode> getDepartTreeForPoint(Integer id, Boolean state, boolean isQueryPoint) throws Exception;
    /**
     * 根据父级ID查询其下机构的最大排序号
     *
     * @param departPid
     * @return
     */
    public short queryMaxSortByPid(Integer departPid);

    /**
    * @Description 根据机构ID查询所有的二级机构和所有的子类ID
    * @Date 2022/03/22 11:09
    * @Author xiaoyl
    * @Param
    * @return
    */
    public List<TSDepart> getSecondDepartsByPids(Integer departId);
    /**
    * @Description 根据机构ID查询当前机构和所属二级机构
    * @Date 2022/05/26 11:53
    * @Author xiaoyl
    * @Param
    * @return
    */
    public List<Integer> querySecondChild(Integer departId);
}
