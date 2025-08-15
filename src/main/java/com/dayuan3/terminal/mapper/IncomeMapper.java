package com.dayuan3.terminal.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.model.IncomeModel;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * @author Dz
 * @description 针对表【income】的数据库操作Mapper
 * @createDate 2025-07-02 15:58:46
 * @Entity generator.domain.Income
 */
public interface IncomeMapper extends BaseMapper<Income> {

    Income queryPaymentOrder(Integer id);

    /**
     * 根据订单id查询
     *
     * @return
     */
    Income selectBySamplingId(@Param("samplingId")Integer id,@Param("incNumber")String incNumber, @Param("transactionType")Short transactionType);

    /**
     * 根据订单id查询
     *
     * @return
     */
    void deleteBySamplingId(Integer id);

    /**
     * 收费汇总统计
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    List<IncomeModel> loadDatagridForStatistics(Page page);

    int getRowTotalForStatistics(Page page);

    /**
     * 按照日期查看收费明细
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    List<Income> loadDatagridForIncome(Page page);

    int getRowTotalForIncome(Page page);

    /**
     * 根据微信商户订单号查询订单
     * 2019-8-7 huht
     *
     * @param number
     * @return
     */
    Income selectByNumber(@Param("number") String number, @Param("orderPlatform") Integer orderPlatform);

    /**
     * 根据商户订单号查询订单 ,因为可能出现不同支付方式同时支付导致出现重复收费的情况，
     * 所以根据商户订单号可能出现1-3个交易记录
     *
     * @param number
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年11月12日
     */
    List<Income> queryListByNumber(@Param("sampleId") Integer sampleId, @Param("number") String number);

    /**
     * 根据商户订单号和支付类型查询交易信息，用于判断是否重复回调，避免写入多条重复支付数据
     *
     * @param number  商户订单号
     * @param payType 支付类型0微信，1支付宝，2余额
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年11月13日
     */
    int queryUniqueByNumber(@Param("number") String number, @Param("payType") short payType);

    /**
     * 查询用户可开票记录
     *
     * @param userId
     * @param start
     * @param end
     * @param rowStart
     * @param rowEnd
     * @return
     */
    List<Income> queryInvoiceList(@Param("userId") Integer userId, @Param("start") String start, @Param("end") String end, @Param("rowStart") Integer rowStart, @Param("rowEnd") Integer rowEnd);

    /**
     * 获取金额
     *
     * @param ids
     * @return
     */
    Double queryIncomeListMoney(@Param("ids") String[] ids);

    String queryBySamplingId(@Param("samplingId")Integer samplingId);

    List<Income> queryAllSplitOrder(@Param("start")Date start);
}