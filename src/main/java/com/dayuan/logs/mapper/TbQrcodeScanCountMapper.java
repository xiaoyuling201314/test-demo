package com.dayuan.logs.mapper;

import com.dayuan.logs.bean.TbQrcodeScanCount;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

public interface TbQrcodeScanCountMapper extends BaseMapper<TbQrcodeScanCount,Integer> {
    /**
     * @Description 根据对象ID或者抽样单号查询扫描计数对象
     * @Date 2021/07/20 16:43
     * @Author xiaoyl
     * @Param scanParam 扫描对象ID或抽样单号
     * @Param scanType 类型：0 抽样单，1 监管对象，2 经营户
     * @return
     */
    TbQrcodeScanCount queryByScanParams( @Param("scanParam") String scanParam,@Param("scanType")Integer scanType);
}