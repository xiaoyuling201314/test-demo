package com.dayuan3.admin.service;

import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.service.BaseService;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.bean.InspectionUserRelation;
import com.dayuan3.admin.mapper.InspectionUnitMapper;
import com.dayuan3.admin.mapper.InspectionUserRelationMapper;
import com.dayuan3.api.vo.InspectionUnitUserReqVo;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.terminal.bean.InspectionUserLog;
import com.dayuan3.admin.mapper.InspectionUnitUserMapper;
import com.dayuan3.admin.model.InspectionUnitUserModel;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Service
public class InspectionUnitUserService extends BaseService<InspectionUnitUser, Integer> {

    @Autowired
    private InspectionUnitUserMapper mapper;

    @Autowired
    private InspectionUnitService unitService;

    @Autowired
    private InspectionUserAccountService accountService;

    public InspectionUnitUserMapper getMapper() {
        return mapper;
    }

    /**
     * @param user
     * @return
     * @description 自助终端用户登录
     * @author xiaoyl
     * @date 2019年7月2日
     */
    public InspectionUnitUser queryUser(InspectionUnitUser user) {
        return mapper.queryUser(user);
    }

    /**
     * 根据送检单位查询用户ID集合
     *
     * @param inspectionId
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月3日
     */
    public List<InspectionUnitUser> queryUserByInspectId(Integer inspectionId, Integer rowStart, Integer rowEnd) {
        return mapper.queryUserByInspectId(inspectionId, rowStart, rowEnd);
    }

    /**
     * 校验联系人手机号码是否重复
     *
     * @param linkPhone
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月23日
     */
    public InspectionUnitUser queryByPhone(String linkPhone) {
        return mapper.queryByPhone(linkPhone);
    }

    /**
     * 获取下个用户号
     *
     * @return
     */
    public String getNextAccount() {
        String maxAccount = mapper.getMaxAccount();
        if (StringUtil.isEmpty(maxAccount)) {
            return "10001";
        } else {
            Integer int_maxAccount = Integer.parseInt(maxAccount);
            return (int_maxAccount + 1) + "";
        }
    }


    /**
     * 查询账号密码是否存在 2019-7 -25 huht
     *
     * @param userName 账号
     * @param password 密码
     * @param openId openid
     * @return
     */
    public InspectionUnitUser selectByUserName(String userName, String password, String openId) {

        return mapper.selectByUserName(userName, password, openId);
    }

    /**
     * 查询小程序账号密码是否存在 2020-3 -17 huht
     *
     * @param userName
     * @param password
     * @param openId
     * @param miniOpenId
     * @return
     */
    public InspectionUnitUser selectByUserName2(String userName, String password, String openId, String miniOpenId) {

        return mapper.selectByUserName2(userName, password, openId, miniOpenId);
    }

    /**
     * 2019-7-30 huht 添加分页参数
     * 根据送检单位查询用户数量
     *
     * @param inspectionId
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月29日
     */
    public int queryCountByInspectId(Integer inspectionId) {
        return mapper.queryCountByInspectId(inspectionId);
    }

    /**
     * 管理权限转移
     * huht 2019-8-31
     *
     * @param inspectionId 送检单位id
     * @param id           获取管理员权限的用户id
     */
    public void changeManage(@Param("inspectionId") Integer inspectionId, @Param("id") Integer id) {
        mapper.changeManage(inspectionId, id);
    }

    ;

    /**
     * 查询刚注册未审核数量（审核时间为空）
     *
     * @param inspectionId
     * @return
     */
    public int selectUnResCount(Integer inspectionId) {
        return mapper.selectUnResCount(inspectionId);
    }

    ;

    /**
     * 根据登录账号去查询送检用户
     *
     * @param userName
     * @return
     */
    public InspectionUnitUser selectByUsername(String userName) {
        return mapper.selectByUsername(userName);
    }

    /**
     * 根据手机号码去查询送检用户
     *
     * @param phone
     * @return
     */
    public InspectionUnitUser selectByPhone(String phone) {
        return mapper.selectByPhone(phone);
    }

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagridAll(Page page, InspectionUnitUserModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);
        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(mapper.getRowTotalAll(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
        }
        List<InspectionUnitUserModel> dataList = mapper.loadDatagridAll(page);
        page.setResults(dataList);
        return page;
    }

    public void delOpenid(InspectionUnitUser iuu) {
        mapper.delOpenid(iuu);
    }

    /**
     * 重置送检账号支付密码
     *
     * @param iuu
     */
    public void resetpwd(InspectionUnitUser iuu) {
        mapper.resetpwd(iuu);
    }

