package com.dayuan.bean.data;

import com.dayuan.bean.BaseBean;
/**
 * 检测项目类型Bean base_item_type
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月9日
 */
public class BaseItemType extends BaseBean {

    private String itemName;  //类型名称

    private Short sorting;  //排序

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName == null ? null : itemName.trim();
    }

    public Short getSorting() {
        return sorting;
    }

    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }

}