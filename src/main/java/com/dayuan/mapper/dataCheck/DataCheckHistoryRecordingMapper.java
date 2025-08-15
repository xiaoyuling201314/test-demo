package com.dayuan.mapper.dataCheck;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.dataCheck.DataCheckHistoryRecording;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * @author Dz
 * @description 针对表【data_check_history_recording(检测数据历史表)】的数据库操作Mapper
 * @createDate 2025-06-30 11:39:52
 * @Entity DataCheckHistoryRecording
 */
public interface DataCheckHistoryRecordingMapper extends BaseMapper<DataCheckHistoryRecording> {

    /**
     * 查询分页数据列表
     * @param page
     * @return
     */
    List<BaseDetectItem> loadDatagrid(Page page);

    /**
     * 查询记录总数量
     * @param page
     * @return
     */
    int getRowTotal(Page page);

    /**
     * 根据检测数据ID去查询检测历史数据
     * @param rid
     * @return
     */
    List<DataCheckHistoryRecording> selectCheckHistoryByRid(Integer rid);

    DataCheckHistoryRecording selectCheckHistory(@Param("rid") Integer rid, @Param("checkRecordingId") String checkRecordingId, @Param("checkDate") String checkDate, @Param("checkResult") String checkResult, @Param("conclusion") String conclusion);
}