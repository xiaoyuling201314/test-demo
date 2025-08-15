package com.dayuan.service.DataCheck.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.dataCheck.DataCheckHistoryRecording;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.dataCheck.DataCheckHistoryRecordingMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.DataCheck.DataCheckHistoryRecordingService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.DateUtil;
import lombok.RequiredArgsConstructor;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
* @author Dz
* @description 针对表【data_check_history_recording(检测数据历史表)】的数据库操作Service实现
* @createDate 2025-06-30 11:39:52
*/
@Service
@RequiredArgsConstructor
public class DataCheckHistoryRecordingServiceImpl extends ServiceImpl<DataCheckHistoryRecordingMapper, DataCheckHistoryRecording>
    implements DataCheckHistoryRecordingService {

    private final TSDepartService departService;
    private final BasePointService pointService;

    /**
     * 根据检测数据ID去查询检测历史数据
     * @param rid
     * @return
     */
    public List<DataCheckHistoryRecording> selectCheckHistoryByRid(Integer rid)throws Exception {
        return getBaseMapper().selectCheckHistoryByRid(rid);
    }

    /**
     * 查询检测历史数据
     * @param rid
     * @param checkRecordingId
     * @param checkDate
     * @param checkResult
     * @param conclusion
     * @return
     */
    public DataCheckHistoryRecording selectCheckHistory(Integer rid, String checkRecordingId, Date checkDate, String checkResult, String conclusion)throws Exception {
        return getBaseMapper().selectCheckHistory(rid, checkRecordingId, DateUtil.formatDate(checkDate, "yyyy-MM-dd HH:mm:ss"), checkResult, conclusion);
    }

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
     * 通过三级菜单地址，获取当前用户查看数据权限
     * 机构用户默认查看本部，机构数据权限：
     * 查看本部：查看当前机构下的数据
     * 查看直管：查看当前机构和直属检测点的数据
     * 查看下级：查看当前机构及管辖下的所有机构和检测点的数据
     * 检测点用户只能查看当前检测点下的数据，无论是否已配置查看下级等相关权限
     * 监管对象用户只能查看当前监管对象下的数据，无论是否已配置查看下级等相关权限
     *
     * @param url 三级菜单地址
     * @return
     * @throws Exception
     */
    public Map dataPermission(String url) throws Exception {

//		TSFunctionService tSFunctionService = (TSFunctionService) ContextHolderUtils.getBean("tSFunctionService");
//		TSOperationService tSOperationService = (TSOperationService) ContextHolderUtils.getBean("tSOperationService");
//
//		TSFunction tsFunction = tSFunctionService.queryByFunctionUrl(url);
//		List<TSOperation> btnList = tSOperationService.queryByRoleIdAndFunctionId(PublicUtil.getSessionUser().getRoleId(),tsFunction.getId());
//		JSONArray json=new JSONArray().fromObject(btnList);

        Map<String,Object> map = new HashMap<String,Object>();
        Integer departID = null;
        Integer pointID = null;
        ArrayList<Integer> lis = new ArrayList<>();
        TSUser tsUser = PublicUtil.getSessionUser();

        //检测点、监管对象用户权限
        if(tsUser!=null){
            departID = tsUser.getDepartId();

            if(null != tsUser.getRegId()){	//监管对象用户
                pointID = tsUser.getPointId();
                map.put("departArr", null);
                map.put("pointArr", null);
                map.put("userRegId", tsUser.getRegId());
                map.put("handleState", 2);//处置标识,-1查询失败,0下级1直管2本部,多选默认最大权限
                return map;

            }else if(null != tsUser.getPointId()){	//检测点用户
                pointID = tsUser.getPointId();
                map.put("departArr", null);
                map.put("pointArr", new Integer[]{tsUser.getPointId()});
                map.put("userRegId", null);
                map.put("handleState", 2);//处置标识,-1查询失败,0下级1直管2本部,多选默认最大权限
                return map;
            }

        }else {
            map.put("departArr", null);
            map.put("pointArr", null);
            map.put("userRegId", null);
            map.put("handleState", -1);
            return map;
        }

        //获取菜单权限
        HttpSession session = ContextHolderUtils.getSession();
        JSONArray jsonArr = JSONArray.fromObject(session.getAttribute("btnList"));
        Iterator<Object> ja = jsonArr.iterator();
        while (ja.hasNext()){
            JSONObject job = (JSONObject) ja.next();
            if(job.get("functionUrl").equals(url)){
                //获取操作名称(operationCode不唯一,不作为判断条件)
                String operationName = job.get("operationName").toString();
                if(operationName.contains("本部")) lis.add(2);
                if(operationName.contains("直管")) lis.add(1);
                if(operationName.contains("下级")) lis.add(0);
            }
        }

        //机构用户权限
        //拿到处置标识,0下级1直管2本部,多选默认最大权限
        int handleState = 2;	//默认本部
        if(lis.size() > 0){
            handleState = Collections.min(lis);
        }

        List<Integer> pointArr = new ArrayList<Integer>();
        if(handleState == 0){//所有(下级)
            // 获取当前机构和其下属机构ID
            List<TSDepart> sDeparts = departService.getAllSonDepartsByID(departID);
            List<Integer> departArr = new ArrayList<Integer>();
            if(sDeparts !=null && sDeparts.size()>0) {
                for(TSDepart sDepart : sDeparts) {
                    departArr.add(sDepart.getId());
                }
            }
            //获取当前用户下的所有检测点
            List<BasePoint> points = pointService.queryByDepartId(departID, "Y", null, new Integer[]{0,1,2});
            for(BasePoint point : points){
                pointArr.add(point.getId());
            }
            if(departArr.size()>0){
                map.put("departArr", departArr.toArray(new Integer[departArr.size()]));
            }
            if(pointArr.size()>0){
                map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
            }
            map.put("userRegId", null);
            map.put("handleState", 0);

        }else if(handleState == 1){//直管
            //获取当前用户下的直管检测点
            List<BasePoint> points = pointService.selectByDepartid(departID,null);
            for(BasePoint point : points){
                pointArr.add(point.getId());
            }
            if(null != departID){
                map.put("departArr", new Integer[]{departID});
            }else{
                map.put("departArr", null);
            }
            if(pointArr.size()>0){
                map.put("pointArr", pointArr.toArray(new Integer[pointArr.size()]));
            }
            map.put("userRegId", null);
            map.put("handleState", 1);

        }else if(handleState == 2){//本部
            if(null!= departID){
                map.put("departArr", new Integer[]{departID});
            }else{
                map.put("departArr", null);
            }
            if(null != pointID){
                map.put("pointArr", new Integer[]{pointID});
            }else{
                map.put("pointArr", null);
            }
            map.put("userRegId", null);
            map.put("handleState", 2);
        }

        return map;
    }

}




