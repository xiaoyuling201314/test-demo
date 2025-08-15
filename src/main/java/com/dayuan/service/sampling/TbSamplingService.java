package com.dayuan.service.sampling;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.system.TSUser;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.BaseModel;
import com.dayuan.model.sampling.TbSamplingDetailReport;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.api.common.MiniProgramException;
import com.dayuan3.api.vo.pay.PayReqVO;
import com.dayuan3.common.bean.InspectionUnitUserRequester;
import com.dayuan3.common.bean.TbSamplingRequester;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * @author Dz
 * @description 针对表【tb_sampling(抽检单表)】的数据库操作Service
 * @createDate 2025-06-11 12:43:52
 */
public interface TbSamplingService extends IService<TbSampling> {

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception;

    public Page loadDatagrid2(Page page, BaseModel t) throws Exception;

    public void insert(TbSampling t) throws Exception;

    /**
     * 根据数据来源查询 最大 单号
     *
     * @param samplingNo
     * @return
     */
    public String queryLastCode(String samplingNo);

    /**
     * 新增抽检单
     *
     * @param sampling 抽样单
     * @param list     抽样明细
     * @param user     登录用户
     * @param file     经营户签名和购样小票的压缩文件
     * @param
     */
    public TbSampling addSampling(TbSampling sampling, List<TbSamplingDetail> list, TSUser user, MultipartFile file) throws Exception;

    /**
     * 订单(微信)
     *
     * @param sampling 抽样单
     * @param list     抽样明细
     * @param user     登录用户
     * @param file     经营户签名和购样小票的压缩文件
     * @param
     */
    public TbSampling addSampling2(TbSampling sampling, List<TbSamplingDetail> list, TSUser user, InspectionUnitUser uintUser, MultipartFile file, List<TbSamplingRequester> reqList) throws Exception;

    /**
     * 新增订单(自助终端)
     *
     * @param sampling 抽样单
     * @param list     抽样明细
     * @param
     */
    public TbSampling addSampling3(TbSampling sampling, List<TbSamplingDetail> list, InspectionUnitUser uintUser,
                                   List<InspectionUnitUserRequester> requestLists) throws Exception;

    /**
     * 根据抽样单号查询抽样信息
     *
     * @param samplingNo 抽样单号
     * @return
     * @author xyl 2017-09-20
     */
    public TbSampling queryBySamplingNo(String samplingNo);

    /**
     * 重新分配检测任务接收设备
     *
     * @param list 抽样明细
     * @throws MissSessionExceprtion
     */
    public int updateReceviesStatus(List<TbSamplingDetail> list) throws Exception;


    /**
     * 保存抽样单的视频文件地址
     *
     * @param samplingId
     * @param filePath
     * @author LuoYX
     * @date 2018年8月21日
     */
    public void updateSamplingVideoPath(Integer samplingId, String filePath);

    /**
     * 根据APP抽样单ID查询抽样信息
     *
     * @param param2 APP抽样单ID
     * @return
     */
    public TbSampling queryByParam2(String param2);

    /**
     * 根据送检单位用户查询订单信息
     *
     * @param userIds
     * @param createDate          订单创建时间
     * @param orderType           排序方式： 0 下单时间，1收样时间
     * @param status              订单状态0_暂存,1_待支付,2_完成,3_取消
     * @param rowStart，rowEnd分页参数
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月3日
     */
    public List<TbSampling> queryByInspectionUnit(Integer userIds, String createDate, Integer orderType, Integer status, Integer rowStart, Integer rowEnd, String satrtTime, String endTime);

    /**
     * 查询订单总数
     *
     * @param userIds
     * @param createDate 下单时间
     * @param orderType  排序方式： 0 下单时间，1收样时间
     * @param status
     * @return
     */
    public int queryByInspectionUnitCount(Integer userIds, String createDate, Integer orderType, Integer status);

    /**
     * 微信端开发票查询已支付订单
     *
     * @param userId   送检用户id
     * @param start    开始时间
     * @param end      结束时间
     * @param rowStart 开始条数
     * @param rowEnd   结束条数
     * @return
     */
    public List<TbSampling> queryByInspectionUnit2(Integer userId, String start, String end, Integer rowStart, Integer rowEnd);


    /**
     * 根据订单ID和送检单位ID查询订单相关信息
     *
     * @param samplingId
     * @param inspectionId
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月9日
     */
    public TbSampling queryByIdAndInspection(Integer samplingId, Integer inspectionId);

    /**
     * 修改订单状态
     *
     * @param orderStatus
     * @param id
     */
    public void updateSamplingStatus(short orderStatus, Integer id) throws Exception;

    /**
     * 根据抽样单号查询送检订单信息
     *
     * @param samplingId
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月27日
     */
    public TbSampling queryBySamplingId(Integer samplingId);

    /**
     * 根据订单号查看收费纪录
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月1日
     */
    public List<TbSampling> loadDatagridForIncome(Page page);

    /**
     * 根据订单号查看收费总数量
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年8月1日
     */
    public int getRowTotalForIncome(Page page);

