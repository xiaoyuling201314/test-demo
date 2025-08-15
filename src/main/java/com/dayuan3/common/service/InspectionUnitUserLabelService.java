package com.dayuan3.common.service;

import com.dayuan.bean.AjaxJson;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.InspectionUnitUserLabel;
import com.dayuan3.common.bean.InspectionUnitUserRequester;
import com.dayuan3.common.mapper.InspectionUnitUserLabelMapper;
import com.dayuan3.common.mapper.InspectionUnitUserRequesterMapper;
import com.dayuan3.common.util.PingYinUtil;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.service.RequesterUnitService;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class InspectionUnitUserLabelService extends BaseService<InspectionUnitUserLabel, Integer>{
	@Autowired
	private InspectionUnitUserLabelMapper mapper;
	@Autowired
	private InspectionUnitUserRequesterMapper requesterMapper;
	@Autowired
	private InspectionUnitUserRequesterService inspectionUnitUserRequesterService;
	@Autowired
	private RequesterUnitService requesterUnitService;

	@Override
	public BaseMapper<InspectionUnitUserLabel, Integer> getMapper() {
		return mapper;
	}
	
	/**
	 * 根据标签查询委托单位
	 * @param userId
	 * @return
	 */
	public List<InspectionUnitUserLabel> selectByUserId(Integer userId, Integer rowStart, Integer rowEnd) {
		return mapper.selectByUserId(userId, rowStart, rowEnd);
	};
	
	/**
	 * 设置默认标签
	 * @param userId
	 * @param id
	 */
	public   void updateSetDefault( Integer userId, Integer id) {
		if(userId!=null||id!=null){
			mapper.updateSetDefault(userId, id);
		}
	};
	/**
	 * 获取标签的默认状态
	 * @param userId
	 * @param id
	 */
	public   void updateQxDefault( Integer userId, Integer id) {
		if(userId!=null||id!=null){
			mapper.updateQxDefault(userId, id);
		}
	};
	
	/**
	 * 保存标签
	 * @param bean
	 * @param list
	 */
	@Transactional
	public AjaxJson save(InspectionUnitUserLabel bean, List<InspectionUnitUserRequester> list,Integer[] ids) {
		AjaxJson jsonObject = new AjaxJson();
		InspectionUnitUserLabel label=mapper.selectByPrimaryKey(bean.getId());
		Date  now=new Date();
		if(label==null){//新增
			InspectionUnitUserLabel label0 = mapper.selectLabelName(bean.getUserId(), bean.getLabelName());
			if(label0 !=null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("分组名称已存在!");
				return jsonObject;
			}
			try {
				bean.setLabelFirstLetter(PingYinUtil.getFirstLetter(bean.getLabelName()));
				bean.setLabelFullLetter(PingYinUtil.getFullLetter(bean.getLabelName()));
			} catch (BadHanyuPinyinOutputFormatCombination e) {
				 
				e.printStackTrace();
			}
			bean.setCreateDate(now);
			bean.setUpdateDate(now);
			mapper.insertSelective(bean);
			if(bean.getIsdefault()==1){
				mapper.updateSetDefault(bean.getUserId(), bean.getId());//设为默认则将别的修改掉
			}
			for (InspectionUnitUserRequester requester : list) {
				requester.setLabelId(bean.getId());//标签id
				requester.setCreateDate(now);
				requester.setUpdateDate(now);
				requesterMapper.insertSelective(requester);
			}
			jsonObject.setMsg("保存成功");
		}else{//编辑
			InspectionUnitUserLabel label0 = mapper.selectLabelName(bean.getUserId(), bean.getLabelName());
			if(label0 !=null&&!label.getId().equals(label0.getId())){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("分组名称已存在!");
				return jsonObject;
			}

			bean.setUpdateDate(now);
			mapper.updateByPrimaryKeySelective(bean);
			if(ids!=null&&ids.length!=0){//删除
				requesterMapper.deleteByPrimaryKey(ids);
			}
			if(bean.getIsdefault()==1){//设为默认则将别的修改掉
				mapper.updateSetDefault(bean.getUserId(), bean.getId());
			}
			for (InspectionUnitUserRequester requester : list) {
				List<InspectionUnitUserRequester> num= requesterMapper.selectByLabelIdAndresId(bean.getId(), requester.getRequestId());
				if(num.size()==0){//不存在
					requester.setLabelId(bean.getId());//标签id
					requester.setCreateDate(now);
					requester.setUpdateDate(now);
					requesterMapper.insertSelective(requester);
				}
			}
			jsonObject.setMsg("保存成功");
		}
		return jsonObject;
		
	}
	/**
	 * 根据送检用户或最后更新时间查询委托单位标签信息
	 * @description
	 * @param userId
	 * @param date
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月8日
	 */
	public List<InspectionUnitUserLabel> queryAllByLastUpdateTime(Integer userId,String date) {
		return mapper.queryAllByLastUpdateTime(userId,date);
	};

	/**
	 * 根据送检用户和标签名称查询
	 * @param userId
	 * @param labelName
	 * @return
	 */
	public InspectionUnitUserLabel selectLabelName(Integer userId, String labelName) {
		return mapper.selectLabelName(userId, labelName);
	};

	/**
	 * 查询该人员全部委托单位个数
	 * @param inspId
	 * @param userId
	 * @author shit
	 * @return
	 */
	public int selectAllCountLabel(Integer inspId, Integer userId) {
		return mapper.selectAllCountLabel(inspId,userId);
	}


	/**
	 * 查询该人员全部委托单位
	 * @param inspId
	 * @param userId
	 * @author shit
	 * @return
	 */
	public List<InspectionUnitUserRequester> selectAllLabelList(Integer inspId, Integer userId) {
		return mapper.selectAllLabelList(inspId,userId);
	}

	/**
	 * 求得当前用户分组的总数量
	 * @param userId
	 * @author shit
	 * @return
	 */
	public Integer selectLabelNum(Integer userId) {
		return mapper.selectLabelNum(userId);
	}


	/**
	 * 保存分组
	 * @param bean 分组
	 * @param list 分组委托单位
	 * @param user 更新人
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public void saveOrUpdate (InspectionUnitUserLabel bean, List<InspectionUnitUserRequester> list, InspectionUnitUser user) throws Exception {
//		Map<String, Object> map = new HashMap<String, Object>(3);

		InspectionUnitUserLabel label0 = null;
		//查询原数据
		if (null != bean.getId()) {
			label0 = queryById(bean.getId());
			if (null == label0) {
				throw new Exception("数据不存在");
			} else if (label0.getUserId().equals(user.getId())) {
				throw new Exception("权限不足");
			}
		}

		//校验分组名称是否存在
		label0 = selectLabelName(user.getId(), bean.getLabelName());
		if(label0 != null && !label0.getId().equals(bean.getId())){
//			map.put("success", false);
//			map.put("msg", "分组名称已存在");
//			return map;

			throw new Exception("分组名称已存在");
		}

		//分组名称字母
		bean.setLabelFirstLetter(PingYinUtil.getFirstLetter(bean.getLabelName()));
		bean.setLabelFullLetter(PingYinUtil.getFullLetter(bean.getLabelName()));
		bean.setDeleteFlag((short) 0);
		bean.setUserId(user.getId());

		//新增
		if (null == bean.getId()) {
			PublicUtil.setCommonForTable1(bean, true, user);
			insertSelective(bean);

			//新增分组委托单位
			Iterator<InspectionUnitUserRequester> it2 = list.iterator();
			while (it2.hasNext()) {
				InspectionUnitUserRequester r2 = it2.next();
				RequesterUnit ru2 = requesterUnitService.queryById(r2.getRequestId());
				r2.setLabelId(bean.getId());
				r2.setRequestName(ru2.getRequesterName());
				r2.setParam1(ru2.getCompanyAddress());
				r2.setDeleteFlag((short) 0);
				PublicUtil.setCommonForTable1(r2, true, user);
				inspectionUnitUserRequesterService.insertSelective(r2);
			}

		//编辑
		} else {
			PublicUtil.setCommonForTable1(bean, false, user);
			updateBySelective(bean);

			//原分组委托单位
			List<InspectionUnitUserRequester> list0 = inspectionUnitUserRequesterService.selectByLabelId(bean.getId());
			Iterator<InspectionUnitUserRequester> it0 = list0.iterator();

			while (it0.hasNext()) {
				InspectionUnitUserRequester r0 = it0.next();

				//新分组委托单位
				Iterator<InspectionUnitUserRequester> it = list.iterator();

				//是否更新委托单位
				boolean isUpdate = false;
				while (it.hasNext()) {
					InspectionUnitUserRequester r = it.next();
					if (r0.getRequestId().equals(r.getRequestId())) {
						//更新委托单位
						RequesterUnit ru0 = requesterUnitService.queryById(r.getRequestId());
						r0.setRequestName(ru0.getRequesterName());
						r0.setParam1(ru0.getCompanyAddress());
						r0.setDeleteFlag((short) 0);
						PublicUtil.setCommonForTable1(r0, false, user);
						inspectionUnitUserRequesterService.updateBySelective(r0);

						isUpdate = true;

						//清除数组中无需更换分组委托单位
						it.remove();
						break;
					}
				}

				//删除旧委托单位
				if (!isUpdate) {
					r0.setDeleteFlag((short) 1);
					PublicUtil.setCommonForTable1(r0, false, user);
					inspectionUnitUserRequesterService.updateBySelective(r0);
				}
			}

			//新增标签委托单位
			Iterator<InspectionUnitUserRequester> it1 = list.iterator();
			while (it1.hasNext()) {
				InspectionUnitUserRequester r1 = it1.next();
				RequesterUnit ru1 = requesterUnitService.queryById(r1.getRequestId());
				r1.setLabelId(bean.getId());
				r1.setRequestName(ru1.getRequesterName());
				r1.setParam1(ru1.getCompanyAddress());
				r1.setDeleteFlag((short) 0);
				PublicUtil.setCommonForTable1(r1, true, user);
				inspectionUnitUserRequesterService.insertSelective(r1);
			}
		}

		//设为默认，其他改为非默认
		if(bean.getIsdefault()==1){
			updateSetDefault(bean.getUserId(), bean.getId());
		}

//		map.put("success", true);
//		map.put("msg", "保存成功");
//		return map;
	}

}
