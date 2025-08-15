package com.dayuan.mapper.ledger;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.ledger.BaseLedgerUser;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.ledger.BaseLedgerUserModel;

public interface BaseLedgerUserMapper  extends BaseMapper<BaseLedgerUser, Integer>{
	
    int deleteByPrimaryKey(Integer id);

    int insert(BaseLedgerUser record);

    int insertSelective(BaseLedgerUser record);


    BaseLedgerUser selectByPrimaryKey(Integer id);


    int updateByPrimaryKeySelective(BaseLedgerUser record);


    int updateByPrimaryKey(BaseLedgerUser record);
    
    /**
     * 根据regId 或者 businessId查询账号 
     * @param regId
     * @param businessId
     * @return
     */
    BaseLedgerUser selectByRegOrBusiId(@Param("regId")Integer regId,@Param("opeId")Integer opeId);
    
    
    /**
     * 通过账号&账号密码 查询数据是否存在
     * @return
     */
    BaseLedgerUser	selectByUsernameOrPwd(BaseLedgerUserModel model);
    /**
     * 通过openid查询账号
     * @param openid
     * @return
     */
    BaseLedgerUser   selectByOpenid(String openid);
    /**
     * 查询账号是否存在
     * @param username
     * @return
     */
    BaseLedgerUser   selectByUsername(String username);
    /**
     * 解除微信绑定
     * @param id
     */
    void deleteOpenid(Integer  id);
    
}