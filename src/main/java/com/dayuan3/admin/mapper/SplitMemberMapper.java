package com.dayuan3.admin.mapper;

import com.dayuan.bean.Page;
import com.dayuan3.admin.bean.SplitMember;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.poi.ss.formula.functions.T;

import java.util.List;

/**
 * <p>
 * 分账子商户编号管理 Mapper 接口
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-21
 */
@Mapper
public interface SplitMemberMapper extends BaseMapper<SplitMember> {

    int getRowTotal(Page page);

    List<SplitMember> loadDatagrid(Page page);
}
