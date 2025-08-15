package com.dayuan.service.sampling.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.sampling.TbSamplingReportPrintLog;
import com.dayuan.mapper.sampling.TbSamplingReportPrintLogMapper;
import com.dayuan.service.sampling.TbSamplingReportPrintLogService;
import org.springframework.stereotype.Service;

/**
* @author Dz
* @description 针对表【tb_sampling_report_printlog(检测报告表)】的数据库操作Service实现
* @createDate 2025-06-12 13:28:29
*/
@Service
public class TbSamplingReportPrintlogServiceImpl extends ServiceImpl<TbSamplingReportPrintLogMapper, TbSamplingReportPrintLog>
    implements TbSamplingReportPrintLogService {

    /**
     * @Description 根据抽样单ID查询打印记录
     * @return
     */
    public TbSamplingReportPrintLog queryBySamplingId(Integer samplingId) {
        TbSamplingReportPrintLog reportPrintLog = lambdaQuery()
                .eq(TbSamplingReportPrintLog::getSamplingId, samplingId)
                .one();
        return reportPrintLog;
    }

}




