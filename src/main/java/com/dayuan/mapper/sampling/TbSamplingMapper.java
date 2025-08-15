package com.dayuan.mapper.sampling;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.sampling.TbSampling;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author Dz
 * @description 针对表【tb_sampling(抽检单表)】的数据库操作Mapper
 * @createDate 2025-06-11 12:43:52
 * @Entity generator.domain.TbSampling
 */
public interface TbSamplingMapper extends BaseMapper<TbSampling> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BaseFoodType> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal2(Page page);

	/**
	 * 根据数据来源查询 最大 单号
	 * @param
	 * @return
	 */
	String queryLastCode(String samplingNo);

//	List<TbSampling> queryByPid(Map<String, Object> param);
	/**
	 * 根据抽样单号查询抽样信息
	 * @param samplingNo 抽样单号
	 * @return
	 * @author xyl 2017-09-20
	 */
	TbSampling queryBySamplingNo(String samplingNo);

	/**
	 * 保存抽样单的视频文件地址
	 * @param samplingId
	 * @param filePath
	 * @author LuoYX
	 * @date 2018年8月21日
	 */
	void updateSamplingVideoPath(@Param("samplingId")Integer samplingId,@Param("filePath") String filePath);
	
	/**
	 * 根据APP抽样单ID查询抽样信息
	 * @param param2 APP抽样单ID
	 * @return
	 */
	TbSampling queryByParam2(String param2);
	/**
	 * 根据送检单位查询订单信息
	 * @description
	 * @param orderType 排序方式： 0 下单时间，1收样时间
	 * @param rowStart 条数开始
	 * @param rowEnd 条数结束
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月3日
	 */
	List<TbSampling> queryByInspectionUnit(@Param("userId")Integer userId, @Param("createDate")String createDate, @Param("orderType")Integer orderType, @Param("orderStatus")Integer orderStatus, @Param("rowStart")Integer rowStart, @Param("rowEnd")Integer rowEnd, @Param("satrtTime")String  satrtTime, @Param("endTime")String endTime, @Param("checkNumber") Integer checkNumber);
	/**
	 * 查询订单总数
	 * @param userId
	 * @param orderStatus
	 * @return
	 */
	int queryByInspectionUnitCount(@Param("userId")Integer userId,@Param("createDate")String createDate,@Param("orderType")Integer orderType,@Param("orderStatus")Integer orderStatus);
	
	/**
	 * 微信端开票查询 支付订单列表  2019-9-12 huht 
	 * @param userId
	 * @param start
	 * @param end
	 * @param rowStart
	 * @param rowEnd
	 * @return
	 */
	List<TbSampling> queryByInspectionUnit2(@Param("userId")Integer userId,@Param("start")String start,@Param("end")String end,@Param("rowStart")Integer rowStart,@Param("rowEnd")Integer rowEnd);
 
	
	
	
	TbSampling queryByIdAndInspection(@Param("samplingId")Integer samplingId, @Param("inspectionId")Integer inspectionId);
	

	/**
	 * 根据报告码和有效时间获取订单
	 * @param reportCode
	 * @param validityTime
	 * @return
	 */
	TbSampling queryByReportCode(@Param("reportCode")String reportCode,@Param("validityTime") String validityTime);
	
	/**
	 * 修改personal=2 订单的状态
	 * @param orderStatus
	 * @param id
	 */
	void updateSamplingStatus(@Param("orderStatus")short orderStatus,@Param("id") Integer id);

	/**
	 * 查询分页数据列表(订单)
	 * @param page
	 * @return
	 */
	List<TbSampling> loadDatagridOrder(Page page);


	List<TbSampling> loadDatagrid2(Page page);

	/**
	 * 查询记录总数量(订单)
	 * @param page
	 * @return
	 */
	int getRowTotalOrder(Page page);




	TbSampling queryBySamplingId(@Param("samplingId")Integer samplingId);
	
	/**
	 * 自助下单--收费流水
	 * @description
	 * @param page
	 * @return
	 * @author xiaoyl
	 * @date   2019年8月1日
	 */
	List<TbSampling> loadDatagridForIncome(Page page);
	/**
	 * 自助下单--收费流水总数量
	 * @description
	 * @param page
	 * @return
	 * @author xiaoyl
	 * @date   2019年8月1日
	 */
	int getRowTotalForIncome(Page page);

	/**
	 * 根据送检人手机号查询已支付订单信息
	 * @param phone 送检人手机号
	 * @param startTime 下单时间查询范围-开始时间
	 * @param endTime 下单时间查询范围-结束时间
	 * @return
	 */
	List<TbSampling> queryByPhone(@Param("phone") String phone, @Param("startTime") String startTime, @Param("endTime") String endTime);
    
	/**
	 * 定时查询待支付订单
	 * @param samplingDate
	 * @return
	 */
	void UpdateByOrderStatus(@Param("samplingDate") Date samplingDate);
	
	/**
	 *	 订单查询
	 * @description
	 * @param page
	 * @return
	 * @author xiaoyl
	 * @date   2019年10月12日
	 */
	List<TbSampling> loadDatagridQueryOrder(Page page);

	/**
	 * 	查询记录总数量(订单)
	 * @description
	 * @param page
	 * @return
	 * @author xiaoyl
	 * @date   2019年10月12日
	 */
	int getRowTotalQueryOrder(Page page);

	/**
	 * 根据订单ID查询订单信息(查询出订单关联的多个委托单位ID)
	 * @param id
	 * @return
	 * @author shit
	 */
	TbSampling selectById(Integer id);

	/**
	 * 根据委托单位ID和抽样单ID查询报告信息
	 *
	 * @param requestId  委托单位ID
	 * @param samplingId 抽样单ID
	 * @return
	 */
	TbSampling selectByReqestId(@Param("requestId") Integer requestId, @Param("samplingId") Integer samplingId);

	/**
	 * 根据状态查询取样数据
	 *
	 * @param status 是否取样:0 待接收，1 待取样，2  已取样
	 * @param pageNo
	 * @param pageSize
	 * @author shit
	 * @return
	 */
	List<TbSampling> querySampingList(@Param("status") Integer status, @Param("pageNo") int pageNo, @Param("pageSize") int pageSize, @Param("userId") Integer userId
	);

	/**
	 * 更改订单的取样状态
	 * @param tbSampling
	 * @author shit
	 */
	int updateTask(TbSampling tbSampling);

	/**
	 * 查询取样的个数
	 * @param userId
	 * @author shit
	 */
	Map<String,Object> selectTakeNums(Integer userId);

	/**
	 * 清空之前的报告费订单主表的printing_fee字段
	 * @param samplingId
	 * @author shit
	 */
    void emptyPrintingFee(Integer samplingId);

	double queryTotalMoney(Page page);

	double queryTotalMoney2(Page page);
	/**
	 * 查询超时待支付订单信息
	 * @description
	 * @param d
	 * @return
	 * @author xiaoyl
	 * @date   2020年3月20日
	 */
	List<TbSampling> queryAllTimeOutOrder(Date d);

    int reviewSamplingBatch(@Param("idas") Integer[] idas, @Param("reviewName")String reviewName, @Param("approvalSignature")String approvalSignature, @Param("userId")String userId);

	List<TbSampling> queryReCheck(@Param("startTime")String startTime, @Param("endTime")String endTime);
}