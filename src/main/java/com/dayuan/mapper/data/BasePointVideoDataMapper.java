package com.dayuan.mapper.data;

import com.dayuan.bean.data.BasePouintVideoData;
import com.dayuan.mapper.BaseMapper;

import java.util.List;

/**
 * Created by shit on 2018/5/10.
 */
public interface BasePointVideoDataMapper extends BaseMapper<BasePouintVideoData, String> {

    int insert(BasePouintVideoData record);

    /**
     * 根据id查询出对应的视屏文件路径
     * @param id
     * @return
     */
    String selectSrcById(Integer id);

    /**
     * 根据id查询视频名称
     * @param id
     * @return
     */
    String selectTitleById(Integer id);
    /**
    * @Description 东营可视化大屏：查询所有的mp4学习视频
    * @Date 2022/09/26 13:52
    * @Author xiaoyl
    * @Param
    * @return
    */
    List<BasePouintVideoData> queryAllStudyVideo();
}