    /**
     * 根据送检人手机号查询已支付订单信息
     *
     * @param phone     送检人手机号
     * @param startTime 下单时间查询范围-开始时间
     * @param endTime   下单时间查询范围-结束时间
     * @return
     */
    public List<TbSampling> queryByPhone(String phone, String startTime, String endTime);

    /**
     * 定时取消超时订单
     * 2019-8-30 huht
     *
     * @param samplingDate
     */
    public void UpdateByOrderStatus(Date samplingDate);

    /**
     * 根据订单ID查询订单信息(查询出订单关联的多个委托单位ID)
     *
     * @param id
     * @return
     * @author shit
     */
    public TbSampling selectById(Integer id);


    /**
     * 根据委托单位ID和抽样单ID查询报告信息
     *
     * @param requestId  委托单位ID
     * @param samplingId 抽样单ID
     * @return
     */
    public TbSampling selectByReqestId(Integer requestId, Integer samplingId);

    /**
     * 根据状态查询取样数据
     *
     * @param status   是否取样:0 待接收，1 待取样，2  已取样
     * @param pageNo
     * @param pageSize
     * @return
     * @author shit
     */
    public List<TbSampling> querySampingList(Integer status, int pageNo, int pageSize, Integer userId);

    /**
     * 更改订单的取样状态
     *
     * @param tbSampling
     * @author shit
     */
    public int updateTask(TbSampling tbSampling);

    /**
     * 查询取样的个数
     *
     * @param userId
     * @author shit
     */
    public Map<String, Object> selectTakeNums(Integer userId);

    /**
     * 清空之前的报告费订单主表的printing_fee字段
     *
     * @param samplingId
     * @author shit
     */
    public void emptyPrintingFee(Integer samplingId);

    /**
     * 查询时间范围内的订单总金额
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年3月13日
     */
    public double queryTotalMoney(Page page);

    public double queryTotalMoney2(Page page);

    /**
     * 查询超时待支付订单
     * @description
     * @param d
     * @return
     * @author xiaoyl
     * @date   2020年3月20日
     */
	public List<TbSampling> queryAllTimeOutOrder(Date d);


    /**
     * @return
     * @Description 读取检测项目json文件
     * @Date 2020/09/23 13:28
     * @Author xiaoyl
     * @Param 基础数据
     */
    public List<TbSamplingDetailReport> readItemGroupFile(HttpServletRequest request, List<TbSamplingDetailReport> samplingDetailList);

    /**
    * @Description 批量复核检测报告
    * @Date 2020/10/29 16:43
    * @Author xiaoyl
    * @Param idas 抽样单/送检单ID
     *@Param reviewName 复核人员签名/姓名
     *@Param approvalSignature 复核人员签名/姓名
     *@Param idas 抽样单/送检单ID
    * @return
    */
    public int reviewSamplingBatch(Integer[] idas, String reviewName, String approvalSignature, String userId);

    /**
     * 新增订单
     * @param sampling  订单
     * @param details   订单明细
     * @param reqUnits  委托单位
     * @param user      送检人
     * @param
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public TbSampling addOrder(TbSampling sampling, List<TbSamplingDetail> details, List<TbSamplingRequester> reqUnits, InspectionUnitUser user) throws Exception;

    /**
     * 上门取样状态修改
     *
     * @param tbSampling
     * @return
     */
    public AjaxJson updateTaskState(TbSampling tbSampling, InspectionUnitUser user) throws Exception;

    /**
     * 根据有效报告码获取订单
     *
     * @param reportCode 有效期内的报告码
     * @return
     */
    public TbSampling queryByReportCode(String reportCode);

    /**
     * 有效期+7天内报告码是否重复
     *
     * @param reportCode 报告码
     * @return true 重复
     */
    public boolean isRepeat(String reportCode);




    /****************************************************** 快检新模式 Dz 2025.6.11 ******************************************************/
    /**
     * 检查订单号是否合规、占用
     *
     * @param orderNumber 订单号
     */
    boolean checkOrderNumber(String orderNumber);

    /**
     * 新增订单
     *
     * @param sampling 订单
     * @param details 订单项目
     * @return 订单ID
     */
    int createOrder(TbSampling sampling, List<TbSamplingDetail> details);

    /**
     * 更新订单为已支付状态
     *
     * @param id      订单ID
     * @return  返回值：1_成功,0_失败,-1_订单不存在,-2_恢复订单失败（单号已使用）
     */
    int paid(int id);

    String payManyAsyncSplit(PayReqVO payReqVO) throws Exception;

    /**
     * 复检（复检订单所有不合格项目，供复检支付接口调用）
     *
     * @param orderId 复检订单ID
     * @param recheckFees 合计复检费用（单位：分）
     */
    void recheck(int orderId, int recheckFees) throws MiniProgramException;

   /**
    * Description 根据时间范围或者单号查询订单信息
    * @Author xiaoyl
    * @Date 2025/7/5 11:32
    */
    List<TbSampling> queryReCheck(String startTime, String endTime);
    /**
     * Description 计算复检费用
     * @Author xiaoyl
     * @Date 2025/7/10 13:49
     */
    public int reCheckMoney(Integer samplingId,String orderNumber) throws Exception;
}
