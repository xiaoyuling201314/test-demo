package com.dayuan3.api.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.bean.chain.ColdChainUnit;
import com.dayuan3.admin.service.chain.ColdChainUnitService;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramJson;
import com.dayuan3.api.vo.OrderPageRespVo;
import com.dayuan3.api.vo.PageVo;
import com.dayuan3.api.vo.ToSampleCcuRespVo;
import com.dayuan3.api.vo.ToSampleOrderRespVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 取样API
 *
 * @author Dz
 * @version 1.0
 * @date 2025/6/19 14:23
 * @description 类的功能描述
 */
@Slf4j
@Api(tags = "取样")
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/sample")
public class INewSampleController {

    private final TbSamplingService tbSamplingService;
    private final TbSamplingDetailService tbSamplingDetailService;
    private final ColdChainUnitService coldChainUnitService;
    private final DataCheckRecordingService dataCheckRecordingService;
    /**
     * 资源地址
     */
    @Value("${resourcesUrl}")
    private String resourcesUrl;
    /**
     * 文件根目录
     */
    @Value("${resources}")
    private String resources;
    /**
     * 订单附件目录
     */
    @Value("${orderFilePath}")
    private String orderFilePath;

    @ApiOperation("1.待取样冷库汇总")
    @GetMapping("/toSamCcu")
    public MiniProgramJson<List<ToSampleCcuRespVo>> toSampleCcu() {
        // 获取待取样订单(不含个人订单)
        List<TbSampling> orders = tbSamplingService.list(new LambdaQueryWrapper<TbSampling>()
                .eq(TbSampling::getIsSampling, 1)
                .ne(TbSampling::getCcuId, -1)
                .eq(TbSampling::getOrderStatus, 2));
//        orders = tbSamplingService.list();   //测试

        if (orders.isEmpty()) {
            return MiniProgramJson.ok("暂无待取样品！",new ArrayList<>());
        }

        // 获取待取样品
        List<TbSamplingDetail> samples = tbSamplingDetailService.list(new LambdaQueryWrapper<TbSamplingDetail>()
                .in(TbSamplingDetail::getSamplingId, orders.stream().map(TbSampling::getId).collect(Collectors.toList())));
        //按订单ID进行分组统计样品数量
        Map<Integer, Integer> sampleCountMap = samples.stream().collect(Collectors.groupingBy(TbSamplingDetail::getSamplingId, Collectors.summingInt(p -> 1)));

        // 获取冷库信息
        List<ColdChainUnit> ccus = null;
        try {
            List<Integer> ccuIds = orders.stream().map(TbSampling::getCcuId).distinct().collect(Collectors.toList());
            ccus = coldChainUnitService.queryByIds(ccuIds.toArray(new Integer[0]));
        } catch (Exception e) {
            log.error("获取冷库信息失败！", e);
            ccus = new ArrayList<>();
        }

        Map<Integer, ToSampleCcuRespVo> ccuIdMap = new HashMap<>();
        for (TbSampling order : orders) {
            ToSampleCcuRespVo vo = null;
            if (!ccuIdMap.containsKey(order.getCcuId())) {
                vo = new ToSampleCcuRespVo();
                // 冷库信息
                vo.setCcuId(order.getCcuId());
                vo.setCcuName(order.getCcuName());
                ColdChainUnit ccu = ccus.stream().filter(p -> p.getId().equals(order.getCcuId())).findFirst().orElse(null);
                if (ccu != null) {
                    vo.setAddress(ccu.getRegAddress());
                    vo.setLocationXY(StrUtil.isNotBlank(ccu.getPlaceX()) && StrUtil.isNotBlank(ccu.getPlaceY())
                            ? ccu.getPlaceX() + "," + ccu.getPlaceY() : null);
                }
                vo.setOrderQuantity(0);
                vo.setSampleQuantity(0);
            } else {
                vo = ccuIdMap.get(order.getCcuId());
            }
            // 订单数量+1
            vo.setOrderQuantity(vo.getOrderQuantity() + 1);
            // 更新样品数量
            vo.setSampleQuantity(vo.getSampleQuantity() + sampleCountMap.getOrDefault(order.getId(), 0));
            ccuIdMap.put(order.getCcuId(), vo);
        }

        // 转换为VO
        List<ToSampleCcuRespVo> vos = ccuIdMap.values().stream().collect(Collectors.toList());

        // 按冷库待取样品数量倒序排序
        vos = vos.stream().sorted(Comparator.comparing(ToSampleCcuRespVo::getSampleQuantity).reversed()).collect(Collectors.toList());
        return MiniProgramJson.data(vos);
    }


