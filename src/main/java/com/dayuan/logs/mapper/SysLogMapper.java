package com.dayuan.logs.mapper;

import com.dayuan.logs.bean.SysLog;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysLogMapper extends BaseMapper<SysLog,Integer> {

    List<String> queryAllModule();
    /**
    * @Description 查询近三天没有物理地址的IP信息
    * @Date 2022/03/03 15:57
    * @Author xiaoyl
    * @Param
    * @return
    */
    List<String> queryIpForNotAddress();
    /**
    * @Description 根据IP地址更新日志表没有物理地址的日志信息
    * @Date 2022/03/03 15:57
    * @Author xiaoyl
    * @Param
    * @return
    */
    int updateLogsByIp(@Param("ip") String ip,@Param("address") String address);
}