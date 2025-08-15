package com.dayuan.mapper.wx.inspection;

import com.dayuan.bean.wx.inspection.InspectionInformation;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.wx.inspection.PointModel;
import com.dayuan.model.wx.inspection.WxDataCheckRecordingModel;
import com.dayuan.model.wx.inspection.WxTbSamplingDetailModel;
import com.dayuan.model.wx.inspection.WxTbSamplingModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 查看你送我检信息的用户Mapper
 * Created by dy on 2018/8/3.
 */
public interface InspectionInformationMapper extends BaseMapper<InspectionInformation, Integer> {

    /**
     * 查询送检信息
     *
     * @param mobilePhone
     * @param date
     * @return
     */
    List<WxTbSamplingModel> selectInspection(@Param("mobilePhone") String mobilePhone,  @Param("keyword") String date);
    /**
     * 查询送检信息
     *
     * @param mobilePhone
     * @param keyword
     * @param date
     * @return
     */
    List<WxTbSamplingModel> selectInspection2(@Param("mobilePhone") String mobilePhone, @Param("keyword") String keyword, @Param("departs") List<Integer> departs, @Param("date") String date);

    /**
     * 根据送检单id查询其抽样信息
     *
     * @param id
     * @return
     */
    WxTbSamplingModel selectSamplingDetail(Integer id);

    /**
     * 根据送检单id查询其抽样信息明细
     *
     * @param id
     * @return
     */
    List<WxTbSamplingDetailModel> selectSamplingDetails(Integer id);

    /**
     * 查询检测结果
     *
     * @param mobilePhone 电话号码
     * @param keyword 关键字模糊查询
     * @return
     */
    List<WxDataCheckRecordingModel> selectInspectionResult(@Param("mobilePhone") String mobilePhone,  @Param("keyword") String keyword);
    /**
     * 查询检测结果2根据机构id过滤
     *
     * @param mobilePhone 电话号码
     * @param keyword 关键字模糊查询
     * @param departs 子机构数组
     * @param date 字符串时间,用于查询前三个月数据
     * @return
     */
    List<WxDataCheckRecordingModel> selectInspectionResult2(@Param("mobilePhone") String mobilePhone, @Param("keyword") String keyword, @Param("departs") List<Integer> departs, @Param("date") String date);

    /**
     * 根据检测结果数据id查询其检测结果详情信息(data_check_recording.rid)
     *
     * @param id
     * @return
     */
    WxDataCheckRecordingModel selectInspectionResultDetail(Integer id);

    /**
     * 根据机构id查询该机构下的所有子机构
     *
     * @param departId
     * @return
     */
    List<Integer> selectSonDepartIdById(String departId);

    /**
     * 查询该数组机构下所有检测点
     * @param pointType 类型0 为检测点
     * @param departs 机构id
     * @return
     */
    List<PointModel> selectPointByType(@Param("pointType") String pointType, @Param("departs") List<Integer> departs, @Param("keyword") String keyword);
}
