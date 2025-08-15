package com.dayuan.mapper.data;

import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Description:  检测点Mapper
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月7日
 */
public interface BasePointMapper extends BaseMapper<BasePoint, Integer> {

    /**
     * 通过组织ID查询检测点集合
     */
    List<BasePoint> selectByDepartid(@Param("departId") Integer departId, @Param("pointId") Integer pointId);

    /**
     * 逻辑删除检测点
     *
     * @param ids
     * @param userId
     * @author Dz
     */
    void deletePoints(@Param("ids") String[] ids, @Param("userId") String userId);

    /**
     * 通过组织ID查询检测点集合(可包含子级检测点)
     */
    List<BasePoint> queryByDepartId(@Param("departId") Integer departId, @Param("subset") String subset, @Param("pointName") String pointName, @Param("pointTypes") Integer[] pointTypes);

    BasePoint queryByUniqueIMEI(String imei);

    List<BasePoint> queryByPointType(@Param("pointType") String pointType, @Param("departArr") String[] departArr);

    List<BasePoint> selectByPointArr(@Param("pointArr") Integer[] pointArr, @Param("id") Integer id, @Param("pointName") String pointName, @Param("flag") Integer flag, @Param("videoType") Integer videoType,@Param("queryType")String queryType);

    /**
     * 查询出机构下所有的检测点及数量
     *
     * @param departCode 部门Code
     * @param subset     是否查询下级
     * @return
     * @author LuoYX
     * @date 2018年5月29日
     */
    List<Map<String, Object>> queryByDepartCode(@Param("departCode") String departCode, @Param("subset") String subset);

    /**
     * 查询当前机构下检测点的最大排序
     *
     * @param departId
     * @return
     */
    Short queryMaxSortByDepartId(Integer departId);

    /**
     * 查询机构下面的所有子机构的检测点
     * @author shit
     * @param departId
     * @return
     */
    List<Map<String,Object>> selectByDepartId(@Param("departId") Integer departId, @Param("pointId") Integer pointId);
    /**
     * @Description 查询机构下有多少个检测点
     * @Date 2021/11/23 15:39
     * @Author xiaoyl
     * @Param
     * @return
     */
    Integer queryPointSize(Integer departId);

    BasePoint queryRegByPointID(@Param("pointId")Integer pointId);

    int getRowTotalForGS(Page page);

    List<BasePoint> loadPointForGS(Page page);
    /**
    * @Description 根据关键字查询当前用户所属机构下的检测点信息
    * @Date 2022/07/29 11:08
    * @Author xiaoyl
    * @Param
    * @return
    */
    List<BasePoint> selectDepartByName(@Param("departCode")String departCode, @Param("pointId")Integer pointId, @Param("pointName")String pointName);
    /**
    * @Description 东营可视化大屏-根据检测点ID查询检测点和机构名称信息
    * @Date 2022/09/23 10:19
    * @Author xiaoyl
    * @Param
    * @return
    */
    BasePoint queryForVisual(@Param("pointId")Integer pointId);
    /**
    * @Description 根据机构ID查询配置了乐橙摄像头的检测点信息
    * @Date 2022/09/28 17:25
    * @Author xiaoyl
    * @Param
    * @return
    */
    List<BasePoint> selectConfigVideoPoint(@Param("departId")Integer departId);
}