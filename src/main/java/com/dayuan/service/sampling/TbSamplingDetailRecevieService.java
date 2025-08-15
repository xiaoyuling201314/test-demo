package com.dayuan.service.sampling;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dayuan.bean.data.BaseDevicesItem;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.sampling.TbSamplingDetailRecevie;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.sampling.TbSamplingDetailRecevieMapper;
import com.dayuan.service.BaseService;
import com.dayuan.service.data.BaseDevicesItemService;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月12日
 */
@Service
public class TbSamplingDetailRecevieService extends BaseService<TbSamplingDetailRecevie, Integer> {
	
	@Autowired
	private TbSamplingDetailRecevieMapper mapper;
	@Autowired
	private TbSamplingService tbSamplingService;
	@Autowired
	private TbSamplingDetailService tbSamplingDetailService;
	@Autowired
	private BaseDevicesItemService baseDevicesItemService;

	public TbSamplingDetailRecevieMapper getMapper() {
		return mapper;
	}

	/**
	 * 根据抽样明细ID删除检测任务临时表数据
	 * @param sdId 抽样明细ID
	 */
	public void deleteBySdId(Integer sdId) throws Exception{
		mapper.deleteBySdId(sdId);
	}
	
	/**
	 * 根据仪器唯一标识删除检测任务临时表数据
	 * @param serialNumber 仪器唯一标识
	 */
	public void deleteBySerialNumber(String serialNumber) throws Exception{
		mapper.deleteBySerialNumber(serialNumber);
	}

	/**
	 * 更新检测任务状态
	 * @param recevie
	 */
	public void updateByRejectStatus(TbSamplingDetailRecevie recevie) throws Exception{
		mapper.updateByRejectStatus(recevie);
	}

	/**
	 * 根据抽样明细ID获取下一条仪器任务
	 * @param sdId 抽样明细ID
	 */
	public TbSamplingDetailRecevie queryNextDeviceBySdid(Integer sdId) throws Exception{
		return mapper.queryNextDeviceBySdid(sdId);
	}

	/**
	 * 根据抽样明细ID重置所有仪器的接收状态
	 * @param sdId 抽样明细ID
	 */
	public void updateResetRecevieStatusBySdId(Integer sdId) throws Exception{
		mapper.updateResetRecevieStatusBySdId(sdId);
	}
	
	/**
	 * 根据抽样明细ID，获取已分配检测任务
	 * @param sdId 抽样明细ID
	 * @return
	 */
	public List<TbSamplingDetailRecevie> queryBySdId(Integer sdId){
		return mapper.queryBySdId(sdId);
	}
	
