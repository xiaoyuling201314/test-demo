package com.dayuan.service.data.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.*;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.data.*;
import com.dayuan.model.BaseModel;
import com.dayuan.service.data.BaseDeviceService;
import com.dayuan.service.sampling.TbSamplingDetailRecevieService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
* @author Dz
* @description 针对表【base_device(仪器基础表)】的数据库操作Service实现
* @createDate 2025-06-22 17:13:41
*/
@Service
@RequiredArgsConstructor
public class BaseDeviceServiceImpl extends ServiceImpl<BaseDeviceMapper, BaseDevice>
    implements BaseDeviceService {

    @Autowired
    private BaseDevicesItemMapper itemMapper;
    @Autowired
    private BaseDeviceParameterMapper parameterMapper;
    @Autowired
    private BaseDevicePointRelMapper devicePointRelMapper;
    @Autowired
    private BasePointMapper pointMapper;

    private final TbSamplingDetailService samplingDetailService;
    private final TbSamplingDetailRecevieService samplingDetailRecevieService;


    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
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

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 通过检查点ID、机构ID、仪器类型，查询检查点注册仪器
     */
    public List<BaseDevice> queryAllDeviceByPointId(Integer pointId, Integer departId, String deviceStyle) {
        return getBaseMapper().queryAllDeviceByPointId(pointId, departId, deviceStyle);
    }

//	public BaseDevice queryByDeviceCode(String deviceCode) {
//		return getBaseMapper().queryByDeviceCode(deviceCode);
//	}

    /**
     * 新增/编辑仪器
     *
     * @param bean
     * @throws MyException
     * @throws MissSessionExceprtion
     * @author Dz
     */
    public void saveOrUpdateBaseDevice(BaseDevice bean) throws Exception {
        BasePoint point = pointMapper.selectByPrimaryKey(bean.getPointId());

        if (StringUtil.isEmpty(bean.getId())) {
            if ("检测箱".equals(bean.getDeviceStyle())) {
                //新增检测箱
                bean.setId(UUIDGenerator.generate());
                PublicUtil.setCommonForTable(bean, true);
                this.save(bean);
            } else {
                //新增仪器
                bean.setDepartId(point == null ? null : point.getDepartId());
                bean.setDeleteFlag(0);

                //查询仪器是否存在
                List<BaseDevice> devices = this.queryBySeriesAndCode(bean.getDeviceTypeId(), bean.getDeviceCode());
                if (devices != null && devices.size() > 0) {
                    for (BaseDevice device : devices) {
                        if (null == device.getPointId()) {
                            bean.setId(device.getId());
                            bean.setCreateBy(device.getCreateBy());
                            bean.setCreateDate(device.getCreateDate());
                            PublicUtil.setCommonForTable(bean, false);
                            this.updateById(bean);
                            break;
                        }
                    }

                    if (null == bean.getId()) {
                        bean.setId(UUIDGenerator.generate());
                        bean.setYunId(devices.get(0).getYunId());
                        PublicUtil.setCommonForTable(bean, true);
                        this.save(bean);
                    }

                } else {
                    bean.setId(UUIDGenerator.generate());
                    PublicUtil.setCommonForTable(bean, true);
                    this.save(bean);
                }
            }
            if (point == null) {
                return;
            }


            //一期功能-检测点仪器，新增仪器同时新增/更新中间表记录
            BaseDevicePointRel devicePointRel = devicePointRelMapper.selectByDeviceId(bean.getId());
            if (devicePointRel == null) {
                //检测点仪器关联表
                devicePointRel = new BaseDevicePointRel();
                devicePointRel.setDeviceId(bean.getId());
                devicePointRel.setPointId(point == null ? null : point.getId());
                devicePointRel.setDepartId(point == null ? null : point.getDepartId());
                devicePointRel.setDeleteFlag((short) 0);
                devicePointRel.setStartDate(new Date());
                PublicUtil.setCommonForTable(devicePointRel, true);
                devicePointRelMapper.insertSelective(devicePointRel);
            } else {
                devicePointRel.setPointId(point == null ? null : point.getId());
                devicePointRel.setDepartId(point == null ? null : point.getDepartId());
                devicePointRel.setDeleteFlag((short) 0);
                PublicUtil.setCommonForTable(devicePointRel, false);
                devicePointRelMapper.updateByPrimaryKeySelective(devicePointRel);
            }

            //设置仪器检测项目信息
            List<BaseDeviceParameter> list = parameterMapper.queryByDeviceTypeId(bean.getDeviceTypeId());
            BaseDevicesItem bdi = null;
            if (list != null && list.size() > 0) {
                for (BaseDeviceParameter parameter : list) {
                    bdi = new BaseDevicesItem();
                    bdi.setId(UUIDGenerator.generate());
                    bdi.setDeviceId(bean.getId());
                    bdi.setDeviceParameterId(parameter.getId());
                    bdi.setPriority((short) 0);
                    bdi.setChecked((short) 1);
                    PublicUtil.setCommonForTable(bdi, true);
                    itemMapper.insert(bdi);
                }
            }


            //更新仪器
        } else {

            //获取旧数据
            BaseDevice oldDevice = getBaseMapper().selectById(bean.getId());
            if (oldDevice != null) {

                //更新仪器出厂编码
                if (StringUtil.isNotEmpty(oldDevice.getDeviceCode()) && !oldDevice.getDeviceCode().equals(bean.getDeviceCode())) {
                    //查询仪器是否存在
                    List<BaseDevice> devices = this.queryBySeriesAndCode(bean.getDeviceTypeId(), bean.getDeviceCode());
                    if (devices != null && devices.size() > 0) {
                        bean.setYunId(devices.get(0).getYunId());
                    } else {
                        bean.setYunId(null);
                    }
                }

                //停用仪器
                if (oldDevice.getStatus() != bean.getStatus() && 1 == bean.getStatus()) {
                    //清空抽样明细(未检测)中的仪器唯一标识
                    samplingDetailService.cleanSerialNumber(bean.getSerialNumber());
                    //清空仪器检测任务的中间表
                    samplingDetailRecevieService.deleteBySerialNumber(bean.getSerialNumber());
                }

                //更新仪器类型
                if (StringUtil.isNotEmpty(oldDevice.getDeviceTypeId()) && !oldDevice.getDeviceTypeId().equals(bean.getDeviceTypeId())) {
                    //查询仪器是否存在
                    List<BaseDevice> devices = this.queryBySeriesAndCode(bean.getDeviceTypeId(), bean.getDeviceCode());
                    if (devices != null && devices.size() > 0) {
                        bean.setYunId(devices.get(0).getYunId());
                    } else {
                        bean.setYunId(null);
                    }

                    //删除仪器检测项目
                    itemMapper.deleteByDeviceId(bean.getId());

                    //设置仪器检测项目信息
                    List<BaseDeviceParameter> list = parameterMapper.queryByDeviceTypeId(bean.getDeviceTypeId());
                    BaseDevicesItem bdi = null;
                    if (list != null && list.size() > 0) {
                        for (BaseDeviceParameter parameter : list) {
                            bdi = new BaseDevicesItem();
                            bdi.setId(UUIDGenerator.generate());
                            bdi.setDeviceId(bean.getId());
                            bdi.setDeviceParameterId(parameter.getId());
                            bdi.setPriority((short) 0);
                            bdi.setChecked((short) 1);
                            PublicUtil.setCommonForTable(bdi, true);
                            itemMapper.insert(bdi);
                        }
                    }
                }

                //二期功能-摊销设置，更新仪器同时新增/更新中间表记录
                BaseDevicePointRel devicePointRel = devicePointRelMapper.selectByDeviceId(bean.getId());
                if (devicePointRel == null) {
                    //检测点仪器关联表
                    devicePointRel = new BaseDevicePointRel();
                    devicePointRel.setDeviceId(bean.getId());
                    devicePointRel.setPointId(point == null ? null : point.getId());
                    devicePointRel.setDepartId(point == null ? null : point.getDepartId());
                    devicePointRel.setDeleteFlag((short) 0);
                    devicePointRel.setStartDate(new Date());
                    PublicUtil.setCommonForTable(devicePointRel, true);
                    devicePointRelMapper.insertSelective(devicePointRel);
                } else {
                    devicePointRel.setPointId(point == null ? null : point.getId());
                    devicePointRel.setDepartId(point == null ? null : point.getDepartId());
                    devicePointRel.setDeleteFlag((short) 0);
                    PublicUtil.setCommonForTable(devicePointRel, false);
                    devicePointRelMapper.updateByPrimaryKeySelective(devicePointRel);
                }

                bean.setDepartId(point == null ? null : point.getDepartId());
                PublicUtil.setCommonForTable(bean, false);
                getBaseMapper().updateById(bean);

                //仪器解绑
                if (StringUtil.isNotEmpty(oldDevice.getSerialNumber()) && StringUtil.isEmpty(bean.getSerialNumber())) {
                    //解绑后清空任务
                    //清空抽样明细(未检测)中的仪器唯一标识
                    samplingDetailService.cleanSerialNumber(oldDevice.getSerialNumber());
                    //清空仪器检测任务的中间表
                    samplingDetailRecevieService.deleteBySerialNumber(oldDevice.getSerialNumber());

                    //解绑后转发任务
//					List<TbSamplingDetail> details = samplingDetailService.queryUncheckSamplingDetail(oldDevice.getSerialNumber());
//					for (TbSamplingDetail detail : details) {
//						samplingDetailRecevieService.updateStatus(PublicUtil.getSessionUser(), detail.getId(), oldDevice.getSerialNumber(), (short) 2, true);
//					}
                }

            } else {
                throw new MyException("操作失败，仪器不存在！");
            }
        }
    }

    /**
     * @return
     * @Description 新增/编辑仪器：记录仪器在检测点的使用时间和设置仪器检测项目信息
     * @Date 2022/12/28 17:20
     * @Author xiaoyl
     * @Param
     */
    public void saveBaseDevice2AutoRegister(BaseDevice bean, TSUser user) throws Exception {
        BasePoint point = pointMapper.selectByPrimaryKey(bean.getPointId());
        if (point == null) {
            return;
        }
        //新增仪器
        bean.setDeleteFlag(0);
        //查询仪器是否存在
        List<BaseDevice> devices = this.queryBySeriesAndCode(bean.getDeviceTypeId(), bean.getDeviceCode());
        if (devices != null && devices.size() > 0) {
            for (BaseDevice device : devices) {
                if (null == device.getPointId()) {
                    bean.setId(device.getId());
                    bean.setCreateBy(device.getCreateBy());
                    bean.setCreateDate(device.getCreateDate());
                    PublicUtil.setCommonForTable(bean, false, user);
                    this.updateById(bean);
                    break;
                }
            }

            if (null == bean.getId()) {
                bean.setId(UUIDGenerator.generate());
                bean.setYunId(devices.get(0).getYunId());
                PublicUtil.setCommonForTable(bean, true, user);
                this.save(bean);
            }
        } else {
            bean.setId(UUIDGenerator.generate());
            PublicUtil.setCommonForTable(bean, true, user);
            this.save(bean);
        }

        //一期功能-检测点仪器，新增仪器同时新增/更新中间表记录
        BaseDevicePointRel devicePointRel = devicePointRelMapper.selectByDeviceId(bean.getId());
        if (devicePointRel == null) {
            //检测点仪器关联表
            devicePointRel = new BaseDevicePointRel();
            devicePointRel.setDeviceId(bean.getId());
            devicePointRel.setPointId(point == null ? null : point.getId());
            devicePointRel.setDepartId(point == null ? null : point.getDepartId());
            devicePointRel.setDeleteFlag((short) 0);
            devicePointRel.setStartDate(new Date());
            PublicUtil.setCommonForTable(devicePointRel, true, user);
            devicePointRelMapper.insertSelective(devicePointRel);
        } else {
            devicePointRel.setPointId(point == null ? null : point.getId());
            devicePointRel.setDepartId(point == null ? null : point.getDepartId());
            devicePointRel.setDeleteFlag((short) 0);
            PublicUtil.setCommonForTable(devicePointRel, false, user);
            devicePointRelMapper.updateByPrimaryKeySelective(devicePointRel);
        }

        //设置仪器检测项目信息
        List<BaseDeviceParameter> list = parameterMapper.queryByDeviceTypeId(bean.getDeviceTypeId());
        BaseDevicesItem bdi = null;
        if (list != null && list.size() > 0) {
            for (BaseDeviceParameter parameter : list) {
                bdi = new BaseDevicesItem();
                bdi.setId(UUIDGenerator.generate());
                bdi.setDeviceId(bean.getId());
                bdi.setDeviceParameterId(parameter.getId());
                bdi.setPriority((short) 0);
                bdi.setChecked((short) 1);
                PublicUtil.setCommonForTable(bdi, true, user);
                itemMapper.insert(bdi);
            }
        }
    }

    /**
     * 根据仪器类型ID查询仪器ID列表信息
     *
     * @param deviceTypeId
     * @return
     */
    public List<String> queryByDeviceType(String deviceTypeId) {
        return getBaseMapper().queryByDeviceType(deviceTypeId);
    }

    /**
     * 根据仪器唯一标识码查询仪器信息
     *
     * @param serialNumber
     * @return
     */
    public BaseDevice queryBySerialNumber(String serialNumber) {
        return getBaseMapper().queryBySerialNumber(serialNumber);
    }

    /**
     * 根据仪器系列、出厂编码获取仪器
     *
     * @param deviceCode
     * @return
     */
    public List<BaseDevice> queryBySeriesAndCode(String deviceSeriesId, String deviceCode) {
        return getBaseMapper().queryBySeriesAndCode(deviceSeriesId, deviceCode);
    }

    /**
     * 解除仪器和 检测点的关系
     *
     * @param deviceId
     * @author LuoYX
     * @date 2018年1月24日
     */
    public void deletePointRel(String deviceId, TSUser user) {
        Date now = new Date();
        BaseDevice device = getBaseMapper().selectById(deviceId);
        if (null != device) {
            device.setDepartId(null);
            device.setPointId(null);
            device.setUpdateBy(user.getId());
            getBaseMapper().updateById(device);

            BaseDevicePointRel rel = devicePointRelMapper.selectByDeviceId(deviceId);
            if (null != rel) {
                rel.setUpdateBy(user.getId());
                rel.setEndDate(now);
                rel.setUpdateDate(now);
                rel.setDeleteFlag((short) 1);
                devicePointRelMapper.updateByPrimaryKey(rel);
            }
        }
    }

    public BaseDevicePointRel selectByDeviceId(String deviceId) {
        return devicePointRelMapper.selectByDeviceId(deviceId);
    }

    /**
     * @return
     * @Description 根据仪器出厂编号查询仪器信息
     * @Date 2022/02/11 16:25
     * @Author xiaoyl
     * @Param
     */
    public BaseDevice queryByDeviceCode(String deviceCode) {
        return getBaseMapper().queryByDeviceCode(deviceCode);
    }
    /**
     * @Description 根据仪器ID更新仪器的累计上传数量和最后使用时间
     * @Date 2022/12/30 11:07
     * @Author xiaoyl
     * @Param
     * @return
     */
    public int updateDeviceUsage(String deviceId) {
        int count = 0;
        if(StringUtil.isNotEmpty(deviceId)){
            BaseDevice device = getBaseMapper().selectById(deviceId);
            if(null!=device){
                device.setUploadNumbers(device.getUploadNumbers() + 1);
                device.setLastUploadDate(new Date());
                count=getBaseMapper().updateById(device);
            }
        }
        return count;
    }

}




