package com.dayuan3.terminal.model;

import com.dayuan.model.BaseModel;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 委托单位统计Model
 *
 * @author shit
 * @date 2020-04-02
 */
public class ReqStatisModel extends BaseModel implements Comparable<ReqStatisModel> {

    private Integer id;             //委托单位ID
    private String reqName;         //委托单位名称
    private String departName;      //所属机构名称
    private Integer checkNum;       //已检测量
    private Integer checkNumDaily;  //日检测量
    private Integer checkNum2;      //已检测量（根据reqSSmList集合的个数求得）
    private Integer planCheckNum;   //计划检测量
    private Integer unqualifiedNum; //不合格数量
    private Integer unqualifiedNum2;//不合格数量（根据reqSSmList集合的个数求得）
    private Integer unitType;       //单位类型1:餐饮 2:学校 3:食堂 4:供应商 9:其他
    private String unitTypeName;    //单位类型名称

    private List<ReqStatisSonModel> reqSSmList = new ArrayList<>();  //检测结果

    //===========其他字段==================
    private Double checkRate;//检测率

    private Double passRate;//合格率

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getReqName() {
        return reqName;
    }

    public void setReqName(String reqName) {
        this.reqName = reqName;
    }

    public Integer getCheckNum() {
        return checkNum;
    }

    public void setCheckNum(Integer checkNum) {
        this.checkNum = checkNum;
    }

    public Integer getUnitType() {
        return unitType;
    }

    public void setUnitType(Integer unitType) {
        this.unitType = unitType;
    }

    public List<ReqStatisSonModel> getReqSSmList() {
        return reqSSmList;
    }

    public void setReqSSmList(List<ReqStatisSonModel> reqSSmList) {
        this.reqSSmList = reqSSmList;
    }

    public Integer getPlanCheckNum() {
        return planCheckNum;
    }

    public void setPlanCheckNum(Integer planCheckNum) {
        this.planCheckNum = planCheckNum;
    }

    public Integer getUnqualifiedNum() {
        return unqualifiedNum;
    }

    public void setUnqualifiedNum(Integer unqualifiedNum) {
        this.unqualifiedNum = unqualifiedNum;
    }

    public Integer getCheckNum2() {
        return reqSSmList.size();
    }

    public void setCheckNum2(Integer checkNum2) {
        this.checkNum2 = checkNum2;
    }

    public Integer getUnqualifiedNum2() {
        Integer unqualifiedNum2 = 0;
        if (reqSSmList.size() > 0) {
            for (ReqStatisSonModel rm : reqSSmList) {
                if (rm.getConclusion2() == 0) {
                    unqualifiedNum2++;
                }
            }
            return unqualifiedNum2;
        } else {
            return unqualifiedNum2;
        }
    }

    public void setUnqualifiedNum2(Integer unqualifiedNum2) {
        this.unqualifiedNum2 = unqualifiedNum2;
    }

    public Double getCheckRate() {
        if (this.planCheckNum == 0 && this.checkNum == 0) {
            return 0.00;
        } else {
            Integer checkNumberDaily = this.planCheckNum == 0 ? 1 : this.planCheckNum;
            return new BigDecimal("" + ((this.checkNum * 1.00) / (checkNumberDaily * 1.00) * 100)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }
    }

    public void setCheckRate(Double checkRate) {
        this.checkRate = checkRate;
    }

    public Double getPassRate() {
        if (this.unqualifiedNum == 0 && this.checkNum == 0) {
            return null;
        } else {
            Integer passNum = this.unqualifiedNum == 0 ? this.checkNum : this.checkNum - this.unqualifiedNum;
            return new BigDecimal("" + ((passNum * 1.00) / (this.checkNum * 1.00) * 100)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }
    }

    public void setPassRate(Double passRate) {
        this.passRate = passRate;
    }


    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public Integer getCheckNumDaily() {
        return checkNumDaily;
    }

    public void setCheckNumDaily(Integer checkNumDaily) {
        this.checkNumDaily = checkNumDaily;
    }

    public String getUnitTypeName() {
        return unitTypeName;
    }

    public void setUnitTypeName(String unitTypeName) {
        this.unitTypeName = unitTypeName;
    }

    //========================================排序=======================================

    @Override
    public int compareTo(ReqStatisModel rsm) {
        Integer checkNum1 = this.getCheckNum();
        Integer checkNum2 = rsm.getCheckNum();
        boolean null1 = checkNum1 == null;
        boolean null2 = checkNum2 == null;

        boolean allNull = null1 && null2;
        if (allNull) {
            return 0;
        }

        if (null2) {
            return -1;
        }

        if (null1) {
            return 1;
        }

        return checkNum2.compareTo(checkNum1);

       /* if(this.getCheckNum().equals(rsm.getCheckNum())){
            return 0;
        }else if (this.getCheckNum() > rsm.getCheckNum()) {//按照检测数量排序，谁大就排前面
            return -1;
        } else {
            return 1;
        }*/

        /*if (checkNum1 != null && checkNum2 != null) {
            return checkNum1.compareTo(checkNum2);
        } else {
            return checkNum1 == null ? 1 : -1;
        }*/
    }

   /* public static void main(String[] args) {
        ReqStatisModel r1 = new ReqStatisModel();
        r1.setCheckNum(1);
        ReqStatisModel r2 = new ReqStatisModel();
        r2.setCheckNum(1);
        ReqStatisModel r3 = new ReqStatisModel();
        r3.setCheckNum(null);
        ReqStatisModel r4 = new ReqStatisModel();
        r4.setCheckNum(4);
        ReqStatisModel r5 = new ReqStatisModel();
        r5.setCheckNum(5);
        ReqStatisModel r6 = new ReqStatisModel();
        r6.setCheckNum(null);
        ReqStatisModel r7 = new ReqStatisModel();
        r7.setCheckNum(7);
        ReqStatisModel r8 = new ReqStatisModel();
        r8.setCheckNum(8);

        List<ReqStatisModel> list = new ArrayList<>();
        list.add(r1);
        list.add(r2);
        list.add(r3);
        list.add(r4);
        list.add(r5);
        list.add(r6);
        list.add(r7);
        list.add(r8);
        Collections.sort(list);
        System.out.println(list);


    }

    @Override
    public String toString() {
        return "ReqStatisModel{" + "checkNum=" + checkNum + '}';
    }*/
}