package com.dayuan3.api.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseDevice;
import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.bean.system.TSUser;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.data.BaseDeviceService;
import com.dayuan.service.data.BaseDeviceTypeService;
import com.dayuan.service.sampling.TbSamplingDetailCodeService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramException;
import com.dayuan3.api.common.MiniProgramJson;
import com.dayuan3.api.vo.check.CheckTaskRespVO;
import com.dayuan3.api.vo.check.RejectTaskReqVO;
import com.dayuan3.api.vo.check.SaveCheckDataDTO;
import com.dayuan3.api.vo.check.UploadCheckDataReqVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Arrays;
import java.util.Date;

/**
 * 检测相关API
 *
 * @author Dz
 * @version 1.0
 * @date 2025/6/24 16:19
 * @description 类的功能描述
 */
@Slf4j
@Api(tags = "检测相关（仪器专用）")
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/check")
public class INewCheckController {

    private final BaseDeviceService baseDeviceService;
    private final BaseDeviceTypeService baseDeviceTypeService;
    private final TbSamplingService tbSamplingService;
    private final TbSamplingDetailService tbSamplingDetailService;
    private final TbSamplingDetailCodeService tbSamplingDetailCodeService;
    private final DataCheckRecordingService dataCheckRecordingService;
    private final BaseDetectItemService detectItemService;

    @ApiOperation("1.获取检测任务")
    @GetMapping("/getTask")
    @ApiImplicitParams({
            @ApiImplicitParam(name="tubeCode",value="试管码",required=true,dataType="String",example = "B1327"),
            @ApiImplicitParam(name="serialNumber",value="仪器唯一标识",required=true,dataType="String",example = "DY-3500(I)_202506241311520219")
    })
    public MiniProgramJson<CheckTaskRespVO> getTask(@RequestParam(value = "tubeCode") String tubeCode,
                                                    @RequestParam(value = "serialNumber") String serialNumber) {

        // 获取用户信息
        TSUser user = (TSUser) StpUtil.getTokenSession().get("device-user");
        BaseDevice device = baseDeviceService.getOne(new LambdaQueryWrapper<BaseDevice>()
                .eq(BaseDevice::getSerialNumber, serialNumber));
        if (device == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该编号仪器");
        } else if (device.getStatus() != 0){
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL, "该编号仪器已停用");
        } else if (user.getPointId() == null || user.getPointId().intValue() != device.getPointId()){
            return MiniProgramJson.error(ErrCode.NO_PERMISSION, "账号权限不足，无法使用此仪器");
        }

        // 获取试管信息
        TbSamplingDetailCode samplingDetailCode = tbSamplingDetailCodeService.getOne(new LambdaQueryWrapper<TbSamplingDetailCode>()
            .eq(TbSamplingDetailCode::getTubeCode1, tubeCode)
            .or().eq(TbSamplingDetailCode::getTubeCode2, tubeCode));

        if (samplingDetailCode == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该试管检测任务");
        }

        // 获取检测任务信息
        TbSamplingDetail samplingDetail = tbSamplingDetailService.getById(samplingDetailCode.getSamplingDetailId());

