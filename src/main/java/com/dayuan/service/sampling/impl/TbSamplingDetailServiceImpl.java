package com.dayuan.service.sampling.impl;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.mapper.sampling.TbSamplingDetailMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.sampling.TbSamplingDetailReport;
import com.dayuan.service.sampling.TbSamplingDetailCodeService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.SystemConfigUtil;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
* @author Dz
* @description 针对表【tb_sampling_detail(抽检单明细表)】的数据库操作Service实现
* @createDate 2025-06-12 13:00:03
*/
@Service
@RequiredArgsConstructor
public class TbSamplingDetailServiceImpl extends ServiceImpl<TbSamplingDetailMapper, TbSamplingDetail>
    implements TbSamplingDetailService {

    private final TbSamplingService tbSamplingService;

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private TbSamplingDetailCodeService tbSamplingDetailCodeService;
    @Autowired
    private TbSamplingRequesterService tbSamplingRequesterService;
    @Autowired
    private InspectionUnitUserService inspectionUnitUserService;

    /**
     * 根据订单ID查询订单明细
     *
     * @param samplingId 订单ID
     * @return
     */
    public List<TbSamplingDetailReport> queryBySamplingId(Integer samplingId) {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryBySamplingId(samplingId, recheckNumber);
    }

    /**
     * 根据订单明细ID查询订单明细
     *
     * @param samplingDetailId 订单明细ID
     * @return
     */
    public TbSamplingDetailReport queryBySamplingDetailId(Integer samplingDetailId) {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryBySamplingDetailId(samplingDetailId, recheckNumber);
    }

    /**
     * 根据抽样单ID查询，合并检测项目
     *
     * @param id
     * @return
     */
    public List<com.dayuan.bean.sampling.TbSamplingDetail> queryBySamplingIdUnionItems(Integer id) {
        return getBaseMapper().queryBySamplingIdUnionItems(id);
    }

    /**
     * 根据抽样单ID查看抽样详情，用于app扫码查看
     *
     * @param samplingId
     * @return
     */
    public List<TbSamplingDetailReport> queryBySamplingIdForApp(Integer samplingId) {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryBySamplingIdForApp(samplingId, recheckNumber);
    }

    /**
     * 查询 未分配 或 已分配未接收检测任务 的抽样明细信息
     * @param id 抽样单ID
     * @return
     */
    public List<com.dayuan.bean.sampling.TbSamplingDetail> queryTaskBySamplingId(Integer id) {
        return getBaseMapper().queryTaskBySamplingId(id);
    }

    /**
     * 查询仪器未检测的抽样明细
     * @param serialNumber	仪器唯一标识
     * @return
     */
    public List<com.dayuan.bean.sampling.TbSamplingDetail> queryUncheckSamplingDetail(String serialNumber) {
        return getBaseMapper().queryUncheckSamplingDetail(serialNumber);
    }

    /**
     * 清空抽样明细（未检测）的仪器唯一标识
     * @param serialNumber	仪器唯一标识
     */
    public void cleanSerialNumber(String serialNumber) {
        getBaseMapper().cleanSerialNumber(serialNumber);
    }

    /**
     * 重置检测任务接收状态
     * @param detailId 抽样明细ID
     * @return
     */
    public void resetStatus(Integer detailId) throws Exception {
        getBaseMapper().resetStatus(detailId);
    }


    /**
     * 去查询其抽样单明细 暂时没调用该方法
     *
     * @param rId 检测数据ID
     * @return
     */
    public Map<String, Object> selectDetailByRid(Integer rId) throws Exception {
        return getBaseMapper().selectDetailByRid(rId);
    }

    /**
     * 根据抽样单明显信息去查询溯源表中数据 暂时没调用该方法
     *
     * @param regId      市场ID
     * @param opeId      经营户ID
     * @param foodName   食品名称
     * @param batchNumber 批次
     * @return
     */
    public BaseLedgerStock selectSource(Integer regId, Integer opeId, String foodName, String batchNumber)throws Exception {
        return getBaseMapper().selectSource(regId,opeId,foodName,batchNumber);
    }

    /**
     * 根据抽样单id(订单) 查询订单明细 huht
     * @param samplingId
     * @return
     */
    public List<com.dayuan.bean.sampling.TbSamplingDetail>	queryBySamplingId2(Integer samplingId,Integer queryReCheck)throws Exception {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryBySamplingId2(samplingId, recheckNumber,queryReCheck);
    }


    /**
     * 根据样品码获取样品信息
     * @param barCode 样品码
     * @return
     */
    public List<com.dayuan.bean.sampling.TbSamplingDetail> queryByBarCode(String barCode) {
        return getBaseMapper().queryByBarCode(barCode);
    }

    /**
     * 根据送样码获取样品信息
     * @param samplingId 订单ID
     * @param collectCode 送样码
     * @return
     */
    public List<com.dayuan.bean.sampling.TbSamplingDetail> queryByCollectCode(Integer samplingId, String collectCode) {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryByCollectCode(samplingId, collectCode, recheckNumber);
    }

    /**
     * 查询分页数据列表(订单)
     * @param page
     * @return
     */
    public List<TbSamplingDetail> loadDatagridOrderDetails(Page page){
        return getBaseMapper().loadDatagridOrderDetails(page);
    }

    public Page loadDatagridOrderDetails2(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotalOrderDetails(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常s
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        }

        List<TbSamplingDetail> dataList = getBaseMapper().loadDatagridOrderDetails2(page);
        page.setResults(dataList);
        return page;
    }



    /**
     * 查询记录总数量(订单)
     * @param page
     * @return
     */
    public int getRowTotalOrderDetails(Page page){
        return getBaseMapper().getRowTotalOrderDetails(page);
    }
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
    public List<TbSamplingDetailReport> queryOrderDetailBySamplingId(Integer samplingId,Integer reportNumber,String collectCode) {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryOrderDetailBySamplingId(samplingId,reportNumber,collectCode,recheckNumber);
    }
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
    public List<Map<String, Object>> queryReportNumberBySamplingId(Integer samplingId, String collectCode) {
        return getBaseMapper().queryReportNumberBySamplingId(samplingId,collectCode);
    }
    /**
     * 报告首次打印：批量写入打印报告码
     * @description
     * @param reportNumber 报告码
     * @param samplingDetailIds
     * @return
     * @author xiaoyl
     * @date   2019年8月15日
     */
    public int updateReportNumberByDetailIds(Integer reportNumber, int[] samplingDetailIds) {
        return getBaseMapper().updateReportNumberByDetailIds(reportNumber,samplingDetailIds);
    }
    /**
     * 根据订单明细ID更新报告打印次数
     * @description
     * @param samplingDetailIds 抽样单ID列表
     * @return
     * @author xiaoyl
     * @date   2019年8月15日
     */
    public int updateByDetailIds( int[]  samplingDetailIds) {
        return getBaseMapper().updateByDetailIds(samplingDetailIds);
    }

//    /**
//     * 收样批量更新样品码
//     * @param sampling 订单
//     * @param samplingDetails 样品
//     * @param requesters 委托单位
//     * @return  收样时间
//     * @throws Exception
//     */
//    public Map bulkUpdateCode(TbSampling sampling, List<TbSamplingDetail> samplingDetails, List<TbSamplingRequester> requesters) throws Exception {
//        Map map = new HashMap();
//        sampling=tbSamplingService.getById(sampling.getId());
//        List<TbSamplingRequester> oldRequesters = null;
////        //一单一个委托单位
////        //原订单
////        TbSampling oldSampling = tbSamplingService.getById(sampling.getId());
////        //更换了委托单位
////        if (oldSampling.getRegId() != sampling.getRegId()){
////            PublicUtil.setCommonForTable(sampling, false);
////            tbSamplingService.updateBySelective(sampling);
////
////            List<TbSamplingRequester> oldRequesters = tbSamplingRequesterService.queryBySamplingId(sampling.getId());
////
////            oldRequesters.get(0).setRequestId(sampling.getRegId());
////            oldRequesters.get(0).setRequestName(sampling.getRegName());
////            PublicUtil.setCommonForTable(oldRequesters.get(0), false);
////            tbSamplingRequesterService.updateBySelective(oldRequesters.get(0));
////
////        }
//
//        //更换委托单位
//        if (requesters != null && requesters.size() > 0) {
//            //一单多个委托单位
//           oldRequesters = tbSamplingRequesterService.queryBySamplingId(sampling.getId());
//            if (oldRequesters.size() != requesters.size()) {
//                throw new Exception("不能增加或删减订单委托单位");
//            }
//
//            //去除不需要更换的委托单位
//            Iterator<TbSamplingRequester> it0 = oldRequesters.iterator();
//            while (it0.hasNext()) {
//                TbSamplingRequester r0 = it0.next();
//
//                Iterator<TbSamplingRequester> it1 = requesters.iterator();
//                while (it1.hasNext()) {
//                    TbSamplingRequester r1 = it1.next();
//
//                    if (r0.getRequestId().equals(r1.getRequestId())) {
//                        it0.remove();
//                        it1.remove();
//                        break;
//                    }
//                }
//            }
//
//            //更新数据
//            for (int i=0;i<oldRequesters.size();i++){
//                TbSamplingRequester r2 = oldRequesters.get(i);
//                r2.setRequestId(requesters.get(i).getRequestId());
//                r2.setRequestName(requesters.get(i).getRequestName());
//                r2.setParam1(requesters.get(i).getParam1());
//                r2.setParam2(requesters.get(i).getParam2());
//                PublicUtil.setCommonForTable(r2, false);
//                tbSamplingRequesterService.updateBySelective(r2);
//            }
//            // add by xiaoyl 2020-03-17 更改委托单位时更新订单主表的相关信息
//            if(requesters.size()==1) {//一个订单对应一个委托单位
//            	sampling.setRegId(requesters.get(0).getRequestId());
//            	sampling.setRegName(requesters.get(0).getRequestName());
//            	sampling.setRegLinkPhone(requesters.get(0).getParam1());
//            }else {
//            	//TODO
//            }
//        }
//
//
//        //收样人
//        TSUser user = PublicUtil.getSessionUser();
//        //收样时间
//        Date date = new Date();
//        //收样编号
//        String collectCode = null;
//
//        //本次收样的样品码
//        Set<String> sCode = new HashSet<String>();
//
//        //更新样品、样品码
//        if (samplingDetails != null && samplingDetails.size()>0) {
//            //获取未创建tbSamplingDetailCode的样品ID
//            StringBuffer sql = new StringBuffer();
//            sql.append("SELECT " +
//                    " tb1.sdId " +
//                    "FROM " +
//                    "( ");
//            for (TbSamplingDetail samplingDetail : samplingDetails){
//                sql.append("SELECT "+samplingDetail.getId()+" sdId UNION ");
//
//                if (StringUtil.isNotEmpty(samplingDetail.getSampleTubeCode())){
//                    //生成收样编号
//                    if (collectCode == null){
//                        collectCode = RandomStringUtils.random(6,true,false).toUpperCase();
//                    }
//
//                    //记录收样编号
//                    samplingDetail.setCollectCode(collectCode);
//                    //记录收样时间
//                    samplingDetail.setSampleTubeTime(date);
//                    //记录收样人
//                    samplingDetail.setParam4(user.getRealname());
//                    //记录收样人ID
//                    samplingDetail.setParam5(user.getId());
//                    //记录收样机构ID
//                    samplingDetail.setDepartId(user.getDepartId());
//                    //记录收样检测点ID
//                    samplingDetail.setPointId(user.getPointId());
//
//                    sCode.add(samplingDetail.getSampleTubeCode());
//                }
//            }
//            sql.delete(sql.length()-6, sql.length());
//            sql.append(") tb1 " +
//                    "LEFT JOIN tb_sampling_detail_code tsdc ON tsdc.sampling_detail_id = tb1.sdId " +
//                    "WHERE tsdc.id IS NULL");
//            List<Map<String,Object>> list = jdbcTemplate.queryForList(sql.toString());
//
//            //插入tb_sampling_detail_code
//            if (list!=null && list.size()>0){
//                for (Map map1 : list){
//                    TbSamplingDetailCode samplingDetailCode = new TbSamplingDetailCode();
//                    samplingDetailCode.setSamplingDetailId(Integer.parseInt(map1.get("sdId").toString()));
//                    samplingDetailCode.setDeleteFlag((short) 0);
//                    PublicUtil.setCommonForTable(samplingDetailCode, true);
//                    tbSamplingDetailCodeService.insert(samplingDetailCode);
//                }
//            }
//
//            //更新样品码
//            getBaseMapper().bulkUpdateCode(samplingDetails);
//        }
//        //add by xiaoyl 2020-02-29更新取样订单状态：更改为已取样
//        if(sampling.getTakeSamplingModal()==1 &&  sampling.getIsTakeSampling()!=2) {
//        	sampling.setIsTakeSampling((short)2);
//        	sampling.setTakeSamplingUserid(0);
//        	sampling.setTakeSamplingUsername("收样人员");
//        	sampling.setTakeFoodDate(new Date());
//        	tbSamplingService.updateBySelective(sampling);
//        }else if(oldRequesters != null && oldRequesters.size() > 0) {
//        	tbSamplingService.updateBySelective(sampling);
//        }
//        //收样时间
//        map.put("collectTime", date);
//        //收样编号
//        map.put("collectCode", collectCode);
//
//        try {
//            //推送收样通知
//            if (sCode.size() > 0) {
//                InspectionUnitUser samplingUser = inspectionUnitUserService.queryById(Integer.parseInt(sampling.getSamplingUserid()));
//                if(StringUtil.isNotEmpty(samplingUser.getOpenId())) {
//                	wxPayService.sendMsg(WeChatMsgConfig.sample, samplingUser.getOpenId(),
//                			null, "订单"+sampling.getSamplingNo()+"的送检样品状态如下：", null,
//                			new String[]{"已收样", samplingUser.getRealName(), samplingUser.getRealName(), DateUtil.formatDate(new Date(), "yyyy-MM-dd"), "共计"+sCode.size()+"个样品"});
//                }
//            }
//        } catch (Exception e) {
//            log.error("******************************推送收样通知失败：" + e.getMessage() + e.getStackTrace());
//        }
//
//        return map;
//    }

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
    public List<Map<String, Object>> queryCollectCodeBySamplingId(Integer samplingId, String collectCode) {
        return getBaseMapper().queryCollectCodeBySamplingId(samplingId,collectCode);
    }
    /**
     *
     * @description 根据抽样单ID查询样品数量
     * @param samplindId 订单ID
     * @return
     * @author xiaoyl
     * @date   2020年2月24日
     */
    public int queryFoodCountBySamplingId(Integer samplindId) {
        return getBaseMapper().queryFoodCountBySamplingId(samplindId);
    }
    /**
     * @Description 四季美项目：根据抽样单ID查询抽样明细已经检测结论
     * @Date 2021/06/18 15:41
     * @Author xiaoyl
     * @Param
     * @return
     */
    public List<TbSamplingDetailReport> queryBySamplingIdForSelfPrint(Integer samplindId) {
//        停用20220829 Dz
//        //不合格样品检测次数，≥checkNumber出报告，先从系统参数配置“系统名称”配置中获取，没有则使用sysconfig.properties中的配置
//        JSONObject systemConfig=SystemConfigUtil.SYSTEM_NAME_CONFIG;
//        if(null!=systemConfig && systemConfig.getInteger("checkNumber")!=null){
//            recheckNumber=systemConfig.getInteger("checkNumber");
//        }

        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return getBaseMapper().queryBySamplingIdForSelfPrint(samplindId,recheckNumber);
    }
    /**
     * 收样批量更新样品码
     * @param sampling 订单
     * @param samplingDetails 样品
     * @param requesters 委托单位
     * @return  收样时间
     * @throws Exception
     */
    public Map bulkUpdateCode(TbSampling sampling, List<com.dayuan.bean.sampling.TbSamplingDetail> samplingDetails, List<TbSamplingRequester> requesters) throws Exception {
        Map map = new HashMap();
        sampling=tbSamplingService.getById(sampling.getId());
        List<TbSamplingRequester> oldRequesters = null;
        //        //一单一个委托单位
        //        //原订单
        //        TbSampling oldSampling = tbSamplingService.getById(sampling.getId());
        //        //更换了委托单位
        //        if (oldSampling.getRegId() != sampling.getRegId()){
        //            PublicUtil.setCommonForTable(sampling, false);
        //            tbSamplingService.updateBySelective(sampling);
        //
        //            List<TbSamplingRequester> oldRequesters = tbSamplingRequesterService.queryBySamplingId(sampling.getId());
        //
        //            oldRequesters.get(0).setRequestId(sampling.getRegId());
        //            oldRequesters.get(0).setRequestName(sampling.getRegName());
        //            PublicUtil.setCommonForTable(oldRequesters.get(0), false);
        //            tbSamplingRequesterService.updateBySelective(oldRequesters.get(0));
        //
        //        }

        //更换委托单位
        if (requesters != null && requesters.size() > 0) {
            //一单多个委托单位
            oldRequesters = tbSamplingRequesterService.queryBySamplingId(sampling.getId());
            if (oldRequesters.size() != requesters.size()) {
                throw new Exception("不能增加或删减订单委托单位");
            }

            //去除不需要更换的委托单位
            Iterator<TbSamplingRequester> it0 = oldRequesters.iterator();
            while (it0.hasNext()) {
                TbSamplingRequester r0 = it0.next();

                Iterator<TbSamplingRequester> it1 = requesters.iterator();
                while (it1.hasNext()) {
                    TbSamplingRequester r1 = it1.next();

                    if (r0.getRequestId().equals(r1.getRequestId())) {
                        it0.remove();
                        it1.remove();
                        break;
                    }
                }
            }

            //更新数据
            for (int i=0;i<oldRequesters.size();i++){
                TbSamplingRequester r2 = oldRequesters.get(i);
                r2.setRequestId(requesters.get(i).getRequestId());
                r2.setRequestName(requesters.get(i).getRequestName());
                r2.setParam1(requesters.get(i).getParam1());
                r2.setParam2(requesters.get(i).getParam2());
                PublicUtil.setCommonForTable(r2, false);
                tbSamplingRequesterService.updateBySelective(r2);
            }
            // add by xiaoyl 2020-03-17 更改委托单位时更新订单主表的相关信息
            if(requesters.size()==1) {//一个订单对应一个委托单位
//                sampling.setRegId(requesters.get(0).getRequestId());
//                sampling.setRegName(requesters.get(0).getRequestName());
//                sampling.setRegLinkPhone(requesters.get(0).getParam1());
            }else {
                //TODO
            }
        }


        //收样人
        TSUser user = PublicUtil.getSessionUser();
        //收样时间
        Date date = new Date();
        //收样编号
        String collectCode = null;

        //本次收样的样品码
        Set<String> sCode = new HashSet<String>();

        //更新样品、样品码
        if (samplingDetails != null && samplingDetails.size()>0) {
            //获取未创建tbSamplingDetailCode的样品ID
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT " +
                    " tb1.sdId " +
                    "FROM " +
                    "( ");
            for (com.dayuan.bean.sampling.TbSamplingDetail samplingDetail : samplingDetails){
                sql.append("SELECT "+samplingDetail.getId()+" sdId UNION ");

                if (StringUtil.isNotEmpty(samplingDetail.getSampleTubeCode())){
                    //生成收样编号
                    if (collectCode == null){
                        collectCode = RandomStringUtils.random(6,true,false).toUpperCase();
                    }

//                    //记录收样编号
//                    samplingDetail.setCollectCode(collectCode);
//                    //记录收样时间
//                    samplingDetail.setSampleTubeTime(date);
//                    //记录收样人
//                    samplingDetail.setParam4(user.getRealname());
//                    //记录收样人ID
//                    samplingDetail.setParam5(user.getId());
//                    //记录收样机构ID
//                    samplingDetail.setDepartId(user.getDepartId());
//                    //记录收样检测点ID
//                    samplingDetail.setPointId(user.getPointId());

                    sCode.add(samplingDetail.getSampleTubeCode());
                }
            }
            sql.delete(sql.length()-6, sql.length());
            sql.append(") tb1 " +
                    "LEFT JOIN tb_sampling_detail_code tsdc ON tsdc.sampling_detail_id = tb1.sdId " +
                    "WHERE tsdc.id IS NULL");
            List<Map<String,Object>> list = jdbcTemplate.queryForList(sql.toString());

            //插入tb_sampling_detail_code
            if (list!=null && list.size()>0){
                for (Map map1 : list){
                    TbSamplingDetailCode samplingDetailCode = new TbSamplingDetailCode();
                    samplingDetailCode.setSamplingDetailId(Integer.parseInt(map1.get("sdId").toString()));
                    samplingDetailCode.setDeleteFlag(0);
                    PublicUtil.setCommonForTable(samplingDetailCode, true);
                    tbSamplingDetailCodeService.save(samplingDetailCode);
                }
            }

            //更新样品码
            getBaseMapper().bulkUpdateCode(samplingDetails);
        }
        //add by xiaoyl 2020-02-29更新取样订单状态：更改为已取样
//        if(sampling.getTakeSamplingModal()==1 &&  sampling.getIsTakeSampling()!=2) {
//            sampling.setIsTakeSampling((short)2);
//            sampling.setTakeSamplingUserid(0);
//            sampling.setTakeSamplingUsername("收样人员");
//            sampling.setTakeFoodDate(new Date());
//            tbSamplingService.updateBySelective(sampling);
//        }else if(oldRequesters != null && oldRequesters.size() > 0) {
//            tbSamplingService.updateBySelective(sampling);
//        }
        //收样时间
        map.put("collectTime", date);
        //收样编号
        map.put("collectCode", collectCode);

//        try {
//            //推送收样通知
//            if (sCode.size() > 0) {
//                InspectionUnitUser samplingUser = inspectionUnitUserService.queryById(Integer.parseInt(sampling.getSamplingUserid()));
//                if(StringUtil.isNotEmpty(samplingUser.getOpenId())) {
//                    wxPayService.sendMsg(WeChatMsgConfig.sample, samplingUser.getOpenId(),
//                            null, "订单"+sampling.getSamplingNo()+"的送检样品状态如下：", null,
//                            new String[]{"已收样", samplingUser.getRealName(), samplingUser.getRealName(), DateUtil.formatDate(new Date(), "yyyy-MM-dd"), "共计"+sCode.size()+"个样品"});
//                }
//            }
//        } catch (Exception e) {
//            log.error("******************************推送收样通知失败：" + e.getMessage() + e.getStackTrace());
//        }

        return map;
    }

    @Override
    public int updatePrintNum(Integer samplId, Integer sampleDetailId) {
        return getBaseMapper().updatePrintNum(samplId,sampleDetailId);
    }

    @Override
    public int bulkSampleCode(Integer samplId, Integer sampleDetailId,String sampleCode) throws Exception {
        int result=0;
        //1.首先写入收样和前处理记录表
        TbSamplingDetailCode  samplingDetailCode=null;
        if(sampleDetailId!=null){
            samplingDetailCode=tbSamplingDetailCodeService.queryBySamplingDetailId(sampleDetailId);
            if(samplingDetailCode==null){
                samplingDetailCode = new TbSamplingDetailCode(sampleDetailId,sampleCode,new Date(),0);
                PublicUtil.setCommonForTable(samplingDetailCode, true);
                tbSamplingDetailCodeService.save(samplingDetailCode);
                result++;
            }
        }else{
            List<TbSamplingDetail> list= getBaseMapper().queryBySamplingId2(samplId,2,0);
            for (TbSamplingDetail detail:list){
                samplingDetailCode=tbSamplingDetailCodeService.queryBySamplingDetailId(detail.getId());
                if(samplingDetailCode==null){
                    samplingDetailCode = new TbSamplingDetailCode(detail.getId(),detail.getSampleCode(),new Date(),0);
                    PublicUtil.setCommonForTable(samplingDetailCode, true);
                   tbSamplingDetailCodeService.save(samplingDetailCode);
                    result++;
                }
            }
        }
        //2. 更新订单明细表的分拣时间和打印次数
        getBaseMapper().updatePrintNum(samplId,sampleDetailId);
        return result;
    }


    @Deprecated
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int recheck(int detailId, int recheckFee) {
        // 返回值：1_成功,0_失败,-1_复检样品不存在,-2_订单异常
        int result = 1;

        // 获取复检样品
        TbSamplingDetail sample = getById(detailId);
        if (sample == null) {
            // 复检样品不存在
            result = -1;

        } else {
            TbSampling order = tbSamplingService.getById(sample.getSamplingId());
            if (order == null || !Arrays.asList(2,3,5,6).contains(order.getOrderStatus())) {
                // 订单不存在或订单状态异常
                result = -2;

            } else {
                // 复制复检样品信息
                TbSamplingDetail recheckSample = new TbSamplingDetail();
                BeanUtils.copyProperties(sample, recheckSample);
                recheckSample.setId(null);
                recheckSample.setIsRecheck(0);
                recheckSample.setItemId(null);
                recheckSample.setItemName(null);
                recheckSample.setInspectionFee(recheckFee);
                recheckSample.setRecheckDetailId(detailId);
                recheckSample.setRecevieStatus(0);
                recheckSample.setRecevieDevice("");
                recheckSample.setOperatingTime(null);
                save(recheckSample);

                // 原样品信息改为已申请复检
                sample.setIsRecheck(1);
                updateById(sample);

                // 更新订单费用
                LambdaUpdateWrapper<TbSampling> updateWrapper = new LambdaUpdateWrapper<TbSampling>()
                        .set(TbSampling::getOrderFees, (order.getOrderFees() + recheckFee))
                        .set(TbSampling::getReportTime, null)
                        .set(TbSampling::getOrderStatus, 6)

                        .eq(TbSampling::getId, order.getId());
                tbSamplingService.update(updateWrapper);
            }
        }

        return result;
    }

    @Override
    public List<TbSamplingDetail> queryUnqualifiedFoodNum(Integer orderId) {
        return getBaseMapper().queryUnqualifiedFoodNum(orderId);
    }

    @Override
    public int bulkRecheckSampleCode(List<TbSamplingDetail> list) throws MissSessionExceprtion {
        int result=0;
        TbSamplingDetailCode  samplingDetailCode=null;
        for (TbSamplingDetail detail:list){
            //1.更新检测项目
         TbSamplingDetail samplingDetail= getById(detail.getId());
            samplingDetail.setItemId(detail.getItemId());
            samplingDetail.setItemName(detail.getItemName());
            saveOrUpdate(samplingDetail);
            // 2.首先写入收样和前处理记录表
            samplingDetailCode=tbSamplingDetailCodeService.queryBySamplingDetailId(detail.getId());
            if(samplingDetailCode==null){
                samplingDetailCode = new TbSamplingDetailCode(detail.getId(),detail.getSampleCode(),new Date(),0);
                PublicUtil.setCommonForTable(samplingDetailCode, true);
                tbSamplingDetailCodeService.save(samplingDetailCode);
                result++;
            }
            //2. 更新订单明细表的分拣时间和打印次数
            getBaseMapper().updatePrintNum(samplingDetail.getSamplingId(),detail.getId());
        }

        return result;
    }

}




