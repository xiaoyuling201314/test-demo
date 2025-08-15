package com.dayuan3.api.controller;

import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dayuan.bean.data.BaseDevice;
import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.service.data.BaseDeviceService;
import com.dayuan.service.data.BaseDeviceTypeService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.system.TSUserService;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MiniProgramJson;
import com.dayuan3.api.vo.DeviceRegisterReqVO;
import com.dayuan3.api.vo.DeviceRegisterRespVO;
import com.dayuan3.api.vo.DeviceLoginReqVO;
import com.dayuan3.api.vo.DeviceLoginRespVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.Date;
import java.util.List;

/**
 * 检测设备用户API
 *
 * @author Dz
 * @version 1.0
 * @date 2025/6/21 14:33
 * @description 类的功能描述
 */
@Slf4j
@Api(tags = "设备授权认证（仪器专用）")
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/deviceAuth")
public class IDeviceAuthController {

    private final TSUserService tsUserService;
    private final TSDepartService departService;
    private final BasePointService basePointService;
    private final BaseDeviceService baseDeviceService;
    private final BaseDeviceTypeService baseDeviceTypeService;

    @ApiOperation("1.设备登录")
    @PostMapping("/login")
    public MiniProgramJson<DeviceLoginRespVo> create(@Valid @RequestBody DeviceLoginReqVO reqVO) {

        // 获取用户信息
        TSUser user = tsUserService.getOne(new LambdaQueryWrapper<TSUser>().eq(TSUser::getUserName, reqVO.getUsername()));

        // 用户不存在或密码错误
        if (user == null || !user.getPassword().equals(DigestUtil.md5Hex(reqVO.getPassword()).toUpperCase())) {
            return MiniProgramJson.error(ErrCode.LOGIN_FAILED);
        } else if (user.getStatus() != 0) {
            return MiniProgramJson.error(ErrCode.NO_PERMISSION, "该账号已停用");
        } else if (user.getPointId() == null) {
            return MiniProgramJson.error(ErrCode.NO_PERMISSION, "该账号未绑定检测点");
        }

        String departName = "";
        try {
            TSDepart depart = departService.getById(user.getDepartId());
            if (depart != null) {
                user.setDepartName(depart.getDepartName());
                departName = depart.getDepartName();
            }
        } catch (Exception e) {
            log.error("获取机构信息失败", e);
        }

        String pointName = "";
        try {
            BasePoint point = basePointService.queryById(user.getPointId());
            if (point != null) {
                user.setPointName(point.getPointName());
                pointName = point.getPointName();
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("获取检测点信息失败", e);
        }

        // 第1步，先登录上
        StpUtil.login("DU_" + user.getId(), "DEVICE");
        StpUtil.getTokenSession().set("device-user", user);

        // 第2步，获取 Token相关参数
        SaTokenInfo tokenInfo = StpUtil.getTokenInfo();

        DeviceLoginRespVo respVo = new DeviceLoginRespVo(tokenInfo.tokenValue,  user.getRealname(), departName, pointName);
        return MiniProgramJson.ok("登录成功", respVo);
    }

    @ApiOperation("2.设备注册")
    @PostMapping("/register")
    public MiniProgramJson<DeviceRegisterRespVO> register(@Valid @RequestBody DeviceRegisterReqVO reqVO) {
        // 获取用户信息
        TSUser user = (TSUser) StpUtil.getTokenSession().get("device-user");

        if (user == null || user.getPointId() == null) {
            return MiniProgramJson.error(ErrCode.NO_PERMISSION, "仅限检测账号允许注册设备！");
        }

        // 获取系列信息
        BaseDeviceType deviceType = baseDeviceTypeService.queryDeviceBySeries(reqVO.getSeries());
        if (deviceType == null) {
            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "找不到该系列仪器，请确认仪器系列编号！");
        }

        // 获取设备信息，判断是否已注册
        BaseDevice device = baseDeviceService.getOne(new LambdaQueryWrapper<BaseDevice>()
                .eq(BaseDevice::getPointId, user.getPointId())
                .eq(BaseDevice::getDeviceTypeId, deviceType.getId())
                .eq(BaseDevice::getMacAddress, reqVO.getMac()));
        // 设备未注册
        if (device == null) {
            // 获取检测点下空余设备记录
            List<BaseDevice> list = baseDeviceService.list(new LambdaQueryWrapper<BaseDevice>()
                    .eq(BaseDevice::getPointId, user.getPointId())
                    .eq(BaseDevice::getDeviceTypeId, deviceType.getId())
                    .isNull(BaseDevice::getSerialNumber));
            if (list != null && !list.isEmpty()) {
                // 取第一条记录
                device = list.get(0);
            } else {
                // 新增记录
                device = new BaseDevice();
            }
        }
        if (StrUtil.isBlank(device.getSerialNumber())) {
            // 获取注册时间
            Date registerDate = new Date();
            // 生成仪器唯一编号:仪器类型_yyyyMMddHHmmss + 4位随机数
            String serialNumber = deviceType.getDeviceSeries() + "_" + DateUtil.format(registerDate, "yyyyMMddHHmmss") + RandomUtil.randomNumbers(4);

            if (StrUtil.isBlank(device.getId())) {
                device.setId(IdUtil.fastSimpleUUID());
            }

            device.setDeviceTypeId(deviceType.getId());
            device.setSerialNumber(serialNumber);
            device.setMacAddress(reqVO.getMac());
            device.setDepartId(user.getDepartId());
            device.setPointId(user.getPointId());
            device.setRegisterDate(registerDate);

            device.setDeviceCode(reqVO.getDeviceCode());
            device.setDeviceName(deviceType.getDeviceName());
            device.setDeviceStyle("仪器设备");
            device.setStatus(0);
            device.setDeleteFlag(0);
            baseDeviceService.saveOrUpdate(device);
        }

        // 返回结果
        DeviceRegisterRespVO respVo = BeanUtil.toBean(device, DeviceRegisterRespVO.class);
        return MiniProgramJson.ok("仪器注册成功", respVo);
    }

    @ApiOperation("3.设备退出")
    @PostMapping("/logout")
    public MiniProgramJson<Object> logout() {
        StpUtil.logout();
        return MiniProgramJson.ok("退出成功", null);
    }

}
