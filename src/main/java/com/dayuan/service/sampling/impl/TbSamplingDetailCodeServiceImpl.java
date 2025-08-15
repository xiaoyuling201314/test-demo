package com.dayuan.service.sampling.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.mapper.sampling.TbSamplingDetailCodeMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.sampling.TbSamplingDetailCodeService;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.StringUtil;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
* @author Dz
* @description 针对表【tb_sampling_detail_code(样品明细条形码/二维码)】的数据库操作Service实现
* @createDate 2025-06-24 17:07:00
*/
@Service
public class TbSamplingDetailCodeServiceImpl extends ServiceImpl<TbSamplingDetailCodeMapper, TbSamplingDetailCode>
    implements TbSamplingDetailCodeService {

    @Value("${tubeCodeValidity}")
    private int tubeCodeValidity;


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
     * 数据列表分页方法
     *
     * @param page               分页
     * @param t                  条件参数
     * @param c                  查询方法的类
     * @param loadDatagridMethod 查询列表数据方法
     * @param getRowTotalMethod  查询记录总数方法
     * @return
     * @throws Exception
     */
    public Page loadDatagrid(Page page, BaseModel t, Class c, String loadDatagridMethod, String getRowTotalMethod) throws Exception {
        Object bean = ContextHolderUtils.getBean(c);

        //获取查询列表数据方法
        Method m1 = c.getDeclaredMethod(loadDatagridMethod, Page.class);
        //获取查询记录总数方法
        Method m2 = c.getDeclaredMethod(getRowTotalMethod, Page.class);

        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal((Integer) m2.invoke(bean, page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
        }

        List<T> dataList = (List<T>) m1.invoke(bean, page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 前处理批量更新试管码,清除检测任务被接收仪器信息
     * @param samplingDetailCodes
     * @throws Exception
     */
    public int bulkUpdateTubeCode(List<TbSamplingDetailCode> samplingDetailCodes) throws Exception {
        Date now = new Date();
        int count=0;
        if (null != samplingDetailCodes) {
            for (TbSamplingDetailCode samplingDetailCode : samplingDetailCodes) {
                if (StringUtil.isNotEmpty(samplingDetailCode.getTubeCode1()) && samplingDetailCode.getTubeCodeTime1() == null ){
                    samplingDetailCode.setTubeCodeTime1(now);
                }
                if (StringUtil.isNotEmpty(samplingDetailCode.getTubeCode2()) && samplingDetailCode.getTubeCodeTime2() == null ){
                    samplingDetailCode.setTubeCodeTime2(now);
                }
                samplingDetailCode.setUpdateDate(now);
            }
            count=getBaseMapper().bulkUpdateTubeCode(samplingDetailCodes);
        }
        return count;
    }

    /**
     * 根据样品码查询
     * @param bagCode 样品码
     * @return
     */
    public List<TbSamplingDetailCode> queryByBagCode(String bagCode){
        return getBaseMapper().queryByBagCode(bagCode);
    }

//	/**
//	 * 根据有效试管码查询
//	 * 试管码有效期：扫描后30天内
//	 * @param tubecode 试管码
//	 * @return
//	 */
//    public List<TbSamplingDetailCode> queryByTubeCode(String tubecode) {
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//    	Calendar calendar = Calendar.getInstance();
//		calendar.add(Calendar.DAY_OF_MONTH, -tubeCodeValidity);
//		return getBaseMapper().queryByTubeCode(tubecode, sdf.format(calendar.getTime()));
//    }

    /**
     * 根据抽样单详情id 查询 2019-7-15 huht
     * @param Id
     * @return
     */
    public TbSamplingDetailCode queryBySamplingDetailId(Integer Id) {
        return getBaseMapper().queryBySamplingDetailId(Id);
    }
    /**
     * 根据有效试管码查询
     * 试管码有效期：扫描后30天内
     * @param tubecode 试管码
     * @return
     */
    public List<TbSamplingDetailCode> queryByTubeCode(String tubecode) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, -tubeCodeValidity);
        return getBaseMapper().queryByTubeCode(tubecode, sdf.format(calendar.getTime()));
    }

}




