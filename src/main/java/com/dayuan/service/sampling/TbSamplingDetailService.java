package com.dayuan.service.sampling;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.BaseModel;
import com.dayuan.model.sampling.TbSamplingDetailReport;
import com.dayuan3.common.bean.TbSamplingRequester;

import java.util.List;
import java.util.Map;

/**
 * @author Dz
 * @description 针对表【tb_sampling_detail(抽检单明细表)】的数据库操作Service
 * @createDate 2025-06-12 13:00:03
 */
public interface TbSamplingDetailService extends IService<TbSamplingDetail> {

    /**
     * 根据订单ID查询订单明细
     *
     * @param samplingId 订单ID
     * @return
     */
    List<TbSamplingDetailReport> queryBySamplingId(Integer samplingId);

    /**
     * 根据订单明细ID查询订单明细
     *
     * @param samplingDetailId 订单明细ID
     * @return
     */
    public TbSamplingDetailReport queryBySamplingDetailId(Integer samplingDetailId);

    /**
     * 根据抽样单ID查询，合并检测项目
     *
     * @param id
     * @return
     */
    public List<TbSamplingDetail> queryBySamplingIdUnionItems(Integer id);

    /**
     * 根据抽样单ID查看抽样详情，用于app扫码查看
     *
     * @param samplingId
     * @return
     */
    public List<TbSamplingDetailReport> queryBySamplingIdForApp(Integer samplingId);

    /**
     * 查询 未分配 或 已分配未接收检测任务 的抽样明细信息
     * @param id 抽样单ID
     * @return
     */
    public List<TbSamplingDetail> queryTaskBySamplingId(Integer id);
    
    /**
	 * 查询仪器未检测的抽样明细
	 * @param serialNumber	仪器唯一标识
	 * @return
	 */
    public List<TbSamplingDetail> queryUncheckSamplingDetail(String serialNumber);
    
    /**
	 * 清空抽样明细（未检测）的仪器唯一标识
	 * @param serialNumber	仪器唯一标识
	 */
    public void cleanSerialNumber(String serialNumber);

    /**
     * 重置检测任务接收状态
     * @param detailId 抽样明细ID
     * @return
     */
    public void resetStatus(Integer detailId) throws Exception;


    /**
     * 去查询其抽样单明细 暂时没调用该方法
     *
     * @param rId 检测数据ID
     * @return
     */
    public Map<String, Object> selectDetailByRid(Integer rId) throws Exception;

    /**
     * 根据抽样单明显信息去查询溯源表中数据 暂时没调用该方法
     *
     * @param regId      市场ID
     * @param opeId      经营户ID
     * @param foodName   食品名称
     * @param batchNumber 批次
     * @return
     */
    public BaseLedgerStock selectSource(Integer regId, Integer opeId, String foodName, String batchNumber)throws Exception;

	    /**
		 * 根据抽样单id(订单) 查询订单明细 huht
		 * @param samplingId
		 * @return
		 */
	 public List<TbSamplingDetail>	queryBySamplingId2(Integer samplingId,Integer queryReCheck)throws Exception;


    /**
     * 根据样品码获取样品信息
     * @param barCode 样品码
     * @return
     */
    public List<TbSamplingDetail> queryByBarCode(String barCode);

    /**
     * 根据送样码获取样品信息
     * @param samplingId 订单ID
     * @param collectCode 送样码
     * @return
     */
    public List<TbSamplingDetail> queryByCollectCode(Integer samplingId, String collectCode);

    /**
     * 查询分页数据列表(订单)
     * @param page
     * @return
     */
    public List<TbSamplingDetail> loadDatagridOrderDetails(Page page);
	public Page loadDatagridOrderDetails2(Page page, BaseModel t) throws Exception;


    /**
     * 查询记录总数量(订单)
     * @param page
     * @return
     */
    public int getRowTotalOrderDetails(Page page);

