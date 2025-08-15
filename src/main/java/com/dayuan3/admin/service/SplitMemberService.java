package com.dayuan3.admin.service;

import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import com.dayuan3.admin.bean.SplitMember;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 分账子商户编号管理 服务类
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-21
 */
public interface SplitMemberService extends IService<SplitMember> {
    /**
     * Description 查询所有子商户编号信息
     * @Author xiaoyl
     * @Date 2025/7/21 10:22
     */
    List<SplitMember> querySplitMember();

    int mySaveOrUpdate(SplitMember bean);

    SplitMember getByMbUserId(String mbUserId);

    boolean deleteData(String id, Integer[] idas);

    Page loadDatagrid(Page page, BaseModel model);
}
