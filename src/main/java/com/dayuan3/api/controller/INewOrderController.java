package com.dayuan3.api.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.common.PublicUtil;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.pdf.ReportData;
import com.dayuan.util.pdf.ReportPdfUtil;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramJson;
import com.dayuan3.api.vo.*;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.service.IncomeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 自助下单API
 *
 * @author Dz
 * @version 1.0
 * @date 2025/6/11 14:23
 * @description 类的功能描述
 */
@Slf4j
@Api(tags = "自助下单")
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/order")
public class INewOrderController {

    private final TbSamplingService tbSamplingService;
    private final TbSamplingDetailService tbSamplingDetailService;
    private final DataCheckRecordingService dataCheckRecordingService;
    private final IncomeService incomeService;

    @Value("${resources}")
    private String resources;
//    @Value("${resourcesUrl}")
//    private String resourcesUrl;
    @Value("${wxSystemUrl}")
    private String systemUrl;
    @Value("${reportDirPath}")
    private String reportDirPath;

    @ApiOperation("1.校验订单号")
    @ApiImplicitParam(name="orderNumber",value="订单号(格式：A+反写年份后两位+8位数字，例:A5200000001)",required=false,dataType="String",example = "A5200000001")
    @GetMapping("/check/{orderNumber}")
    public MiniProgramJson<Boolean> checkOrderNumber(@PathVariable("orderNumber") String orderNumber) {
        Boolean isValid = tbSamplingService.checkOrderNumber(orderNumber);
        if (!isValid) {
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL,"订单号无效或已占用", isValid);
        } else {
            return MiniProgramJson.ok("订单号有效", isValid);
        }
    }

    @ApiOperation("2.新增订单")
    @PostMapping("/create")
    public MiniProgramJson<CreateOrderRespVo> create(@Valid @RequestBody CreateOrderReqVO reqVO) throws Exception{

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");

        // 订单信息
        TbSampling sampling = new TbSampling();
        BeanUtil.copyProperties(reqVO, sampling);
        // 订单详情
        List<TbSamplingDetail> details = new ArrayList<>();
        reqVO.getOrderItems().forEach(orderItem -> {
            TbSamplingDetail detail = new TbSamplingDetail();
            BeanUtil.copyProperties(orderItem, detail);
            if (orderItem.getPurchaseQuantity() != null) {
                detail.setPurchaseAmount((int) (orderItem.getPurchaseQuantity()*1000));
            }
            details.add(detail);
        });

        if (1 == user.getType()) {
            // 电子抽样
            sampling.setOrderType(2);

        } else {
            // 自助下单
            sampling.setOrderType(1);
        }

        // 下单人
        sampling.setOrderUserid(user.getId());
        sampling.setOrderUsername(user.getRealName());
        sampling.setOrderUserPhone(user.getPhone());
        PublicUtil.setCommonForTable1(sampling,true,user);
        //创建订单
        int orderId = tbSamplingService.createOrder(sampling, details);
        if (orderId != 0) {
            CreateOrderRespVo respVo = new CreateOrderRespVo(orderId);
            return MiniProgramJson.ok("下单成功", respVo);
        } else {
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL,"下单失败，无效订单号。", null);
        }
    }

    @ApiOperation("3.取消订单")
    @PostMapping("/cancel")
    public MiniProgramJson<Boolean> cancel(@Valid @RequestBody CancelOrderReqVO reqVO) {

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
        // 获取订单
        TbSampling order = tbSamplingService.getById(reqVO.getId());
        if (order == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND,"找不到订单信息！");
        }
        //  禁止其他用户操作订单
        if (!order.getOrderUserid().equals(user.getId())) {
            return MiniProgramJson.error(ErrCode.NO_PERMISSION,"无权取消订单！");
        }
        switch (order.getOrderStatus()) {
            case 1:
                // 待支付，允许取消。订单取消后支付成功，由支付接口恢复订单状态。
                order.setOrderStatus(4);
                tbSamplingService.updateById(order);
                return MiniProgramJson.ok("订单已取消！",true);

            case 2:
                // 支付成功，不允许取消
                return MiniProgramJson.error(ErrCode.NO_PERMISSION,"订单已支付，无法取消，请联系管理员！",false);
            case 3:
                // 订单完成
                return MiniProgramJson.error(ErrCode.NO_PERMISSION,"订单已完成，无法取消！",false);
            case 4:
                // 取消订单
                return MiniProgramJson.ok("订单已取消！", true);
            default:
                return MiniProgramJson.error(ErrCode.DATA_ABNORMAL,"订单状态异常！",false);
        }
    }

    @GetMapping("/page")
    @ApiOperation("9.分页查询订单")
    @ApiImplicitParams({
            @ApiImplicitParam(name="keywords",value="关键词",required=false,dataType="String"),
            @ApiImplicitParam(name="phone",value="手机号",required=false,dataType="String"),
            @ApiImplicitParam(name="done",value="订单状态,默认:0(0:全部,1:已完成,-1:未完成)",required=false,dataType="Long"),
            @ApiImplicitParam(name="current",value="页码",required=true,dataType="Long"),
            @ApiImplicitParam(name="size",value="每页显示记录数（默认10）",required=false,dataType="Long")
    })
    public MiniProgramJson<PageVo<OrderPageRespVo>> orderPage(
            @RequestParam(value = "keywords", required = false) String keywords,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam(value = "done", required = false, defaultValue = "0") Long done,
            @RequestParam(value = "current", required = true) Long current,
            @RequestParam(value = "size", required = false, defaultValue = "10") Long size) {

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");

        // 查询订单条件
        LambdaQueryWrapper<TbSampling> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.like(StrUtil.isNotBlank(keywords), TbSampling::getOrderNumber, keywords)
                .eq(StrUtil.isNotBlank(phone),TbSampling::getOrderUserPhone, phone)

                //订单状态:1_待支付,2_已支付,3_已完成,4_取消,5_检测中,6_复检中
                // 完成
                .eq(done==1, TbSampling::getOrderStatus, 3)
                // 未完成
                .in(done==-1, TbSampling::getOrderStatus, 2,5,6)
                // 隐藏其他状态
                .ne(TbSampling::getOrderStatus, 1)
                .ne(TbSampling::getOrderStatus, 4)

                // 普通用户显示当前经营单位的订单
                .eq(user.getType() == 0, TbSampling::getIuId, user.getInspectionId())
                //抽样人员，显示自己抽的订单
                .eq(user.getType() == 1, TbSampling::getOrderUserid, user.getId())
                .orderByDesc(TbSampling::getOrderTime);

        Page<TbSampling> samplingPage = tbSamplingService.page(Page.of(current, size), queryWrapper);

        // 查询订单详情
        List<TbSamplingDetail> details;
        // 查询订单不合格检测数据
        List<DataCheckRecording> checkRecords;
        if (!samplingPage.getRecords().isEmpty()) {
            details = tbSamplingDetailService.list(new LambdaQueryWrapper<TbSamplingDetail>()
                    // 不计算已申请复检项目
                    .eq(TbSamplingDetail::getIsRecheck, 0)
                    .in(TbSamplingDetail::getSamplingId, samplingPage.getRecords().stream().map(TbSampling::getId).collect(Collectors.toList()))
            );
            if (!details.isEmpty()) {
                checkRecords = dataCheckRecordingService.list(new LambdaQueryWrapper<DataCheckRecording>()
                        .eq(DataCheckRecording::getConclusion, "不合格")
                        .in(DataCheckRecording::getSamplingDetailId, details.stream().map(TbSamplingDetail::getId).collect(Collectors.toList()))
                );
            } else {
                checkRecords = new ArrayList<>();
            }

        } else {
            details = new ArrayList<>();
            checkRecords = new ArrayList<>();
        }

        // 转换数据
        PageVo<OrderPageRespVo> pageVo = new PageVo<>();
        BeanUtil.copyProperties(samplingPage, pageVo);
        pageVo.setRecords(samplingPage.getRecords().stream().map(sampling -> {
            OrderPageRespVo dataVo = new OrderPageRespVo();
            BeanUtil.copyProperties(sampling, dataVo);

            List<TbSamplingDetail> orderDetails = details.stream()
                    .filter(detail -> detail.getSamplingId().equals(sampling.getId()))
                    .collect(Collectors.toList());
            // 不合格数量
            dataVo.setUnqualifiedCount((int) checkRecords.stream().filter(checkRecord -> sampling.getId().equals(checkRecord.getSamplingId())).count());
            // 已检测量
            dataVo.setCheckCount((int) orderDetails.stream().filter(detail -> 2 == detail.getRecevieStatus()).count());
            // 检测总数
            dataVo.setCheckTotal(orderDetails.size());
            return dataVo;
        }).collect(Collectors.toList()));

        return MiniProgramJson.data(pageVo);
    }


    @GetMapping("/get")
    @ApiOperation("10.查询订单详情(至少输入一个参数)")
    @ApiImplicitParams({
            @ApiImplicitParam(name="orderId", value="订单ID", required=false, dataType="Integer"),
            @ApiImplicitParam(name="orderNumber", value="订单号", required=false, dataType="String"),
            @ApiImplicitParam(name="queryType", value="查询类型:(0： 普通查询，1：取样查询)", required=false, dataType="Integer")
    })
    public MiniProgramJson<OrderInfoRespVo> get(HttpServletRequest request,
        @RequestParam(value = "orderId", required = false) Integer orderId,
        @RequestParam(value = "orderNumber", required = false) String orderNumber,
        @RequestParam(value = "queryType", required = false,defaultValue = "0") Integer queryType) {

        if (orderId == null && StrUtil.isBlank(orderNumber)) {
            return MiniProgramJson.error(ErrCode.PARAM_REQUIRED,"至少输入一个必填参数！");
        }

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");

        // 获取订单
        TbSampling order = tbSamplingService.getOne(new LambdaQueryWrapper<TbSampling>()
                .eq(orderId != null, TbSampling::getId, orderId)
                .eq(StrUtil.isNotBlank(orderNumber), TbSampling::getOrderNumber, orderNumber)
                .ne(TbSampling::getOrderStatus, 4)
                .ne(queryType==1,TbSampling::getOrderStatus, 1)
                // 普通用户仅显示当前用户订单
                .eq(user.getType() == 0,TbSampling::getOrderUserid, user.getId()));
        if (order == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND,"找不到订单信息！");
        }

        // 取样图片地址
        if(StrUtil.isNotBlank(order.getSamplingPhotos())) {
            String resourcesUrl = systemUrl + "resources/";
            String[] photos = order.getSamplingPhotos().split(",");
            StringBuffer photosUrl = new StringBuffer();
            for (String photo : photos) {
                photosUrl.append(resourcesUrl).append(photo).append(",");
            }
            order.setSamplingPhotos(photosUrl.substring(0, photosUrl.length() - 1));
        }

        // 获取订单详情
        List<TbSamplingDetail> details = tbSamplingDetailService.list(new LambdaQueryWrapper<TbSamplingDetail>()
                .eq(TbSamplingDetail::getSamplingId, order.getId())
                // 隐藏复检项目原来记录
                .eq(TbSamplingDetail::getIsRecheck, 0)
                .orderByAsc(TbSamplingDetail::getSampleCode));

        // 获取检测结果
        List<DataCheckRecording> checkRecords;
        if (!details.isEmpty()) {
            checkRecords = dataCheckRecordingService.list(new LambdaQueryWrapper<DataCheckRecording>()
                    .in(DataCheckRecording::getSamplingDetailId, details.stream().map(TbSamplingDetail::getId).collect(Collectors.toList())));
        } else {
            checkRecords = new ArrayList<>();
        }
        //add by xiaoyl 2025/07/10 获取交易流水号
        String payNumber=incomeService.queryBySamplingId(order.getId());
        // 转换为VO
        OrderInfoRespVo respVo = BeanUtil.toBean(order, OrderInfoRespVo.class);
        respVo.setOrderDetails(details.stream().map(detail -> {
            OrderInfoRespVo.OrderDetail orderDetail = BeanUtil.toBean(detail, OrderInfoRespVo.OrderDetail.class);
            DataCheckRecording checkRecord0 = checkRecords.stream().filter(checkRecord -> checkRecord.getSamplingDetailId().equals(detail.getId())).findFirst().orElse( null);
            orderDetail.setConclusion(checkRecord0==null?"":checkRecord0.getConclusion());
            return orderDetail;
        }).collect(Collectors.toList()));
        respVo.setPayNumber(payNumber);
        return MiniProgramJson.data(respVo);
    }


    @GetMapping("/getReport/{orderNumber}/{ct}/{df}")
    @ApiOperation("11.获取（已完成）订单电子报告（无需登录）")
    @ApiImplicitParams({
        @ApiImplicitParam(name="orderNumber", value="订单号", required=true, dataType="String", example = "A5220000001"),
        @ApiImplicitParam(name="ct", value="密文（MD5加密去除首字母的单号）", required=true, dataType="String", example = "80f9b681ca9a728d202b32e0f958be35"),
        @ApiImplicitParam(name="df", value="返回数据格式（json|pdf）", required=true, dataType="String", example = "json")
    })
    public MiniProgramJson getReport(HttpServletRequest request, HttpServletResponse response,
        @PathVariable("orderNumber") String orderNumber, @PathVariable("ct") String ct, @PathVariable("df") String df) throws Exception {
        // 密文
        String ct0 = DigestUtil.md5Hex(orderNumber.substring(1));
//        log.info("ct:"+ct0);

        // 获取系统资源文件网络地址
        String path = request.getContextPath();
        String systemUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
        String resourcesUrl = systemUrl + "resources/";

        // 校验参数
        if (!ct.equals(ct0)) {
            return MiniProgramJson.error(ErrCode.PARAM_ILLEGAL, "非法参数");
        }

        // 获取订单
        TbSampling order = tbSamplingService.getOne(new LambdaQueryWrapper<TbSampling>()
                .eq(TbSampling::getOrderNumber, orderNumber)
                .eq(TbSampling::getOrderStatus, 3));
        if (order == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND,"找不到报告信息！");
        }

        // 首次生成报告，设置报告时间
        if (order.getReportTime() == null) {
            // 设置报告时间
            order.setReportTime(new Date());
        }

        // 报告文件相对路径   例：report/202501/A5200000001_123721.pdf
        String reportFilePath = reportDirPath +
                DateUtil.format(order.getSamplingTime(), "yyyyMM") + "/" +
                order.getOrderNumber() + "_" + DateUtil.format(order.getReportTime(),"HHmmss") + ".pdf";

        // 查询报告pdf文件
        if (!FileUtil.exist(resources + reportFilePath)) {
            // 文件不存在，生成pdf文件
            // 获取订单详情(过滤已复检数据)
            List<TbSamplingDetail> orderDetails = tbSamplingDetailService.list(new LambdaQueryWrapper<TbSamplingDetail>()
                    .eq(TbSamplingDetail::getSamplingId, order.getId())
                    .eq(TbSamplingDetail::getIsRecheck, 0)
                    .orderByAsc(TbSamplingDetail::getSampleCode));

            //update by xiaoyl 2025/07/22 提取非复检详情的ID列表,用于查询对应的检测数据，修复复检合格后无法查看检测报告问题
            List<Integer> detailIds = orderDetails.stream()
                    .map(TbSamplingDetail::getId)
                    .collect(Collectors.toList());

            List<DataCheckRecording> checkRecords = dataCheckRecordingService.list(new LambdaQueryWrapper<DataCheckRecording>()
//                    .eq(DataCheckRecording::getSamplingId, order.getId())
                    .in(DataCheckRecording::getSamplingDetailId,detailIds)
            );

            // 判断是否有不合格项目，检测出阳性样品，不出报告
            if (checkRecords.stream().anyMatch(checkRecord -> "不合格".equals(checkRecord.getConclusion()))) {
                return MiniProgramJson.error(ErrCode.POSITIVE_REPORT);
            }

            // 转换为VO
            List<ReportData.Detail> reportDetails = new ArrayList<>();
            orderDetails.stream().forEach(detail -> {
                DataCheckRecording checkRecord0 = checkRecords.stream().filter(checkRecord -> checkRecord.getSamplingDetailId().equals(detail.getId())).findFirst().orElse( null);
                reportDetails.add(new ReportData.Detail(detail.getFoodName(), detail.getItemName(), checkRecord0==null?"":checkRecord0.getConclusion()));
            });

            // 二维码地址
            String qrCode = systemUrl + "api/order/getReport/" + orderNumber + "/" + ct + "/pdf";
            //如果是个人订单：报告中冷冻仓号为“”
            String iuName=order.getCcuId()==-1 ? "" : order.getIuName();
            ReportData reportData = new ReportData(order.getOrderNumber(), order.getSamplingTime(),
                    order.getCcuName(), iuName, order.getOrderUserPhone(), order.getCarNumber(),
                    qrCode, reportDetails, order.getReportTime());
            ReportPdfUtil.generate(reportData, resources + reportFilePath);

            // 更新报告时间
            tbSamplingService.updateById(order);
        }

        // 报告文件网络地址
        String reportUrl = resourcesUrl + reportFilePath;
        if ("pdf".equals(df)) {
            // 执行重定向，跳转到文件地址
            response.sendRedirect(reportUrl);
        }

        return MiniProgramJson.data(reportUrl);
    }

}
