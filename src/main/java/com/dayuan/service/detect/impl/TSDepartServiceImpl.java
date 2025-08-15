package com.dayuan.service.detect.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.data.TSDepartMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.DepartTreeModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.BaseService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.system.TSUserService;
import com.dayuan.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 组织机构
 *
 * @author Dz
 */
@Service
public class TSDepartServiceImpl extends ServiceImpl<TSDepartMapper, TSDepart> implements TSDepartService {


    @Autowired
    private TSUserService tsUserService;
    @Autowired
    private BasePointService basePointService;
    @Autowired
    private BaseRegulatoryObjectService regulatoryObjectService;

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    @Override
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
        }

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 获取机构树形数据
     *
     * @param id
     * @param state    设置节点状态
     * @param isJoinId 是否拼接机构ID add by xiaoyl 2020-10-16
     * @return
     * @throws MissSessionExceprtion
     */
    @Override
    public List<TreeNode> getDapartTree(Integer id, Boolean state, Boolean isJoinId) throws MissSessionExceprtion {
        List<TreeNode> trees = new ArrayList<TreeNode>();
        if (StringUtil.isNotEmpty(id)) {
            //多个机构
            List<TSDepart> departs = getBaseMapper().getDepartsByPid(id);
            for (TSDepart depart : departs) {
                TreeNode tree = new TreeNode();
                tree.setId(depart.getId() + "");
                if (isJoinId) {
                    tree.setText(depart.getDepartName() + "(" + depart.getId() + ")");
                } else {
                    tree.setText(depart.getDepartName());
                }

                //设置节点
                if (state) {
                    List<TSDepart> subDeparts = getBaseMapper().getDepartsByPid(depart.getId());
                    if (subDeparts != null && subDeparts.size() > 0) {
                        tree.setState("closed");
                    }
                }
                trees.add(tree);
            }
        } else {
            //当前用户机构（用于加载顶级节点）
            TSDepart depart = PublicUtil.getSessionUserDepart();
            TreeNode tree = new TreeNode();
            tree.setId(depart.getId() + "");
            if (isJoinId) {
                tree.setText(depart.getDepartName() + "(" + depart.getId() + ")");
            } else {
                tree.setText(depart.getDepartName());
            }

            //设置节点
            if (state && depart != null) {
                List<TSDepart> subDeparts = getBaseMapper().getDepartsByPid(depart.getId());
                if (subDeparts != null && subDeparts.size() > 0) {
                    tree.setState("closed");
                }
            }
            trees.add(tree);
        }
        return trees;
    }

    /**
     * 根据父ID获取机构集合
     *
     * @param pid
     * @return
     */
    @Override
    public List<TSDepart> getDepartsByPid(Integer pid) {
        return getBaseMapper().getDepartsByPid(pid);
    }

    /**
     * 根据父ID获取机构（含删除机构）
     *
     * @param pid
     * @return
     */
    @Override
    public List<TSDepart> getAllDepartsByPid(Integer pid) {
        return getBaseMapper().getAllDepartsByPid(pid);
    }

    /**
     * 根据父ID获取机构集合
     * 包括本身
     *
     * @param pid
     * @return
     * @author wtt
     * @date 2018年8月24日
     */
    @Override
    public List<TSDepart> getDepartsByPids(Integer pid) {
        return getBaseMapper().getDepartsByPids(pid);
    }

    /**
     * 根据ID获取所有下级机构
     *
     * @param id
     * @return
     */
    @Override
    public List<TSDepart> getAllSonDepartsByID(Integer id) {
        TSDepart depart = getById(id);
        if (depart == null) {
            return null;
        }
        return getBaseMapper().queryByDepartCode(depart.getDepartCode());
    }

    /**
     * 根据机构ID，获取子机构及检测点集合
     *
     * @param departid
     * @return
     */
    @Override
    public DepartTreeModel getDepartPoint(Integer departid) {
        return getBaseMapper().getDepartPoint(departid);
    }

    /**
     * 删除检测机构
     *
     * @param ids 检测机构ID
     * @throws Exception
     */
    @Override
    public void deleteDeparts(Integer[] ids) throws Exception {
        if (null != ids && ids.length > 0) {
            StringBuffer buffer = new StringBuffer();
            buffer.append("删除失败；");
            for (Integer id : ids) {
                TSDepart depart = getById(id);
                if (depart != null) {
                    List<TSDepart> childDeparts=getBaseMapper().queryByDepartCode(depart.getDepartCode());
                    if (childDeparts.size() > 1) {
                        buffer.append(depart.getDepartName() + "机构下存在子机构，请先将其删除！");
                        continue;
                    }
                    List<BasePoint> points = basePointService.queryByDepartId(id, "Y", null, new Integer[]{0, 1, 2});
                    List<TSUser> users = tsUserService.queryByDepartId(id, "Y", null);
                    List<BaseRegulatoryObject> regObjects = regulatoryObjectService.queryByDepartId(id, null);

                    if (points.size() > 0 || users.size() > 0 || regObjects.size() > 0) {
                        buffer.append(depart.getDepartName() + "已经被");
                        if (points.size() > 0) {
                            buffer.append("检测点管理、");
                        }
                        if (users.size() > 0) {
                            buffer.append("用户管理、");
                        }
                        if (regObjects.size() > 0) {
                            buffer.append("监管对象管理、");
                        }
                        buffer.deleteCharAt(buffer.length() - 1);
                        buffer.append("使用；");
                    }
                }
            }
            if (buffer.length() > 5) {
                //检测机构被占用，不再删除，并提示被占用信息
                throw new MyException(buffer.toString());
            }
//			逻辑删除检测机构
            getBaseMapper().deleteByPrimaryKey(ids);

        }
    }

    /**
     * 根据机构名称获取机构
     *
     * @param departName
     * @return
     */
    @Override
    public List<TSDepart> queryByDepartName(String departName) {
        return getBaseMapper().queryByDepartName(departName);
    }

    @Override
    public List<TSDepart> getSonDepartsByIds(List<Integer> departArr, String departName) {
        return getBaseMapper().getSonDepartsByIds(departArr, departName);
    }

    @Override
    public List<TSDepart> getSonDepartsById(String departCode) {
        return getBaseMapper().getSonDepartsById(departCode);
    }

    /**
     * 查询机构下的所有子机构
     *
     * @param departCode
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    @Override
    public List<Integer> querySubDeparts(String departCode) {
        return getBaseMapper().querySubDeparts(departCode);
    }

    /**
     * 查询机构下的所有子机构
     *
     * @param id
     * @return
     */
    @Override
    public List<Integer> querySonDeparts(Integer id) {
        return getBaseMapper().querySonDeparts(id);
    }

    /**
     * 根据region_id查询 这个行政机构下的 部门
     *
     * @param regionId
     * @return
     * @author LuoYX
     * @date 2018年4月25日
     */
    @Override
    public List<TSDepart> queryDepartsByRegionId(String regionId) {
        return getBaseMapper().queryDepartsByRegionId(regionId);
    }

    /**
     * 查询机构下的最大departCode
     *
     * @param departCode
     * @return
     * @author LuoYX
     * @date 2018年5月16日
     */
    @Override
    public String getLastDepartCode(String departCode) {
        return getBaseMapper().getLastDepartCode(departCode);
    }

    /**
     * 根据departCode查询所有子机构
     *
     * @param departCode
     * @return
     * @author LuoYX
     * @date 2018年5月22日
     */
    @Override
    public List<TSDepart> queryByDepartCode(String departCode) {
        return getBaseMapper().queryByDepartCode(departCode);
    }

    /**
     * 根据departId查询departCode
     *
     * @param departId
     * @return
     * @author Y
     * @date 2025年6月20日
     */
    @Override
    public String queryByDepartId(Integer departId) {
        return getBaseMapper().queryByDepartId(departId);
    }


    /**
     * 查询选中机构下 有没有 机构
     *
     * @param departCode 选中机构的departCode
     * @param departName 机构名称
     * @return
     * @author LuoYX
     * @date 2018年5月25日
     */
    @Override
    public List<TSDepart> selectByDepartCodeAndDepartName(String departCode, String departName) {
        return getBaseMapper().selectByDepartCodeAndDepartName(departCode, departName);
    }

    /**
     * 查询系统名称和版权
     * @param departCode
     * @return
     */
    @Override
    public TSDepart selectSystemName(String departCode) {
        if (StringUtils.hasText(departCode)) {
            ArrayList<String> departCodes = new ArrayList<String>();
            while (StringUtils.hasText(departCode)) {
                departCodes.add(departCode);
                if (departCode.length() <= 2) {
                    break;
                } else {
                    departCode = departCode.substring(0, departCode.length()-2);
                }
            }
            return getBaseMapper().selectSystemName(departCodes);
        } else {
            return null;
        }
    }

    @Override
    public String getParentDepartList(Integer id) {
        return getBaseMapper().getParentDepartList(id);
    }

    /**
     * 获取机构树形数据
     *
     * @param id
     * @param state 设置节点状态
     * @return
     * @throws MissSessionExceprtion
     */
    @Override
    public List<TreeNode> getDepartTreeForPoint(Integer id, Boolean state, boolean isQueryPoint) throws Exception {
        List<TreeNode> trees = new ArrayList<TreeNode>();
        Map<String, Object> map = null;
        if (StringUtil.isNotEmpty(id)) {
            //多个机构
            List<TSDepart> departs = getBaseMapper().getDepartsByPidForPoint(id);
            for (TSDepart depart : departs) {
                map = new HashMap<>();
                TreeNode tree = new TreeNode();
                tree.setId(depart.getId() + "");
                if (isQueryPoint) {
                    tree.setText(depart.getDepartName() + "(" + depart.getPointNumbers() + ")");
                } else {
                    tree.setText(depart.getDepartName());
                }
                map.put("departName", depart.getDepartName());
                tree.setAttributes(map);
                //设置节点
                if (state) {
                    List<TSDepart> subDeparts = getBaseMapper().getDepartsByPidForPoint(depart.getId());
                    if (subDeparts != null && subDeparts.size() > 0) {
                        tree.setState("closed");
                    }
                }
                trees.add(tree);
            }
        } else {
            //当前用户机构（用于加载顶级节点）
            TSDepart depart = PublicUtil.getSessionUserDepart();
            List<BasePoint> list = basePointService.queryByDepartId(depart.getId(), "N", null, new Integer[]{0, 1, 2});
            TreeNode tree = new TreeNode();
            tree.setId(depart.getId() + "");
            if (isQueryPoint) {
                tree.setText(depart.getDepartName() + "(" + list.size() + ")");
            } else {
                tree.setText(depart.getDepartName());
            }
            map = new HashMap<>();
            map.put("departName", depart.getDepartName());
            tree.setAttributes(map);
            //设置节点
            if (state && depart != null) {
                List<TSDepart> subDeparts = getBaseMapper().getDepartsByPidForPoint(depart.getId());
                if (subDeparts != null && subDeparts.size() > 0) {
                    tree.setState("closed");
                }
            }
            trees.add(tree);
        }
        return trees;
    }

    /**
     * 根据父级ID查询其下机构的最大排序号
     *
     * @param departPid
     * @return
     */
    @Override
    public short queryMaxSortByPid(Integer departPid) {
        return getBaseMapper().queryMaxSortByPid(departPid);
    }

    /**
    * @Description 根据机构ID查询所有的二级机构和所有的子类ID
    * @Date 2022/03/22 11:09
    * @Author xiaoyl
    * @Param
    * @return
    */
    @Override
    public List<TSDepart> getSecondDepartsByPids(Integer departId) {
        return getBaseMapper().getSecondDepartsByPids(departId);
    }
    /**
    * @Description 根据机构ID查询当前机构和所属二级机构
    * @Date 2022/05/26 11:53
    * @Author xiaoyl
    * @Param
    * @return
    */
    @Override
    public List<Integer> querySecondChild(Integer departId) {
        return getBaseMapper().querySecondChild(departId);
    }
}