    public int selcetNumber(Integer id, String identifiedNumber) {
        return mapper.selcetNumber(id, identifiedNumber);
    }

    public InspectionUnitUser queryByUserId(Integer userId) {
        return mapper.queryByUserId(userId);
    }

    /**
     * 送检用户停用或者启用用户方法
     *
     * @param stopId
     * @param checked
     */
    public void stop(Integer stopId, Short checked, String updateBy, Date now) {
        mapper.stop(stopId, checked, updateBy, now);
    }

    /**
     * 保存操作日志
     *
     * @param bean
     */
    public void insertOperationLog(InspectionUnitUser bean, Short result, Short type, Logger log) {
        try {
            InspectionUserLog iulog = new InspectionUserLog();
            iulog.setCreateBy(bean.getUpdateBy());
            iulog.setCreateDate(bean.getUpdateDate());
            if (type != null) {
                iulog.setType(type);
            } else {
                if (bean.getId() == null) {
                    iulog.setType(new Short("0"));
                } else {
                    iulog.setType(new Short("1"));
                }
            }
            iulog.setResult(result);
            if (bean != null) {
                iulog.setDescription(JSONObject.toJSONString(bean));
            }
            mapper.insertInsUserLog(iulog);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("送检用户日志保存失败******************************" + e.getMessage() + e.getStackTrace());
        }
    }
    /**
     * Description 微信公众号用户登录
     * @Author xiaoyl
     * @Date 2025/6/11 17:23
     */
    public InspectionUnitUser queryUserLogin(String openid, String phone, String password) {
        if (StringUtil.isEmpty(openid) && StringUtil.isEmpty(phone)) {
            return null;
        }
        return mapper.queryUserLogin(openid, phone, password);
    }
    /**
     * Description 用户信息注册与修改
     * @Author xiaoyl
     * @Date 2025/6/12 16:23
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public InspectionUnitUser saveOrUpdateUser(InspectionUnitUserReqVo bean,String openId, MultipartFile[] files,Integer saveType) throws Exception {
        String filePath = WebConstant.res.getString("filePath") + "inspUnit/";
        boolean isCreate = bean.getId() == null;
        //1.文件处理
        String reportImage = "";
        if (null != files && files.length > 0) {
            for (MultipartFile file : files) {
                if (file.getSize() > 0) {
                    String fileName = filePath+getFileName(file);
                    saveFile(file,fileName);
                    reportImage += (fileName+ ",");
                }
            }
        }
        String totalFileUrl = StringUtil.handleComma(reportImage);
        if(bean.getCompanyType()==1){
            bean.setCompanyCode(bean.getCompanyName());
        }
        //2.写入经营单位
        InspectionUnit unit=new InspectionUnit(bean.getColdUnitId(),bean.getCompanyName(),bean.getCompanyCode(),bean.getCompanyType(),bean.getCreditCode(),bean.getLegalPerson(),bean.getLegalPhone());
        unit.setId(bean.getInspectionId());
        if(StringUtil.isNotEmpty(totalFileUrl)){
            unit.setFilePath(totalFileUrl);
        }
        unitService.saveOrUpdate(unit);
        //3.新增或编辑用户
        InspectionUnitUser  user = new InspectionUnitUser();
        BeanUtil.copyProperties(bean,user);
        user.setSourceType((short) 1);
        user.setChecked((short)1);
        String password = bean.getPassword();
        if(saveType==0){
            user.setType(1);//用户类型： 0 普通用户,1 抽样人员,2 监管方,4财务统计
            if (password.length() == 32) {
                user.setPassword(CipherUtil.encodeByMD5(password));
            } else {
                user.setPassword(CipherUtil.generatePassword(password));
            }
        }
        //个人注册，设置用户姓名为经验单位名称
        if(bean.getCompanyType()==1){
            user.setRealName(bean.getCompanyName());
        }
        user.setInspectionId(unit.getId());
        if(isCreate){
            user.setLoginTime(new Date());
            user.setLoginCount((short) (user.getLoginCount() + 1));
            user.setOpenId(openId);
            user.setUserType((short) 0);
            user.setStatus((short) 0);
            user.setType(0);
            PublicUtil.setCommonForTable1(user, true,user);
            mapper.insertSelective(user);
            //4.用户注册成功的同时开通余额账号
            Date now = new Date();
            InspectionUserAccount account = new InspectionUserAccount(user.getId(), 0,
                    0, 0, null, user.getId().toString(), now, now);
            account.setTotalMoney(0);
            accountService.saveOrUpdate(account);
        }else{
            PublicUtil.setCommonForTable1(user, false,user);
            mapper.updateByPrimaryKeySelective(user);
        }
        return user;
    }
}
