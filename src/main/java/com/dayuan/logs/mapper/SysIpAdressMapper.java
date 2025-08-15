package com.dayuan.logs.mapper;

import com.dayuan.logs.bean.SysIpAdress;
import com.dayuan.mapper.BaseMapper;
/**
 * @Description IP地址和物理地址对应表 Mapper
 * @Author xiaoyl
 * @Date 2022/03/03 14:55:32
 */
public interface SysIpAdressMapper extends BaseMapper<SysIpAdress, Integer> {
    /**
    * @Description 根据IP查询IP与物理地址对应关系对象
    * @Date 2022/03/04 9:51
    * @Author xiaoyl
    * @Param
    * @return
    */
    SysIpAdress querByIp(String ip);
}