	/**
	 * 接收检测任务
	 * @param detailId	抽样明细ID
	 * @param serialNumber	仪器唯一标识
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void receivingTask(Integer detailId, String serialNumber) throws Exception {
		
		TbSamplingDetail samplingDetail = tbSamplingDetailService.getById(detailId);
		
//		samplingDetail.setStatus((short) 1);
		samplingDetail.setRecevieDevice(serialNumber);//仪器唯一标识

		tbSamplingDetailService.updateById(samplingDetail);
		
		//删除临时表中关于该明细的分配记录
		this.deleteBySdId(detailId);
		
	}
	
	/**
	 * 接收/拒绝检测任务
	 * 所有仪器拒收后不开始新一轮下发
	 * @param user	登录用户
	 * @param detailId	抽样明细ID
	 * @param serialNumber	仪器唯一标识
	 * @param recevieStatus	状态（1：接收；2：拒绝）
	 * @param resend		拒绝任务后重新下发（true：是；false：否）
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void updateStatus(TSUser user, Integer detailId, String serialNumber, Short recevieStatus, boolean resend) throws Exception {
		TbSamplingDetail samplingDetail = tbSamplingDetailService.getById(detailId);
		if (samplingDetail == null || (StringUtils.isNotBlank(samplingDetail.getRecevieDevice()) && !samplingDetail.getRecevieDevice().equals(serialNumber)) ) {
			throw new MyException("权限不足！", "权限不足！", WebConstant.INTERFACE_CODE14);
		}
		TbSampling sampling = tbSamplingService.getById(samplingDetail.getSamplingId());
		
		samplingDetail.setRecevieDevice(serialNumber);//仪器唯一标识

		if(recevieStatus==1){//仪器接收任务
//			samplingDetail.setStatus((short) 1);
			
			//更新抽样明细
			tbSamplingDetailService.updateById(samplingDetail);
			
			//删除临时表中关于该明细的分配记录
			this.deleteBySdId(detailId);
			
		}else if(recevieStatus==2){//仪器拒绝了任务
//			samplingDetail.setStatus((short) 0);

			List<BaseDevicesItem> rels = baseDevicesItemService.queryDeviceByDetectName(sampling.getPointId(), samplingDetail.getItemId());	//根据检测项目和检测点查询所有可分配的仪器
			List<TbSamplingDetailRecevie> sdrs = this.queryBySdId(samplingDetail.getId());	//根据抽样明细ID，获取已分配检测任务
			
			//判断是否有仪器加入/退出任务队列
			if(sdrs.size()==0) {

				//所有可分配仪器加入任务队列
				for (int i = 0; i < rels.size(); i++) {
					BaseDevicesItem bdi = rels.get(i);

					TbSamplingDetailRecevie recevie = new TbSamplingDetailRecevie();
					recevie.setSdId(samplingDetail.getId());
					recevie.setRecevieSerialNumber(bdi.getSerialNumber());
					recevie.setPriority((short) (rels.size()-i));
					PublicUtil.setCommonForTable(recevie, true, user);
					this.insert(recevie);

					sdrs.add(recevie);
				}
				
			}else {
				//判断检测点是否删减了仪器;有,则删除仪器检测任务
				Iterator ite1 = sdrs.iterator();
				while (ite1.hasNext()) {//遍历已分配检测任务
					TbSamplingDetailRecevie sdr = (TbSamplingDetailRecevie) ite1.next();

					if (rels.size() == 0) {
						//所有可分配仪器被删除了，删除已分配任务
						ite1.remove();
						this.delete(sdr.getId());

					} else {
						for (int i = 0; i < rels.size(); i++) {	//可分配仪器
							if(sdr.getRecevieSerialNumber().equals(rels.get(i).getSerialNumber())){	//已分配检测任务中存在检测仪器，不用删除检测任务
								break;
							}
							if(i == rels.size()-1){	//仪器不存在，删除检测任务
								ite1.remove();
								this.delete(sdr.getId());
							}
						}
					}
				}
				
				//判断检测点是否新增了仪器;有,则新增仪器检测任务
				Iterator ite2 = rels.iterator();
				int priority = rels.size();
				while (ite2.hasNext()) {//遍历可分配仪器
					BaseDevicesItem bdi = (BaseDevicesItem) ite2.next();
					
					for (int i = 0; i < sdrs.size(); i++) {	//遍历已分配检测任务
						if(bdi.getSerialNumber().equals(sdrs.get(i).getRecevieSerialNumber())){	//已分配检测任务中存在检测仪器，不用新增检测任务
							//更新优先级别
							TbSamplingDetailRecevie recevie = sdrs.get(i);
							recevie.setPriority((short) priority);
							PublicUtil.setCommonForTable(recevie, false, user);
							updateBySelective(recevie);
							break;
						}
						if(i == sdrs.size()-1){	//仪器不存在，新增检测任务
							TbSamplingDetailRecevie recevie = new TbSamplingDetailRecevie();
							recevie.setSdId(samplingDetail.getId());
							recevie.setRecevieSerialNumber(bdi.getSerialNumber());
							recevie.setPriority((short) priority);
							PublicUtil.setCommonForTable(recevie, true, user);
							insert(recevie);
							
							sdrs.add(recevie);
						}
					}
					priority--;
				}
			}

			int notReceivedNum = 0; //未接收仪器数量
			for(TbSamplingDetailRecevie sdr1 :sdrs){
				//设置当前待接收仪器的任务状态为拒绝
				if(sdr1.getRecevieSerialNumber().equals(samplingDetail.getRecevieDevice())){
					sdr1.setRecevieStatus((short) 2);
					PublicUtil.setCommonForTable(sdr1, false, user);
					this.updateByRejectStatus(sdr1);
				}
				//计算未接收仪器数量
				if(sdr1.getRecevieStatus() == 0){
					notReceivedNum++;
				}
			}
			
			//重发检测任务
			if(resend) {
				if(sdrs.size() == 0){//无仪器可接收任务
					//清空接收仪器唯一编码
					samplingDetail.setRecevieDevice(null);
					tbSamplingDetailService.updateById(samplingDetail);
					
				}else{//重发到下一台仪器
					//判断是否所有仪器拒绝任务，是则开始新一轮下发检测任务，否则重发到下一台仪器
					if(notReceivedNum == 0){
						
						//所有仪器拒绝任务，重置所有仪器任务状态为未接收
						this.updateResetRecevieStatusBySdId(samplingDetail.getId());
						
						//获取下一条仪器任务
						TbSamplingDetailRecevie tsdr = this.queryNextDeviceBySdid(samplingDetail.getId());
						
						//继续下发到仪器的唯一标识与拒收任务仪器的唯一标识相同，不再下发任务
						if(tsdr.getRecevieSerialNumber().equals(serialNumber)) {
							samplingDetail.setRecevieDevice(null);
						}else {
							samplingDetail.setRecevieDevice(tsdr.getRecevieSerialNumber());
						}
						//更新任务明细接收仪器唯一编码
						PublicUtil.setCommonForTable(samplingDetail, false, user);
						tbSamplingDetailService.updateById(samplingDetail);
						
					}else {
						//获取下一台仪器
						TbSamplingDetailRecevie tsdr = this.queryNextDeviceBySdid(samplingDetail.getId());
						//更新任务明细接收仪器唯一编码
						samplingDetail.setRecevieDevice(tsdr.getRecevieSerialNumber());
						PublicUtil.setCommonForTable(samplingDetail, false, user);
						tbSamplingDetailService.updateById(samplingDetail);
					}
				}
			}
			
			//更新抽样明细
			tbSamplingDetailService.updateById(samplingDetail);
			
		}else{
			throw new Exception("检测任务状态："+recevieStatus+"未定义");
		}
	}

	
}