    @GetMapping("/toSamOrder")
    @ApiOperation("2.获取待取样订单列表(至少输入一个参数)")
    @ApiImplicitParams({
            @ApiImplicitParam(name="ccuId", value="冷库ID", required=false, dataType="Integer"),
            @ApiImplicitParam(name="orderNumber", value="订单号", required=false, dataType="String")
    })
    public MiniProgramJson<List<ToSampleOrderRespVo>> toSampleOrder(@RequestParam(value = "ccuId", required = false) Integer ccuId,
                                                                    @RequestParam(value = "orderNumber", required = false) String orderNumber) {
        if (ccuId == null && StrUtil.isBlank(orderNumber)) {
            return MiniProgramJson.error(ErrCode.PARAM_REQUIRED,"至少输入一个必填参数！");
        }

//        // 获取用户信息
//        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");

        // 获取待取样订单
        List<TbSampling> orders = tbSamplingService.list(new LambdaQueryWrapper<TbSampling>()
                .eq(ccuId != null, TbSampling::getCcuId, ccuId)
                .eq(StrUtil.isNotBlank(orderNumber), TbSampling::getOrderNumber, orderNumber)
                .eq(TbSampling::getIsSampling, 1)
                .eq(TbSampling::getOrderStatus, 2));

        // 转换为VO
        List<ToSampleOrderRespVo> respVo = orders.stream().map(order -> {
            return BeanUtil.toBean(order, ToSampleOrderRespVo.class);
        }).collect(Collectors.toList());

        return MiniProgramJson.data(respVo);
    }

    @ApiOperation("3.确认取样")
    @PostMapping("/sampled")
    @ApiImplicitParams({
            @ApiImplicitParam(name="id",value="订单ID",required=true,dataType="Integer"),
            @ApiImplicitParam(name="files",value="取样照片",required=false,dataType="MultipartFile[]")
    })
    public MiniProgramJson<Object> sampled(@RequestParam(value = "id") Integer id,
                                            @RequestParam(value = "files", required = false) MultipartFile[] files) {

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");

        // 获取订单
        TbSampling order = tbSamplingService.getById(id);
        if (order == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND,"找不到订单信息！");
        }
        if (order.getOrderStatus() ==1) {
            return MiniProgramJson.error(ErrCode.NO_PERMISSION,"订单未支付，无法取样！");
        }

        if (order.getIsSampling() == 2) {
            return MiniProgramJson.error(ErrCode.NO_PERMISSION,"订单已取样，请勿重复操作！");
        }

        if (files != null) {
            StringBuilder photos = new StringBuilder();
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    try {
                        // 文件扩展名
                        String extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                        // 新文件名
                        String fileName = IdUtil.fastSimpleUUID() + extName;
                        // 文件目录
                        String filePath = orderFilePath + order.getOrderNumber() + "/";
//                        if (!FileUtil.exist(filePath)) {
//                            FileUtil.mkdir(filePath);
//                        }
                        FileUtil.writeBytes(file.getBytes(), resources + filePath + fileName);
                        photos.append((photos.length() == 0) ? filePath + fileName : "," + filePath + fileName);

                    } catch (Exception e) {
                        log.error("文件上传失败！", e);
                        return MiniProgramJson.error(ErrCode.FILE_UPLOAD_FAILED);
                    }
                }
            }
            order.setSamplingPhotos(photos.toString());
        }
        order.setSamplingUserid(user.getId());
        order.setSamplingUsername(user.getRealName());
        order.setSamplingTime(new Date());
        order.setIsSampling(2);
        tbSamplingService.updateById(order);

        return MiniProgramJson.ok("订单完成取样！", true);
    }

    @GetMapping("/page")
    @ApiOperation("4.已取样订单分页查询")
    @ApiImplicitParams({
            @ApiImplicitParam(name="keywords",value="关键词",required=false,dataType="String"),
            @ApiImplicitParam(name="current",value="页码",required=true,dataType="Long"),
            @ApiImplicitParam(name="size",value="每页显示记录数（默认10）",required=false,dataType="Long")
    })
    public MiniProgramJson<PageVo<OrderPageRespVo>> samplePage(
            @RequestParam(value = "keywords", required = false) String keywords,
            @RequestParam(value = "current", required = true) Long current,
            @RequestParam(value = "size", required = false, defaultValue = "10") Long size) {

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
        // 查询订单条件
        LambdaQueryWrapper<TbSampling> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.like(StrUtil.isNotBlank(keywords), TbSampling::getOrderNumber, keywords)
                .or().like(StrUtil.isNotBlank(keywords),TbSampling::getCcuName, keywords)
                .eq(TbSampling::getIsSampling,2)
                .eq(TbSampling::getSamplingUserid,user.getId())
                .orderByDesc(TbSampling::getSamplingTime);

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
            checkRecords = dataCheckRecordingService.list(new LambdaQueryWrapper<DataCheckRecording>()
                    .eq(DataCheckRecording::getConclusion, "不合格")
                    .in(DataCheckRecording::getSamplingId, samplingPage.getRecords().stream().map(TbSampling::getId).collect(Collectors.toList()))
            );
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
}
