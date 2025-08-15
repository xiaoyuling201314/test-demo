package com.dayuan.service.data;

import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dayuan.bean.data.BaseDevice;
import com.dayuan.bean.data.BaseDeviceParameter;
import com.dayuan.bean.data.BaseDevicePointRel;
import com.dayuan.bean.data.BaseDevicesItem;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.data.BaseDeviceMapper;
import com.dayuan.mapper.data.BaseDeviceParameterMapper;
import com.dayuan.mapper.data.BaseDevicePointRelMapper;
import com.dayuan.mapper.data.BaseDevicesItemMapper;
import com.dayuan.mapper.data.BasePointMapper;
import com.dayuan.service.BaseService;
import com.dayuan.service.sampling.TbSamplingDetailRecevieService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;

/**
 * @author Dz
 * @description 针对表【base_device(仪器基础表)】的数据库操作Service
 * @createDate 2025-06-22 17:13:41
 */
public interface BaseDeviceService extends IService<BaseDevice> {

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception;

    /**
     * 通过检查点ID、机构ID、仪器类型，查询检查点注册仪器
     */
    public List<BaseDevice> queryAllDeviceByPointId(Integer pointId, Integer departId, String deviceStyle);

//	public BaseDevice queryByDeviceCode(String deviceCode) {
//		return mapper.queryByDeviceCode(deviceCode);
//	}

    /**
     * 新增/编辑仪器
     *
     * @param bean
     * @throws MyException
     * @throws MissSessionExceprtion
     * @author Dz
     */
    public void saveOrUpdateBaseDevice(BaseDevice bean) throws Exception;

    /**
     * @return
     * @Description 新增/编辑仪器：记录仪器在检测点的使用时间和设置仪器检测项目信息
     * @Date 2022/12/28 17:20
     * @Author xiaoyl
     * @Param
     */
    public void saveBaseDevice2AutoRegister(BaseDevice bean, TSUser user) throws Exception;

    /**
     * 根据仪器类型ID查询仪器ID列表信息
     *
     * @param deviceTypeId
     * @return
     */
    public List<String> queryByDeviceType(String deviceTypeId);

    /**
     * 根据仪器唯一标识码查询仪器信息
     *
     * @param serialNumber
     * @return
     */
    public BaseDevice queryBySerialNumber(String serialNumber);

    /**
     * 根据仪器系列、出厂编码获取仪器
     *
     * @param deviceCode
     * @return
     */
    public List<BaseDevice> queryBySeriesAndCode(String deviceSeriesId, String deviceCode);

    /**
     * 解除仪器和 检测点的关系
     *
     * @param deviceId
     * @author LuoYX
     * @date 2018年1月24日
     */
    public void deletePointRel(String deviceId, TSUser user);

    public BaseDevicePointRel selectByDeviceId(String deviceId);

    /**
     * @return
     * @Description 根据仪器出厂编号查询仪器信息
     * @Date 2022/02/11 16:25
     * @Author xiaoyl
     * @Param
     */
    public BaseDevice queryByDeviceCode(String deviceCode);

    /**
    * @Description 根据仪器ID更新仪器的累计上传数量和最后使用时间
    * @Date 2022/12/30 11:07
    * @Author xiaoyl
    * @Param
    * @return
    */
    public int updateDeviceUsage(String deviceId);

}
