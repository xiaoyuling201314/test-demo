package com.dayuan.service.ledger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.ledger.BaseLedgerUser;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.ledger.BaseLedgerUserMapper;
import com.dayuan.model.ledger.BaseLedgerUserModel;
import com.dayuan.service.BaseService;

@Service
public class BaseLedgerUserService extends BaseService<BaseLedgerUser, Integer> {
	@Autowired
	private BaseLedgerUserMapper mapper;

	@Override
	public BaseMapper<BaseLedgerUser, Integer> getMapper() {
		return mapper;
	}

	/** 根据regId 或者 businessId查询账号
	  * @param regId
	 * @param businessId
	 * @return */
	public BaseLedgerUser selectByRegOrBusiId(Integer regId, Integer opeId) {

		return mapper.selectByRegOrBusiId(regId, opeId);
	}

	/** 通过账号&账号密码 查询数据是否存在
	 * 
	 * @return BaseLedgerUser
	 * 
	 */
	public BaseLedgerUser selectByUsernameOrPwd(BaseLedgerUserModel model) {
		
		return mapper.selectByUsernameOrPwd(model);
	}
	
	/**
	 * 根据openid 查询账号是否存在
	 * @param openid
	 * @return
	 */
	public BaseLedgerUser   selectByOpenid(String openid){
		
		return mapper.selectByOpenid(openid);
	}
	/**
	 * 查询账号是否存在
	 * @param username
	 * @return
	 */
	public BaseLedgerUser   selectByUsername(String username){

		return mapper.selectByUsername(username);
	}
	/**
	 * 解除微信账号绑定
	 * @param id
	 */
	public void deleteOpenid(Integer  id){
		mapper.deleteOpenid(id);
	}

}
