package com.dayuan.mapper.data;

import com.dayuan.bean.data.TbFile;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 附件Mapper
 *
 * @author Dz
 * @Description:
 * @Company:
 * @date 2017年12月15日
 */
public interface TbFileMapper extends BaseMapper<TbFile, Integer> {
    int insert(TbFile record);

    List<TbFile> queryBySource(@Param("sourceId") Integer sourceId, @Param("sourceType") String sourceType);

    /**
     * 根据路径查询文件真实名称
     * @param path
     * @return
     */
    String selectNameByPath(@Param("path") String path);
}