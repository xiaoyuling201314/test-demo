package com.dayuan3.terminal.mapper;

import com.dayuan.bean.Page;
import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.sampleDetail;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.ss.formula.functions.T;

import java.util.List;

public interface RequesterUnitMapper extends BaseMapper<RequesterUnit, Integer> {

    List<RequesterUnit> queryAll(@Param("lastUpdateTime") String lastUpdateTime);

    /**
     * 委托单位查询
     *
     * @param id
     * @param end
     * @param start
     * @return
     */
    List<sampleDetail> queryDataCheckById(@Param("id") Integer id,
                                          @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd, @Param("start") String start, @Param("end") String end, @Param("checkNumber") Integer checkNumber);

    /**
     * 判断名称、统一编码是否已存在
     *
     * @param requesterName
     * @param creditCode
     * @return
     */
    int queryIsExist(@Param("requesterName") String requesterName, @Param("creditCode") String creditCode);

    /**
     * 根据委托单位名称去查询校验其唯一性
     *
     * @param requesterName
     * @param id
     * @return
     */
    RequesterUnit selectByName(@Param("requesterName") String requesterName, @Param("id") Integer id);


    List<T> loadDatagrid2(Page page);

    int getRowTotal2(Page page);

    /**2020-03-04 shit
     * 委托单位查询检测数据
     * @param id
     * @param end 结束时间
     * @param start 开始时间
     * @param rowStart 分页第几条开始
     * @param rowEnd 第几条结束
     * @return
     */
    List<sampleDetail> queryDataCheckById2(@Param("id") Integer id, @Param("rowStart") int rowStart, @Param("rowEnd") int rowEnd, @Param("start") String start, @Param("end") String end, @Param("checkNumber") Integer checkNumber);
}