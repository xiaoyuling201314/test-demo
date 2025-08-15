package com.dayuan.service.data;

import com.dayuan.bean.data.BasePointUser;
import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.mapper.data.BasePointUserMapper;
import com.dayuan.mapper.data.BaseWorkersMapper;
import com.dayuan.service.BaseService;
import com.dayuan.util.UUIDGenerator;
//import com.dayuan2.bean.personnel.PPersonnelAssessment;
//import com.dayuan2.mapper.personnel.PPersonnelAssessmentMapper;
//import com.dayuan2.mapper.project.PProjectMapper;
//import com.dayuan2.mapper.project.pProjectTemporaryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 检测机构、点人员
 * Description:
 *
 * @author Dz
 * @Company: 食安科技
 * @date 2017年9月3日
 */
@Service
public class BasePointUserService extends BaseService<BasePointUser, String> {

    @Autowired
    private BasePointUserMapper mapper;
    @Autowired
    private BaseWorkersMapper baseWorkersMapper;
//    @Autowired
//    private PPersonnelAssessmentMapper pPersonnelAssessmentMapper;
//    @Autowired
//    private PProjectMapper pProjectMapper;
//    @Autowired
//    private pProjectTemporaryMapper pProjectTemporaryMapper;

    public BasePointUserMapper getMapper() {
        return mapper;
    }

    public void updateByPrimaryKeySelective(BasePointUser bean) {
        mapper.updateByPrimaryKeySelective(bean);
    }

    public BasePointUser queryById(String id) {
        BasePointUser pointUser = mapper.selectByPrimaryKey(id);
        return pointUser;
    }

    public List<BasePointUser> getSubPointUsers(Integer departId) throws Exception {
        List<BasePointUser> users = mapper.getSubPointUsers(departId);
        return users;
    }

    public List<BasePointUser> queryByPointId(Integer pointId) throws Exception {
        List<BasePointUser> users = mapper.queryByPointId(pointId);
        return users;
    }

    public List<BasePointUser> queryByDepartId(String departId) throws Exception {
        List<BasePointUser> users = mapper.queryByDepartId(departId);
        return users;
    }