    /**
     * 自助终端查看订单明细
     * @description
     * @param samplingId
     * @param reportNumber
     * @param collectCode 收样批次
     * @return
     * @author xiaoyl
     * @date   2019年8月13日
     */
	public List<TbSamplingDetailReport> queryOrderDetailBySamplingId(Integer samplingId,Integer reportNumber,String collectCode);

	/**
	 * 查看已打印报告码列表，用于重打模块使用
	 * @description
	 * @param samplingId
	 * @param collectCode 送检批次码
	 * @return
	 * @author xiaoyl
	 * @param collectCode 
	 * @date   2019年8月15日
	 */
	public List<Map<String, Object>> queryReportNumberBySamplingId(Integer samplingId, String collectCode);

	/**
	 * 报告首次打印：批量写入打印报告码
	 * @description
	 * @param reportNumber 报告码
	 * @param samplingDetailIds
	 * @return
	 * @author xiaoyl
	 * @date   2019年8月15日
	 */
	public int updateReportNumberByDetailIds(Integer reportNumber, int[] samplingDetailIds);

	/**
	 * 根据订单明细ID更新报告打印次数
	 * @description
	 * @param samplingDetailIds 抽样单ID列表
	 * @return
	 * @author xiaoyl
	 * @date   2019年8月15日
	 */
	public int updateByDetailIds( int[]  samplingDetailIds);

//    /**
//     * 收样批量更新样品码
//     * @param sampling 订单
//     * @param samplingDetails 样品
//     * @param requesters 委托单位
//     * @return  收样时间
//     * @throws Exception
//     */
//    public Map bulkUpdateCode(TbSampling sampling, List<TbSamplingDetail> samplingDetails, List<TbSamplingRequester> requesters) throws Exception;

    /**
     * 查询送检批次和每次送样数量
     * @description
     * @param samplingId
     * @param collectCode 送检批次码
     * @return
     * @author xiaoyl
     * @param collectCode 
     * @date   2019年8月23日
     */
	public List<Map<String, Object>> queryCollectCodeBySamplingId(Integer samplingId, String collectCode);

	/**
	 * 
	 * @description 根据抽样单ID查询样品数量
	 * @param samplindId 订单ID
	 * @return
	 * @author xiaoyl
	 * @date   2020年2月24日
	 */
	public int queryFoodCountBySamplingId(Integer samplindId);

    /**
    * @Description 四季美项目：根据抽样单ID查询抽样明细已经检测结论
    * @Date 2021/06/18 15:41
    * @Author xiaoyl
    * @Param
    * @return
    */
    public List<TbSamplingDetailReport> queryBySamplingIdForSelfPrint(Integer samplindId);

    /**
     * 收样批量更新样品码
     * @param sampling 订单
     * @param samplingDetails 样品
     * @param requesters 委托单位
     * @return  收样时间
     * @throws Exception
     */
    public Map bulkUpdateCode(TbSampling sampling, List<TbSamplingDetail> samplingDetails, List<TbSamplingRequester> requesters) throws Exception;


	int updatePrintNum(Integer samplId, Integer sampleDetailId);



	/******************************************** 快检新模式 20250625 *************************************/
	/**
	 * Description 订单分拣打印，更新样品码到样品明细条码记录表：tb_sampling_detail_code，用于后续前处理操作
	 * @Author xiaoyl
	 * @Date 2025/6/21 9:28
	 */
	int bulkSampleCode(Integer samplId, Integer sampleDetailId,String sampleCode) throws Exception;

	/**
	 * 复检（单项复检，供复检支付接口调用）
	 * 弃用，改为默认整张订单所有不合格项目复检 20250626
	 *
	 * @param detailId 复检订单明细ID
	 * @param recheckFee 复检费用（单位：分）
	 * @return 返回值：1_成功,0_失败,-1_复检样品不存在,-2_订单异常
	 */
	int recheck(int detailId, int recheckFee);

	List<TbSamplingDetail> queryUnqualifiedFoodNum(Integer orderId);

	int bulkRecheckSampleCode(List<TbSamplingDetail> detail) throws MissSessionExceprtion;
}
