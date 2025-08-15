package com.dayuan.mapper.sampling;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.model.BaseModel;
import com.dayuan.model.sampling.TbSamplingDetailReport;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
/**
 * Description:
 * @author Dz
 * @description 针对表【tb_sampling_detail(抽检单明细表)】的数据库操作Mapper
 * @createDate 2025-06-12 13:00:03
 */
public interface TbSamplingDetailMapper extends BaseMapper<TbSamplingDetail> {

	/**
	 * 根据订单ID查询订单明细
	 * @param samplingId
	 * @return
	 * @author xyl 2017-09-13
	 */
	List<TbSamplingDetailReport> queryBySamplingId(@Param("samplingId")Integer samplingId,@Param("checkNumber") Integer checkNumber);

	/**
	 * 根据订单明细ID查询订单明细
	 * @param samplingDetailId
	 * @return
	 */
	TbSamplingDetailReport queryBySamplingDetailId(@Param("samplingDetailId")Integer samplingDetailId,@Param("checkNumber") Integer checkNumber);

	List<TbSamplingDetail> queryBySamplingIdUnionItems(Integer id);
	/**
	 * 根据抽样单ID查看抽样详情，用于app扫码查看
	 * @param samplingId
	 * @return
	 */
	List<TbSamplingDetailReport> queryBySamplingIdForApp(@Param("samplingId")Integer samplingId,@Param("checkNumber") Integer checkNumber);

	/**
	 * 查询 未分配 或 已分配未接收检测任务 的抽样明细信息
	 * @param id 抽样单ID
	 * @return
	 */
	List<TbSamplingDetail> queryTaskBySamplingId(Integer id);
	
	/**
	 * 查询仪器未检测的抽样明细
	 * @param serialNumber	仪器唯一标识
	 * @return
	 */
	List<TbSamplingDetail> queryUncheckSamplingDetail(String serialNumber);
	
    /**
	 * 清空抽样明细（未检测）的仪器唯一标识
	 * @param serialNumber 仪器唯一标识
	 */
	void cleanSerialNumber(String serialNumber);

	/**
	 * 重置检测任务接收状态
	 * @param id
	 */
	void resetStatus(Integer id);

	/**
	 * 去查询其抽样单明细 暂时没调用该方法
	 *
	 * @param rId 检测数据ID
	 * @return
	 */
    Map<String,Object> selectDetailByRid(Integer rId);

	/**
	 * 根据抽样单明显信息去查询溯源表中数据 暂时没调用该方法
	 *
	 * @param regId      市场ID
	 * @param opeId      经营户ID
	 * @param foodName   食品名称
	 * @param batchNumber 批次
	 * @return
	 */
	BaseLedgerStock selectSource(@Param("regId") Integer regId, @Param("opeId") Integer opeId, @Param("foodName") String foodName, @Param("batchNumber") String batchNumber);

	
	/**
	 * 根据抽样单id(订单) 查询订单明细
	 * @param samplingId
	 * @return
	 */
	List<TbSamplingDetail> queryBySamplingId2(@Param("samplingId")Integer samplingId, @Param("checkNumber") Integer checkNumber,@Param("queryReCheck")Integer queryReCheck);
	
	

	/**
	 * 根据样品码获取样品信息
	 * @param barCode 样品码
	 * @return
	 */
    List<TbSamplingDetail> queryByBarCode(String barCode);


	/**
	 * 根据送样码获取样品信息
	 * @param samplingId 订单ID
	 * @param collectCode 送样码
	 * @return
	 */
    List<TbSamplingDetail> queryByCollectCode(@Param("samplingId")Integer samplingId, @Param("collectCode")String collectCode,@Param("checkNumber") Integer checkNumber);

    List<TbSamplingDetail> loadDatagridOrderDetails(Page page);

	List<TbSamplingDetail> loadDatagridOrderDetails2(Page page);

	int getRowTotalOrderDetails(Page page);

	List<TbSamplingDetailReport> queryOrderDetailBySamplingId(@Param("samplingId")Integer samplingId,
			@Param("reportNumber")Integer reportNumber,@Param("collectCode")String collectCode,@Param("checkNumber") Integer checkNumber);
	/**
	 * 根据订单号查询所有取报告码
	 * @description
	 * @param samplingId
	 * @param collectCode 收样批次码
	 * @return
	 * @author xiaoyl
	 * @param collectCode 
	 * @date   2019年8月15日
	 */
	List<Map<String, Object>> queryReportNumberBySamplingId(@Param("samplingId")Integer samplingId, @Param("collectCode")String collectCode);
	/**
	 * 报告首次打印：批量写入打印报告码
	 * @description
	 * @param reportNumber 报告码
	 * @param samplingDetailIds
	 * @return
	 * @author xiaoyl
	 * @date   2019年8月15日
	 */
	int updateReportNumberByDetailIds(@Param("reportNumber")Integer reportNumber, @Param("samplingDetailIds") int[]  samplingDetailIds);
	
	/**
	 * 根据订单明细ID更新报告打印次数
	 * @description
	 * @param samplingDetailIds 抽样单ID列表
	 * @return
	 * @author xiaoyl
	 * @date   2019年8月15日
	 */
	int updateByDetailIds(@Param("samplingDetailIds") int[]  samplingDetailIds);

	void bulkUpdateCode(@Param("samplingDetails")List<TbSamplingDetail> samplingDetails);

	List<Map<String, Object>> queryCollectCodeBySamplingId(@Param("samplingId")Integer samplingId, @Param("collectCode")String collectCode);
	/**
	 * 根据抽样单ID查询样品数量，样品名称相同视为同一个样品
	 * @description
	 * @param samplindId
	 * @return
	 * @author xiaoyl
	 * @date   2020年2月24日
	 */
	int queryFoodCountBySamplingId(@Param("samplingId")Integer samplindId);
	/**
	 * @Description 四季美项目：根据抽样单ID查询抽样明细已经检测结论
	 * @Date 2021/06/18 15:41
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	List<TbSamplingDetailReport> queryBySamplingIdForSelfPrint(@Param("samplingId")Integer samplindId,@Param("checkNumber") Integer checkNumber);

	int updatePrintNum(@Param("samplingId")Integer samplindId, @Param("sampleDetailId")Integer sampleDetailId);
	/**
	* @Description 根据订单ID查询不合格样品明细
	* @Date 2025/06/26 17:22
	* @Author xiaoyl
	* @Param
	* @return
	*/
    List<TbSamplingDetail> queryUnqualifiedFoodNum(@Param("samplingId")Integer samplingId);
}