    /**
     * 保存检测点人员
     *
     * @param userIds
     * @param pointId
     * @author Dz
     */
    public void savePointUser(String[] userIds, Integer departId, Integer pointId) throws Exception {
        String db = WebConstant.res.getString("db1");
        List<BasePointUser> users = mapper.queryByPointId(pointId);
//        //shit:根据depart_id查询出对应的项目id
//        Integer pId = pPersonnelAssessmentMapper.selectPidByDepartId(db,departId);
        //拿到当前年份
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Date date = new Date();
        String format = sdf.format(date);
        sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date month = sdf.parse(format + "-01-01");
        String startMonth = format + "-01";
        if (users.size() > 0) {
            for (String userId : userIds) {
                for (int i = 0; i < users.size(); i++) {
                    BasePointUser user = users.get(i);
                    if (userId.equals(user.getUserId())) {
                        //人员已存在
                        break;
                    }
                    if (i == users.size() - 1) {
                        //新增检测点人员
                        BasePointUser pointUser = new BasePointUser();
                        pointUser.setId(UUIDGenerator.generate());
                        pointUser.setDepartId(departId);
                        pointUser.setPointId(pointId);
                        pointUser.setUserId(userId);
                        pointUser.setStartTime(new Date());
                        //默认人员在当前项目职位为人员表职位
                        String position = mapper.selectPosition(db,userId);
                        pointUser.setPositionCode(position);
                        pointUser.setDeleteFlag((short) 0);
                        PublicUtil.setCommonForTable(pointUser, true);
                        mapper.insert(pointUser);
                        //shit:新增该人员的考核信息=================================
                        //shit:在保存之前先根据年份和人员id查询一下该人员考核信息是否已经存在
//                        if (pId != null) {//如果该人员只是加入检测点而不是加入项目,就不添加项目对应的考核信息
//                            PPersonnelAssessment pPA = pPersonnelAssessmentMapper.selectByUserIdOrMonth(pId, userId, startMonth);
//                            //shit:新增该人员的审核初始信息
//                            PPersonnelAssessment pPersonnelAssessment = new PPersonnelAssessment();
//                            pPersonnelAssessment.setUserId(userId);
//                            pPersonnelAssessment.setpId(pId);
//                            pPersonnelAssessment.setMonth(month);
//                            //在保存之前先查询一下看看是否存在,不存在就保存
//                            if (pPA == null) {
//                                pPersonnelAssessmentMapper.insert(pPersonnelAssessment);
//                            }
//                        }
                    }
                }
            }
        } else {
            BaseWorkers worker = null;
            for (String userId : userIds) {
                worker = baseWorkersMapper.selectByPrimaryKey(userId);
                if (worker != null) {
                    //新增检测点人员
                    BasePointUser pointUser = new BasePointUser();
                    pointUser.setId(UUIDGenerator.generate());
                    pointUser.setDepartId(departId);
                    pointUser.setPointId(pointId);
                    pointUser.setUserId(userId);
                    pointUser.setStartTime(new Date());
                    //默认人员在当前项目职位为人员表职位
                    pointUser.setPositionCode(worker.getPosition());
                    pointUser.setDeleteFlag((short) 0);
                    PublicUtil.setCommonForTable(pointUser, true);
                    mapper.insert(pointUser);
                    //shit:在保存之前先根据年份和人员id查询一下该人员考核信息是否已经存在
//                    if (pId != null) {//如果该人员只是加入检测点而不是加入项目,就不添加项目对应的考核信息
//                        PPersonnelAssessment pPA = pPersonnelAssessmentMapper.selectByUserIdOrMonth(pId, userId, startMonth);
//                        PPersonnelAssessment pPersonnelAssessment = new PPersonnelAssessment();
//                        //shit:新增该人员的考核信息
//                        pPersonnelAssessment.setUserId(userId);
//                        pPersonnelAssessment.setpId(pId);
//                        pPersonnelAssessment.setMonth(month);
//                        //在保存之前先查询一下看看是否存在,不存在就保存
//                        if (pPA == null) {
//                            pPersonnelAssessmentMapper.insert(pPersonnelAssessment);
//                        }
//                    }
                }
            }
        }
//		for(String userId : userIds){
//			BasePointUser user = mapper.queryByPointAndUser(pointId, userId);
////			BasePointUser user = mapper.queryByPointAndUser(pointId);
//			if(null == user){
//				user = new BasePointUser();
//				user.setId(UUIDGenerator.generate());
//				user.setDepartId(departId);
//				user.setPointId(pointId);
//				user.setUserId(userId);
//				mapper.insert(user);
//			}
//		}
    }

    /**
     * 保存机构人员
     *
     * @param userIds
     * @param departId
     * @author Dz
     */
    public void saveDepartUser(String[] userIds, Integer departId) throws Exception {
//		for(String userId : userIds){
//			BasePointUser user = mapper.queryByDepartAndUser(departId, userId);
////			BasePointUser user = mapper.queryByDepartAndUser(departId);
//			if(null == user){
//				user = new BasePointUser();
//				user.setId(UUIDGenerator.generate());
//				user.setDepartId(departId);
//				user.setUserId(userId);
//				mapper.insert(user);
//			}
//		}
    }

    /**
     * 通过机构或检测点ID查询人员
     *
     * @param departId 检测机构ID
     * @param pointId  检测点ID
     */
    public List<BasePointUser> queryByPoint(Integer departId, Integer pointId) throws Exception {
        return mapper.queryByPoint(departId, pointId);
    }

    public List<BasePointUser> selectByPointId(Integer pointId) {

        return mapper.selectByPointId(pointId);
    }


    @Override
    public int delete(String... strings) throws Exception {
        Date endDate = new Date();
        return mapper.delete(strings, endDate);
    }

    /**
     * shit添加,根据人员id和人员状态为离职之后删除其中间表信息
     *
     * @param id
     */
    public void deleteByUserId(String id) throws Exception {
        mapper.deleteByUserId(id, new Date());
    }

    /**
     * shit添加,如果该项目完成或者终止那就保存结束时间到该项目对应的中间表，同时删除该人员与与项目之间的关系
     *
     * @param pId
     */
//    public void updateByProjectId(Integer pId) {
//        //根据项目id查询对应的机构id
//        Integer departId = pProjectMapper.selectDepartIdBypId(pId);
//        //项目终止等情况时—根据项目id把人员数设置为0
//        pProjectTemporaryMapper.updateByProjectId(pId);
//        mapper.updateByProjectId(departId, new Date());
//    }
}
