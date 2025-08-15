package com.dayuan.service.data;

import com.dayuan.service.BaseService;
import com.dayuan.bean.data.BasePouintVideoData;
import com.dayuan.mapper.data.BasePointVideoDataMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by shit on 2018/5/10.
 */
@Service
public class BasePointVideoDataService extends BaseService<BasePouintVideoData, String> {

    @Autowired
    private BasePointVideoDataMapper videoDataMapper;

    public BasePointVideoDataMapper getMapper() {
        return videoDataMapper;
    }

    public String selectSrcById(Integer id) throws Exception {
        return videoDataMapper.selectSrcById(id);
    }

    public String selectTitleById(Integer id)throws Exception {
        return videoDataMapper.selectTitleById(id);
    }
    /**
    * @Description 东营可视化大屏：查询所有的mp4学习视频
    * @Date 2022/09/26 13:47
    * @Author xiaoyl
    * @Param
    * @return
    */
    public List<BasePouintVideoData> queryAllStudyVideo() {
        return videoDataMapper.queryAllStudyVideo();
    }
}
