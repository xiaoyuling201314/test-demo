package com.dayuan.service.wx.inspection;

import com.dayuan.bean.wx.inspection.InspectionInformation;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.wx.inspection.InspectionInformationMapper;
import com.dayuan.model.wx.inspection.PointModel;
import com.dayuan.model.wx.inspection.WxDataCheckRecordingModel;
import com.dayuan.model.wx.inspection.WxTbSamplingDetailModel;
import com.dayuan.model.wx.inspection.WxTbSamplingModel;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InspectionInformationService extends BaseService<InspectionInformation, Integer> {
    @Autowired
    private InspectionInformationMapper mapper;

    @Override
    public BaseMapper<InspectionInformation, Integer> getMapper() {
        return mapper;
    }

    /**
     * 查询送检信息
     *
     * @param mobilePhone
     * @param keyword
     * @return
     * @throws Exception
     */
    public List<WxTbSamplingModel> selectInspection(String mobilePhone, String keyword) throws Exception {
        return mapper.selectInspection(mobilePhone, keyword);
    }
    /**
     * 查询送检信息
     *
     * @param mobilePhone
     * @param keyword
     * @param date
     * @return
     * @throws Exception
     */
    public List<WxTbSamplingModel> selectInspection2(String mobilePhone, String keyword,List<Integer> departs,String date) throws Exception {
        return mapper.selectInspection2(mobilePhone, keyword,departs,date);
    }

    /**
     * 根据送检单id查询其抽样信息
     *
     * @param id
     * @return
     * @throws Exception
     */
    public WxTbSamplingModel selectSamplingDetail(Integer id) throws Exception {
        return mapper.selectSamplingDetail(id);
    }

    /**
     * 根据送检单id查询其抽样信息明细
     *
     * @param id
     * @return
     */
    public List<WxTbSamplingDetailModel> selectSamplingDetails(Integer id) {
        return mapper.selectSamplingDetails(id);

    }

    /**
     * 查询检测结果
     *
     * @param mobilePhone 电话号码
     * @param keyword 关键字模糊查询
     * @return
     */
    public List<WxDataCheckRecordingModel> selectInspectionResult(String mobilePhone,  String keyword) {
        return mapper.selectInspectionResult(mobilePhone,  keyword);
    }
    /**
     * 查询检测结果2根据机构id过滤
     *
     * @param mobilePhone 电话号码
     * @param keyword 关键字模糊查询
     * @param departs 子机构数组
     * @param date 时间,用于查询前三个月数据
     * @return
     */
    public List<WxDataCheckRecordingModel> selectInspectionResult2(String mobilePhone,  String keyword,List<Integer> departs,String date) {
        return mapper.selectInspectionResult2(mobilePhone,keyword,departs,date);
    }

    /**
     * 根据检测结果数据id查询其检测结果详情信息(data_check_recording.rid)
     *
     * @param id
     * @return
     */
    public WxDataCheckRecordingModel selectInspectionResultDetail(Integer id) {
        return mapper.selectInspectionResultDetail(id);
    }

    /**
     * 根据机构id查询该机构下的所有子机构
     * @param departId
     * @return
     */
    public List<Integer> selectSonDepartIdById(String departId) {
        return mapper.selectSonDepartIdById(departId);
    }

    /**
     * 查询检测点
     * @param pointType 类型0 为检测点
     * @param departs 机构id
     * @return
     */
    public List<PointModel> selectPointByType(String pointType, List<Integer> departs,String keyword) {
        return mapper.selectPointByType(pointType,departs,keyword);
    }
}
