package com.dayuan.service.wx;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.wx.WxUser;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.wx.WxUserMapper;
import com.dayuan.service.BaseService;

@Service
public class WxUserService extends BaseService<WxUser, Integer> {
	@Autowired
	private WxUserMapper mapper;

	@Override
	public BaseMapper<WxUser, Integer> getMapper() {
		return mapper;
	}

	/** 根据openid查询用户是否绑定
	 * @param openid 微信id
	 * @return */
	public WxUser selectByOpenid(String openid) {
		return mapper.selectByOpenid(openid);
	}

	/** 根据openid查询用户信息
	 * @param openid 微信id
	 * @return */
	public WxUser selectByOpenidForUser(String openid) {
		return mapper.selectByOpenidForUser(openid);
	}
	
	/** 根据userId查询是否被绑定
	 * @param openid 微信id
	 * @return */
	public WxUser selectByUserId(String userId) {
		return mapper.selectByUserId(userId);
	}
	/** 根据departId查询机构下已绑定人员
	 * @param openid 微信id
	 * @return */
	public List<WxUser>    selectByDepartId(String  departId) {
		return mapper.selectByDepartId(departId);
	}
	
	/**
	 * 根据用户名称查询用户是否已存在
	 * @param userName
	 * @return
	 */
	public WxUser    getUserByUserName(String  userName) {
		return mapper.getUserByUserName(userName);
	}
	
	public	WxUser selectByPrimaryKey(Integer id){
		return mapper.selectByPrimaryKey(id);
	}

    /**
	 * 校验用户名密码
	 * @param userName
	 * @param password
	 * @return
	 */
	public WxUser	selectByUserAndPwd(String userName,String password	){
		return mapper.selectByUserAndPwd(userName, password);
	}

    /**
	 * 根据机构code查询可绑定的平台账号
	 * @param departCode
	 * @return 
	 * @return
	 */
	public List<WxUser> selectByDepartCode(String departCode){
		
		return mapper.selectByDepartCode(departCode);
	}

    /**
	 *查询已经存在的所有人员
	 * @return
	 */
	public List<WxUser> selectAllUser() {
		return mapper.selectAllUser();
	}
}
