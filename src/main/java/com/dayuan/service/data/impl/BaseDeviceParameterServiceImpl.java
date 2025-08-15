package com.dayuan.service.data.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDeviceParameter;
import com.dayuan.mapper.data.BaseDeviceParameterMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.BaseDeviceParameterModel;
import com.dayuan.model.data.DeviceParameterExportModel;
import com.dayuan.service.data.BaseDeviceParameterService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Dz
* @description 针对表【base_device_parameter(仪器检测项目表)】的数据库操作Service实现
* @createDate 2025-06-24 12:11:05
*/
@Service
public class BaseDeviceParameterServiceImpl extends ServiceImpl<BaseDeviceParameterMapper, BaseDeviceParameter>
    implements BaseDeviceParameterService {

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
     * 根据仪器系列，检测项目，检测模块查询检测项目信息
     * @param bean
     * @return
     */
    public BaseDeviceParameter queryByUniqueDeviceItem(BaseDeviceParameter bean) throws Exception {
        return getBaseMapper().queryByUniqueDeviceItem(bean);
    }

    /**
     * 根据仪器系列，检测项目查询检测项目信息
     * @return
     */
    public List<BaseDeviceParameter> queryByDeviceItem(String deviceTypeId, String itemId) throws Exception {
        return getBaseMapper().queryByDeviceItem(deviceTypeId, itemId);
    }

    /**
     * 根据检测项目查询检测项目信息(以检测模块、检测方法分组)
     * @return
     */
    public List<BaseDeviceParameter> queryByItemG(String itemId) throws Exception {
        return getBaseMapper().queryByItemG(itemId);
    }

    public List<DeviceParameterExportModel> queryListForExport(BaseDeviceParameterModel model, List<String> listIds) {
        return getBaseMapper().queryListForExport(model, listIds);
    }
}




