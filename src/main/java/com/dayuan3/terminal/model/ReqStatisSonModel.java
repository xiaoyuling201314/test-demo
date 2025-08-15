package com.dayuan3.terminal.model;

/**
 * 委托单位统计Model
 *
 * @author shit
 * @date 2020-04-02
 */
public class ReqStatisSonModel{
    private Integer id;         //抽检单明细表ID
    private String conclusion;  //检测结果
    private Integer conclusion2; //检测结果 0：不合格 1：合格 2：未出结果

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getConclusion() {
        return conclusion;
    }

    public void setConclusion(String conclusion) {
        this.conclusion = conclusion;
    }

    public Integer getConclusion2() {
        return conclusion2;
    }

    public void setConclusion2(Integer conclusion2) {
        this.conclusion2 = conclusion2;
    }
}