        if (samplingDetail == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该试管检测任务");

        } else if (samplingDetail.getRecevieStatus() == 2) {
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL, "该试管检测任务已完成");
        } else if (samplingDetail.getRecevieStatus() == 1 && !samplingDetail.getRecevieDevice().equals(serialNumber)) {
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL, "该试管检测任务已被其他设备接收");

        } else if (samplingDetail.getRecevieStatus() == 0) {
            // 接收任务并更新相关信息
            // 更新检测明细任务状态-已接收
            samplingDetail.setRecevieStatus(1);
            samplingDetail.setRecevieDevice(serialNumber);
            samplingDetail.setOperatingTime(new Date());
            tbSamplingDetailService.updateById(samplingDetail);

            TbSampling sampling = tbSamplingService.getById(samplingDetail.getSamplingId());
            // 更新主订单信息，检测任务状态不在检测中或复检中，更新为检测中
            if (sampling != null && Arrays.asList(5,6).contains(sampling.getOrderStatus())) {
                sampling.setOrderStatus(5);
                tbSamplingService.updateById(sampling);
            }
        }
        // 未接收任务 或 接收任务的同一台设备可重复获取任务信息
        // 封装返回数据
        CheckTaskRespVO respVo = BeanUtil.toBean(samplingDetail, CheckTaskRespVO.class);
        //add by xiaoyl 2025/07/02 根据检测项目查询检测标准和限定值
        BaseDetectItem detectItem=detectItemService.queryItemById(samplingDetail.getItemId());
        if(detectItem!=null){
            respVo.setCheckAccord(detectItem.getStdCode());
            respVo.setLimitValue(detectItem.getDetectSign()+detectItem.getDetectValue());
            respVo.setCheckUnit(detectItem.getDetectValueUnit());
        }
        return MiniProgramJson.data(respVo);
    }

    @ApiOperation("2.拒绝检测任务")
    @PostMapping("/rejectTask")
    public MiniProgramJson rejectTask(@Valid @RequestBody RejectTaskReqVO reqVO) {
        // 获取用户信息
        TSUser user = (TSUser) StpUtil.getTokenSession().get("device-user");
        BaseDevice device = baseDeviceService.getOne(new LambdaQueryWrapper<BaseDevice>()
                .eq(BaseDevice::getSerialNumber, reqVO.getSerialNumber()));
        if (device == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该编号仪器");
        } else if (user.getPointId() == null || user.getPointId().intValue() != device.getPointId()){
            return MiniProgramJson.error(ErrCode.NO_PERMISSION, "账号权限不足，无法使用此仪器");
        }

        TbSamplingDetail samplingDetail = tbSamplingDetailService.getById(reqVO.getId());
        if (samplingDetail == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该检测任务");
        } else if (!reqVO.getSerialNumber().equals(samplingDetail.getRecevieDevice())) {
            return MiniProgramJson.error(ErrCode.NO_PERMISSION, "该任务已由其他设备接收");
        } else if (samplingDetail.getRecevieStatus() == 2) {
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL, "该任务已完成检测");
        }

        // 更新检测任务状态-未接收
        samplingDetail.setRecevieStatus(0);
        samplingDetail.setRecevieDevice("");
        tbSamplingDetailService.updateById(samplingDetail);

        // 返回结果
        return MiniProgramJson.ok("任务已拒收");
    }

    @ApiOperation("3.上传检测数据")
    @PostMapping("/uploadData")
    public MiniProgramJson uploadData(@Valid @RequestBody UploadCheckDataReqVO reqVO) throws Exception {
        // 获取用户信息
        TSUser user = (TSUser) StpUtil.getTokenSession().get("device-user");

        BaseDevice device = baseDeviceService.getOne(new LambdaQueryWrapper<BaseDevice>()
                .eq(BaseDevice::getSerialNumber, reqVO.getSerialNumber()));
        if (device == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该编号仪器");
        } else if (device.getStatus() != 0){
            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL, "该编号仪器已停用");
        } else if (user.getPointId() == null || user.getPointId().intValue() != device.getPointId()){
            return MiniProgramJson.error(ErrCode.NO_PERMISSION, "账号权限不足，无法使用此仪器");
        }

        // 转换保存检测数据对象
        SaveCheckDataDTO dto = BeanUtil.toBean(reqVO, SaveCheckDataDTO.class);
        dto.setCheckUserid(user.getId());
        dto.setCheckUsername(user.getRealname());
        dto.setDeviceId(device.getId());
        dto.setDeviceName(device.getDeviceName());
        try {
            BaseDeviceType deviceType = baseDeviceTypeService.queryById(device.getDeviceTypeId());
            if (deviceType != null) {
                dto.setDeviceCompany(deviceType.getDeviceMaker());
            }
        } catch (Exception e) {
            log.error("获取设备类型信息失败", e);
        }
        // 保存检测数据
        dataCheckRecordingService.saveCheckData(dto);
        return MiniProgramJson.ok("上传成功", null);
    }

}
