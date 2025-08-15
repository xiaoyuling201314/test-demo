package com.dayuan.mapper.dataCheck;

import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.dataCheck.DataUnqualifiedRecording;
import com.dayuan.bean.dataCheck.DataUnqualifiedRecordingDepart;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface DataUnqualifiedRecordingMapper extends BaseMapper<DataUnqualifiedRecording, Integer> {

    DataUnqualifiedRecording queryByRid(@Param("rid") Integer rid);

    /**
     * 查询待发送短信的不合格数据
     *
     * @return
     */
    List<DataUnqualifiedRecordingDepart> querySmsToniceData();

    Integer deleteCheckRecording(@Param("rid") Integer rid);


    /**
     * 查询检测历史记录
     *
     * @param page
     * @return
     */
    List<DataCheckRecording> loadDatagridHistory(Page page);

    /**
     * 查询检测历史记录
     *
     * @param page
     * @return
     */
    int getRowTotalHistory(Page page);

    /**
    * @Description 查询2小时内的检测不合格的数据，用于发送微信通知
    * @Date 2022/08/25 13:53
    * @Author xiaoyl
    * @Param
    * @return
    */
    List<DataUnqualifiedRecording> wxQueryUnqualData2Msg();
    /**
    * @Description 根据机构ID和黑名单查询需要发送通知的所有上级用户openID
    * @Date 2022/08/25 14:29
    * @Author xiaoyl
    * @Param
    * @return
    */
    List<Map<String, String>> queryOpenIdByDepartID(@Param("departId")Integer departId, @Param("blacklist")String[] blacklist);
}