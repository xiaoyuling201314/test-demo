package com.dayuan.service.sampling;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.sampling.TbSamplingReportPrintLog;


/**
 * @author Dz
 * @description 针对表【tb_sampling_report_printlog(检测报告表)】的数据库操作Service
 * @createDate 2025-06-12 13:28:29
 */
public interface TbSamplingReportPrintLogService extends IService<TbSamplingReportPrintLog> {
    /**
    * @Description 根据抽样单ID查询打印记录
    * @Date 2021/07/16 13:17
    * @Author xiaoyl
    * @Param
    * @return
    */
    public TbSamplingReportPrintLog queryBySamplingId(Integer samplingId);
}
