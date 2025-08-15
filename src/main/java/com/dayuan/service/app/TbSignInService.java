package com.dayuan.service.app;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.dayuan.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.app.TbSignIn;
import com.dayuan.bean.app.TbSignLast;
import com.dayuan.bean.system.TSUser;
import com.dayuan.mapper.app.TbSignInMapper;
import com.dayuan.mapper.app.TbSignLastMapper;
import com.dayuan.model.app.TbSignInModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;

/**
 * 人员签到
 * @author Bill
 */
@Service
public class TbSignInService extends BaseService<TbSignIn, String> {
	
	@Autowired
	private TbSignInMapper mapper;
	
	@Autowired
	private TbSignLastMapper lastMapper;
	
	public TbSignInMapper getMapper() {
		return mapper;
	}
	
	private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	public List<TbSignInModel> queryByDepartIds(String[] departArr, Date signDate,String realname) {
		String sd = DateUtil.date_sdf.format(signDate);
		List<TbSignInModel> signs = mapper.queryByDepartIds(departArr,sd,realname);
		return signs;
	}
	
	/**
	 * 通过机构ID查询最近半年有签到记录的日期
	 * @author Dz
	 * @param departId
	 * @param userId 
	 * @return
	 */
	public List<String> querySignDate(int departId, String userId) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, -6);
		List<String> signs = mapper.querySignDate(departId, sdf.format(c.getTime()),userId);
		return signs;
	}
	
	/**
	 * 获取签到人某天签到记录
	 * @author Dz
	 * @param userId	//签到人ID
	 * @param date	//签到日期
	 * @return
	 */
	public List<TbSignInModel> queryByUserId(String userId, Date date) {
		String dateStr =date!=null ? sdf.format(date) : null;
		List<TbSignInModel> signs = mapper.queryByUserId(userId, dateStr);
		return signs;
	}
	/**
	 * 根据用户ID查询用户最后一次定位信息
	 * @description
	 * @param userId
	 * @return
	 * @author xiaoyl
	 * @date   2020年5月12日
	 */
	public TbSignInModel queryLastSignByUserId(String userId) {
		return mapper.queryLastSignByUserId(userId);
	}
	/**
	 * 写入签到记录的同时并更新用户最后一次签到表的信息
	 * @description
	 * @param bean
	 * @return
	 * @author xiaoyl
	 * @date   2020年5月14日
	 */
	public TbSignIn saveSignData(TbSignIn bean,TSUser user) {
		//1.写入签到记录
		mapper.insert(bean);
		//2.更新用户最后签到记录表的信息
		TbSignLast signLast=lastMapper.queryByUserId(bean.getCreateBy());
		if(signLast==null) {//第一次签到，插入新的数据
			signLast=new TbSignLast(user.getId(),user.getRealname(), bean.getSignType(), bean.getLongitude(), bean.getLatitude(), bean.getAddress(), bean.getCreateDate(), null, null, null);
			lastMapper.insert(signLast);
		}else {//非第一次签到，直接更新签到信息
			if(StringUtil.isNotEmpty(bean.getLongitude()) && StringUtil.isNotEmpty(bean.getLatitude())){
				signLast.setSignType(bean.getSignType());
				signLast.setLongitude( bean.getLongitude());
				signLast.setLatitude(bean.getLatitude());
				signLast.setSignAddress(bean.getAddress());
				signLast.setSignDate(bean.getCreateDate());
				lastMapper.updateByPrimaryKeySelective(signLast);
			}
		}
		return bean;
	}
	/**
	 *	 根据机构ID、用户名称查询用户最后一次签到信息
	 * @description
	 * @param departIds
	 * @param realname
	 * @return
	 * @author xiaoyl
	 * @date   2020年5月18日
	 */
	public List<TbSignInModel> querySignByDepartIds(String[] departIds, String realname) {
		return mapper.querySignByDepartIds(departIds,realname);
	}
	/**
	 * 写入签到记录的同时并更新用户最后一次签到表的信息
	 * @description
	 * @param bean
	 * @return
	 * @author xiaoyl
	 * @date   2020年5月14日
	 */
	public TbSignIn saveSignDataForWEB(TbSignIn bean,TSUser user,String realName) {
		//1.写入签到记录
		mapper.insert(bean);
		//2.更新用户最后签到记录表的信息
		TbSignLast signLast=lastMapper.queryByUserId(bean.getCreateBy());
		if(StringUtil.isEmpty(realName)){
			realName=user.getRealname();
		}
		if(signLast==null) {//第一次签到，插入新的数据
			signLast=new TbSignLast(bean.getCreateBy(),realName, bean.getSignType(), bean.getLongitude(), bean.getLatitude(), bean.getAddress(), bean.getCreateDate(), null, null, null);
			lastMapper.insert(signLast);
		}else {//非第一次签到，直接更新签到信息
			if(StringUtil.isNotEmpty(bean.getLongitude()) && StringUtil.isNotEmpty(bean.getLatitude())){
				signLast.setSignType(bean.getSignType());
				signLast.setLongitude( bean.getLongitude());
				signLast.setLatitude(bean.getLatitude());
				signLast.setSignAddress(bean.getAddress());
				signLast.setSignDate(bean.getCreateDate());
				lastMapper.updateByPrimaryKeySelective(signLast);
			}
		}
		return bean;
	}
}
